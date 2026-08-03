local Module = {}

function Module.Create(Context)
    assert(type(Context) == 'table' and type(Context.Common) == 'table')
    local Common = Context.Common
    local finite = Context.finite
    local reliablePosition = Context.reliablePosition
    local resolveEntity = Context.resolveEntity
    local getPlayer = Context.getPlayer

local TOPAZ_CONTENT_ID = 14792
local SQUARE_EVENT_OBJECT_ID = 2015301
local L_EVENT_OBJECT_ID = 2015302
local ARENA_CENTER = { x = 238, y = 15, z = 352 }
local ARENA_HALF_SIZE = 20
local DRAW_Y = 15.05
local POSITION_TOLERANCE = 0.3
local L_POSITION_TOLERANCE = 0.6
local HEADING_TOLERANCE = math.rad(5)
local EVENT_OBJECT_CENTER_TOLERANCE_SQ = 1
local CHANNEL_BATCH_WINDOW_MS = 750
local PHASE_TIMEOUT_MS = 60000
local EARLY_PREDICTION_TIMEOUT_MS = 30000
local CHANNEL_PREDICTION_TIMEOUT_MS = 5000
local STONE_RESOLVE_TIMEOUT_MS = 1000
local SAFE_TARGET_MARGIN = 1.5

local AID = {
    TopazReflection = 48281,
    TopazNormal = 48282,
    RubyGlow = 48284,
    SquareReflection = 48285,
    LReflectionA = 48286,
    LReflectionB = 48287,
}

local DEFAULTS = {
    Enable = true,
    DrawSafeZone = true,
    DynamicGuide = true,
}

local QUADRANT_ORDER = { 'NW', 'NE', 'SW', 'SE' }
local QUADRANTS = {
    NW = { x = -10, z = -10 },
    NE = { x = 10, z = -10 },
    SW = { x = -10, z = 10 },
    SE = { x = 10, z = 10 },
}
-- The 2015302 wall mesh divides the 4x4 floor into four L tetrominoes.
-- Rows run north to south and columns run west to east.
local ROOM_BY_CELL = {
    { 'A', 'A', 'C', 'C' },
    { 'A', 'B', 'C', 'D' },
    { 'A', 'B', 'C', 'D' },
    { 'B', 'B', 'D', 'D' },
}
local ROOM_CELLS = {
    A = {
        { x = -15, z = -15 }, { x = -5, z = -15 },
        { x = -15, z = -5 }, { x = -15, z = 5 },
    },
    B = {
        { x = -5, z = -5 }, { x = -5, z = 5 },
        { x = -15, z = 15 }, { x = -5, z = 15 },
    },
    C = {
        { x = 5, z = -15 }, { x = 15, z = -15 },
        { x = 5, z = -5 }, { x = 5, z = 5 },
    },
    D = {
        { x = 15, z = -5 }, { x = 15, z = 5 },
        { x = 5, z = 15 }, { x = 15, z = 15 },
    },
}
local ROOM_ORDER = { 'A', 'B', 'C', 'D' }

local function newState()
    return {
        visibleStones = {},
        stoneBatchSequence = 0,
        phase = nil,
        phaseSequence = 0,
        channelBatch = nil,
        prediction = nil,
        safeDrawer = nil,
        lastRubyGlowAt = nil,
        lastDiagnostic = nil,
    }
end

local function ensureState(state)
    state = type(state) == 'table' and state or newState()
    state.visibleStones = type(state.visibleStones) == 'table'
            and state.visibleStones or {}
    state.stoneBatchSequence = finite(state.stoneBatchSequence)
            and state.stoneBatchSequence or 0
    state.phaseSequence = finite(state.phaseSequence)
            and state.phaseSequence or 0
    return state
end

local feature = Common.newFeature({
    key = 'GemstoneBeast',
    defaults = DEFAULTS,
    newState = newState,
    ensureState = ensureState,
    diagnosticThrottleMs = 1000,
    diagnosticText = {
        ruby_glow_boss_mismatch = '负隅宝石兽红宝石之光实体不匹配',
        stone_geometry_missing = '负隅宝石兽黄宝石缺少可靠位置或朝向',
        event_object_mismatch = '负隅宝石兽墙体事件对象不匹配',
        event_object_heading_ambiguous = '负隅宝石兽墙体朝向无法可靠归一化',
        event_object_layout_conflict = '负隅宝石兽同批墙体事件状态冲突',
        phase_kind_conflict = '负隅宝石兽墙体类型与当前阶段冲突',
        early_geometry_ambiguous = '负隅宝石兽提前宝石几何不唯一，已停止绘图',
        channel_batch_conflict = '负隅宝石兽黄宝石读条批次存在冲突',
        channel_geometry_ambiguous = '负隅宝石兽读条未能得到唯一安全区',
        early_prediction_conflict = '负隅宝石兽提前预测与可靠读条结果不一致',
        safe_drawer_unavailable = '负隅宝石兽绿色安全区绘图器不可用',
        guide_unavailable = '负隅宝石兽安全区指路接口不可用',
    },
})
local getConfig = feature.GetConfig

local function getState()
    return Common.getRuntimeState(
            'GemstoneBeast', newState, ensureState)
end

local function diagnostic(state, code, now, context)
    feature.Diagnostic(
            state, rawget(_G, 'MuAiGuide'), code, now, context)
end

local function normalizeHeading(value)
    if not finite(value) then
        return nil
    end
    local twoPi = math.pi * 2
    value = (value + math.pi) % twoPi - math.pi
    return value
end

local function headingDifference(left, right)
    local difference = normalizeHeading(left - right)
    return difference ~= nil and math.abs(difference) or nil
end

local function nearestInteger(value)
    if value >= 0 then
        return math.floor(value + 0.5)
    end
    return math.ceil(value - 0.5)
end

local function quantizeCardinalHeading(value)
    value = normalizeHeading(value)
    if value == nil then
        return nil, nil
    end
    local step = math.pi / 2
    local rawIndex = nearestInteger(value / step)
    local candidate = normalizeHeading(rawIndex * step)
    if headingDifference(value, candidate) > HEADING_TOLERANCE then
        return nil, nil
    end
    local index = rawIndex % 4
    return candidate, index
end

local function closeTo(value, expected)
    return finite(value)
            and math.abs(value - expected) <= POSITION_TOLERANCE
end

local function closeToEither(value, first, second)
    return closeTo(value, first) or closeTo(value, second)
end

local function closeToL(value, expected)
    return finite(value)
            and math.abs(value - expected) <= L_POSITION_TOLERANCE
end

local function closeToEitherL(value, first, second)
    return closeToL(value, first) or closeToL(value, second)
end

local function insideArena(position)
    return Common.validXZ(position)
            and math.abs(position.x - ARENA_CENTER.x)
                    <= ARENA_HALF_SIZE + 0.75
            and math.abs(position.z - ARENA_CENTER.z)
                    <= ARENA_HALF_SIZE + 0.75
end

local function validStonePosition(entityID)
    if not finite(entityID) or entityID <= 0 then
        return nil
    end
    local entity = resolveEntity(entityID)
    if type(entity) ~= 'table'
            or entity.alive == false
    then
        return nil
    end
    local position = reliablePosition(entity.pos, true)
    return position ~= nil and insideArena(position) and position or nil
end

local function validEventObject(entityID)
    local entity = resolveEntity(entityID)
    if type(entity) ~= 'table' then
        return nil, nil
    end
    local contentID = tonumber(entity.contentid)
    if contentID ~= SQUARE_EVENT_OBJECT_ID
            and contentID ~= L_EVENT_OBJECT_ID
    then
        return nil, nil
    end
    local position = reliablePosition(entity.pos, true)
    if position == nil
            or Common.distanceSquared(position, ARENA_CENTER)
                    > EVENT_OBJECT_CENTER_TOLERANCE_SQ
    then
        return nil, nil
    end
    return contentID, position
end

local function worldToLocal(position, heading)
    if not Common.validXZ(position) or not finite(heading) then
        return nil
    end
    local dx = position.x - ARENA_CENTER.x
    local dz = position.z - ARENA_CENTER.z
    local cosine = math.cos(heading)
    local sine = math.sin(heading)
    return {
        x = dx * cosine - dz * sine,
        z = dx * sine + dz * cosine,
        h = finite(position.h)
                and normalizeHeading(position.h - heading) or nil,
    }
end

local function localToWorld(position, heading)
    if not Common.validXZ(position) or not finite(heading) then
        return nil
    end
    local cosine = math.cos(heading)
    local sine = math.sin(heading)
    return {
        x = ARENA_CENTER.x + position.x * cosine + position.z * sine,
        y = DRAW_Y,
        z = ARENA_CENTER.z - position.x * sine + position.z * cosine,
    }
end

local function headingMatches(actual, expected)
    local difference = headingDifference(actual, expected)
    return difference ~= nil and difference <= HEADING_TOLERANCE
end

local function isOutwardCenterWallStone(position)
    if not Common.validXZ(position) or not finite(position.h) then
        return false
    end
    local absoluteX = math.abs(position.x)
    local absoluteZ = math.abs(position.z)
    if closeTo(absoluteX, 1)
            and closeToEither(absoluteZ, 5, 15)
    then
        return headingMatches(
                position.h,
                position.x > 0 and math.pi / 2 or -math.pi / 2)
    end
    if closeTo(absoluteZ, 1)
            and closeToEither(absoluteX, 5, 15)
    then
        return headingMatches(
                position.h,
                position.z > 0 and 0 or math.pi)
    end
    return false
end

local function isEarlySquareReflection(position)
    local localPosition = worldToLocal(position, 0)
    return localPosition ~= nil
            and isOutwardCenterWallStone(localPosition)
end

local function isEarlyLReflection(position, effectiveHeading)
    local localPosition = worldToLocal(position, effectiveHeading)
    if localPosition == nil or not finite(localPosition.h) then
        return false
    end
    if closeToL(math.abs(localPosition.x), 1)
            and closeToEitherL(math.abs(localPosition.z), 5, 15)
    then
        return headingMatches(
                localPosition.h,
                localPosition.x > 0 and math.pi / 2 or -math.pi / 2)
    end
    if closeToL(math.abs(localPosition.x), 15)
            and closeToL(math.abs(localPosition.z), 9)
    then
        return headingMatches(
                localPosition.h,
                localPosition.z > 0 and math.pi or 0)
    end
    return false
end

local function quadrantFor(position)
    if not Common.validXZ(position) then
        return nil
    end
    local x = position.x - ARENA_CENTER.x
    local z = position.z - ARENA_CENTER.z
    if math.abs(x) < 0.25 or math.abs(z) < 0.25 then
        return nil
    end
    if x < 0 then
        return z < 0 and 'NW' or 'SW'
    end
    return z < 0 and 'NE' or 'SE'
end

local function roomForLocalPosition(position)
    if not Common.validXZ(position)
            or position.x <= -ARENA_HALF_SIZE
            or position.x >= ARENA_HALF_SIZE
            or position.z <= -ARENA_HALF_SIZE
            or position.z >= ARENA_HALF_SIZE
    then
        return nil
    end
    local column = math.floor((position.x + ARENA_HALF_SIZE) / 10) + 1
    local row = math.floor((position.z + ARENA_HALF_SIZE) / 10) + 1
    return type(ROOM_BY_CELL[row]) == 'table'
            and ROOM_BY_CELL[row][column] or nil
end

local function sortedEntityEntries(entries)
    table.sort(entries, function(left, right)
        return left.entityID < right.entityID
    end)
    return entries
end

local function magicEntries(entries, predicate, useActions)
    local result = {}
    for _, entry in ipairs(entries) do
        local selected = useActions == true
                and entry.actionID == AID.TopazReflection
                or useActions ~= true and predicate(entry.position)
        if selected then
            result[#result + 1] = entry
        end
    end
    return result
end

local function makeMagicIDSet(entries)
    local result = {}
    for _, entry in ipairs(entries) do
        result[entry.entityID] = true
    end
    return result
end

local function resolveSquare(entries, useActions)
    if type(entries) ~= 'table' or #entries ~= 10 then
        return nil
    end
    local selected = magicEntries(
            entries, isEarlySquareReflection, useActions)
    if #selected ~= 2 then
        return nil
    end
    local dangerous = {}
    local dangerousCount = 0
    for _, entry in ipairs(selected) do
        local quadrant = quadrantFor(entry.position)
        if quadrant == nil then
            return nil
        end
        if not dangerous[quadrant] then
            dangerous[quadrant] = true
            dangerousCount = dangerousCount + 1
        end
    end
    if dangerousCount ~= 2 then
        return nil
    end
    local safeNames = {}
    local rectangles = {}
    for _, name in ipairs(QUADRANT_ORDER) do
        if not dangerous[name] then
            safeNames[#safeNames + 1] = name
            local center = QUADRANTS[name]
            rectangles[#rectangles + 1] = {
                x = ARENA_CENTER.x + center.x,
                y = DRAW_Y,
                z = ARENA_CENTER.z + center.z,
                length = 20,
                width = 20,
                heading = 0,
            }
        end
    end
    if #safeNames ~= 2 then
        return nil
    end
    return {
        kind = 'square',
        key = 'square:' .. table.concat(safeNames, ','),
        safeNames = safeNames,
        rectangles = rectangles,
        magicIDs = makeMagicIDSet(selected),
    }
end

local function resolveL(entries, effectiveHeading, useActions)
    if type(entries) ~= 'table'
            or #entries ~= 10
            or not finite(effectiveHeading)
    then
        return nil
    end
    local selected = magicEntries(entries, function(position)
        return isEarlyLReflection(position, effectiveHeading)
    end, useActions)
    if #selected ~= 3 then
        return nil
    end
    local dangerous = {}
    local dangerousCount = 0
    for _, entry in ipairs(selected) do
        local localPosition = worldToLocal(entry.position, effectiveHeading)
        local room = localPosition ~= nil
                and roomForLocalPosition(localPosition) or nil
        if room == nil then
            return nil
        end
        if not dangerous[room] then
            dangerous[room] = true
            dangerousCount = dangerousCount + 1
        end
    end
    if dangerousCount ~= 3 then
        return nil
    end
    local safeRoom = nil
    for _, room in ipairs(ROOM_ORDER) do
        if not dangerous[room] then
            if safeRoom ~= nil then
                return nil
            end
            safeRoom = room
        end
    end
    local cells = safeRoom ~= nil and ROOM_CELLS[safeRoom] or nil
    if type(cells) ~= 'table' or #cells ~= 4 then
        return nil
    end
    local rectangles = {}
    for _, cell in ipairs(cells) do
        local center = localToWorld(cell, effectiveHeading)
        if center == nil then
            return nil
        end
        rectangles[#rectangles + 1] = {
            x = center.x,
            y = center.y,
            z = center.z,
            length = 10,
            width = 10,
            heading = effectiveHeading,
        }
    end
    local _, headingIndex = quantizeCardinalHeading(effectiveHeading)
    if headingIndex == nil then
        return nil
    end
    return {
        kind = 'l',
        key = 'l:' .. safeRoom .. ':' .. tostring(headingIndex),
        safeRoom = safeRoom,
        effectiveHeading = effectiveHeading,
        rectangles = rectangles,
        magicIDs = makeMagicIDSet(selected),
    }
end

local function clearPrediction(state)
    if type(state) ~= 'table' then
        return false
    end
    local hadPrediction = state.prediction ~= nil
    state.prediction = nil
    return hadPrediction
end

local function clearState(state)
    state = ensureState(state)
    state.visibleStones = {}
    state.stoneBatchSequence = 0
    state.phase = nil
    state.channelBatch = nil
    state.prediction = nil
    state.safeDrawer = nil
    state.lastRubyGlowAt = nil
    state.lastDiagnostic = nil
end

local function makePhase(state, now)
    state.phaseSequence = state.phaseSequence + 1
    state.phase = {
        sequence = state.phaseSequence,
        startedAt = now,
        expiresAt = now + PHASE_TIMEOUT_MS,
        kind = nil,
        layout = nil,
    }
    state.channelBatch = nil
    clearPrediction(state)
    return state.phase
end

local function ensurePhase(state, now)
    local phase = state.phase
    if type(phase) ~= 'table'
            or not finite(phase.expiresAt)
            or now > phase.expiresAt
    then
        phase = makePhase(state, now)
    end
    return phase
end

local function setPhaseKind(state, phase, kind, now, context)
    if phase.kind ~= nil and phase.kind ~= kind then
        diagnostic(state, 'phase_kind_conflict', now, {
            previous = phase.kind,
            incoming = kind,
            context = context,
        })
        clearPrediction(state)
        return false
    end
    phase.kind = kind
    return true
end

local function collectVisibleEntries(state, now)
    local entries = {}
    local stale = {}
    for entityID, observedAt in pairs(state.visibleStones) do
        local position = validStonePosition(entityID)
        if position == nil then
            if not finite(observedAt)
                    or not finite(now)
                    or now - observedAt > STONE_RESOLVE_TIMEOUT_MS
            then
                stale[#stale + 1] = entityID
            end
        else
            entries[#entries + 1] = {
                entityID = entityID,
                position = position,
            }
        end
    end
    for _, entityID in ipairs(stale) do
        state.visibleStones[entityID] = nil
    end
    return sortedEntityEntries(entries)
end

local function applyPrediction(state, prediction, source, now)
    if type(prediction) ~= 'table' or type(prediction.key) ~= 'string' then
        return false
    end
    local previous = state.prediction
    if type(previous) == 'table' and previous.key == prediction.key then
        if source == 'channel' then
            previous.source = source
            previous.expiresAt = now + CHANNEL_PREDICTION_TIMEOUT_MS
            previous.magicIDs = prediction.magicIDs
        end
        return false
    end
    if type(previous) == 'table'
            and previous.source == 'visibility'
            and source == 'channel'
            and previous.key ~= prediction.key
    then
        diagnostic(state, 'early_prediction_conflict', now, {
            early = previous.key,
            channel = prediction.key,
        })
    end
    prediction.source = source
    prediction.createdAt = now
    prediction.expiresAt = now + (source == 'channel'
            and CHANNEL_PREDICTION_TIMEOUT_MS
            or EARLY_PREDICTION_TIMEOUT_MS)
    state.prediction = prediction
    return true
end

local function bindPendingPhaseSignal(state)
    local phase = state.phase
    if type(phase) ~= 'table' then
        return false
    end
    local signal = phase.kind == 'square'
            and phase.squareGate
            or phase.kind == 'l' and phase.layout
            or nil
    if type(signal) ~= 'table'
            or signal.consumed == true
            or signal.stoneBatchSequence ~= nil
    then
        return false
    end
    signal.stoneBatchSequence = state.stoneBatchSequence
    return true
end

local function signalMatchesChannelBatch(signal, state)
    if type(signal) ~= 'table' or signal.consumed == true then
        return false
    end
    if signal.stoneBatchSequence == nil then
        signal.stoneBatchSequence = state.stoneBatchSequence
    end
    return signal.stoneBatchSequence == state.stoneBatchSequence
end

local function tryEarlyPrediction(state, now)
    local phase = state.phase
    if type(phase) ~= 'table'
            or phase.kind == nil
            or phase.completed == true
    then
        return false
    end
    local entries = collectVisibleEntries(state, now)
    if #entries ~= 10 then
        return false
    end
    local prediction = nil
    if phase.kind == 'square'
            and type(phase.squareGate) == 'table'
            and phase.squareGate.stoneBatchSequence
                    == state.stoneBatchSequence
    then
        prediction = resolveSquare(entries, false)
    elseif phase.kind == 'l'
            and type(phase.layout) == 'table'
            and phase.layout.consumed ~= true
            and phase.layout.stoneBatchSequence
                    == state.stoneBatchSequence
            and finite(phase.layout.effectiveHeading)
    then
        prediction = resolveL(
                entries, phase.layout.effectiveHeading, false)
    end
    if prediction == nil then
        diagnostic(state, 'early_geometry_ambiguous', now, {
            kind = phase.kind,
            visibleCount = #entries,
            layoutState = type(phase.layout) == 'table'
                    and phase.layout.state or nil,
        })
        clearPrediction(state)
        return false
    end
    state.lastDiagnostic = nil
    return applyPrediction(state, prediction, 'visibility', now)
end

local function beginRubyGlow(state, entityID, now)
    if not finite(now)
            or (finite(state.lastRubyGlowAt)
                    and now - state.lastRubyGlowAt <= 1000)
    then
        return false
    end
    if not finite(entityID) or entityID <= 0 then
        diagnostic(state, 'ruby_glow_boss_mismatch', now, entityID)
        return false
    end
    state.lastRubyGlowAt = now
    makePhase(state, now)
    state.lastDiagnostic = nil
    return true
end

local function recordEventObject(state, entityID, a1, a2, a3, now)
    a1, a2, a3 = tonumber(a1), tonumber(a2), tonumber(a3)
    if not finite(now) or a3 ~= 0 then
        return false
    end
    local contentID, position = validEventObject(entityID)
    if contentID == nil then
        return false
    end
    local phase = ensurePhase(state, now)
    if contentID == SQUARE_EVENT_OBJECT_ID then
        if not ((a1 == 1 and a2 == 2)
                or (a1 == 16 and a2 == 32))
        then
            return false
        end
        if not setPhaseKind(
                state, phase, 'square', now, entityID)
        then
            return false
        end
        local squareGate = phase.squareGate
        if type(squareGate) == 'table' then
            return false
        end
        phase.squareGate = {
            entityID = entityID,
            observedAt = now,
            stoneBatchSequence = next(state.visibleStones) ~= nil
                    and state.stoneBatchSequence or nil,
        }
        state.lastDiagnostic = nil
        tryEarlyPrediction(state, now)
        return true
    end
    if contentID ~= L_EVENT_OBJECT_ID then
        diagnostic(state, 'event_object_mismatch', now, entityID)
        return false
    end
    if a1 == 1 and a2 == 2 then
        return setPhaseKind(state, phase, 'l', now, entityID)
    end
    local layoutState = nil
    local headingOffset = nil
    if a1 == 16 and a2 == 32 then
        layoutState = 16
        headingOffset = math.pi / 2
    elseif a1 == 256 and a2 == 512 then
        layoutState = 256
        headingOffset = 0
    else
        return false
    end
    local effectiveHeading, headingIndex = quantizeCardinalHeading(
            position.h + headingOffset)
    if effectiveHeading == nil then
        diagnostic(state, 'event_object_heading_ambiguous', now, {
            entityID = entityID,
            state = layoutState,
            heading = position.h,
        })
        clearPrediction(state)
        return false
    end
    if not setPhaseKind(state, phase, 'l', now, entityID) then
        return false
    end
    local previousLayout = phase.layout
    if type(previousLayout) == 'table' then
        if previousLayout.entityID == entityID
                and previousLayout.headingIndex == headingIndex
                and previousLayout.state == layoutState
        then
            return false
        end
        if previousLayout.consumed ~= true
                and (previousLayout.stoneBatchSequence == nil
                        or previousLayout.stoneBatchSequence
                                == state.stoneBatchSequence)
        then
            diagnostic(state, 'event_object_layout_conflict', now, {
                previousEntityID = previousLayout.entityID,
                incomingEntityID = entityID,
                previousState = previousLayout.state,
                incomingState = layoutState,
                stoneBatchSequence = state.stoneBatchSequence,
            })
            clearPrediction(state)
            previousLayout.consumed = true
            return false
        end
    end
    phase.layout = {
        entityID = entityID,
        state = layoutState,
        effectiveHeading = effectiveHeading,
        headingIndex = headingIndex,
        observedAt = now,
        consumed = false,
        stoneBatchSequence = next(state.visibleStones) ~= nil
                and state.stoneBatchSequence or nil,
    }
    state.lastDiagnostic = nil
    tryEarlyPrediction(state, now)
    return true
end

local function recordVisibility(
        state, entityID, wasVisible, isVisible, now)
    if not finite(entityID) or entityID <= 0 or not finite(now) then
        return false
    end
    if wasVisible == false and isVisible == true then
        local entity = resolveEntity(entityID)
        if type(entity) ~= 'table'
                or tonumber(entity.contentid) ~= TOPAZ_CONTENT_ID
        then
            return false
        end
        if next(state.visibleStones) == nil then
            state.stoneBatchSequence = state.stoneBatchSequence + 1
        end
        state.visibleStones[entityID] = now
        bindPendingPhaseSignal(state)
        local position = reliablePosition(entity.pos, true)
        if position == nil or not insideArena(position) then
            diagnostic(state, 'stone_geometry_missing', now, entityID)
        end
        tryEarlyPrediction(state, now)
        return true
    end
    if wasVisible == true and isVisible == false then
        local known = state.visibleStones[entityID] ~= nil
        state.visibleStones[entityID] = nil
        local prediction = state.prediction
        if type(prediction) == 'table'
                and type(prediction.magicIDs) == 'table'
                and prediction.magicIDs[entityID]
        then
            clearPrediction(state)
        end
        return known
    end
    return false
end

local function newChannelBatch(now)
    return {
        startedAt = now,
        entriesByID = {},
        count = 0,
        completed = false,
    }
end

local function finishChannelBatch(state, batch, now)
    if batch.count ~= 10 then
        return false
    end
    local entries = {}
    local reflectionCount = 0
    for _, entry in pairs(batch.entriesByID) do
        entries[#entries + 1] = entry
        if entry.actionID == AID.TopazReflection then
            reflectionCount = reflectionCount + 1
        end
    end
    sortedEntityEntries(entries)
    local phase = state.phase
    local prediction = nil
    if reflectionCount == 2
            and type(phase) == 'table'
            and phase.kind == 'square'
            and phase.completed ~= true
            and signalMatchesChannelBatch(
                    phase.squareGate, state)
    then
        prediction = resolveSquare(entries, true)
    elseif reflectionCount == 3
            and type(phase) == 'table'
            and phase.kind == 'l'
            and type(phase.layout) == 'table'
            and phase.layout.consumed ~= true
            and signalMatchesChannelBatch(
                    phase.layout, state)
            and finite(phase.layout.effectiveHeading)
    then
        prediction = resolveL(
                entries, phase.layout.effectiveHeading, true)
    elseif reflectionCount == 0 and type(phase) ~= 'table' then
        batch.completed = true
        return false
    end
    batch.completed = true
    if prediction == nil then
        if reflectionCount > 0 then
            diagnostic(state, 'channel_geometry_ambiguous', now, {
                reflectionCount = reflectionCount,
                phaseKind = type(phase) == 'table' and phase.kind or nil,
                layoutState = type(phase) == 'table'
                        and type(phase.layout) == 'table'
                        and phase.layout.state or nil,
            })
            clearPrediction(state)
        end
        return false
    end
    state.lastDiagnostic = nil
    return applyPrediction(state, prediction, 'channel', now)
end

local function recordTopazChannel(
        state, entityID, actionID, now)
    if actionID ~= AID.TopazReflection
            and actionID ~= AID.TopazNormal
    then
        return false
    end
    local position = validStonePosition(entityID)
    if position == nil then
        diagnostic(state, 'stone_geometry_missing', now, entityID)
        return false
    end
    local batch = state.channelBatch
    if type(batch) ~= 'table'
            or not finite(batch.startedAt)
            or now - batch.startedAt > CHANNEL_BATCH_WINDOW_MS
    then
        batch = newChannelBatch(now)
        state.channelBatch = batch
    end
    if batch.completed then
        return false
    end
    local previous = batch.entriesByID[entityID]
    if type(previous) == 'table' then
        if previous.actionID ~= actionID then
            diagnostic(state, 'channel_batch_conflict', now, {
                entityID = entityID,
                previous = previous.actionID,
                incoming = actionID,
            })
            batch.completed = true
            clearPrediction(state)
        end
        return false
    end
    batch.entriesByID[entityID] = {
        entityID = entityID,
        actionID = actionID,
        position = position,
    }
    batch.count = batch.count + 1
    if batch.count > 10 then
        diagnostic(state, 'channel_batch_conflict', now, batch.count)
        batch.completed = true
        clearPrediction(state)
        return false
    end
    return finishChannelBatch(state, batch, now)
end

local function clamp(value, minimum, maximum)
    return math.max(minimum, math.min(maximum, value))
end

local function nearestPointInRectangle(playerPosition, rectangle)
    if not Common.validXZ(playerPosition)
            or type(rectangle) ~= 'table'
            or not finite(rectangle.x)
            or not finite(rectangle.z)
            or not finite(rectangle.length)
            or not finite(rectangle.width)
            or not finite(rectangle.heading)
    then
        return nil
    end
    local dx = playerPosition.x - rectangle.x
    local dz = playerPosition.z - rectangle.z
    local cosine = math.cos(rectangle.heading)
    local sine = math.sin(rectangle.heading)
    local localX = dx * cosine - dz * sine
    local localZ = dx * sine + dz * cosine
    local halfLength = math.max(
            0.25, rectangle.length / 2 - SAFE_TARGET_MARGIN)
    local halfWidth = math.max(
            0.25, rectangle.width / 2 - SAFE_TARGET_MARGIN)
    local targetX = clamp(localX, -halfLength, halfLength)
    local targetZ = clamp(localZ, -halfWidth, halfWidth)
    return {
        x = rectangle.x + targetX * cosine + targetZ * sine,
        z = rectangle.z - targetX * sine + targetZ * cosine,
    }
end

local function nearestSafeTarget(playerPosition, prediction)
    local best = nil
    local bestDistance = nil
    for _, rectangle in ipairs(prediction.rectangles or {}) do
        local candidate = nearestPointInRectangle(
                playerPosition, rectangle)
        local distance = candidate ~= nil
                and Common.distanceSquared(playerPosition, candidate) or nil
        if finite(distance)
                and (bestDistance == nil or distance < bestDistance)
        then
            best = candidate
            bestDistance = distance
        end
    end
    return best, bestDistance
end

local function getSafeDrawer(state, guide, now)
    local drawerType = type(state.safeDrawer)
    if drawerType == 'table' or drawerType == 'userdata' then
        return state.safeDrawer
    end
    if type(guide) ~= 'table'
            or type(guide.CreateDrawer) ~= 'function'
    then
        diagnostic(state, 'safe_drawer_unavailable', now, nil)
        return nil
    end
    local drawer = guide.CreateDrawer(0, 1, 0, 0.3, 0, 0)
    drawerType = type(drawer)
    if drawerType ~= 'table' and drawerType ~= 'userdata' then
        diagnostic(state, 'safe_drawer_unavailable', now, drawerType)
        return nil
    end
    state.safeDrawer = drawer
    return drawer
end

local function drawSafeZone(state, guide, prediction, now)
    local drawer = getSafeDrawer(state, guide, now)
    if drawer == nil or type(drawer.addCenteredRect) ~= 'function' then
        diagnostic(
                state, 'safe_drawer_unavailable', now, 'addCenteredRect')
        return false
    end
    local drawn = false
    for _, rectangle in ipairs(prediction.rectangles or {}) do
        drawer:addCenteredRect(
                rectangle.x, rectangle.y, rectangle.z,
                rectangle.length, rectangle.width, rectangle.heading)
        drawn = true
    end
    return drawn
end

local function drawGuide(state, guide, prediction, now)
    if type(guide) ~= 'table'
            or type(guide.FrameDirect) ~= 'function'
    then
        diagnostic(state, 'guide_unavailable', now, nil)
        return false
    end
    local player = getPlayer(guide)
    if type(player) ~= 'table' or not Common.validXZ(player.pos) then
        return false
    end
    local target, distance = nearestSafeTarget(player.pos, prediction)
    if target == nil then
        return false
    end
    if distance <= 0.25 then
        return true
    end
    local color = type(guide.Config) == 'table'
            and type(guide.Config.Main) == 'table'
            and guide.Config.Main.GuideColor
            or { r = 0, g = 1, b = 1, a = 0.5 }
    guide.FrameDirect(target.x, target.z, 0.7, color)
    return true
end

local function updateState(state, guide, cfg, now)
    if type(state.phase) == 'table'
            and (not finite(state.phase.expiresAt)
                    or now > state.phase.expiresAt)
    then
        state.phase = nil
        state.channelBatch = nil
        clearPrediction(state)
    end
    if type(state.channelBatch) == 'table'
            and finite(state.channelBatch.startedAt)
            and now - state.channelBatch.startedAt
                    > CHANNEL_BATCH_WINDOW_MS * 3
    then
        state.channelBatch = nil
    end
    if state.prediction == nil then
        tryEarlyPrediction(state, now)
    end
    local prediction = state.prediction
    if type(prediction) ~= 'table' then
        return false
    end
    if not finite(prediction.expiresAt) or now > prediction.expiresAt then
        clearPrediction(state)
        return false
    end
    local handled = false
    if cfg.DrawSafeZone == true then
        handled = drawSafeZone(state, guide, prediction, now) or handled
    end
    if cfg.DynamicGuide == true then
        handled = drawGuide(state, guide, prediction, now) or handled
    end
    return handled
end

local Feature = {}

Feature.Init = function(M)
    if type(M.GemstoneBeast) == 'table' then
        clearState(M.GemstoneBeast)
    end
    M.GemstoneBeast = newState()
    getConfig(M)
    M.SetGemstoneBeastEnabled = function(enabled)
        local cfg = getConfig(M)
        if cfg ~= nil then
            cfg.Enable = enabled == true
        end
        if enabled ~= true then
            clearState(M.GemstoneBeast)
        end
    end
    M.SetGemstoneBeastSafeZoneEnabled = function(enabled)
        local cfg = getConfig(M)
        if cfg ~= nil then
            cfg.DrawSafeZone = enabled == true
        end
    end
    M.SetGemstoneBeastDynamicGuideEnabled = function(enabled)
        local cfg = getConfig(M)
        if cfg ~= nil then
            cfg.DynamicGuide = enabled == true
        end
    end
end

Feature.Clear = function()
    local state = getState()
    if state ~= nil then
        clearState(state)
    end
end

Feature.OnVisibilityChange = function(
        entityID, wasVisible, isVisible, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state == nil or cfg == nil or cfg.Enable ~= true then
        return false
    end
    return recordVisibility(
            state, entityID, wasVisible, isVisible, now)
end

Feature.OnEntityChannel = function(entityID, actionID, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state == nil or cfg == nil or cfg.Enable ~= true then
        return false
    end
    if actionID == AID.RubyGlow then
        return beginRubyGlow(state, entityID, now)
    end
    return recordTopazChannel(state, entityID, actionID, now)
end

Feature.OnEntityCast = function(entityID, actionID)
    local state = getState()
    if state == nil then
        return false
    end
    if actionID == AID.TopazReflection
            or actionID == AID.TopazNormal
            or actionID == AID.SquareReflection
            or actionID == AID.LReflectionA
            or actionID == AID.LReflectionB
    then
        state.channelBatch = nil
        local phase = state.phase
        if type(phase) == 'table' then
            if phase.kind == 'square' then
                -- A square Ruby Glow contains one reflective topaz batch.
                -- Later normal topaz batches can share the same early geometry.
                phase.completed = true
            elseif phase.kind == 'l'
                    and type(phase.layout) == 'table'
            then
                -- Each L-shaped reflective batch receives a fresh layout event.
                -- Consuming it prevents the following normal batch from reusing it.
                phase.layout.consumed = true
            end
        end
        return clearPrediction(state)
    end
    return false
end

Feature.OnEventObjectScriptFunc = function(
        entityID, a1, a2, a3, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state == nil or cfg == nil or cfg.Enable ~= true then
        return false
    end
    return recordEventObject(state, entityID, a1, a2, a3, now)
end

Feature.Update = function(guide, now)
    local state = getState()
    if state == nil then
        return false
    end
    local cfg = getConfig(guide)
    if cfg == nil or cfg.Enable ~= true then
        clearState(state)
        return false
    end
    return updateState(state, guide, cfg, now)
end

Feature.Test = {
    Defaults = DEFAULTS,
    AID = AID,
    TopazContentID = TOPAZ_CONTENT_ID,
    SquareEventObjectID = SQUARE_EVENT_OBJECT_ID,
    LEventObjectID = L_EVENT_OBJECT_ID,
    ArenaCenter = ARENA_CENTER,
    RoomByCell = ROOM_BY_CELL,
    RoomCells = ROOM_CELLS,
    NewState = newState,
    EnsureState = ensureState,
    NormalizeHeading = normalizeHeading,
    QuantizeCardinalHeading = quantizeCardinalHeading,
    WorldToLocal = worldToLocal,
    LocalToWorld = localToWorld,
    IsEarlySquareReflection = isEarlySquareReflection,
    IsEarlyLReflection = isEarlyLReflection,
    QuadrantFor = quadrantFor,
    RoomForLocalPosition = roomForLocalPosition,
    ResolveSquare = resolveSquare,
    ResolveL = resolveL,
    RecordVisibility = recordVisibility,
    BeginRubyGlow = beginRubyGlow,
    RecordEventObject = recordEventObject,
    RecordTopazChannel = recordTopazChannel,
    NearestSafeTarget = nearestSafeTarget,
    UpdateState = updateState,
    ClearState = clearState,
}

return Feature
end

rawset(_G, 'MuAiOccultCrescentNorthGemstoneBeast', Module)
return Module
