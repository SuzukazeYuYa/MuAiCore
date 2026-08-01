local Module = {}

function Module.Create(Context)
    assert(type(Context) == 'table')
    local Common = assert(Context.Common)
    local getNow = assert(Context.GetNow)
    local validXZ = Common.validXZ
    local validXYZ = assert(Context.ValidXYZ)
    local copyPosition = assert(Context.CopyPosition)
    local copyReliablePosition = assert(Context.CopyReliablePosition)
    local entityPosition = assert(Context.EntityPosition)
    local reliableEntityPosition = assert(Context.ReliableEntityPosition)
    local eventPosition = assert(Context.EventPosition)
    local eventHeading = assert(Context.EventHeading)
    local distanceSquared = Common.distanceSquared
    local normalized = Common.normalized
    local getGreenDrawer = assert(Context.GetGreenDrawer)
    local greenGuideColor = Context.GreenGuideColor

local KNIGHT_CONTENT_ID = 13728
local BOSS_MISSING_CLEAR_MS = 1000
local KNIGHT_ARENA_CENTER = { x = 680, z = -280 }
local KNIGHT_ARENA_RADIUS = 20
local KNIGHT_ARENA_MARGIN = 0.5
local KNIGHT_EVENT_DEDUPE_MS = 350
local KNIGHT_SEEN_TTL_MS = 35000
local SPINNING_INCREMENT = math.pi / 20
local SPINNING_INTERVAL_MS = 1700
local SPINNING_CASTS = 6
local SPINNING_FIRST_GUIDE_LEAD_MS = 4000
local SPINNING_CROSS_LENGTH = 60
local SPINNING_CROSS_HALF_WIDTH = 3
local CAGE_LENGTH = 60
local CAGE_HALF_WIDTH = 4
local KNOCKBACK_DISTANCE = 15
local FLURRY_RADIUS = 6
local FLURRY_STEP = 7
local FLURRY_FIRST_DELAY_MS = 900
local FLURRY_INTERVAL_MS = 2100
local FLURRY_EXPLOSIONS = 6
local FLURRY_MATCH_DISTANCE_SQ = 0.25
local knightAID = {
    SpinningSiegeCW = 41822,
    SpinningSiegeCCW = 41823,
    SpinningSiegeRepeat = 41824,
    CageOfFire = 41825,
    BlastKnucklesCast = 41826,
    Moatmaker = 41827,
    DualistFlurryFirst = 41828,
    DualistFlurryRest = 41829,
    SpiritSling = 41834,
    BlastKnuckles = 41891,
    DeathWall = 41901,
    DualistFlurryAOE = 43152,
}

local greenGuideColor = { r = 0, g = 1, b = 0, a = 0.5 }
local knightDangerDrawer
local function newKnightState()
    return {
        spinning = {
            sequences = {},
            seenStarts = {},
        },
        cage = {
            lines = {},
            seenStarts = {},
        },
        knockback = {
            active = nil,
            seenStarts = {},
        },
        flurry = {
            lines = {},
            seenStarts = {},
            sequence = 0,
        },
        seenCasts = {},
        trackedBossEntityIDs = {},
        bossLastSeenAt = nil,
        lastActivityAt = nil,
        lastDiagnostic = nil,
    }
end

local function ensureKnightState(state)
    state.spinning = type(state.spinning) == 'table' and state.spinning or {}
    state.spinning.sequences = type(state.spinning.sequences) == 'table'
            and state.spinning.sequences or {}
    state.spinning.seenStarts = type(state.spinning.seenStarts) == 'table'
            and state.spinning.seenStarts or {}
    state.cage = type(state.cage) == 'table' and state.cage or {}
    state.cage.lines = type(state.cage.lines) == 'table' and state.cage.lines or {}
    state.cage.seenStarts = type(state.cage.seenStarts) == 'table'
            and state.cage.seenStarts or {}
    state.knockback = type(state.knockback) == 'table' and state.knockback or {}
    state.knockback.seenStarts = type(state.knockback.seenStarts) == 'table'
            and state.knockback.seenStarts or {}
    state.flurry = type(state.flurry) == 'table' and state.flurry or {}
    state.flurry.lines = type(state.flurry.lines) == 'table' and state.flurry.lines or {}
    state.flurry.seenStarts = type(state.flurry.seenStarts) == 'table'
            and state.flurry.seenStarts or {}
    state.flurry.sequence = type(state.flurry.sequence) == 'number'
            and state.flurry.sequence or 0
    state.seenCasts = type(state.seenCasts) == 'table' and state.seenCasts or {}
    state.trackedBossEntityIDs = type(state.trackedBossEntityIDs) == 'table'
            and state.trackedBossEntityIDs or {}
    return state
end

local function clearKnightState(state)
    ensureKnightState(state)
    state.spinning.sequences = {}
    state.spinning.seenStarts = {}
    state.cage.lines = {}
    state.cage.seenStarts = {}
    state.knockback.active = nil
    state.knockback.seenStarts = {}
    state.flurry.lines = {}
    state.flurry.seenStarts = {}
    state.flurry.sequence = 0
    state.seenCasts = {}
    state.trackedBossEntityIDs = {}
    state.bossLastSeenAt = nil
    state.lastActivityAt = nil
    state.lastDiagnostic = nil
end

local function knightStartKey(prefix, aoeInfo, now)
    local startTime = type(aoeInfo.startTime) == 'number' and aoeInfo.startTime or now
    return prefix
            .. ':' .. tostring(aoeInfo.entityID)
            .. ':' .. tostring(aoeInfo.aoeID)
            .. ':' .. tostring(math.floor(startTime))
end

local validXZ = Common.validXZ

local function validXYZ(pos)
    return validXZ(pos) and Common.finite(pos.y)
end

local function copyPosition(pos, fallbackY)
    return Common.copyPosition(pos, false, fallbackY or 0)
end

local function copyReliablePosition(pos)
    return Common.copyPosition(pos, false)
end

local function entityPosition(entityID)
    if type(entityID) ~= 'number'
            or type(TensorCore) ~= 'table'
            or type(TensorCore.mGetEntity) ~= 'function'
    then
        return nil
    end
    local entity = TensorCore.mGetEntity(entityID)
    return entity ~= nil and copyPosition(entity.pos) or nil
end

local function reliableEntityPosition(entityID)
    if type(entityID) ~= 'number'
            or type(TensorCore) ~= 'table'
            or type(TensorCore.mGetEntity) ~= 'function'
    then
        return nil
    end
    local entity = TensorCore.mGetEntity(entityID)
    return entity ~= nil and copyReliablePosition(entity.pos) or nil
end

local function eventPosition(entityID, castPos)
    return copyPosition(castPos) or entityPosition(entityID)
end

local function eventHeading(castPos)
    if type(castPos) == 'table' then
        if type(castPos.h) == 'number' then
            return castPos.h
        end
        if type(castPos.heading) == 'number' then
            return castPos.heading
        end
    end
    return nil
end

local distanceSquared = Common.distanceSquared
local normalized = Common.normalized

local function isInsideArena(pos, margin)
    if not validXZ(pos) then
        return false
    end
    local maxRadius = KNIGHT_ARENA_RADIUS - (margin or 0)
    return distanceSquared(pos, KNIGHT_ARENA_CENTER) <= maxRadius * maxRadius
end

local function isPointInForwardRect(pos, origin, heading, length, halfWidth)
    if not validXZ(pos) or not validXZ(origin) or type(heading) ~= 'number' then
        return false
    end
    local dx = pos.x - origin.x
    local dz = pos.z - origin.z
    local forward = dx * math.sin(heading) + dz * math.cos(heading)
    local lateral = dx * math.cos(heading) - dz * math.sin(heading)
    return forward >= 0 and forward <= length and math.abs(lateral) <= halfWidth
end

local function isPointInCross(pos, origin, heading)
    if not validXZ(pos) or not validXZ(origin) or type(heading) ~= 'number' then
        return false
    end
    local dx = pos.x - origin.x
    local dz = pos.z - origin.z
    local forward = dx * math.sin(heading) + dz * math.cos(heading)
    local lateral = dx * math.cos(heading) - dz * math.sin(heading)
    return math.abs(forward) <= SPINNING_CROSS_LENGTH
                    and math.abs(lateral) <= SPINNING_CROSS_HALF_WIDTH
            or math.abs(lateral) <= SPINNING_CROSS_LENGTH
                    and math.abs(forward) <= SPINNING_CROSS_HALF_WIDTH
end

local function spinningIncrement(spellID)
    if spellID == knightAID.SpinningSiegeCW then
        return -SPINNING_INCREMENT
    end
    if spellID == knightAID.SpinningSiegeCCW then
        return SPINNING_INCREMENT
    end
    return nil
end

local function consumeKnightEvent(bucket, key, now, dedupeMs)
    return Common.consumeEvent(
            bucket,
            key,
            now,
            dedupeMs or KNIGHT_EVENT_DEDUPE_MS)
end

local function recordKnightActor(state, entityID, now)
    if type(entityID) == 'number' then
        state.trackedBossEntityIDs[entityID] = true
    end
    state.lastActivityAt = now
    state.bossLastSeenAt = now
end

local knightDiagnosticText = {
    knockback_missing_source = '击退指路跳过：当前事件缺少可靠的击退中心。',
    knockback_waiting_cages = '击退指路等待：尚未取得同时激活的火线数据。',
    knockback_no_solution = '击退指路跳过：场内未找到避开火线的可靠落点。',
    flurry_missing_position = '连环爆炸未推进：实际爆炸事件缺少可靠坐标。',
    flurry_unmatched_position = '连环爆炸未推进：实际爆炸坐标无法匹配当前预测队列。',
}

local knightFeature = Common.newFeature({
    key = 'OccultKnight',
    newState = newKnightState,
    ensureState = ensureKnightState,
    diagnosticText = knightDiagnosticText,
})
local getKnightConfig = knightFeature.GetConfig
local getKnightRuntimeState = knightFeature.GetRuntimeState
local setKnightDiagnostic = knightFeature.Diagnostic

local function addSpinningSequence(state, aoeInfo, now)
    local increment = spinningIncrement(aoeInfo.aoeID)
    if increment == nil
            or type(aoeInfo.entityID) ~= 'number'
            or not validXZ(aoeInfo)
            or type(aoeInfo.heading) ~= 'number'
            or type(aoeInfo.duration) ~= 'number'
            or aoeInfo.duration < 0
            or aoeInfo.duration > 15
    then
        return false
    end

    local key = knightStartKey('spin', aoeInfo, now)
    if state.spinning.seenStarts[key] ~= nil then
        return false
    end
    local startTime = type(aoeInfo.startTime) == 'number' and aoeInfo.startTime or now
    local activation = startTime + aoeInfo.duration * 1000
    state.spinning.seenStarts[key] = now
    recordKnightActor(state, aoeInfo.entityID, now)
    state.spinning.sequences[#state.spinning.sequences + 1] = {
        key = key,
        entityID = aoeInfo.entityID,
        origin = copyPosition(aoeInfo),
        currentHeading = aoeInfo.heading,
        increment = increment,
        nextActivationAt = activation,
        castEndsAt = activation,
        resolvedCount = 0,
        remaining = SPINNING_CASTS,
        expiresAt = activation + SPINNING_INTERVAL_MS * SPINNING_CASTS + 4000,
    }
    return true
end

local function findSpinningSequence(state, entityID)
    local selected
    for _, sequence in ipairs(state.spinning.sequences) do
        if sequence.entityID == entityID and sequence.remaining > 0
                and (selected == nil
                or sequence.nextActivationAt < selected.nextActivationAt)
        then
            selected = sequence
        end
    end
    return selected
end

local function observeSpinningRepeat(state, aoeInfo, now)
    if type(aoeInfo.entityID) ~= 'number'
            or not validXZ(aoeInfo)
            or type(aoeInfo.heading) ~= 'number'
            or type(aoeInfo.duration) ~= 'number'
            or aoeInfo.duration < 0
            or aoeInfo.duration > 5
    then
        return false
    end
    local key = knightStartKey('spin-repeat', aoeInfo, now)
    if state.spinning.seenStarts[key] ~= nil then
        return false
    end
    local sequence = findSpinningSequence(state, aoeInfo.entityID)
    if sequence == nil then
        return false
    end
    local startTime = type(aoeInfo.startTime) == 'number' and aoeInfo.startTime or now
    state.spinning.seenStarts[key] = now
    sequence.origin = copyPosition(aoeInfo)
    sequence.currentHeading = aoeInfo.heading
    sequence.nextActivationAt = startTime + aoeInfo.duration * 1000
    sequence.expiresAt = sequence.nextActivationAt
            + SPINNING_INTERVAL_MS * sequence.remaining + 4000
    recordKnightActor(state, aoeInfo.entityID, now)
    return true
end

local function getSpinningPredictions(sequence, count)
    local predictions = {}
    local maxCount = math.min(count or 2, math.max(0, sequence.remaining - 1))
    for step = 1, maxCount do
        predictions[#predictions + 1] = {
            x = sequence.origin.x,
            y = sequence.origin.y,
            z = sequence.origin.z,
            heading = sequence.currentHeading + sequence.increment * step,
            activationAt = sequence.nextActivationAt + SPINNING_INTERVAL_MS * step,
        }
    end
    return predictions
end

local function advanceSpinning(state, entityID, spellID, castPos, now)
    if spellID ~= knightAID.SpinningSiegeCW
            and spellID ~= knightAID.SpinningSiegeCCW
            and spellID ~= knightAID.SpinningSiegeRepeat
    then
        return false
    end
    local sequence = findSpinningSequence(state, entityID)
    if sequence == nil then
        return false
    end
    local key = 'spin-cast:' .. tostring(entityID) .. ':' .. tostring(spellID)
    if not consumeKnightEvent(state.seenCasts, key, now) then
        return false
    end

    local observedPosition = eventPosition(entityID, castPos)
    if observedPosition ~= nil then
        sequence.origin = observedPosition
    end
    local observedHeading = eventHeading(castPos)
    if type(observedHeading) == 'number' then
        sequence.currentHeading = observedHeading + sequence.increment
    else
        sequence.currentHeading = sequence.currentHeading + sequence.increment
    end
    sequence.resolvedCount = sequence.resolvedCount + 1
    sequence.remaining = sequence.remaining - 1
    sequence.nextActivationAt = now + SPINNING_INTERVAL_MS
    sequence.expiresAt = sequence.nextActivationAt
            + SPINNING_INTERVAL_MS * math.max(0, sequence.remaining - 1) + 4000
    recordKnightActor(state, entityID, now)

    if sequence.remaining <= 0 then
        for index, candidate in ipairs(state.spinning.sequences) do
            if candidate == sequence then
                table.remove(state.spinning.sequences, index)
                break
            end
        end
    end
    return true
end

local function spinningGuideActive(sequence, now)
    return sequence.resolvedCount > 0
            or now >= sequence.nextActivationAt - SPINNING_FIRST_GUIDE_LEAD_MS
end

local function inInitialSweepSide(sequence, pos)
    if sequence.resolvedCount ~= 0 then
        return false
    end
    local centerX, centerZ = normalized(
            KNIGHT_ARENA_CENTER.x - sequence.origin.x,
            KNIGHT_ARENA_CENTER.z - sequence.origin.z)
    local pointX, pointZ = normalized(
            pos.x - sequence.origin.x,
            pos.z - sequence.origin.z)
    if centerX == nil or pointX == nil then
        return false
    end

    local sweepX
    local sweepZ
    if sequence.increment > 0 then
        sweepX = -centerZ
        sweepZ = centerX
    else
        sweepX = centerZ
        sweepZ = -centerX
    end
    return pointX * sweepX + pointZ * sweepZ >= math.sqrt(0.5)
end

local function spinningPointUnsafe(state, pos, now)
    for _, sequence in ipairs(state.spinning.sequences) do
        if spinningGuideActive(sequence, now) then
            local hazards = math.min(2, sequence.remaining)
            for step = 0, hazards - 1 do
                if isPointInCross(
                        pos,
                        sequence.origin,
                        sequence.currentHeading + sequence.increment * step)
                then
                    return true
                end
            end
            if inInitialSweepSide(sequence, pos) then
                return true
            end
        end
    end
    return false
end

local function findNearestArenaPoint(playerPos, unsafe)
    if not validXZ(playerPos)
            or type(playerPos.y) ~= 'number'
            or type(unsafe) ~= 'function'
    then
        return nil
    end
    local best
    local bestDistanceSq
    local function consider(candidate)
        if isInsideArena(candidate, KNIGHT_ARENA_MARGIN) and not unsafe(candidate) then
            local candidateDistanceSq = distanceSquared(candidate, playerPos)
            if best == nil or candidateDistanceSq < bestDistanceSq then
                best = candidate
                bestDistanceSq = candidateDistanceSq
            end
        end
    end

    consider(copyPosition(playerPos))
    consider({
        x = KNIGHT_ARENA_CENTER.x,
        y = playerPos.y,
        z = KNIGHT_ARENA_CENTER.z,
    })
    for radius = 2, KNIGHT_ARENA_RADIUS - KNIGHT_ARENA_MARGIN, 1.5 do
        for angleIndex = 0, 71 do
            local angle = angleIndex * math.pi / 36
            consider({
                x = KNIGHT_ARENA_CENTER.x + math.sin(angle) * radius,
                y = playerPos.y,
                z = KNIGHT_ARENA_CENTER.z + math.cos(angle) * radius,
            })
        end
    end
    return best
end

local function findSpinningSafePoint(state, playerPos, now)
    return findNearestArenaPoint(playerPos, function(candidate)
        return spinningPointUnsafe(state, candidate, now)
    end)
end

local function addCageLine(state, aoeInfo, now)
    if type(aoeInfo.entityID) ~= 'number'
            or not validXZ(aoeInfo)
            or type(aoeInfo.heading) ~= 'number'
            or type(aoeInfo.duration) ~= 'number'
            or aoeInfo.duration < 0
            or aoeInfo.duration > 15
    then
        return false
    end
    local key = knightStartKey('cage', aoeInfo, now)
    if state.cage.seenStarts[key] ~= nil then
        return false
    end
    local startTime = type(aoeInfo.startTime) == 'number' and aoeInfo.startTime or now
    local activation = startTime + aoeInfo.duration * 1000
    state.cage.seenStarts[key] = now
    state.cage.lines[#state.cage.lines + 1] = {
        key = key,
        entityID = aoeInfo.entityID,
        origin = copyPosition(aoeInfo),
        heading = aoeInfo.heading,
        activationAt = activation,
        expiresAt = activation + 5000,
    }
    if #state.cage.lines > 5 then
        local oldestIndex = 1
        for index = 2, #state.cage.lines do
            if state.cage.lines[index].activationAt
                    < state.cage.lines[oldestIndex].activationAt
            then
                oldestIndex = index
            end
        end
        table.remove(state.cage.lines, oldestIndex)
    end
    recordKnightActor(state, aoeInfo.entityID, now)
    return true
end

local function removeCageLine(state, entityID)
    local selectedIndex
    local selectedActivation
    for index, line in ipairs(state.cage.lines) do
        if line.entityID == entityID
                and (selectedActivation == nil or line.activationAt < selectedActivation)
        then
            selectedIndex = index
            selectedActivation = line.activationAt
        end
    end
    if selectedIndex ~= nil then
        table.remove(state.cage.lines, selectedIndex)
        return true
    end
    return false
end

local function startKnockback(state, aoeInfo, now, guide)
    if type(aoeInfo.entityID) ~= 'number'
            or type(aoeInfo.duration) ~= 'number'
            or aoeInfo.duration < 0
            or aoeInfo.duration > 10
    then
        return false
    end
    local key = knightStartKey('knockback', aoeInfo, now)
    if state.knockback.seenStarts[key] ~= nil then
        return false
    end
    local startTime = type(aoeInfo.startTime) == 'number' and aoeInfo.startTime or now
    local activation = startTime + aoeInfo.duration * 1000
    local source = copyPosition(aoeInfo) or entityPosition(aoeInfo.entityID)
    state.knockback.seenStarts[key] = now
    state.knockback.active = {
        key = key,
        entityID = aoeInfo.entityID,
        source = source,
        activationAt = activation,
        expiresAt = activation + 5000,
        solution = nil,
    }
    recordKnightActor(state, aoeInfo.entityID, now)
    if source == nil then
        setKnightDiagnostic(state, guide, 'knockback_missing_source', now, {
            entityID = aoeInfo.entityID,
        })
    end
    return true
end

local function pointInCageLines(pos, cageLines)
    for _, line in ipairs(cageLines or {}) do
        if isPointInForwardRect(
                pos, line.origin, line.heading, CAGE_LENGTH, CAGE_HALF_WIDTH)
        then
            return true
        end
    end
    return false
end

local function projectKnockback(source, startPos)
    if not validXZ(source) or not validXZ(startPos) then
        return nil
    end
    local dirX, dirZ = normalized(startPos.x - source.x, startPos.z - source.z)
    if dirX == nil then
        return nil
    end
    return {
        x = startPos.x + dirX * KNOCKBACK_DISTANCE,
        y = startPos.y or source.y or 0,
        z = startPos.z + dirZ * KNOCKBACK_DISTANCE,
    }
end

local function findKnockbackSolution(source, playerPos, cageLines)
    if not validXZ(source) or not validXZ(playerPos)
            or type(cageLines) ~= 'table' or #cageLines == 0
    then
        return nil
    end

    local best
    local bestDistanceSq
    for radiusIndex = 2, 10 do
        local radius = radiusIndex * 0.5
        for angleIndex = 0, 71 do
            local angle = angleIndex * math.pi / 36
            local startPos = {
                x = source.x + math.sin(angle) * radius,
                y = source.y or playerPos.y or 0,
                z = source.z + math.cos(angle) * radius,
            }
            local landing = projectKnockback(source, startPos)
            if isInsideArena(startPos, KNIGHT_ARENA_MARGIN)
                    and landing ~= nil
                    and isInsideArena(landing, KNIGHT_ARENA_MARGIN)
                    and not pointInCageLines(landing, cageLines)
            then
                local startDistanceSq = distanceSquared(startPos, playerPos)
                if best == nil or startDistanceSq < bestDistanceSq then
                    best = {
                        start = startPos,
                        landing = landing,
                    }
                    bestDistanceSq = startDistanceSq
                end
            end
        end
    end
    return best
end

local function updateKnockbackCast(state, entityID, castPos, now, guide)
    local active = state.knockback.active
    if active == nil then
        return false
    end
    local key = 'knockback-cast:' .. tostring(entityID)
    if not consumeKnightEvent(state.seenCasts, key, now) then
        return false
    end
    local source = eventPosition(entityID, castPos)
    if source ~= nil then
        active.source = source
    elseif active.source == nil then
        setKnightDiagnostic(state, guide, 'knockback_missing_source', now, {
            entityID = entityID,
        })
    end
    active.activationAt = now
    active.expiresAt = now + 5000
    recordKnightActor(state, active.entityID, now)
    return true
end

local function resolveKnockback(state, entityID, now)
    local key = 'knockback-resolve:' .. tostring(entityID)
    if not consumeKnightEvent(state.seenCasts, key, now) then
        return false
    end
    if state.knockback.active == nil then
        return false
    end
    state.knockback.active = nil
    state.lastActivityAt = now
    return true
end

local function startFlurry(state, aoeInfo, now)
    if type(aoeInfo.entityID) ~= 'number'
            or not validXZ(aoeInfo)
            or type(aoeInfo.heading) ~= 'number'
            or type(aoeInfo.duration) ~= 'number'
            or aoeInfo.duration < 0
            or aoeInfo.duration > 15
    then
        return false
    end
    local key = knightStartKey('flurry', aoeInfo, now)
    if state.flurry.seenStarts[key] ~= nil then
        return false
    end

    local startTime = type(aoeInfo.startTime) == 'number' and aoeInfo.startTime or now
    local castEndsAt = startTime + aoeInfo.duration * 1000
    local advanceX = math.sin(aoeInfo.heading) * FLURRY_STEP
    local advanceZ = math.cos(aoeInfo.heading) * FLURRY_STEP
    local positions = {}
    for index = 1, FLURRY_EXPLOSIONS do
        local step = index - 1
        positions[index] = {
            x = aoeInfo.x + advanceX * step,
            y = type(aoeInfo.y) == 'number' and aoeInfo.y or 0,
            z = aoeInfo.z + advanceZ * step,
        }
    end

    state.flurry.sequence = state.flurry.sequence + 1
    state.flurry.seenStarts[key] = now
    state.flurry.lines[#state.flurry.lines + 1] = {
        key = key,
        sequence = state.flurry.sequence,
        entityID = aoeInfo.entityID,
        advanceX = advanceX,
        advanceZ = advanceZ,
        positions = positions,
        castEndsAt = castEndsAt,
        nextActivationAt = castEndsAt + FLURRY_FIRST_DELAY_MS,
        resolvedIndex = 0,
        expiresAt = castEndsAt + FLURRY_FIRST_DELAY_MS
                + FLURRY_INTERVAL_MS * FLURRY_EXPLOSIONS + 4000,
    }
    recordKnightActor(state, aoeInfo.entityID, now)
    return true
end

local function getFlurryPredictions(line, count, skipCurrent)
    local predictions = {}
    local startIndex = line.resolvedIndex + 1 + (skipCurrent and 1 or 0)
    local endIndex = math.min(
            FLURRY_EXPLOSIONS,
            startIndex + (count or 3) - 1)
    for index = startIndex, endIndex do
        local pos = line.positions[index]
        if pos ~= nil then
            predictions[#predictions + 1] = {
                x = pos.x,
                y = pos.y,
                z = pos.z,
                index = index,
                activationAt = line.nextActivationAt
                        + FLURRY_INTERVAL_MS * (index - line.resolvedIndex - 1),
            }
        end
    end
    return predictions
end

local function findFlurryLine(state, actualPos)
    local selected
    local selectedDistanceSq
    for _, line in ipairs(state.flurry.lines) do
        local nextIndex = line.resolvedIndex + 1
        local expected = line.positions[nextIndex]
        if expected ~= nil then
            local currentDistanceSq = distanceSquared(expected, actualPos)
            if currentDistanceSq <= FLURRY_MATCH_DISTANCE_SQ
                    and (selected == nil
                    or line.nextActivationAt < selected.nextActivationAt
                    or line.nextActivationAt == selected.nextActivationAt
                            and currentDistanceSq < selectedDistanceSq
                    or line.nextActivationAt == selected.nextActivationAt
                            and currentDistanceSq == selectedDistanceSq
                            and line.sequence < selected.sequence)
            then
                selected = line
                selectedDistanceSq = currentDistanceSq
            end
        end
    end
    return selected
end

local function advanceFlurry(state, entityID, castPos, now, guide)
    local actualPos = eventPosition(entityID, castPos)
    if actualPos == nil then
        setKnightDiagnostic(state, guide, 'flurry_missing_position', now, {
            entityID = entityID,
        })
        return false
    end
    local key = 'flurry-hit:' .. tostring(entityID)
            .. ':' .. tostring(math.floor(actualPos.x * 10 + 0.5))
            .. ':' .. tostring(math.floor(actualPos.z * 10 + 0.5))
    if not consumeKnightEvent(state.seenCasts, key, now, 1000) then
        return false
    end

    local line = findFlurryLine(state, actualPos)
    if line == nil then
        setKnightDiagnostic(state, guide, 'flurry_unmatched_position', now, {
            entityID = entityID,
            x = actualPos.x,
            z = actualPos.z,
        })
        return false
    end

    local resolvedIndex = line.resolvedIndex + 1
    line.positions[resolvedIndex] = actualPos
    line.resolvedIndex = resolvedIndex
    for index = resolvedIndex + 1, FLURRY_EXPLOSIONS do
        local step = index - resolvedIndex
        line.positions[index] = {
            x = actualPos.x + line.advanceX * step,
            y = actualPos.y,
            z = actualPos.z + line.advanceZ * step,
        }
    end
    line.nextActivationAt = now + FLURRY_INTERVAL_MS
    line.expiresAt = line.nextActivationAt
            + FLURRY_INTERVAL_MS * (FLURRY_EXPLOSIONS - resolvedIndex) + 4000
    state.lastActivityAt = now

    if resolvedIndex >= FLURRY_EXPLOSIONS then
        for index, candidate in ipairs(state.flurry.lines) do
            if candidate == line then
                table.remove(state.flurry.lines, index)
                break
            end
        end
    end
    return true
end

local function observeFlurryRest(state, entityID, now)
    local key = 'flurry-rest:' .. tostring(entityID)
    if not consumeKnightEvent(state.seenCasts, key, now) then
        return false
    end
    state.lastActivityAt = now
    return #state.flurry.lines > 0
end

local function handleKnightAOECreate(state, aoeInfo, now, guide)
    if type(state) ~= 'table' or type(aoeInfo) ~= 'table'
            or type(aoeInfo.aoeID) ~= 'number'
    then
        return false
    end
    ensureKnightState(state)
    now = type(now) == 'number' and now or getNow()
    if aoeInfo.aoeID == knightAID.SpinningSiegeCW
            or aoeInfo.aoeID == knightAID.SpinningSiegeCCW
    then
        return addSpinningSequence(state, aoeInfo, now)
    end
    if aoeInfo.aoeID == knightAID.SpinningSiegeRepeat then
        return observeSpinningRepeat(state, aoeInfo, now)
    end
    if aoeInfo.aoeID == knightAID.CageOfFire then
        return addCageLine(state, aoeInfo, now)
    end
    if aoeInfo.aoeID == knightAID.BlastKnucklesCast then
        return startKnockback(state, aoeInfo, now, guide)
    end
    if aoeInfo.aoeID == knightAID.DualistFlurryFirst then
        return startFlurry(state, aoeInfo, now)
    end
    return false
end

local function handleKnightEntityCast(state, entityID, spellID, castPos, now, guide)
    if type(state) ~= 'table'
            or type(entityID) ~= 'number'
            or type(spellID) ~= 'number'
    then
        return false
    end
    ensureKnightState(state)
    now = type(now) == 'number' and now or getNow()
    if spellID == knightAID.SpinningSiegeCW
            or spellID == knightAID.SpinningSiegeCCW
            or spellID == knightAID.SpinningSiegeRepeat
    then
        return advanceSpinning(state, entityID, spellID, castPos, now)
    end
    if spellID == knightAID.CageOfFire then
        local key = 'cage-cast:' .. tostring(entityID)
        if not consumeKnightEvent(state.seenCasts, key, now) then
            return false
        end
        state.lastActivityAt = now
        return removeCageLine(state, entityID)
    end
    if spellID == knightAID.BlastKnucklesCast then
        return updateKnockbackCast(state, entityID, castPos, now, guide)
    end
    if spellID == knightAID.BlastKnuckles then
        return resolveKnockback(state, entityID, now)
    end
    if spellID == knightAID.DualistFlurryRest then
        return observeFlurryRest(state, entityID, now)
    end
    if spellID == knightAID.DualistFlurryAOE then
        return advanceFlurry(state, entityID, castPos, now, guide)
    end
    return false
end

local function hasKnightActivity(state)
    return #state.spinning.sequences > 0
            or #state.cage.lines > 0
            or state.knockback.active ~= nil
            or #state.flurry.lines > 0
end

local function pruneSeen(bucket, now)
    for key, seenAt in pairs(bucket) do
        if now - seenAt > KNIGHT_SEEN_TTL_MS then
            bucket[key] = nil
        end
    end
end

local function pruneKnightState(state, now)
    ensureKnightState(state)
    for index = #state.spinning.sequences, 1, -1 do
        if now > state.spinning.sequences[index].expiresAt then
            table.remove(state.spinning.sequences, index)
        end
    end
    for index = #state.cage.lines, 1, -1 do
        if now > state.cage.lines[index].expiresAt then
            table.remove(state.cage.lines, index)
        end
    end
    if state.knockback.active ~= nil and now > state.knockback.active.expiresAt then
        state.knockback.active = nil
    end
    for index = #state.flurry.lines, 1, -1 do
        if now > state.flurry.lines[index].expiresAt then
            table.remove(state.flurry.lines, index)
        end
    end
    pruneSeen(state.spinning.seenStarts, now)
    pruneSeen(state.cage.seenStarts, now)
    pruneSeen(state.knockback.seenStarts, now)
    pruneSeen(state.flurry.seenStarts, now)
    pruneSeen(state.seenCasts, now)
    if not hasKnightActivity(state) then
        state.trackedBossEntityIDs = {}
        state.bossLastSeenAt = nil
    end
end

local function hasLiveKnight(state)
    local checked = false
    if type(TensorCore) == 'table' and type(TensorCore.mGetEntity) == 'function' then
        for entityID in pairs(state.trackedBossEntityIDs) do
            checked = true
            local entity = TensorCore.mGetEntity(entityID)
            if entity ~= nil and entity.alive ~= false then
                return true
            end
        end
    end

    -- 13728 来自 BossMod NameID；本机暂无该遭遇日志，Minion contentid 对应关系需实战确认。
    if type(TensorCore) == 'table' and type(TensorCore.entityList) == 'function' then
        checked = true
        local entities = TensorCore.entityList('contentid=' .. tostring(KNIGHT_CONTENT_ID))
        if type(entities) == 'table' then
            for _, entity in pairs(entities) do
                if entity ~= nil
                        and entity.contentid == KNIGHT_CONTENT_ID
                        and entity.alive ~= false
                then
                    return true
                end
            end
        end
    end
    if checked then
        return false
    end
    return nil
end

local function getKnightDangerDrawer(guide)
    if knightDangerDrawer == nil and type(guide.CreateDrawer) == 'function' then
        knightDangerDrawer = guide.CreateDrawer(1, 0.25, 0, 0.2, 2, 0)
    end
    return knightDangerDrawer
end

local function drawSpinning(guide, cfg, state, now)
    if #state.spinning.sequences == 0 then
        return
    end
    local dangerDrawer = getKnightDangerDrawer(guide)
    if cfg.DrawSpinningPrediction and dangerDrawer ~= nil then
        for _, sequence in ipairs(state.spinning.sequences) do
            if spinningGuideActive(sequence, now) then
                for _, prediction in ipairs(getSpinningPredictions(sequence, 2)) do
                    dangerDrawer:addCross(
                            prediction.x,
                            prediction.y,
                            prediction.z,
                            SPINNING_CROSS_LENGTH,
                            SPINNING_CROSS_HALF_WIDTH * 2,
                            prediction.heading)
                end
            end
        end
    end

    if not cfg.DrawSpinningGuide or type(guide.FrameDirect) ~= 'function' then
        return
    end
    local anyGuideActive = false
    for _, sequence in ipairs(state.spinning.sequences) do
        if spinningGuideActive(sequence, now) then
            anyGuideActive = true
            break
        end
    end
    if not anyGuideActive then
        return
    end

    local player = type(guide.GetPlayer) == 'function' and guide.GetPlayer() or nil
    if player == nil or not validXZ(player.pos) then
        return
    end
    local safePoint = findSpinningSafePoint(state, player.pos, now)
    if safePoint ~= nil then
        local green = getGreenDrawer(guide)
        if green ~= nil then
            green:addCircle(safePoint.x, safePoint.y, safePoint.z, 0.8)
        end
        guide.FrameDirect(safePoint.x, safePoint.z, 0.45, greenGuideColor)
    end
end

local function drawKnockback(guide, cfg, state, now)
    local active = state.knockback.active
    if not cfg.DrawKnockbackGuide or active == nil then
        return
    end
    if active.source == nil then
        active.source = entityPosition(active.entityID)
    end
    if active.source == nil then
        active.solution = nil
        setKnightDiagnostic(state, guide, 'knockback_missing_source', now, {
            entityID = active.entityID,
        })
        return
    end
    if #state.cage.lines == 0 then
        active.solution = nil
        setKnightDiagnostic(state, guide, 'knockback_waiting_cages', now)
        return
    end

    local player = type(guide.GetPlayer) == 'function' and guide.GetPlayer() or nil
    if player == nil or not validXZ(player.pos) then
        return
    end
    active.solution = findKnockbackSolution(active.source, player.pos, state.cage.lines)
    if active.solution == nil then
        setKnightDiagnostic(state, guide, 'knockback_no_solution', now)
        return
    end

    local drawer = getGreenDrawer(guide)
    if drawer ~= nil then
        local start = active.solution.start
        local landing = active.solution.landing
        drawer:addCircle(start.x, start.y, start.z, 0.9)
        drawer:addCircle(landing.x, landing.y, landing.z, 1.2)
        drawer:addLine(
                start.x, start.y, start.z,
                landing.x, landing.y, landing.z,
                0.12, 0.25)
    end
    if type(guide.FrameDirect) == 'function' then
        guide.FrameDirect(
                active.solution.start.x,
                active.solution.start.z,
                0.45,
                greenGuideColor)
    end
end

local function drawFlurry(guide, cfg, state, now)
    if not cfg.DrawFlurryPrediction or #state.flurry.lines == 0 then
        return
    end
    local drawer = getKnightDangerDrawer(guide)
    if drawer == nil then
        return
    end
    for _, line in ipairs(state.flurry.lines) do
        local skipCurrent = line.resolvedIndex == 0 and now < line.castEndsAt
        for _, prediction in ipairs(getFlurryPredictions(line, 3, skipCurrent)) do
            drawer:addCircle(
                    prediction.x,
                    prediction.y,
                    prediction.z,
                    FLURRY_RADIUS)
        end
    end
end

local function updateKnight(guide, cfg, state)
    if not cfg.Enable then
        if hasKnightActivity(state)
                or next(state.seenCasts) ~= nil
                or next(state.trackedBossEntityIDs) ~= nil
        then
            clearKnightState(state)
        end
        return
    end

    local now = getNow()
    pruneKnightState(state, now)
    if not hasKnightActivity(state) then
        return
    end

    local bossPresent = hasLiveKnight(state)
    if bossPresent == true then
        state.bossLastSeenAt = now
    elseif bossPresent == false
            and state.bossLastSeenAt ~= nil
            and now - state.bossLastSeenAt > BOSS_MISSING_CLEAR_MS
    then
        clearKnightState(state)
        return
    end

    drawSpinning(guide, cfg, state, now)
    drawKnockback(guide, cfg, state, now)
    drawFlurry(guide, cfg, state, now)
end


return {
    AID = knightAID,
    ArenaCenter = KNIGHT_ARENA_CENTER,
    ArenaRadius = KNIGHT_ARENA_RADIUS,
    NewState = newKnightState,
    EnsureState = ensureKnightState,
    ClearState = clearKnightState,
    GetConfig = getKnightConfig,
    GetRuntimeState = getKnightRuntimeState,
    PruneState = pruneKnightState,
    HandleAOECreate = handleKnightAOECreate,
    HandleEntityCast = handleKnightEntityCast,
    GetSpinningPredictions = getSpinningPredictions,
    FindSpinningSafePoint = findSpinningSafePoint,
    FindNearestArenaPoint = findNearestArenaPoint,
    IsPointInCross = isPointInCross,
    IsPointInForwardRect = isPointInForwardRect,
    ProjectKnockback = projectKnockback,
    FindKnockbackSolution = findKnockbackSolution,
    GetFlurryPredictions = getFlurryPredictions,
    HasActivity = hasKnightActivity,
    Update = updateKnight,
}
end

rawset(_G, 'MuAiOccultCrescentSouthOccultKnight', Module)
return Module
