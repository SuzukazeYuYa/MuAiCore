local Module = {}

function Module.Create(Context)
    assert(type(Context) == 'table' and type(Context.Common) == 'table')
    local Common = Context.Common
    local finite = Context.finite
    local nowMs = Context.nowMs
    local reliablePosition = Context.reliablePosition
    local resolveEntity = Context.resolveEntity

local CONTENT_ID = 14801
local HELPER_MODEL_ID = 9020
local BOSS_MODEL_ID = 19575
local RUSH_ROUTE_CONTENT_ID = 2015387
local OMEN_EFFECT = 'o6b2_fan60_o0r1'
local BREATH_RADIUS = 60
local BREATH_ANGLE = math.rad(60)
local BREATH_TIMEOUT_GRACE_MS = 1500
local TOKEN_GRACE_MS = 1000
local OMEN_GROUP_WINDOW_MS = 5000
local OMEN_ROUND_TIMEOUT_MS = 20000
local SEEN_TTL_MS = 30000
local HEADING_TOLERANCE = math.rad(5)
local POSITION_TOLERANCE_SQUARED = 0.5 * 0.5
local RUSH_ACTION_ID = 48343
local RUSH_FOLLOWUP_ACTION_ID = 48344
local RUSH_CHANNEL_TIME = 5.7
local RUSH_AOE_CAST_TYPE = 8
local RUSH_AOE_TYPE = 2
local RUSH_AOE_EFFECT = 'general02f'
local RUSH_AOE_LENGTH = 25
local RUSH_AOE_WIDTH = 10
local RUSH_AOE_TOLERANCE = 0.25
local RUSH_EVENT_FRESH_PAST_MS = 1000
local RUSH_EVENT_FRESH_FUTURE_MS = 250
local RUSH_DRAW_LEAD_MS = 5000
local RUSH_SEGMENT_INTERVAL_MS = 2250
local RUSH_TIMEOUT_GRACE_MS = 1000
local RUSH_PHASE_TIMEOUT_MS = 16000
local RUSH_ROUTE_WINDOW_GRACE_MS = 500
local RUSH_WIDTH = 10
local RUSH_CENTER_ARROW_MIN_DISTANCE = 2.5
local RUSH_CENTER_ARROW_MAX_DISTANCE = 5.5
local RUSH_BOUNDARY_MIN_DISTANCE = 23.5
local RUSH_BOUNDARY_MAX_DISTANCE = 26.5
local RUSH_CROSS_TRACK_TOLERANCE = 0.75
local RUSH_SEGMENT_LENGTHS = {
    25,
    math.sqrt(1250),
    50,
    math.sqrt(1250),
}
local RUSH_SEGMENT_LENGTH_TOLERANCE = 1
local DONUT_SOURCE = 'MuAiCore - 变形法师'
local DONUT_BLACKLIST_SOURCE = DONUT_SOURCE .. '月环直绘'
local SUPERCELL_INITIAL_STEEL_ACTION_ID = 50767
local SUPERCELL_STEEL_ACTION_ID = 48360
local SUPERCELL_INNER_RING_ACTION_ID = 48361
local SUPERCELL_DONUT_ACTION_ID = 48362
local SUPERCELL_STEEL_EFFECT = 'general_1bf'
local SUPERCELL_INNER_RING_EFFECT = 'gl_sircle_2010bf'
local SUPERCELL_DONUT_EFFECT = 'gl_donut3016_o0r1'
local SUPERCELL_STEEL_RADIUS = 8
local SUPERCELL_INNER_RING_OUTER = 16
local SUPERCELL_DONUT_INNER = SUPERCELL_INNER_RING_OUTER
local SUPERCELL_DONUT_OUTER = 30
local SUPERCELL_DONUT_DURATION = 5.7
local SUPERCELL_DONUT_DELAY = 4.5
local SUPERCELL_DONUT_TOLERANCE = 0.15
local SUPERCELL_PAIR_MIN_MS = 2200
local SUPERCELL_PAIR_MAX_MS = 2800

local SUPERCELL_STEEL_SPECS = {
    [SUPERCELL_INITIAL_STEEL_ACTION_ID] = { delay = 0 },
    [SUPERCELL_STEEL_ACTION_ID] = { delay = SUPERCELL_DONUT_DELAY },
}

local SUPERCELL_RING_SPECS = {
    [SUPERCELL_INNER_RING_ACTION_ID] = {
        aoeType = 111,
        effect = SUPERCELL_INNER_RING_EFFECT,
        outer = SUPERCELL_INNER_RING_OUTER,
        predecessors = {
            [SUPERCELL_INITIAL_STEEL_ACTION_ID] = true,
            [SUPERCELL_STEEL_ACTION_ID] = true,
        },
    },
    [SUPERCELL_DONUT_ACTION_ID] = {
        aoeType = 764,
        effect = SUPERCELL_DONUT_EFFECT,
        outer = SUPERCELL_DONUT_OUTER,
        predecessors = {
            [SUPERCELL_INNER_RING_ACTION_ID] = true,
        },
    },
}

local DEFAULTS = {
    Enable = true,
    CorrectSupercellDonut = true,
    DrawHellishBreathPrediction = true,
    DrawHellfireRushPrediction = true,
}

-- The three helper omens are delivered together. Their headings are the
-- headings used by the later real breaths; the helper actors turn back before
-- those breaths, so retaining this event geometry is essential.
local OMEN_SPECS = {
    [48347] = {
        order = 1,
        duration = 1.7,
        delay = 0,
        activationOffsetMs = 8250,
    },
    [48348] = {
        order = 2,
        duration = 3.7,
        delay = 2,
        activationOffsetMs = 10350,
    },
    [48349] = {
        order = 3,
        duration = 5.7,
        delay = 4,
        activationOffsetMs = 12450,
    },
}
local OMEN_ORDER = { 48347, 48348, 48349 }
local REAL_BREATH_ACTIONS = {
    [48662] = true,
    [48663] = true,
    [50677] = true,
}

-- Each ring begins exactly where the preceding observed AOE ends: the
-- 8-yalm steel predicts 48361's inner edge, then 48361's 16-yalm outer edge
-- predicts 48362's inner edge. Moogle needs both custom inner radii.
local SUPERCELL_DONUTS = {
    [SUPERCELL_INNER_RING_ACTION_ID] = {
        name = '超级细胞变形内环',
        radius = SUPERCELL_STEEL_RADIUS,
    },
    [SUPERCELL_DONUT_ACTION_ID] = {
        name = '超级细胞变形外环',
        radius = SUPERCELL_DONUT_INNER,
    },
}

local function newMoogleState()
    return {
        registered = false,
        owned = {},
        previous = {},
        previousKnown = {},
    }
end

local function newState()
    return {
        seen = {},
        omenRound = nil,
        rush = nil,
        supercellPrevious = nil,
        active = {},
        moogle = newMoogleState(),
        blacklist = {
            registered = false,
            owned = {},
        },
        lastDiagnostic = nil,
    }
end

local function ensureState(state)
    state = type(state) == 'table' and state or newState()
    state.seen = type(state.seen) == 'table' and state.seen or {}
    state.active = type(state.active) == 'table' and state.active or {}
    state.moogle = type(state.moogle) == 'table'
            and state.moogle or newMoogleState()
    state.moogle.registered = state.moogle.registered == true
    state.moogle.owned = type(state.moogle.owned) == 'table'
            and state.moogle.owned or {}
    state.moogle.previous = type(state.moogle.previous) == 'table'
            and state.moogle.previous or {}
    state.moogle.previousKnown = type(state.moogle.previousKnown) == 'table'
            and state.moogle.previousKnown or {}
    state.blacklist = type(state.blacklist) == 'table'
            and state.blacklist or { registered = false, owned = {} }
    state.blacklist.registered = state.blacklist.registered == true
    state.blacklist.owned = type(state.blacklist.owned) == 'table'
            and state.blacklist.owned or {}
    return state
end

local feature = Common.newFeature({
    key = 'ShapeshiftingMage',
    defaults = DEFAULTS,
    newState = newState,
    ensureState = ensureState,
    diagnosticThrottleMs = 1000,
    diagnosticText = {
        omen_geometry_invalid = '变形法师炼狱吐息预兆缺少可靠几何',
        omen_set_conflict = '变形法师炼狱吐息预兆集合冲突',
        omen_heading_pattern_invalid = '变形法师炼狱吐息预兆方向不完整',
        danger_drawer_unavailable = '变形法师危险范围绘图器不可用',
        danger_drawer_rejected_shape = '变形法师炼狱吐息预测绘制失败',
        rush_channel_invalid = '变形法师烈火地狱冲读条信息不可靠',
        rush_aoe_invalid = '变形法师烈火地狱冲初始AOE几何不可靠',
        rush_route_object_invalid = '变形法师烈火地狱冲箭头对象不可靠',
        rush_route_conflict = '变形法师烈火地狱冲箭头集合冲突',
        rush_route_geometry_invalid = '变形法师烈火地狱冲路线不完整',
        rush_drawer_rejected_shape = '变形法师烈火地狱冲矩形绘制失败',
        supercell_geometry_invalid = '变形法师超级细胞月环事件几何不可靠',
        supercell_drawer_unavailable = '变形法师超级细胞月环绘图器不可用',
        supercell_drawer_rejected_shape = '变形法师超级细胞月环绘制失败',
    },
})
local getConfig = feature.GetConfig

local function getState()
    return Common.getRuntimeState(
            'ShapeshiftingMage', newState, ensureState)
end

local function diagnostic(state, code, now, context)
    feature.Diagnostic(
            state, rawget(_G, 'MuAiGuide'), code, now, context)
end

local donutRegistry = Common.newMoogleDonutRegistry({
    entries = SUPERCELL_DONUTS,
    source = DONUT_SOURCE,
    ensureState = ensureState,
    getBucket = function(state)
        return ensureState(state).moogle
    end,
})

local function applyDonutFallback(state, enabled)
    state = ensureState(state)
    local donuts = Common.getMoogleTable(
            'aoeIDUserSetDonuts', enabled == true)
    if enabled == true
            and donuts ~= nil
            and state.moogle.tableRef ~= nil
            and state.moogle.tableRef ~= donuts
    then
        state.moogle = newMoogleState()
    end
    local applied = donutRegistry.Apply(state, enabled == true)
    if enabled == true and donuts ~= nil then
        state.moogle.tableRef = donuts
    elseif enabled ~= true then
        state.moogle.tableRef = nil
    end
    return applied
end

local function getDonutBlacklist(create)
    return Common.getMoogleTable('aoeIDUserBlacklist', create)
end

local function ownsDonutBlacklist(state, actionID, current)
    return current ~= nil
            and (current == state.blacklist.owned[actionID]
            or (type(current) == 'table'
                    and current.source == DONUT_BLACKLIST_SOURCE))
end

local function registerDonutBlacklist(state)
    state = ensureState(state)
    local blacklist = getDonutBlacklist(true)
    if blacklist == nil then
        state.blacklist.registered = false
        return false
    end
    for actionID, entry in pairs(SUPERCELL_DONUTS) do
        local current = blacklist[actionID]
        if current == nil then
            local owned = {
                label = entry.name .. '直绘',
                source = DONUT_BLACKLIST_SOURCE,
            }
            blacklist[actionID] = owned
            state.blacklist.owned[actionID] = owned
        elseif type(current) == 'table'
                and current.source == DONUT_BLACKLIST_SOURCE
        then
            state.blacklist.owned[actionID] = current
        else
            state.blacklist.owned[actionID] = nil
        end
    end
    state.blacklist.registered = true
    return true
end

local function unregisterDonutBlacklist(state)
    state = ensureState(state)
    local blacklist = getDonutBlacklist(false)
    if blacklist == nil then
        state.blacklist.registered = false
        return false
    end
    for actionID in pairs(SUPERCELL_DONUTS) do
        local current = blacklist[actionID]
        if ownsDonutBlacklist(state, actionID, current) then
            blacklist[actionID] = nil
        end
    end
    state.blacklist.owned = {}
    state.blacklist.registered = false
    return true
end

local function applyDonutBlacklist(state, enabled)
    if enabled == true then
        return registerDonutBlacklist(state)
    end
    return unregisterDonutBlacklist(state)
end

local function hasExternalDonutBlacklist(state, actionID)
    state = ensureState(state)
    local blacklist = getDonutBlacklist(false)
    local current = blacklist ~= nil
            and blacklist[actionID] or nil
    return current ~= nil
            and not ownsDonutBlacklist(state, actionID, current)
end

local function getDangerDrawer()
    if type(TensorCore) ~= 'table'
            or type(TensorCore.getMoogleDrawer) ~= 'function'
    then
        return nil
    end
    local drawer = TensorCore.getMoogleDrawer()
    return type(drawer) == 'table' and drawer or nil
end

local function deleteActive(state, key)
    local entry = type(state) == 'table'
            and type(state.active) == 'table'
            and state.active[key] or nil
    if type(entry) ~= 'table' then
        return false
    end
    Common.deleteTimedShape(entry.token)
    state.active[key] = nil
    return true
end

local function clearPredictions(state)
    state = ensureState(state)
    local keys = {}
    for key in pairs(state.active) do
        keys[#keys + 1] = key
    end
    for _, key in ipairs(keys) do
        deleteActive(state, key)
    end
end

local function clearPredictionsWithPrefix(state, prefix)
    state = ensureState(state)
    local keys = {}
    for key in pairs(state.active) do
        if key:sub(1, #prefix) == prefix then
            keys[#keys + 1] = key
        end
    end
    for _, key in ipairs(keys) do
        deleteActive(state, key)
    end
end

local function clearBreathPredictions(state)
    clearPredictionsWithPrefix(state, 'breath:')
end

local function clearRushPredictions(state)
    clearPredictionsWithPrefix(state, 'rush:')
end

local function clearState(state)
    state = ensureState(state)
    clearPredictions(state)
    state.seen = {}
    state.omenRound = nil
    state.rush = nil
    state.supercellPrevious = nil
    state.lastDiagnostic = nil
end

local function reliableAOEPosition(aoeInfo)
    if type(aoeInfo) ~= 'table' then
        return nil
    end
    return reliablePosition({
        x = aoeInfo.x,
        y = aoeInfo.y,
        z = aoeInfo.z,
    }, false)
end

local function supercellDrawerAvailable()
    local drawer = getDangerDrawer()
    return drawer ~= nil and type(drawer.addTimedDonut) == 'function'
end

local function applySupercellRendering(state, enabled)
    if enabled == true and supercellDrawerAvailable() then
        applyDonutFallback(state, false)
        return applyDonutBlacklist(state, true)
    end
    applyDonutBlacklist(state, false)
    return applyDonutFallback(state, enabled == true)
end

local function validateHelper(entityID, source)
    local entity = resolveEntity(entityID)
    local entityPosition = type(entity) == 'table'
            and reliablePosition(entity.pos, false) or nil
    local distance = entityPosition ~= nil
            and Common.distanceSquared(entityPosition, source) or nil
    if type(entity) ~= 'table'
            or tonumber(entity.id) ~= entityID
            or tonumber(entity.contentid) ~= CONTENT_ID
            or tonumber(entity.modelid) ~= HELPER_MODEL_ID
            or entity.alive == false
            or distance == nil
            or distance > POSITION_TOLERANCE_SQUARED
    then
        return nil
    end
    return entity
end

local function eventKey(aoeInfo)
    return tostring(aoeInfo.entityID)
            .. ':' .. tostring(aoeInfo.aoeID)
            .. ':' .. string.format('%.3f', aoeInfo.startTime)
end

local function validateSupercellAOE(state, aoeInfo, now)
    local actionID = type(aoeInfo) == 'table'
            and tonumber(aoeInfo.aoeID) or nil
    local steelSpec = SUPERCELL_STEEL_SPECS[actionID]
    local ringSpec = SUPERCELL_RING_SPECS[actionID]
    local source = reliableAOEPosition(aoeInfo)
    local effectInfo = type(aoeInfo) == 'table'
            and type(aoeInfo.aoeEffectInfo) == 'table'
            and aoeInfo.aoeEffectInfo or nil
    local entityID = type(aoeInfo) == 'table'
            and tonumber(aoeInfo.entityID) or nil
    local expectedCastType = steelSpec ~= nil and 2 or 10
    local expectedAOEType = steelSpec ~= nil and 1
            or (ringSpec ~= nil and ringSpec.aoeType or nil)
    local expectedLength = steelSpec ~= nil and SUPERCELL_STEEL_RADIUS
            or (ringSpec ~= nil and ringSpec.outer or nil)
    local expectedDelay = steelSpec ~= nil and steelSpec.delay
            or SUPERCELL_DONUT_DELAY
    local expectedEffect = steelSpec ~= nil and SUPERCELL_STEEL_EFFECT
            or (ringSpec ~= nil and ringSpec.effect or nil)
    if not finite(now)
            or type(aoeInfo) ~= 'table'
            or (steelSpec == nil and ringSpec == nil)
            or tonumber(aoeInfo.contentID) ~= CONTENT_ID
            or tonumber(aoeInfo.aoeCastType) ~= expectedCastType
            or tonumber(aoeInfo.aoeType) ~= expectedAOEType
            or not finite(aoeInfo.aoeLength)
            or math.abs(aoeInfo.aoeLength - expectedLength) > 0.5
            or not finite(aoeInfo.duration)
            or math.abs(aoeInfo.duration - SUPERCELL_DONUT_DURATION)
                    > SUPERCELL_DONUT_TOLERANCE
            or not finite(aoeInfo.delay)
            or math.abs(aoeInfo.delay - expectedDelay)
                    > SUPERCELL_DONUT_TOLERANCE
            or not finite(aoeInfo.startTime)
            or not finite(entityID)
            or effectInfo == nil
            or effectInfo.aoeEffectName ~= expectedEffect
            or source == nil
    then
        diagnostic(state, 'supercell_geometry_invalid',
                finite(now) and now or nowMs(), {
                    actionID = actionID,
                    entityID = entityID,
                })
        return nil
    end
    return {
        actionID = actionID,
        entityID = entityID,
        source = source,
        outer = expectedLength,
        predecessors = ringSpec ~= nil and ringSpec.predecessors or nil,
        durationMs = math.floor(aoeInfo.duration * 1000 + 0.5),
        eventKey = eventKey(aoeInfo),
    }
end

local function handleSupercellAOE(state, aoeInfo, now)
    state = ensureState(state)
    local entry = validateSupercellAOE(state, aoeInfo, now)
    if entry == nil or state.seen[entry.eventKey] ~= nil then
        return false
    end
    local inner
    if entry.predecessors ~= nil then
        local previous = state.supercellPrevious
        local elapsed = type(previous) == 'table'
                and now - (tonumber(previous.receivedAt) or math.huge)
                or nil
        local centerDistance = type(previous) == 'table'
                and Common.distanceSquared(previous.source, entry.source)
                or nil
        if type(previous) ~= 'table'
                or entry.predecessors[previous.actionID] ~= true
                or not finite(elapsed)
                or elapsed < SUPERCELL_PAIR_MIN_MS
                or elapsed > SUPERCELL_PAIR_MAX_MS
                or centerDistance == nil
                or centerDistance > POSITION_TOLERANCE_SQUARED
                or not finite(previous.outer)
                or previous.outer >= entry.outer
        then
            diagnostic(state, 'supercell_geometry_invalid', now, {
                actionID = entry.actionID,
                previousActionID = type(previous) == 'table'
                        and previous.actionID or nil,
                pairElapsed = elapsed,
            })
            return false
        end
        inner = previous.outer
    end
    state.seen[entry.eventKey] = now
    state.supercellPrevious = {
        actionID = entry.actionID,
        outer = entry.outer,
        source = entry.source,
        receivedAt = now,
    }
    if inner == nil then
        state.lastDiagnostic = nil
        return true
    end
    if hasExternalDonutBlacklist(state, entry.actionID) then
        return false
    end
    local drawer = getDangerDrawer()
    if drawer == nil or type(drawer.addTimedDonut) ~= 'function' then
        applySupercellRendering(state, true)
        diagnostic(state, 'supercell_drawer_unavailable', now)
        return false
    end
    local key = 'donut:' .. tostring(entry.actionID)
            .. ':' .. tostring(entry.entityID)
    deleteActive(state, key)
    local token = drawer:addTimedDonut(
            entry.durationMs,
            entry.source.x, entry.source.y, entry.source.z,
            inner, entry.outer,
            0, nil, true)
    if type(token) ~= 'string' then
        applyDonutBlacklist(state, false)
        applyDonutFallback(state, true)
        diagnostic(state, 'supercell_drawer_rejected_shape', now, {
            entityID = entry.entityID,
        })
        return false
    end
    state.active[key] = {
        key = key,
        token = token,
        entityID = entry.entityID,
        actionID = entry.actionID,
        expiresAt = now + entry.durationMs + TOKEN_GRACE_MS,
    }
    state.lastDiagnostic = nil
    return true
end

local function validateOmen(state, aoeInfo, now)
    local actionID = type(aoeInfo) == 'table'
            and tonumber(aoeInfo.aoeID) or nil
    local spec = OMEN_SPECS[actionID]
    if spec == nil then
        return nil
    end
    local source = reliableAOEPosition(aoeInfo)
    local effectInfo = type(aoeInfo.aoeEffectInfo) == 'table'
            and aoeInfo.aoeEffectInfo or nil
    local entityID = tonumber(aoeInfo.entityID)
    if not finite(now)
            or not finite(entityID)
            or tonumber(aoeInfo.contentID) ~= CONTENT_ID
            or tonumber(aoeInfo.aoeCastType) ~= 13
            or not finite(aoeInfo.aoeLength)
            or math.abs(aoeInfo.aoeLength - BREATH_RADIUS) > 0.5
            or not finite(aoeInfo.heading)
            or not finite(aoeInfo.duration)
            or math.abs(aoeInfo.duration - spec.duration) > 0.15
            or not finite(aoeInfo.delay)
            or math.abs(aoeInfo.delay - spec.delay) > 0.15
            or not finite(aoeInfo.startTime)
            or effectInfo == nil
            or effectInfo.aoeEffectName ~= OMEN_EFFECT
            or source == nil
            or validateHelper(entityID, source) == nil
    then
        diagnostic(state, 'omen_geometry_invalid',
                finite(now) and now or nowMs(), {
                    actionID = actionID,
                    entityID = entityID,
                })
        return nil
    end
    return {
        actionID = actionID,
        entityID = entityID,
        heading = aoeInfo.heading,
        source = source,
        observedAt = now,
        activationOffsetMs = spec.activationOffsetMs,
    }
end

local function headingPatternValid(entries)
    local distances = {}
    for left = 1, #OMEN_ORDER - 1 do
        for right = left + 1, #OMEN_ORDER do
            local leftEntry = entries[OMEN_ORDER[left]]
            local rightEntry = entries[OMEN_ORDER[right]]
            local difference = leftEntry ~= nil and rightEntry ~= nil
                    and Common.headingDifference(
                            leftEntry.heading, rightEntry.heading) or nil
            if difference == nil then
                return false
            end
            distances[#distances + 1] = difference
        end
    end
    table.sort(distances)
    return #distances == 3
            and math.abs(distances[1] - math.rad(60))
                    <= HEADING_TOLERANCE
            and math.abs(distances[2] - math.rad(60))
                    <= HEADING_TOLERANCE
            and math.abs(distances[3] - math.rad(120))
                    <= HEADING_TOLERANCE
end

local function drawCompletedRound(state, round, now)
    if not headingPatternValid(round.entries) then
        diagnostic(state, 'omen_heading_pattern_invalid', now, {
            startedAt = round.startedAt,
        })
        return false
    end
    local drawer = getDangerDrawer()
    if drawer == nil or type(drawer.addTimedCone) ~= 'function' then
        diagnostic(state, 'danger_drawer_unavailable', now)
        return false
    end
    local created = {}
    for _, actionID in ipairs(OMEN_ORDER) do
        local entry = round.entries[actionID]
        local timeout = entry.activationOffsetMs
                + BREATH_TIMEOUT_GRACE_MS
        local token = drawer:addTimedCone(
                timeout,
                round.source.x, round.source.y, round.source.z,
                BREATH_RADIUS, BREATH_ANGLE, entry.heading)
        if type(token) ~= 'string' then
            for _, item in ipairs(created) do
                Common.deleteTimedShape(item.token)
            end
            diagnostic(state, 'danger_drawer_rejected_shape', now, {
                actionID = actionID,
                entityID = entry.entityID,
            })
            return false
        end
        created[#created + 1] = {
            key = 'breath:' .. tostring(entry.entityID),
            token = token,
            entityID = entry.entityID,
            omenActionID = actionID,
            expiresAt = now + timeout + TOKEN_GRACE_MS,
        }
    end
    for _, item in ipairs(created) do
        state.active[item.key] = item
    end
    round.completed = true
    round.expiresAt = now + OMEN_ROUND_TIMEOUT_MS
    state.lastDiagnostic = nil
    return true
end

local function startRound(state, entry, now)
    clearBreathPredictions(state)
    state.omenRound = {
        startedAt = now,
        source = entry.source,
        entries = {},
        completed = false,
        expiresAt = now + OMEN_ROUND_TIMEOUT_MS,
    }
    return state.omenRound
end

local function distance2d(left, right)
    if type(left) ~= 'table' or type(right) ~= 'table'
            or not finite(left.x) or not finite(left.z)
            or not finite(right.x) or not finite(right.z)
    then
        return nil
    end
    local dx = right.x - left.x
    local dz = right.z - left.z
    return math.sqrt(dx * dx + dz * dz)
end

local function rayMetrics(source, target, heading)
    local length = distance2d(source, target)
    if length == nil or length <= 0 or not finite(heading) then
        return nil
    end
    local dx = target.x - source.x
    local dz = target.z - source.z
    local directionX = math.sin(heading)
    local directionZ = math.cos(heading)
    return {
        length = length,
        forward = dx * directionX + dz * directionZ,
        crossTrack = math.abs(directionX * dz - directionZ * dx),
    }
end

local function removeEntry(entries, selected)
    local remaining = {}
    for _, entry in ipairs(entries) do
        if entry ~= selected then
            remaining[#remaining + 1] = entry
        end
    end
    return remaining
end

local function findNextRouteEntry(source, heading, entries)
    local selected = nil
    for _, entry in ipairs(entries) do
        local metrics = rayMetrics(source, entry.position, heading)
        if metrics ~= nil
                and metrics.forward > 0
                and metrics.crossTrack <= RUSH_CROSS_TRACK_TOLERANCE
        then
            if selected ~= nil then
                return nil
            end
            selected = entry
        end
    end
    return selected
end

local function segmentLengthValid(segment, index)
    return type(segment) == 'table'
            and finite(segment.length)
            and math.abs(segment.length - RUSH_SEGMENT_LENGTHS[index])
                    <= RUSH_SEGMENT_LENGTH_TOLERANCE
end

local function buildRushSegments(phase)
    if type(phase) ~= 'table'
            or type(phase.origin) ~= 'table'
            or type(phase.routeObjects) ~= 'table'
    then
        return nil
    end
    local entries = {}
    for _, entry in pairs(phase.routeObjects) do
        entries[#entries + 1] = entry
    end
    if #entries ~= 4 then
        return nil
    end

    local centerArrow = nil
    local boundary = {}
    local radiusTotal = 0
    for _, entry in ipairs(entries) do
        local radius = distance2d(phase.origin, entry.position)
        if radius ~= nil
                and radius >= RUSH_CENTER_ARROW_MIN_DISTANCE
                and radius <= RUSH_CENTER_ARROW_MAX_DISTANCE
        then
            if centerArrow ~= nil then
                return nil
            end
            centerArrow = entry
        elseif radius ~= nil
                and radius >= RUSH_BOUNDARY_MIN_DISTANCE
                and radius <= RUSH_BOUNDARY_MAX_DISTANCE
        then
            boundary[#boundary + 1] = entry
            radiusTotal = radiusTotal + radius
        else
            return nil
        end
    end
    if centerArrow == nil or #boundary ~= 3 then
        return nil
    end

    local segments = {}
    local source = phase.origin
    local arrow = centerArrow
    local remaining = boundary
    for index = 1, 3 do
        local nextEntry = findNextRouteEntry(
                source, arrow.heading, remaining)
        if nextEntry == nil then
            return nil
        end
        local metrics = rayMetrics(
                source, nextEntry.position, arrow.heading)
        segments[index] = {
            source = source,
            heading = arrow.heading,
            length = metrics.length,
        }
        if not segmentLengthValid(segments[index], index) then
            return nil
        end
        source = nextEntry.position
        arrow = nextEntry
        remaining = removeEntry(remaining, nextEntry)
    end
    if #remaining ~= 0 then
        return nil
    end

    local radius = radiusTotal / 3
    local offsetX = source.x - phase.origin.x
    local offsetZ = source.z - phase.origin.z
    local directionX = math.sin(arrow.heading)
    local directionZ = math.cos(arrow.heading)
    local projection = offsetX * directionX + offsetZ * directionZ
    local discriminant = projection * projection
            + radius * radius
            - offsetX * offsetX
            - offsetZ * offsetZ
    if projection >= 0 or discriminant < -0.25 then
        return nil
    end
    if discriminant < 0 then
        discriminant = 0
    end
    local finalLength = -projection + math.sqrt(discriminant)
    segments[4] = {
        source = source,
        heading = arrow.heading,
        length = finalLength,
    }
    if not segmentLengthValid(segments[4], 4) then
        return nil
    end
    return segments
end

local function validateRushObject(args)
    if type(args) ~= 'table' then
        return nil
    end
    local entityID = tonumber(args[1])
    local heading = tonumber(args[12])
    local position = reliablePosition({
        x = args[17],
        y = args[18],
        z = args[19],
    }, false)
    if not finite(entityID)
            or tonumber(args[2]) ~= 7
            or tonumber(args[3]) ~= 5
            or tonumber(args[4]) ~= 0
            or tonumber(args[5]) ~= RUSH_ROUTE_CONTENT_ID
            or tonumber(args[6]) ~= entityID
            or tonumber(args[10]) ~= 0
            or math.abs((tonumber(args[11]) or -1) - 1) > 0.05
            or not finite(heading)
            or tonumber(args[13]) ~= 0
            or tonumber(args[14]) ~= 0
            or tonumber(args[15]) ~= 1
            or position == nil
    then
        return nil
    end
    return {
        entityID = entityID,
        heading = heading,
        position = position,
    }
end

local function drawRushSegments(state, phase, segments, now)
    local drawer = getDangerDrawer()
    if drawer == nil or type(drawer.addTimedRect) ~= 'function' then
        diagnostic(state, 'danger_drawer_unavailable', now)
        return false
    end
    local delay = math.max(0, phase.drawAt - now)
    local created = {}
    for index, segment in ipairs(segments) do
        local resolvesAt = phase.firstResolveAt
                + (index - 1) * RUSH_SEGMENT_INTERVAL_MS
        local timeout = math.max(delay + 1,
                resolvesAt - now + RUSH_TIMEOUT_GRACE_MS)
        local token = drawer:addTimedRect(
                timeout,
                segment.source.x,
                segment.source.y,
                segment.source.z,
                segment.length,
                RUSH_WIDTH,
                segment.heading,
                delay,
                nil,
                true)
        if type(token) ~= 'string' then
            for _, item in ipairs(created) do
                Common.deleteTimedShape(item.token)
            end
            diagnostic(state, 'rush_drawer_rejected_shape', now, {
                index = index,
            })
            return false
        end
        created[#created + 1] = {
            key = 'rush:' .. tostring(index),
            token = token,
            expiresAt = now + timeout + TOKEN_GRACE_MS,
        }
    end
    for _, item in ipairs(created) do
        state.active[item.key] = item
    end
    phase.drawn = true
    phase.segments = segments
    state.lastDiagnostic = nil
    return true
end

local function handleRushChannel(
        state, entityID, actionID, channelTimeMax, now)
    if actionID ~= RUSH_ACTION_ID then
        return false
    end
    if not finite(entityID)
            or entityID <= 0
            or not finite(channelTimeMax)
            or math.abs(channelTimeMax - RUSH_CHANNEL_TIME) > 0.2
            or not finite(now)
    then
        diagnostic(state, 'rush_channel_invalid',
                finite(now) and now or nowMs(), {
                    entityID = entityID,
                    channelTimeMax = channelTimeMax,
                })
        return false
    end
    -- OnEntityChannel can precede the live entity snapshot. The same-frame
    -- native AOE owns the first segment geometry and opens the route phase.
    return true
end

local function readRushAOE(aoeInfo, now)
    if type(aoeInfo) ~= 'table'
            or tonumber(aoeInfo.aoeID) ~= RUSH_ACTION_ID
    then
        return nil, nil
    end
    local entityID = tonumber(aoeInfo.entityID)
    local startTime = tonumber(aoeInfo.startTime)
    local duration = tonumber(aoeInfo.duration)
    local heading = tonumber(aoeInfo.heading)
    local length = tonumber(aoeInfo.aoeLength)
    local width = tonumber(aoeInfo.aoeWidth)
    local x = tonumber(aoeInfo.x)
    local y = tonumber(aoeInfo.y)
    local z = tonumber(aoeInfo.z)
    local effect = type(aoeInfo.aoeEffectInfo) == 'table'
            and aoeInfo.aoeEffectInfo.aoeEffectName or nil
    if not finite(now)
            or not finite(entityID)
            or entityID <= 0
            or tonumber(aoeInfo.contentID) ~= CONTENT_ID
            or tonumber(aoeInfo.aoeCastType) ~= RUSH_AOE_CAST_TYPE
            or tonumber(aoeInfo.aoeType) ~= RUSH_AOE_TYPE
            or aoeInfo.isAreaTarget ~= true
            or effect ~= RUSH_AOE_EFFECT
            or not finite(startTime)
            or not finite(duration)
            or math.abs(duration - RUSH_CHANNEL_TIME) > 0.2
            or not finite(length)
            or math.abs(length - RUSH_AOE_LENGTH)
                    > RUSH_AOE_TOLERANCE
            or not finite(width)
            or math.abs(width - RUSH_AOE_WIDTH)
                    > RUSH_AOE_TOLERANCE
            or not finite(heading)
            or not finite(x)
            or not finite(y)
            or not finite(z)
    then
        return nil, 'rush_aoe_invalid', {
            entityID = entityID,
            castType = aoeInfo.aoeCastType,
            aoeType = aoeInfo.aoeType,
            effect = effect,
            duration = duration,
            length = length,
            width = width,
        }
    end
    local age = now - startTime
    if age > RUSH_EVENT_FRESH_PAST_MS
            or age < -RUSH_EVENT_FRESH_FUTURE_MS
    then
        return nil, 'rush_aoe_invalid', {
            entityID = entityID,
            age = age,
        }
    end
    return {
        key = tostring(entityID) .. ':'
                .. tostring(math.floor(startTime + 0.5)),
        entityID = entityID,
        startTime = startTime,
        duration = duration,
        origin = {
            x = x - math.sin(heading) * length,
            y = y,
            z = z - math.cos(heading) * length,
        },
    }
end

local function handleRushAOE(state, aoeInfo, now)
    state = ensureState(state)
    local entry, code, context = readRushAOE(aoeInfo, now)
    if entry == nil then
        if code ~= nil then
            diagnostic(state, code, now, context)
        end
        return false
    end
    if type(state.rush) == 'table'
            and state.rush.key == entry.key
    then
        return false
    end
    clearRushPredictions(state)
    state.rush = nil
    local firstResolveAt = entry.startTime + entry.duration * 1000
    state.rush = {
        key = entry.key,
        bossEntityID = entry.entityID,
        origin = entry.origin,
        startedAt = entry.startTime,
        firstResolveAt = firstResolveAt,
        drawAt = firstResolveAt - RUSH_DRAW_LEAD_MS,
        expiresAt = entry.startTime + RUSH_PHASE_TIMEOUT_MS,
        routeObjects = {},
        drawn = false,
        resolvedCount = 0,
    }
    state.lastDiagnostic = nil
    return true
end

local function handleRushGroundEffect(state, args, now)
    local phase = type(state) == 'table' and state.rush or nil
    if type(phase) ~= 'table'
            or phase.drawn == true
            or not finite(now)
            or now < phase.startedAt
            or now > phase.firstResolveAt + RUSH_ROUTE_WINDOW_GRACE_MS
    then
        return false
    end
    local entry = validateRushObject(args)
    if entry == nil then
        if tonumber(type(args) == 'table' and args[5] or nil)
                == RUSH_ROUTE_CONTENT_ID
        then
            phase.invalid = true
            diagnostic(state, 'rush_route_object_invalid', now)
        end
        return false
    end
    if phase.invalid == true then
        return false
    end
    local existing = phase.routeObjects[entry.entityID]
    if existing ~= nil then
        local difference = Common.distanceSquared(
                existing.position, entry.position)
        if difference ~= nil
                and difference <= POSITION_TOLERANCE_SQUARED
                and Common.headingDifference(
                        existing.heading, entry.heading)
                        <= HEADING_TOLERANCE
        then
            return false
        end
        phase.invalid = true
        diagnostic(state, 'rush_route_conflict', now, {
            entityID = entry.entityID,
        })
        return false
    end
    phase.routeObjects[entry.entityID] = entry
    local count = 0
    for _ in pairs(phase.routeObjects) do
        count = count + 1
    end
    if count < 4 then
        return true
    end
    if count > 4 then
        phase.invalid = true
        diagnostic(state, 'rush_route_conflict', now, {
            count = count,
        })
        return false
    end
    local segments = buildRushSegments(phase)
    if segments == nil then
        phase.invalid = true
        diagnostic(state, 'rush_route_geometry_invalid', now)
        return false
    end
    return drawRushSegments(state, phase, segments, now)
end

local function handleOmenAOE(state, aoeInfo, now)
    state = ensureState(state)
    local entry = validateOmen(state, aoeInfo, now)
    if entry == nil then
        return false
    end
    local key = eventKey(aoeInfo)
    if state.seen[key] ~= nil then
        return false
    end
    state.seen[key] = now

    local round = state.omenRound
    if type(round) ~= 'table'
            or not finite(round.startedAt)
            or now - round.startedAt > OMEN_GROUP_WINDOW_MS
    then
        round = startRound(state, entry, now)
    end
    if round.completed == true then
        return false
    end
    local sourceDistance = Common.distanceSquared(round.source, entry.source)
    if sourceDistance == nil
            or sourceDistance > POSITION_TOLERANCE_SQUARED
    then
        state.omenRound = nil
        diagnostic(state, 'omen_set_conflict', now, {
            reason = 'source_position',
            actionID = entry.actionID,
        })
        return false
    end
    for actionID, existing in pairs(round.entries) do
        if existing.entityID == entry.entityID
                and actionID ~= entry.actionID
        then
            state.omenRound = nil
            diagnostic(state, 'omen_set_conflict', now, {
                reason = 'duplicate_entity',
                entityID = entry.entityID,
            })
            return false
        end
    end
    local existing = round.entries[entry.actionID]
    if existing ~= nil then
        if existing.entityID == entry.entityID
                and Common.headingDifference(
                        existing.heading, entry.heading) <= HEADING_TOLERANCE
        then
            return false
        end
        state.omenRound = nil
        diagnostic(state, 'omen_set_conflict', now, {
            reason = 'duplicate_action',
            actionID = entry.actionID,
        })
        return false
    end
    round.entries[entry.actionID] = entry
    for _, actionID in ipairs(OMEN_ORDER) do
        if round.entries[actionID] == nil then
            return true
        end
    end
    return drawCompletedRound(state, round, now)
end

local function handleEntityCast(state, entityID, actionID)
    if SUPERCELL_RING_SPECS[actionID] ~= nil and finite(entityID) then
        return deleteActive(state, 'donut:' .. tostring(actionID)
                .. ':' .. tostring(entityID))
    end
    if REAL_BREATH_ACTIONS[actionID] == true and finite(entityID) then
        return deleteActive(state, 'breath:' .. tostring(entityID))
    end
    local phase = type(state) == 'table' and state.rush or nil
    if type(phase) ~= 'table'
            or tonumber(entityID) ~= phase.bossEntityID
            or (actionID ~= RUSH_ACTION_ID
                    and actionID ~= RUSH_FOLLOWUP_ACTION_ID)
    then
        return false
    end
    local expectedActionID = phase.resolvedCount == 0
            and RUSH_ACTION_ID or RUSH_FOLLOWUP_ACTION_ID
    if actionID ~= expectedActionID then
        clearRushPredictions(state)
        state.rush = nil
        return false
    end
    phase.resolvedCount = phase.resolvedCount + 1
    local removed = deleteActive(
            state, 'rush:' .. tostring(phase.resolvedCount))
    if phase.resolvedCount >= 4 then
        state.rush = nil
    end
    return removed
end

local function pruneState(state, now)
    state = ensureState(state)
    if not finite(now) then
        return false
    end
    local removed = false
    local expired = {}
    for key, entry in pairs(state.active) do
        if not finite(entry.expiresAt) or now > entry.expiresAt then
            expired[#expired + 1] = key
        end
    end
    for _, key in ipairs(expired) do
        removed = deleteActive(state, key) or removed
    end
    if type(state.omenRound) == 'table'
            and (not finite(state.omenRound.expiresAt)
                    or now > state.omenRound.expiresAt)
    then
        state.omenRound = nil
    end
    if type(state.rush) == 'table'
            and (not finite(state.rush.expiresAt)
                    or now > state.rush.expiresAt)
    then
        clearRushPredictions(state)
        state.rush = nil
    end
    if type(state.supercellPrevious) == 'table'
            and (not finite(state.supercellPrevious.receivedAt)
                    or now - state.supercellPrevious.receivedAt
                            > SUPERCELL_PAIR_MAX_MS)
    then
        state.supercellPrevious = nil
    end
    Common.pruneSeen(state.seen, now, SEEN_TTL_MS)
    return removed
end

local Feature = {}

Feature.Init = function(M)
    if type(M.ShapeshiftingMage) == 'table' then
        clearState(M.ShapeshiftingMage)
        applySupercellRendering(M.ShapeshiftingMage, false)
    end
    M.ShapeshiftingMage = newState()
    local cfg = getConfig(M)
    M.SetShapeshiftingMageEnabled = function(enabled)
        local current = getConfig(M)
        if current ~= nil then
            current.Enable = enabled == true
        end
        if enabled == true then
            if current ~= nil and current.CorrectSupercellDonut == true then
                applySupercellRendering(M.ShapeshiftingMage, true)
            end
        else
            clearState(M.ShapeshiftingMage)
            applySupercellRendering(M.ShapeshiftingMage, false)
        end
    end
    M.SetShapeshiftingMageDonutCorrectionEnabled = function(enabled)
        local current = getConfig(M)
        if current ~= nil then
            current.CorrectSupercellDonut = enabled == true
        end
        if enabled ~= true then
            clearPredictionsWithPrefix(M.ShapeshiftingMage, 'donut:')
            M.ShapeshiftingMage.supercellPrevious = nil
        end
        applySupercellRendering(
                M.ShapeshiftingMage,
                enabled == true and current ~= nil
                        and current.Enable == true)
    end
    M.SetShapeshiftingMageBreathPredictionEnabled = function(enabled)
        local current = getConfig(M)
        if current ~= nil then
            current.DrawHellishBreathPrediction = enabled == true
        end
        if enabled ~= true then
            clearBreathPredictions(M.ShapeshiftingMage)
            M.ShapeshiftingMage.omenRound = nil
        end
    end
    M.SetShapeshiftingMageRushPredictionEnabled = function(enabled)
        local current = getConfig(M)
        if current ~= nil then
            current.DrawHellfireRushPrediction = enabled == true
        end
        if enabled ~= true then
            clearRushPredictions(M.ShapeshiftingMage)
            M.ShapeshiftingMage.rush = nil
        end
    end
    if cfg ~= nil
            and cfg.Enable == true
            and cfg.CorrectSupercellDonut == true
    then
        applySupercellRendering(M.ShapeshiftingMage, true)
    end
end

Feature.Clear = function(releaseOwnership)
    local state = getState()
    if state ~= nil then
        clearState(state)
        if releaseOwnership == true then
            applySupercellRendering(state, false)
        end
    end
end

Feature.OnAOECreate = function(aoeInfo, now)
    local actionID = type(aoeInfo) == 'table'
            and tonumber(aoeInfo.aoeID) or nil
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if actionID == RUSH_ACTION_ID then
        if state ~= nil
                and cfg ~= nil
                and cfg.Enable == true
                and cfg.DrawHellfireRushPrediction == true
        then
            return handleRushAOE(state, aoeInfo, now)
        end
        return false
    end
    if SUPERCELL_STEEL_SPECS[actionID] ~= nil
            or SUPERCELL_RING_SPECS[actionID] ~= nil
    then
        if state ~= nil
                and cfg ~= nil
                and cfg.Enable == true
                and cfg.CorrectSupercellDonut == true
        then
            return handleSupercellAOE(state, aoeInfo, now)
        end
        return false
    end
    if OMEN_SPECS[actionID] == nil then
        return false
    end
    if state ~= nil
            and cfg ~= nil
            and cfg.Enable == true
            and cfg.DrawHellishBreathPrediction == true
    then
        return handleOmenAOE(state, aoeInfo, now)
    end
    return false
end

Feature.OnEntityChannel = function(
        entityID, actionID, channelTimeMax, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state ~= nil
            and cfg ~= nil
            and cfg.Enable == true
            and cfg.DrawHellfireRushPrediction == true
    then
        return handleRushChannel(
                state, entityID, actionID, channelTimeMax, now)
    end
    return false
end

Feature.OnAddGroundEffect = function(args, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state ~= nil
            and cfg ~= nil
            and cfg.Enable == true
            and cfg.DrawHellfireRushPrediction == true
    then
        return handleRushGroundEffect(state, args, now)
    end
    return false
end

Feature.OnEntityCast = function(entityID, actionID)
    local state = getState()
    return state ~= nil
            and handleEntityCast(state, entityID, actionID) or false
end

Feature.Update = function(guide, now)
    local state = getState()
    if state == nil then
        return false
    end
    local cfg = getConfig(guide)
    if cfg ~= nil and cfg.Enable == true then
        applySupercellRendering(
                state, cfg.CorrectSupercellDonut == true)
        return pruneState(state, now)
    end
    clearState(state)
    applySupercellRendering(state, false)
    return false
end

Feature.Test = {
    Defaults = DEFAULTS,
    OmenSpecs = OMEN_SPECS,
    OmenOrder = OMEN_ORDER,
    RealBreathActions = REAL_BREATH_ACTIONS,
    SupercellDonuts = SUPERCELL_DONUTS,
    DonutSource = DONUT_SOURCE,
    DonutBlacklistSource = DONUT_BLACKLIST_SOURCE,
    SupercellInitialSteelActionID = SUPERCELL_INITIAL_STEEL_ACTION_ID,
    SupercellSteelActionID = SUPERCELL_STEEL_ACTION_ID,
    SupercellInnerRingActionID = SUPERCELL_INNER_RING_ACTION_ID,
    SupercellSteelEffect = SUPERCELL_STEEL_EFFECT,
    SupercellInnerRingEffect = SUPERCELL_INNER_RING_EFFECT,
    SupercellSteelRadius = SUPERCELL_STEEL_RADIUS,
    SupercellInnerRingOuter = SUPERCELL_INNER_RING_OUTER,
    SupercellDonutActionID = SUPERCELL_DONUT_ACTION_ID,
    SupercellDonutEffect = SUPERCELL_DONUT_EFFECT,
    SupercellDonutInner = SUPERCELL_DONUT_INNER,
    SupercellDonutOuter = SUPERCELL_DONUT_OUTER,
    BreathRadius = BREATH_RADIUS,
    BreathAngle = BREATH_ANGLE,
    BreathTimeoutGraceMs = BREATH_TIMEOUT_GRACE_MS,
    RushActionID = RUSH_ACTION_ID,
    RushFollowupActionID = RUSH_FOLLOWUP_ACTION_ID,
    RushRouteContentID = RUSH_ROUTE_CONTENT_ID,
    RushDrawLeadMs = RUSH_DRAW_LEAD_MS,
    RushSegmentIntervalMs = RUSH_SEGMENT_INTERVAL_MS,
    RushWidth = RUSH_WIDTH,
    RushSegmentLengths = RUSH_SEGMENT_LENGTHS,
    NewState = newState,
    EnsureState = ensureState,
    GetConfig = getConfig,
    DonutRegistry = donutRegistry,
    ApplyDonutFallback = applyDonutFallback,
    ApplyDonutBlacklist = applyDonutBlacklist,
    ApplySupercellRendering = applySupercellRendering,
    HandleSupercellAOE = handleSupercellAOE,
    HeadingPatternValid = headingPatternValid,
    HandleOmenAOE = handleOmenAOE,
    BuildRushSegments = buildRushSegments,
    HandleRushChannel = handleRushChannel,
    HandleRushAOE = handleRushAOE,
    HandleRushGroundEffect = handleRushGroundEffect,
    HandleEntityCast = handleEntityCast,
    PruneState = pruneState,
    ClearState = clearState,
}

return Feature
end

rawset(_G, 'MuAiOccultCrescentNorthShapeshiftingMage', Module)
return Module
