local Module = {}

function Module.Create(Context)
    assert(type(Context) == 'table' and type(Context.Common) == 'table')
    local Common = Context.Common
    local finite = Context.finite
    local nowMs = Context.nowMs
    local reliablePosition = Context.reliablePosition

local BOSS_CONTENT_ID = 14767

local BREATH_RADIUS = 30
local BREATH_ANGLE = math.rad(120)
local BREATH_PREVIEW_MS = 5000
local BREATH_TIMEOUT_GRACE_MS = 500
local BREATH_ACTIVATION_OFFSETS_MS = { 6000, 8700, 11400 }
local ROAR_ACTIVATION_OFFSET_MS = 18000
local ROAR_PREVIEW_MS = 6000
local ROAR_TIMEOUT_GRACE_MS = 500
local ICE_ROAR_RADIUS = 9
local LIGHTNING_ROAR_INNER = 8
local LIGHTNING_ROAR_OUTER = 30
local ROUND_TIMEOUT_MS = 30000
local TOKEN_GRACE_MS = 1000
local BREATH_HEADING_TOLERANCE = math.rad(5)
local BLACKLIST_SOURCE = 'MuAiCore - 统领奇美拉首段吐息校正'

local BREATH_OMEN_AIDS = {
    [48631] = true,
    [48629] = true,
}

local DEFAULTS = {
    Enable = true,
    DrawBreathSequencePrediction = true,
}

-- Argus publishes the side-head cone direction, not the boss body's heading.
-- The 2026-08-02 capture confirms that the following two side-head cones turn
-- by 120 degrees from that omen in a stable arena-locked sequence.
local BREATH_SPECS = {
    [48631] = {
        expectedOmenHeading = math.rad(135),
        turn = math.rad(120),
        actions = { 48631, 48632, 49748 },
        roarAction = 48633,
        roarKind = 'circle',
    },
    [48629] = {
        expectedOmenHeading = math.rad(-135),
        turn = math.rad(-120),
        actions = { 48629, 48630, 49747 },
        roarAction = 48634,
        roarKind = 'donut',
    },
}

local function normalizeHeading(heading)
    return (heading + math.pi) % (2 * math.pi) - math.pi
end

local function newState()
    return {
        round = nil,
        active = {},
        blacklist = { owned = {}, registered = false },
        lastDiagnostic = nil,
    }
end

local function ensureState(state)
    state = type(state) == 'table' and state or newState()
    state.active = type(state.active) == 'table' and state.active or {}
    state.blacklist = type(state.blacklist) == 'table'
            and state.blacklist or {}
    state.blacklist.owned = type(state.blacklist.owned) == 'table'
            and state.blacklist.owned or {}
    state.blacklist.registered = state.blacklist.registered == true
    return state
end

local feature = Common.newFeature({
    key = 'LeaderChimera',
    defaults = DEFAULTS,
    newState = newState,
    ensureState = ensureState,
    diagnosticThrottleMs = 1000,
    diagnosticText = {
        breath_geometry_invalid = '统领奇美拉吐息缺少可靠几何',
        breath_heading_unexpected = '统领奇美拉吐息预兆方向不符合已验证模式',
        danger_drawer_unavailable = '统领奇美拉危险范围绘图器不可用',
        danger_drawer_rejected_shape = '统领奇美拉危险范围绘制失败',
        roar_sequence_mismatch = '统领奇美拉咆哮与吐息序列不匹配',
    },
})
local getConfig = feature.GetConfig

local function getState()
    return Common.getRuntimeState(
            'LeaderChimera', newState, ensureState)
end

local function diagnostic(state, code, now, context)
    feature.Diagnostic(
            state, rawget(_G, 'MuAiGuide'), code, now, context)
end

local function getBlacklist(create)
    return Common.getMoogleTable('aoeIDUserBlacklist', create)
end

local function ownsBlacklist(state, actionID, current)
    return current ~= nil
            and (current == state.blacklist.owned[actionID]
            or (type(current) == 'table'
                    and current.source == BLACKLIST_SOURCE))
end

local function registerBlacklist(state)
    state = ensureState(state)
    local blacklist = getBlacklist(true)
    if blacklist == nil then
        state.blacklist.registered = false
        return false
    end
    for actionID in pairs(BREATH_OMEN_AIDS) do
        local current = blacklist[actionID]
        if current == nil then
            local owned = {
                label = '统领奇美拉首段吐息校正',
                source = BLACKLIST_SOURCE,
            }
            blacklist[actionID] = owned
            state.blacklist.owned[actionID] = owned
        elseif type(current) == 'table'
                and current.source == BLACKLIST_SOURCE
        then
            state.blacklist.owned[actionID] = current
        else
            state.blacklist.owned[actionID] = nil
        end
    end
    state.blacklist.registered = true
    return true
end

local function unregisterBlacklist(state)
    state = ensureState(state)
    local blacklist = getBlacklist(false)
    if blacklist == nil then
        state.blacklist.registered = false
        return false
    end
    for actionID in pairs(BREATH_OMEN_AIDS) do
        local current = blacklist[actionID]
        if ownsBlacklist(state, actionID, current) then
            blacklist[actionID] = nil
        end
    end
    state.blacklist.owned = {}
    state.blacklist.registered = false
    return true
end

local function applyBlacklist(state, enabled)
    if enabled == true then
        return registerBlacklist(state)
    end
    return unregisterBlacklist(state)
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

local function rememberActive(state, key, token, expiresAt, metadata)
    if type(token) ~= 'string' or not finite(expiresAt) then
        return false
    end
    deleteActive(state, key)
    metadata = type(metadata) == 'table' and metadata or {}
    metadata.token = token
    metadata.expiresAt = expiresAt
    state.active[key] = metadata
    return true
end

local function clearDraws(state)
    state = ensureState(state)
    local keys = {}
    for key in pairs(state.active) do
        keys[#keys + 1] = key
    end
    for _, key in ipairs(keys) do
        deleteActive(state, key)
    end
    state.active = {}
end

local function clearState(state)
    state = ensureState(state)
    clearDraws(state)
    state.round = nil
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

local function drawTimedCone(
        state, drawer, key, source, heading, activationOffset, now, actionID)
    if type(drawer.addTimedCone) ~= 'function' then
        return false
    end
    local delay = math.max(0, activationOffset - BREATH_PREVIEW_MS)
    local timeout = BREATH_PREVIEW_MS + BREATH_TIMEOUT_GRACE_MS
    local token = drawer:addTimedCone(
            timeout,
            source.x, source.y, source.z,
            BREATH_RADIUS, BREATH_ANGLE, heading, delay)
    return rememberActive(
            state,
            key,
            token,
            now + delay + timeout + TOKEN_GRACE_MS,
            { kind = 'breath', actionID = actionID })
end

local function drawPredictedRoar(state, drawer, spec, source, now)
    local delay = ROAR_ACTIVATION_OFFSET_MS - ROAR_PREVIEW_MS
    local timeout = ROAR_PREVIEW_MS + ROAR_TIMEOUT_GRACE_MS
    local token = nil
    if spec.roarKind == 'circle'
            and type(drawer.addTimedCircle) == 'function'
    then
        token = drawer:addTimedCircle(
                timeout,
                source.x, source.y, source.z,
                ICE_ROAR_RADIUS, delay)
    elseif spec.roarKind == 'donut'
            and type(drawer.addTimedDonut) == 'function'
    then
        token = drawer:addTimedDonut(
                timeout,
                source.x, source.y, source.z,
                LIGHTNING_ROAR_INNER, LIGHTNING_ROAR_OUTER, delay)
    end
    return rememberActive(
            state,
            'roar',
            token,
            now + delay + timeout + TOKEN_GRACE_MS,
            { kind = 'roar', actionID = spec.roarAction })
end

local function startBreathRound(state, aoeInfo, now)
    state = ensureState(state)
    local actionID = type(aoeInfo) == 'table'
            and tonumber(aoeInfo.aoeID) or nil
    local spec = BREATH_SPECS[actionID]
    if spec == nil then
        return false
    end
    local entityID = tonumber(aoeInfo.entityID)
    local source = reliableAOEPosition(aoeInfo)
    local effectName = type(aoeInfo.aoeEffectInfo) == 'table'
            and aoeInfo.aoeEffectInfo.aoeEffectName or nil
    if not finite(now)
            or not finite(entityID)
            or tonumber(aoeInfo.contentID) ~= BOSS_CONTENT_ID
            or tonumber(aoeInfo.aoeCastType) ~= 13
            or not finite(aoeInfo.aoeLength)
            or math.abs(aoeInfo.aoeLength - BREATH_RADIUS) > 0.5
            or effectName ~= 'gl_fan120_1bxf'
            or not finite(aoeInfo.duration)
            or aoeInfo.duration < 5.4
            or aoeInfo.duration > 6.0
            or not finite(aoeInfo.heading)
            or source == nil
    then
        diagnostic(state, 'breath_geometry_invalid', nowMs(), {
            actionID = actionID,
            entityID = entityID,
        })
        return false
    end
    local headingDifference = Common.headingDifference(
            aoeInfo.heading, spec.expectedOmenHeading)
    if headingDifference == nil
            or headingDifference > BREATH_HEADING_TOLERANCE
    then
        diagnostic(state, 'breath_heading_unexpected', now, {
            actionID = actionID,
            heading = aoeInfo.heading,
            difference = headingDifference,
        })
        return false
    end
    local round = state.round
    if type(round) == 'table'
            and round.bossEntityID == entityID
            and round.firstActionID == actionID
            and finite(round.startedAt)
            and math.abs(round.startedAt - now) <= 500
    then
        return false
    end

    clearDraws(state)
    local firstHeading = normalizeHeading(aoeInfo.heading)
    state.round = {
        bossEntityID = entityID,
        firstActionID = actionID,
        roarAction = spec.roarAction,
        source = source,
        startedAt = now,
        expiresAt = now + ROUND_TIMEOUT_MS,
    }

    local drawer = Common.getMoogleDrawer()
    if drawer == nil then
        diagnostic(state, 'danger_drawer_unavailable', now, actionID)
        return false
    end
    local created = {}
    for index, breathAction in ipairs(spec.actions) do
        local key = 'breath:' .. tostring(breathAction)
        local heading = normalizeHeading(
                firstHeading + (index - 1) * spec.turn)
        if not drawTimedCone(
                state,
                drawer,
                key,
                source,
                heading,
                BREATH_ACTIVATION_OFFSETS_MS[index],
                now,
                breathAction)
        then
            for _, createdKey in ipairs(created) do
                deleteActive(state, createdKey)
            end
            diagnostic(state, 'danger_drawer_rejected_shape', now, {
                actionID = breathAction,
                kind = 'cone',
            })
            return false
        end
        created[#created + 1] = key
    end
    if not drawPredictedRoar(state, drawer, spec, source, now) then
        for _, createdKey in ipairs(created) do
            deleteActive(state, createdKey)
        end
        diagnostic(state, 'danger_drawer_rejected_shape', now, {
            actionID = spec.roarAction,
            kind = spec.roarKind,
        })
        return false
    end
    state.lastDiagnostic = nil
    return true
end
local function handleRoarChannel(
        state, entityID, actionID, channelTimeMax, now)
    state = ensureState(state)
    if actionID ~= 48633 and actionID ~= 48634 then
        return false
    end
    local round = state.round
    local elapsed = type(round) == 'table'
            and finite(round.startedAt) and now - round.startedAt or nil
    if type(round) ~= 'table'
            or round.bossEntityID ~= entityID
            or round.roarAction ~= actionID
            or not finite(channelTimeMax)
            or channelTimeMax < 3.4
            or channelTimeMax > 4.0
            or not finite(elapsed)
            or elapsed < 13000
            or elapsed > 15500
    then
        diagnostic(state, 'roar_sequence_mismatch', now, {
            entityID = entityID,
            actionID = actionID,
            elapsed = elapsed,
        })
        return false
    end
    deleteActive(state, 'roar')
    return true
end

local function handleEntityCast(state, actionID)
    state = ensureState(state)
    return deleteActive(state, 'breath:' .. tostring(actionID))
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
    if type(state.round) == 'table'
            and (not finite(state.round.expiresAt)
                    or now > state.round.expiresAt)
    then
        clearState(state)
        return true
    end
    return removed
end

local Feature = {}

Feature.Init = function(M)
    if type(M.LeaderChimera) == 'table' then
        clearState(M.LeaderChimera)
        applyBlacklist(M.LeaderChimera, false)
    end
    M.LeaderChimera = newState()
    local initialConfig = getConfig(M)
    M.SetLeaderChimeraEnabled = function(enabled)
        local cfg = getConfig(M)
        if cfg ~= nil then
            cfg.Enable = enabled == true
        end
        if enabled == true then
            applyBlacklist(
                    M.LeaderChimera,
                    cfg ~= nil
                            and cfg.DrawBreathSequencePrediction == true)
        else
            clearState(M.LeaderChimera)
            applyBlacklist(M.LeaderChimera, false)
        end
    end
    M.SetLeaderChimeraBreathPredictionEnabled = function(enabled)
        local cfg = getConfig(M)
        if cfg ~= nil then
            cfg.DrawBreathSequencePrediction = enabled == true
        end
        applyBlacklist(
                M.LeaderChimera,
                enabled == true and cfg ~= nil and cfg.Enable == true)
        if enabled ~= true then
            local state = ensureState(M.LeaderChimera)
            local keys = {}
            for key, entry in pairs(state.active) do
                if entry.kind == 'breath' or entry.kind == 'roar' then
                    keys[#keys + 1] = key
                end
            end
            for _, key in ipairs(keys) do
                deleteActive(state, key)
            end
        end
    end
    if initialConfig ~= nil and initialConfig.Enable == true
            and initialConfig.DrawBreathSequencePrediction == true
    then
        applyBlacklist(M.LeaderChimera, true)
    end
end

Feature.Clear = function(releaseOwnership)
    local state = getState()
    if state ~= nil then
        clearState(state)
        if releaseOwnership == true then
            applyBlacklist(state, false)
        end
    end
end

Feature.OnAOECreate = function(aoeInfo, now)
    local actionID = type(aoeInfo) == 'table'
            and tonumber(aoeInfo.aoeID) or nil
    if BREATH_SPECS[actionID] == nil then
        return false
    end
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state ~= nil
            and cfg ~= nil
            and cfg.Enable == true
            and cfg.DrawBreathSequencePrediction == true
    then
        return startBreathRound(state, aoeInfo, now)
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
            and cfg.DrawBreathSequencePrediction == true
    then
        return handleRoarChannel(
                state,
                entityID,
                actionID,
                channelTimeMax,
                now)
    end
    return false
end

Feature.OnEntityCast = function(entityID, actionID)
    local state = getState()
    return state ~= nil
            and handleEntityCast(state, actionID) or false
end

Feature.Update = function(guide, now)
    local state = getState()
    if state == nil then
        return false
    end
    local cfg = getConfig(guide)
    if cfg ~= nil and cfg.Enable == true then
        applyBlacklist(
                state, cfg.DrawBreathSequencePrediction == true)
        return pruneState(state, now)
    end
    clearState(state)
    applyBlacklist(state, false)
    return false
end

Feature.Test = {
    Defaults = DEFAULTS,
    BreathSpecs = BREATH_SPECS,
    BreathRadius = BREATH_RADIUS,
    BreathAngle = BREATH_ANGLE,
    BreathPreviewMs = BREATH_PREVIEW_MS,
    BreathTimeoutGraceMs = BREATH_TIMEOUT_GRACE_MS,
    BreathActivationOffsetsMs = BREATH_ACTIVATION_OFFSETS_MS,
    RoarActivationOffsetMs = ROAR_ACTIVATION_OFFSET_MS,
    RoarPreviewMs = ROAR_PREVIEW_MS,
    RoarTimeoutGraceMs = ROAR_TIMEOUT_GRACE_MS,
    IceRoarRadius = ICE_ROAR_RADIUS,
    LightningRoarInner = LIGHTNING_ROAR_INNER,
    LightningRoarOuter = LIGHTNING_ROAR_OUTER,
    BlacklistSource = BLACKLIST_SOURCE,
    NormalizeHeading = normalizeHeading,
    NewState = newState,
    EnsureState = ensureState,
    GetConfig = getConfig,
    StartBreathRound = startBreathRound,
    ApplyBlacklist = applyBlacklist,
    HandleRoarChannel = handleRoarChannel,
    HandleEntityCast = handleEntityCast,
    PruneState = pruneState,
    ClearState = clearState,
}

return Feature
end

rawset(_G, 'MuAiOccultCrescentNorthLeaderChimera', Module)
return Module
