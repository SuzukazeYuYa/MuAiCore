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
local DONUT_SOURCE = 'MuAiCore - 变形法师'

local DEFAULTS = {
    Enable = true,
    CorrectSupercellDonut = true,
    DrawHellishBreathPrediction = true,
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

-- gl_donut3016_o0r1 encodes an outer radius of 30 and inner radius of 16.
-- Moogle otherwise falls back to its generic 10-yalm donut inner radius.
local SUPERCELL_DONUTS = {
    [48362] = {
        name = '超级细胞变形外环',
        radius = 16,
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
        active = {},
        moogle = newMoogleState(),
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

local function clearState(state)
    state = ensureState(state)
    clearPredictions(state)
    state.seen = {}
    state.omenRound = nil
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
    clearPredictions(state)
    state.omenRound = {
        startedAt = now,
        source = entry.source,
        entries = {},
        completed = false,
        expiresAt = now + OMEN_ROUND_TIMEOUT_MS,
    }
    return state.omenRound
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
    if REAL_BREATH_ACTIONS[actionID] ~= true or not finite(entityID) then
        return false
    end
    return deleteActive(state, 'breath:' .. tostring(entityID))
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
    Common.pruneSeen(state.seen, now, SEEN_TTL_MS)
    return removed
end

local Feature = {}

Feature.Init = function(M)
    if type(M.ShapeshiftingMage) == 'table' then
        clearState(M.ShapeshiftingMage)
        donutRegistry.Apply(M.ShapeshiftingMage, false)
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
                donutRegistry.Apply(M.ShapeshiftingMage, true)
            end
        else
            clearState(M.ShapeshiftingMage)
            donutRegistry.Apply(M.ShapeshiftingMage, false)
        end
    end
    M.SetShapeshiftingMageDonutCorrectionEnabled = function(enabled)
        local current = getConfig(M)
        if current ~= nil then
            current.CorrectSupercellDonut = enabled == true
        end
        donutRegistry.Apply(
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
            clearPredictions(M.ShapeshiftingMage)
            M.ShapeshiftingMage.omenRound = nil
        end
    end
    if cfg ~= nil
            and cfg.Enable == true
            and cfg.CorrectSupercellDonut == true
    then
        donutRegistry.Apply(M.ShapeshiftingMage, true)
    end
end

Feature.Clear = function(releaseOwnership)
    local state = getState()
    if state ~= nil then
        clearState(state)
        if releaseOwnership == true then
            donutRegistry.Apply(state, false)
        end
    end
end

Feature.OnAOECreate = function(aoeInfo, now)
    local actionID = type(aoeInfo) == 'table'
            and tonumber(aoeInfo.aoeID) or nil
    if OMEN_SPECS[actionID] == nil then
        return false
    end
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state ~= nil
            and cfg ~= nil
            and cfg.Enable == true
            and cfg.DrawHellishBreathPrediction == true
    then
        return handleOmenAOE(state, aoeInfo, now)
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
        donutRegistry.Apply(
                state, cfg.CorrectSupercellDonut == true)
        return pruneState(state, now)
    end
    clearState(state)
    donutRegistry.Apply(state, false)
    return false
end

Feature.Test = {
    Defaults = DEFAULTS,
    OmenSpecs = OMEN_SPECS,
    OmenOrder = OMEN_ORDER,
    RealBreathActions = REAL_BREATH_ACTIONS,
    SupercellDonuts = SUPERCELL_DONUTS,
    DonutSource = DONUT_SOURCE,
    BreathRadius = BREATH_RADIUS,
    BreathAngle = BREATH_ANGLE,
    BreathTimeoutGraceMs = BREATH_TIMEOUT_GRACE_MS,
    NewState = newState,
    EnsureState = ensureState,
    GetConfig = getConfig,
    DonutRegistry = donutRegistry,
    HeadingPatternValid = headingPatternValid,
    HandleOmenAOE = handleOmenAOE,
    HandleEntityCast = handleEntityCast,
    PruneState = pruneState,
    ClearState = clearState,
}

return Feature
end

rawset(_G, 'MuAiOccultCrescentNorthShapeshiftingMage', Module)
return Module
