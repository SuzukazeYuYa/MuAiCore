local Module = {}

function Module.Create(Context)
    assert(type(Context) == 'table' and type(Context.Common) == 'table')
    local Common = Context.Common
    local finite = Context.finite
    local nowMs = Context.nowMs
    local reliablePosition = Context.reliablePosition
    local resolveEntity = Context.resolveEntity

local MAP_ID = 1346
local ADD_CONTENT_ID = 14510
local ADD_MODEL_ID = 19391
local HELPER_CONTENT_ID = 108
local HELPER_MODEL_ID = 20157
local INITIAL_ACCLAIM_AID = 47157
local REPEATED_ACCLAIM_AID = 47158
local CONE_RADIUS = 50
local CONE_ANGLE = math.rad(90)
local TOTAL_HITS = 4
local LEFT_QUARTER_TURN = -math.pi / 2
local HEADING_TOLERANCE = math.rad(5)
local HELPER_PAIR_DISTANCE_SQ = 0.5 * 0.5
local HELPER_SIGNAL_WINDOW_MS = 5000
local INITIAL_TOKEN_GRACE_MS = 750
local NEXT_HIT_TIMEOUT_MS = 10000
local TOKEN_GRACE_MS = 1000
local SEQUENCE_TIMEOUT_MS = 45000
local CAST_DEDUPE_MS = 1000

local BLACKLIST_SOURCE = 'MuAiCore - 雪石膏之剑称誉预测'
local LEGACY_REFERENCE_SOURCE = 'MuAiCore - 北岛参考范围'
local OWNED_AIDS = {
    [INITIAL_ACCLAIM_AID] = true,
    [REPEATED_ACCLAIM_AID] = true,
}

local DEFAULTS = {
    Enable = true,
}

-- The 2026-08-01 map-1346 capture contains five complete rounds. The helper
-- VFX names are angle90left_c0/c1/c2, and all 18 adds subsequently resolve
-- with exactly 3/2/1 left quarter-turns respectively.
local TURN_SIGNALS = {
    [2843] = { turns = 3, step = LEFT_QUARTER_TURN },
    [2844] = { turns = 2, step = LEFT_QUARTER_TURN },
    [2845] = { turns = 1, step = LEFT_QUARTER_TURN },
}

local function normalizeHeading(heading)
    return (heading + math.pi) % (2 * math.pi) - math.pi
end

local function headingsMatch(actual, expected)
    if not finite(actual) or not finite(expected) then
        return false
    end
    return math.abs(normalizeHeading(actual - expected))
            <= HEADING_TOLERANCE
end

local function newState()
    return {
        adds = {},
        helperSeen = {},
        blacklist = { owned = {}, registered = false },
        lastDiagnostic = nil,
    }
end

local function ensureState(state)
    state = type(state) == 'table' and state or newState()
    state.adds = type(state.adds) == 'table' and state.adds or {}
    state.helperSeen = type(state.helperSeen) == 'table'
            and state.helperSeen or {}
    state.blacklist = type(state.blacklist) == 'table'
            and state.blacklist or {}
    state.blacklist.owned = type(state.blacklist.owned) == 'table'
            and state.blacklist.owned or {}
    state.blacklist.registered = state.blacklist.registered == true
    return state
end

local feature = Common.newFeature({
    key = 'AlabasterBlade',
    defaults = DEFAULTS,
    newState = newState,
    ensureState = ensureState,
    diagnosticThrottleMs = 1000,
    diagnosticText = {
        channel_identity_missing = '雪石膏之剑称誉事件缺少实体标识',
        add_entity_mismatch = '雪石膏之剑称誉小怪实体不匹配',
        add_geometry_missing = '雪石膏之剑称誉缺少可靠几何',
        helper_entity_mismatch = '雪石膏之剑转向特效实体不匹配',
        helper_pair_missing = '雪石膏之剑转向特效无法匹配小怪',
        helper_pair_ambiguous = '雪石膏之剑转向特效匹配不唯一',
        turn_signal_conflict = '雪石膏之剑转向特效发生冲突',
        turn_signal_missing = '雪石膏之剑缺少完整转向特效',
        prediction_heading_mismatch = '雪石膏之剑预测朝向与实战朝向不符',
        danger_drawer_unavailable = '雪石膏之剑危险范围绘图器不可用',
        danger_drawer_rejected_shape = '雪石膏之剑危险范围绘制失败',
    },
})
local getConfig = feature.GetConfig

local function getState()
    return Common.getRuntimeState(
            'AlabasterBlade', newState, ensureState)
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
    for actionID in pairs(OWNED_AIDS) do
        local current = blacklist[actionID]
        local reclaimLegacy = actionID == REPEATED_ACCLAIM_AID
                and type(current) == 'table'
                and current.source == LEGACY_REFERENCE_SOURCE
        if current == nil or reclaimLegacy then
            local owned = {
                label = '雪石膏之剑称誉预测',
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
    for actionID in pairs(OWNED_AIDS) do
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

local function getDangerDrawer()
    if type(TensorCore) ~= 'table'
            or type(TensorCore.getMoogleDrawer) ~= 'function'
    then
        return nil
    end
    local drawer = TensorCore.getMoogleDrawer()
    return type(drawer) == 'table' and drawer or nil
end

local function resolveAdd(entityID, requireHeading)
    local entity = resolveEntity(entityID)
    if type(entity) ~= 'table'
            or tonumber(entity.id) ~= entityID
            or tonumber(entity.contentid) ~= ADD_CONTENT_ID
            or tonumber(entity.modelid) ~= ADD_MODEL_ID
            or entity.alive == false
    then
        return nil, nil, 'add_entity_mismatch'
    end
    local position = reliablePosition(entity.pos, requireHeading == true)
    if position == nil then
        return nil, nil, 'add_geometry_missing'
    end
    return entity, position, nil
end

local function deleteToken(entry)
    if type(entry) ~= 'table' or type(entry.token) ~= 'string' then
        return false
    end
    Common.deleteTimedShape(entry.token)
    entry.token = nil
    entry.tokenExpiresAt = nil
    return true
end

local function deleteEntry(state, entityID)
    state = ensureState(state)
    local entry = state.adds[entityID]
    if type(entry) ~= 'table' then
        return false
    end
    deleteToken(entry)
    state.adds[entityID] = nil
    return true
end

local function clearState(state)
    state = ensureState(state)
    for entityID in pairs(state.adds) do
        deleteEntry(state, entityID)
    end
    state.adds = {}
    state.helperSeen = {}
    state.lastDiagnostic = nil
end

local function expectedHeading(entry, hitIndex)
    if type(entry) ~= 'table'
            or not finite(entry.initialHeading)
            or not finite(entry.turns)
            or not finite(entry.turnStep)
            or not finite(hitIndex)
    then
        return nil
    end
    local completedTurns = math.min(math.max(hitIndex - 1, 0), entry.turns)
    return normalizeHeading(
            entry.initialHeading + completedTurns * entry.turnStep)
end

local function drawCone(state, entry, heading, timeout, now)
    if type(entry) ~= 'table'
            or not finite(heading)
            or not finite(timeout)
            or timeout <= 0
            or not finite(now)
    then
        diagnostic(state, 'add_geometry_missing', nowMs(), entry)
        return false
    end
    local _, position, entityError = resolveAdd(entry.entityID, false)
    if position == nil then
        diagnostic(state, entityError, now, entry.entityID)
        return false
    end
    local drawer = getDangerDrawer()
    if drawer == nil or type(drawer.addTimedCone) ~= 'function' then
        diagnostic(state, 'danger_drawer_unavailable', now, entry.entityID)
        return false
    end
    local token = drawer:addTimedCone(
            timeout,
            position.x, position.y, position.z,
            CONE_RADIUS, CONE_ANGLE, normalizeHeading(heading))
    if type(token) ~= 'string' then
        diagnostic(state, 'danger_drawer_rejected_shape', now, entry.entityID)
        return false
    end
    deleteToken(entry)
    entry.token = token
    entry.tokenExpiresAt = now + timeout + TOKEN_GRACE_MS
    entry.drawPosition = position
    entry.expectedHeading = normalizeHeading(heading)
    state.lastDiagnostic = nil
    return true
end

local function startInitial(state, entityID, channelTimeMax, now)
    state = ensureState(state)
    if not finite(entityID)
            or entityID <= 0
            or not finite(channelTimeMax)
            or channelTimeMax <= 0
            or channelTimeMax > 30
            or not finite(now)
    then
        diagnostic(state, 'channel_identity_missing', nowMs(), {
            entityID = entityID,
            channelTimeMax = channelTimeMax,
        })
        return false
    end
    local _, position, entityError = resolveAdd(entityID, true)
    if position == nil then
        diagnostic(state, entityError, now, entityID)
        return false
    end
    local existing = state.adds[entityID]
    if type(existing) == 'table'
            and existing.hitIndex == 1
            and finite(existing.startedAt)
            and now - existing.startedAt <= CAST_DEDUPE_MS
    then
        return false
    end
    deleteEntry(state, entityID)
    local entry = {
        entityID = entityID,
        startedAt = now,
        sequenceExpiresAt = now + SEQUENCE_TIMEOUT_MS,
        hitIndex = 1,
        initialHeading = normalizeHeading(position.h),
        origin = position,
        turns = nil,
        turnStep = nil,
        signalID = nil,
        helperID = nil,
        lastResolutionAt = nil,
        fallback = false,
    }
    state.adds[entityID] = entry
    local timeout = math.floor(channelTimeMax * 1000 + 0.5)
            + INITIAL_TOKEN_GRACE_MS
    if not drawCone(state, entry, entry.initialHeading, timeout, now) then
        state.adds[entityID] = nil
        return false
    end
    return true
end

local function startFallback(state, entityID, channelTimeMax, now, context)
    local _, position, entityError = resolveAdd(entityID, true)
    if position == nil then
        diagnostic(state, entityError, now, context or entityID)
        return false
    end
    deleteEntry(state, entityID)
    local entry = {
        entityID = entityID,
        startedAt = now,
        sequenceExpiresAt = now + NEXT_HIT_TIMEOUT_MS + TOKEN_GRACE_MS,
        fallback = true,
        expectedHeading = normalizeHeading(position.h),
    }
    state.adds[entityID] = entry
    local timeout = math.floor(channelTimeMax * 1000 + 0.5)
            + INITIAL_TOKEN_GRACE_MS
    if not drawCone(state, entry, position.h, timeout, now) then
        state.adds[entityID] = nil
        return false
    end
    return true
end

local function handleRepeatChannel(
        state, entityID, channelTimeMax, now)
    local entry = state.adds[entityID]
    if type(entry) == 'table'
            and entry.fallback == true
            and finite(entry.startedAt)
            and now - entry.startedAt <= CAST_DEDUPE_MS
    then
        return false
    end
    if type(entry) ~= 'table'
            or entry.fallback == true
            or not finite(entry.hitIndex)
            or entry.hitIndex < 2
            or entry.hitIndex > TOTAL_HITS
            or not finite(entry.turns)
    then
        return startFallback(
                state, entityID, channelTimeMax, now, 'missing_prediction')
    end
    local _, position, entityError = resolveAdd(entityID, true)
    if position == nil then
        diagnostic(state, entityError, now, entityID)
        deleteEntry(state, entityID)
        return false
    end
    local predicted = expectedHeading(entry, entry.hitIndex)
    if not headingsMatch(position.h, predicted) then
        local mismatch = {
            entityID = entityID,
            hitIndex = entry.hitIndex,
            predicted = predicted,
            actual = position.h,
        }
        diagnostic(state, 'prediction_heading_mismatch', now, mismatch)
        local drawn = startFallback(
                state, entityID, channelTimeMax, now, 'heading_mismatch')
        if drawn then
            diagnostic(state, 'prediction_heading_mismatch', now, mismatch)
        end
        return drawn
    end
    if type(entry.token) ~= 'string' then
        return drawCone(
                state, entry, predicted,
                math.floor(channelTimeMax * 1000 + 0.5)
                        + INITIAL_TOKEN_GRACE_MS,
                now)
    end
    return false
end

local function handleChannel(
        state, entityID, actionID, channelTimeMax, now)
    state = ensureState(state)
    if actionID == INITIAL_ACCLAIM_AID then
        return startInitial(state, entityID, channelTimeMax, now)
    end
    if actionID == REPEATED_ACCLAIM_AID then
        return handleRepeatChannel(
                state, entityID, channelTimeMax, now)
    end
    return false
end

local function helperPosition(entityID)
    local entity = resolveEntity(entityID)
    if type(entity) ~= 'table'
            or tonumber(entity.id) ~= entityID
            or tonumber(entity.contentid) ~= HELPER_CONTENT_ID
            or tonumber(entity.modelid) ~= HELPER_MODEL_ID
    then
        return nil, 'helper_entity_mismatch'
    end
    local position = reliablePosition(entity.pos, false)
    if position == nil then
        return nil, 'helper_entity_mismatch'
    end
    return position, nil
end

local function handleAura(
        state, helperID, oldActiveAura1, newActiveAura1, now)
    state = ensureState(state)
    local spec = TURN_SIGNALS[newActiveAura1]
    if spec == nil then
        return false
    end
    if not finite(helperID) or helperID <= 0 or not finite(now) then
        diagnostic(state, 'helper_entity_mismatch', nowMs(), helperID)
        return false
    end
    local seen = state.helperSeen[helperID]
    if type(seen) == 'table' then
        if seen.signalID == newActiveAura1 then
            return false
        end
        diagnostic(state, 'turn_signal_conflict', now, {
            helperID = helperID,
            oldSignal = seen.signalID,
            newSignal = newActiveAura1,
        })
        return false
    end
    local position, helperError = helperPosition(helperID)
    if position == nil then
        diagnostic(state, helperError, now, helperID)
        return false
    end
    local matches = {}
    for entityID, entry in pairs(state.adds) do
        local elapsed = now - (entry.startedAt or now)
        local distance = type(entry.origin) == 'table'
                and Common.distanceSquared(position, entry.origin) or nil
        if entry.fallback ~= true
                and entry.hitIndex == 1
                and entry.turns == nil
                and elapsed >= 0
                and elapsed <= HELPER_SIGNAL_WINDOW_MS
                and distance ~= nil
                and distance <= HELPER_PAIR_DISTANCE_SQ
        then
            matches[#matches + 1] = {
                entityID = entityID,
                entry = entry,
            }
        end
    end
    if #matches ~= 1 then
        diagnostic(state,
                #matches == 0 and 'helper_pair_missing'
                        or 'helper_pair_ambiguous',
                now,
                { helperID = helperID, matches = #matches })
        return false
    end
    local matched = matches[1]
    matched.entry.turns = spec.turns
    matched.entry.turnStep = spec.step
    matched.entry.signalID = newActiveAura1
    matched.entry.helperID = helperID
    state.helperSeen[helperID] = {
        signalID = newActiveAura1,
        seenAt = now,
        entityID = matched.entityID,
    }
    state.lastDiagnostic = nil
    return true
end

local function advancePrediction(state, entry, now)
    local nextIndex = entry.hitIndex + 1
    if nextIndex > TOTAL_HITS then
        return deleteEntry(state, entry.entityID)
    end
    entry.hitIndex = nextIndex
    local heading = expectedHeading(entry, nextIndex)
    if heading == nil then
        diagnostic(state, 'turn_signal_missing', now, entry.entityID)
        deleteEntry(state, entry.entityID)
        return false
    end
    if not drawCone(
            state, entry, heading, NEXT_HIT_TIMEOUT_MS, now)
    then
        deleteEntry(state, entry.entityID)
        return false
    end
    return true
end

local function handleCast(state, entityID, actionID, now)
    state = ensureState(state)
    local entry = state.adds[entityID]
    if type(entry) ~= 'table'
            or (actionID ~= INITIAL_ACCLAIM_AID
                    and actionID ~= REPEATED_ACCLAIM_AID)
    then
        return false
    end
    if entry.fallback == true then
        if actionID == REPEATED_ACCLAIM_AID then
            return deleteEntry(state, entityID)
        end
        return false
    end
    local expectedAction = entry.hitIndex == 1
            and INITIAL_ACCLAIM_AID or REPEATED_ACCLAIM_AID
    if actionID ~= expectedAction then
        return false
    end
    if finite(entry.lastResolutionAt)
            and now - entry.lastResolutionAt <= CAST_DEDUPE_MS
    then
        return false
    end
    local _, position, entityError = resolveAdd(entityID, true)
    if position == nil then
        diagnostic(state, entityError, now, entityID)
        deleteEntry(state, entityID)
        return false
    end
    local predicted = entry.hitIndex == 1
            and entry.initialHeading
            or expectedHeading(entry, entry.hitIndex)
    if not headingsMatch(position.h, predicted) then
        diagnostic(state, 'prediction_heading_mismatch', now, {
            entityID = entityID,
            hitIndex = entry.hitIndex,
            predicted = predicted,
            actual = position.h,
        })
        deleteEntry(state, entityID)
        return false
    end
    entry.lastResolutionAt = now
    deleteToken(entry)
    if entry.hitIndex == 1 and not finite(entry.turns) then
        diagnostic(state, 'turn_signal_missing', now, entityID)
        state.adds[entityID] = nil
        return false
    end
    return advancePrediction(state, entry, now)
end

local function pruneState(state, now)
    state = ensureState(state)
    if not finite(now) then
        return false
    end
    local removed = false
    for entityID, entry in pairs(state.adds) do
        local entity = resolveEntity(entityID)
        if not finite(entry.sequenceExpiresAt)
                or now > entry.sequenceExpiresAt
                or not finite(entry.tokenExpiresAt)
                or now > entry.tokenExpiresAt
                or type(entity) ~= 'table'
                or entity.alive == false
        then
            deleteEntry(state, entityID)
            removed = true
        end
    end
    for helperID, seen in pairs(state.helperSeen) do
        if type(seen) ~= 'table'
                or not finite(seen.seenAt)
                or now - seen.seenAt > SEQUENCE_TIMEOUT_MS
        then
            state.helperSeen[helperID] = nil
        end
    end
    return removed
end

local Feature = {}

Feature.Init = function(M)
    if type(M.AlabasterBlade) == 'table' then
        clearState(M.AlabasterBlade)
        applyBlacklist(M.AlabasterBlade, false)
    end
    M.AlabasterBlade = newState()
    local cfg = getConfig(M)
    M.SetAlabasterBladeEnabled = function(enabled)
        local current = getConfig(M)
        if current ~= nil then
            current.Enable = enabled == true
        end
        if enabled == true then
            applyBlacklist(M.AlabasterBlade, true)
        else
            clearState(M.AlabasterBlade)
            applyBlacklist(M.AlabasterBlade, false)
        end
    end
    if cfg ~= nil and cfg.Enable == true then
        applyBlacklist(M.AlabasterBlade, true)
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

Feature.OnEntityChannel = function(
        entityID, actionID, channelTimeMax, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state ~= nil and cfg ~= nil and cfg.Enable == true then
        return handleChannel(
                state, entityID, actionID, channelTimeMax, now)
    end
    return false
end

Feature.OnAuraChange = function(
        entityID, oldActiveAura1, newActiveAura1, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state ~= nil and cfg ~= nil and cfg.Enable == true then
        return handleAura(
                state, entityID,
                oldActiveAura1, newActiveAura1, now)
    end
    return false
end

Feature.OnEntityCast = function(entityID, actionID, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state ~= nil and cfg ~= nil and cfg.Enable == true then
        return handleCast(state, entityID, actionID, now)
    end
    return false
end

Feature.Update = function(guide, now)
    local state = getState()
    if state == nil then
        return false
    end
    local cfg = getConfig(guide)
    if cfg ~= nil and cfg.Enable == true then
        applyBlacklist(state, true)
        return pruneState(state, now)
    end
    clearState(state)
    applyBlacklist(state, false)
    return false
end

Feature.Test = {
    MapID = MAP_ID,
    AddContentID = ADD_CONTENT_ID,
    AddModelID = ADD_MODEL_ID,
    HelperContentID = HELPER_CONTENT_ID,
    HelperModelID = HELPER_MODEL_ID,
    InitialAID = INITIAL_ACCLAIM_AID,
    RepeatedAID = REPEATED_ACCLAIM_AID,
    ConeRadius = CONE_RADIUS,
    ConeAngle = CONE_ANGLE,
    TotalHits = TOTAL_HITS,
    TurnSignals = TURN_SIGNALS,
    NextHitTimeoutMs = NEXT_HIT_TIMEOUT_MS,
    Defaults = DEFAULTS,
    BlacklistSource = BLACKLIST_SOURCE,
    NewState = newState,
    EnsureState = ensureState,
    GetConfig = getConfig,
    NormalizeHeading = normalizeHeading,
    HeadingsMatch = headingsMatch,
    ExpectedHeading = expectedHeading,
    ApplyBlacklist = applyBlacklist,
    HandleChannel = handleChannel,
    HandleAura = handleAura,
    HandleCast = handleCast,
    PruneState = pruneState,
    ClearState = clearState,
}

return Feature
end

rawset(_G, 'MuAiOccultCrescentNorthAlabasterBlade', Module)
return Module
