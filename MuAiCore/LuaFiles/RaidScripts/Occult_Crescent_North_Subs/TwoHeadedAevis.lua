local Module = {}

function Module.Create(Context)
    assert(type(Context) == 'table' and type(Context.Common) == 'table')
    local Common = Context.Common
    local finite = Context.finite
    local reliablePosition = Context.reliablePosition
    local resolveEntity = Context.resolveEntity

local GREEN_HEAD_CONTENT_ID = 14490
local BLUE_HEAD_CONTENT_ID = 14491
local THUNDER_ORB_CONTENT_ID = 14492
local ICE_ORB_CONTENT_ID = 14493
local THUNDER_ORB_MODEL_ID = 19478
local ICE_ORB_MODEL_ID = 19479
local HEAD_MODEL_ID = {
    [GREEN_HEAD_CONTENT_ID] = 19474,
    [BLUE_HEAD_CONTENT_ID] = 19475,
}
local CLUSTER_HELPER_MODEL_ID = 9020

local THUNDER_CLUSTER_AID = 50697
local ICE_CLUSTER_AID = 50698
local THUNDERFROST_STORM_AID = 47735
local THUNDER_EXPLOSION_AID = 47706
local ICE_EXPLOSION_AID = 47707

local ORB_COUNT = 4
local ORB_RADIUS = 15
local ORB_SELECTION_DISTANCE_SQ = ORB_RADIUS * ORB_RADIUS
local FIRST_WAVE_TIMEOUT_MS = 10500
local SECOND_WAVE_TIMEOUT_MS = 7800
local ROUND_TIMEOUT_MS = 15000
local ORB_TTL_MS = 30000
local BLACKLIST_SOURCE = 'MuAiCore - 双头怪鸟冰雷球连锁预测'

local CLUSTER_KIND = {
    [THUNDER_CLUSTER_AID] = 'thunder',
    [ICE_CLUSTER_AID] = 'ice',
}

local ORB_SPEC = {
    thunder = {
        contentID = THUNDER_ORB_CONTENT_ID,
        modelID = THUNDER_ORB_MODEL_ID,
    },
    ice = {
        contentID = ICE_ORB_CONTENT_ID,
        modelID = ICE_ORB_MODEL_ID,
    },
}

local EXPLOSION_AIDS = {
    [THUNDER_EXPLOSION_AID] = true,
    [ICE_EXPLOSION_AID] = true,
}

local DEFAULTS = {
    Enable = true,
}

local function newState()
    return {
        orbs = {},
        round = nil,
        active = {},
        blacklist = { owned = {}, registered = false },
        lastDiagnostic = nil,
    }
end

local function ensureState(state)
    state = type(state) == 'table' and state or newState()
    state.orbs = type(state.orbs) == 'table' and state.orbs or {}
    state.active = type(state.active) == 'table' and state.active or {}
    state.blacklist = type(state.blacklist) == 'table'
            and state.blacklist or {}
    state.blacklist.owned = type(state.blacklist.owned) == 'table'
            and state.blacklist.owned or {}
    state.blacklist.registered = state.blacklist.registered == true
    return state
end

local feature = Common.newFeature({
    key = 'TwoHeadedAevis',
    defaults = DEFAULTS,
    newState = newState,
    ensureState = ensureState,
    diagnosticThrottleMs = 1000,
    diagnosticText = {
        orb_count_invalid = '双头怪鸟冰雷球数量不完整，跳过本轮预测',
        orb_geometry_invalid = '双头怪鸟冰雷球实体几何不可用',
        cluster_geometry_invalid = '双头怪鸟冰雷簇缺少可靠几何',
        danger_drawer_unavailable = '双头怪鸟危险范围绘图器不可用',
        danger_drawer_rejected_shape = '双头怪鸟危险范围绘制失败',
    },
})
local getConfig = feature.GetConfig

local function getState()
    return Common.getRuntimeState(
            'TwoHeadedAevis', newState, ensureState)
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
    for actionID in pairs(EXPLOSION_AIDS) do
        local current = blacklist[actionID]
        if current == nil then
            local owned = {
                label = '双头怪鸟冰雷球连锁预测',
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
    for actionID in pairs(EXPLOSION_AIDS) do
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

local function deleteActive(state, entityID)
    local entry = type(state) == 'table'
            and type(state.active) == 'table'
            and state.active[entityID] or nil
    if type(entry) ~= 'table' then
        return false
    end
    Common.deleteTimedShape(entry.token)
    state.active[entityID] = nil
    return true
end

local function clearMechanic(state)
    state = ensureState(state)
    local ids = {}
    for entityID in pairs(state.active) do
        ids[#ids + 1] = entityID
    end
    for _, entityID in ipairs(ids) do
        deleteActive(state, entityID)
    end
    state.orbs = {}
    state.round = nil
    state.lastDiagnostic = nil
end

local function orbKind(contentID)
    if contentID == THUNDER_ORB_CONTENT_ID then
        return 'thunder'
    end
    if contentID == ICE_ORB_CONTENT_ID then
        return 'ice'
    end
    return nil
end

local function entitiesByContent(contentID)
    local tensorCore = rawget(_G, 'TensorCore')
    if type(tensorCore) ~= 'table'
            or type(tensorCore.entityList) ~= 'function'
    then
        return nil
    end
    local entities = tensorCore.entityList(
            'contentid=' .. tostring(contentID))
    if type(entities) ~= 'table' then
        return nil
    end
    return entities
end

local function recordOrb(state, entityID, contentID, now)
    state = ensureState(state)
    local kind = orbKind(contentID)
    if kind == nil or not finite(entityID) or not finite(now) then
        return false
    end
    state.orbs[entityID] = {
        kind = kind,
        addedAt = now,
    }
    return true
end

local function snapshotRound(state, now)
    local pending = {}
    local count = 0
    local positions = {}
    local neededKinds = {}
    for entityID, tracked in pairs(state.orbs) do
        if type(tracked) ~= 'table'
                or ORB_SPEC[tracked.kind] == nil
        then
            return nil, 'orb_geometry_invalid', entityID
        end
        neededKinds[tracked.kind] = true
    end
    for kind in pairs(neededKinds) do
        local spec = ORB_SPEC[kind]
        local entities = entitiesByContent(spec.contentID)
        if entities == nil then
            return nil, 'orb_geometry_invalid', spec.contentID
        end
        for _, entity in pairs(entities) do
            local entityID = type(entity) == 'table'
                    and tonumber(entity.id) or nil
            local tracked = entityID ~= nil and state.orbs[entityID] or nil
            if type(tracked) == 'table' and tracked.kind == kind then
                if tonumber(entity.contentid) ~= spec.contentID
                        or tonumber(entity.modelid) ~= spec.modelID
                        or entity.alive == false
                then
                    return nil, 'orb_geometry_invalid', entityID
                end
                local position = reliablePosition(entity.pos, false)
                if position == nil then
                    return nil, 'orb_geometry_invalid', entityID
                end
                positions[entityID] = position
            end
        end
    end
    for entityID, tracked in pairs(state.orbs) do
        local position = positions[entityID]
        if position == nil then
            return nil, 'orb_geometry_invalid', entityID
        end
        count = count + 1
        pending[entityID] = {
            kind = tracked.kind,
            pos = position,
        }
    end
    if count ~= ORB_COUNT then
        return nil, 'orb_count_invalid', count
    end
    return {
        startedAt = now,
        helpers = {},
        pending = pending,
    }
end

local function drawEntries(state, entries, timeoutMs, now)
    if #entries == 0 then
        return true
    end
    local drawer = Common.getMoogleDrawer()
    if drawer == nil or type(drawer.addTimedCircle) ~= 'function' then
        diagnostic(state, 'danger_drawer_unavailable', now)
        return false
    end
    local created = {}
    for _, entry in ipairs(entries) do
        local token = drawer:addTimedCircle(
                timeoutMs,
                entry.pos.x,
                entry.pos.y,
                entry.pos.z,
                ORB_RADIUS,
                0)
        if type(token) ~= 'string' then
            for _, rollback in ipairs(created) do
                Common.deleteTimedShape(rollback.token)
            end
            diagnostic(state, 'danger_drawer_rejected_shape', now)
            return false
        end
        created[#created + 1] = {
            entityID = entry.entityID,
            token = token,
        }
    end
    for _, createdEntry in ipairs(created) do
        deleteActive(state, createdEntry.entityID)
        state.active[createdEntry.entityID] = {
            token = createdEntry.token,
            expiresAt = now + timeoutMs,
        }
    end
    return true
end

local function clusterPosition(entityID, actionID)
    local kind = CLUSTER_KIND[actionID]
    local expectedContentID = kind == 'thunder'
            and GREEN_HEAD_CONTENT_ID or BLUE_HEAD_CONTENT_ID
    local entities = entitiesByContent(expectedContentID)
    if entities == nil then
        return nil
    end
    for _, entity in pairs(entities) do
        if type(entity) == 'table'
                and tonumber(entity.id) == entityID
                and tonumber(entity.contentid) == expectedContentID
                and tonumber(entity.modelid) == CLUSTER_HELPER_MODEL_ID
                and entity.alive ~= false
        then
            return reliablePosition(entity.pos, false)
        end
    end
    return nil
end

local function handleCluster(state, entityID, actionID, now)
    state = ensureState(state)
    local kind = CLUSTER_KIND[actionID]
    if kind == nil or not finite(now) then
        return false
    end
    local center = clusterPosition(entityID, actionID)
    if center == nil then
        diagnostic(state, 'cluster_geometry_invalid', now, actionID)
        return false
    end
    if type(state.round) ~= 'table'
            or not finite(state.round.startedAt)
            or now - state.round.startedAt > ROUND_TIMEOUT_MS
    then
        local round, code, context = snapshotRound(state, now)
        if round == nil then
            clearMechanic(state)
            diagnostic(state, code, now, context)
            return false
        end
        state.round = round
    end
    local round = state.round
    if round.helpers[actionID] == true then
        return false
    end
    local selected = {}
    for orbID, orb in pairs(round.pending) do
        if orb.kind == kind then
            local dx = orb.pos.x - center.x
            local dz = orb.pos.z - center.z
            if dx * dx + dz * dz <= ORB_SELECTION_DISTANCE_SQ then
                selected[#selected + 1] = {
                    entityID = orbID,
                    pos = orb.pos,
                }
            end
        end
    end
    table.sort(selected, function(a, b)
        return a.entityID < b.entityID
    end)
    if not drawEntries(state, selected, FIRST_WAVE_TIMEOUT_MS, now) then
        local failure = state.lastDiagnostic
        clearMechanic(state)
        state.lastDiagnostic = failure
        return false
    end
    for _, entry in ipairs(selected) do
        round.pending[entry.entityID] = nil
    end
    round.helpers[actionID] = true
    state.lastDiagnostic = nil
    return #selected > 0
end

local function stormCasterValid(entityID)
    local entity = resolveEntity(entityID)
    return type(entity) == 'table'
            and tonumber(entity.id) == entityID
            and tonumber(entity.contentid) == GREEN_HEAD_CONTENT_ID
            and tonumber(entity.modelid)
                    == HEAD_MODEL_ID[GREEN_HEAD_CONTENT_ID]
            and entity.alive ~= false
            and entity.visible ~= false
end

local function handleStorm(state, entityID, now)
    state = ensureState(state)
    local round = state.round
    if type(round) ~= 'table'
            or not finite(round.startedAt)
            or not finite(now)
            or now - round.startedAt > ROUND_TIMEOUT_MS
    then
        return false
    end
    if not stormCasterValid(entityID) then
        return false
    end
    local remaining = {}
    for orbID, orb in pairs(round.pending) do
        local position = type(orb) == 'table'
                and reliablePosition(orb.pos, false) or nil
        if position == nil then
            clearMechanic(state)
            diagnostic(state, 'orb_geometry_invalid', now, orbID)
            return false
        end
        remaining[#remaining + 1] = {
            entityID = orbID,
            pos = position,
        }
    end
    table.sort(remaining, function(a, b)
        return a.entityID < b.entityID
    end)
    if not drawEntries(state, remaining, SECOND_WAVE_TIMEOUT_MS, now) then
        local failure = state.lastDiagnostic
        clearMechanic(state)
        state.lastDiagnostic = failure
        return false
    end
    state.orbs = {}
    state.round = nil
    state.lastDiagnostic = nil
    return #remaining > 0
end

local function prune(state, now)
    state = ensureState(state)
    for entityID, tracked in pairs(state.orbs) do
        if type(tracked) ~= 'table'
                or not finite(tracked.addedAt)
                or now - tracked.addedAt > ORB_TTL_MS
        then
            state.orbs[entityID] = nil
        end
    end
    for entityID, active in pairs(state.active) do
        if type(active) ~= 'table'
                or not finite(active.expiresAt)
                or now >= active.expiresAt
        then
            state.active[entityID] = nil
        end
    end
    if type(state.round) == 'table'
            and finite(state.round.startedAt)
            and now - state.round.startedAt > ROUND_TIMEOUT_MS
    then
        clearMechanic(state)
    end
end

local Feature = {}

Feature.Init = function(M)
    if type(M.TwoHeadedAevis) == 'table' then
        applyBlacklist(M.TwoHeadedAevis, false)
        clearMechanic(M.TwoHeadedAevis)
    end
    M.TwoHeadedAevis = newState()
    local cfg = getConfig(M)
    applyBlacklist(M.TwoHeadedAevis, cfg ~= nil and cfg.Enable == true)
    M.SetTwoHeadedAevisEnabled = function(enabled)
        local current = getConfig(M)
        if current ~= nil then
            current.Enable = enabled == true
        end
        local state = getState()
        if state ~= nil then
            if enabled ~= true then
                clearMechanic(state)
            end
            applyBlacklist(state, enabled == true)
        end
    end
end

Feature.Clear = function(releaseOwnership)
    local state = getState()
    if state == nil then
        return
    end
    clearMechanic(state)
    if releaseOwnership == true then
        applyBlacklist(state, false)
    end
end

Feature.OnEntityAdd = function(entityID, contentID, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state ~= nil and cfg ~= nil and cfg.Enable == true then
        return recordOrb(state, entityID, contentID, now)
    end
    return false
end

Feature.OnVisibilityChange = function(entityID, isVisible)
    if isVisible ~= false then
        return false
    end
    local state = getState()
    if state == nil
            or (state.orbs[entityID] == nil
                    and state.active[entityID] == nil)
    then
        return false
    end
    state.orbs[entityID] = nil
    deleteActive(state, entityID)
    if type(state.round) == 'table' then
        state.round.pending[entityID] = nil
    end
    return true
end

Feature.OnEntityChannel = function(entityID, actionID, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state == nil or cfg == nil or cfg.Enable ~= true then
        return false
    end
    if CLUSTER_KIND[actionID] ~= nil then
        return handleCluster(state, entityID, actionID, now)
    end
    if actionID == THUNDERFROST_STORM_AID then
        return handleStorm(state, entityID, now)
    end
    return false
end

Feature.OnEntityCast = function(entityID, actionID)
    if EXPLOSION_AIDS[actionID] ~= true then
        return false
    end
    local state = getState()
    return state ~= nil and deleteActive(state, entityID) or false
end

Feature.Update = function(guide, now)
    local state = getState()
    if state == nil or not finite(now) then
        return false
    end
    local cfg = getConfig(guide)
    if cfg ~= nil and cfg.Enable == true then
        applyBlacklist(state, true)
        prune(state, now)
        return true
    end
    clearMechanic(state)
    applyBlacklist(state, false)
    return false
end

Feature.Test = {
    Defaults = DEFAULTS,
    GreenHeadContentID = GREEN_HEAD_CONTENT_ID,
    BlueHeadContentID = BLUE_HEAD_CONTENT_ID,
    ThunderOrbContentID = THUNDER_ORB_CONTENT_ID,
    IceOrbContentID = ICE_ORB_CONTENT_ID,
    ThunderClusterActionID = THUNDER_CLUSTER_AID,
    IceClusterActionID = ICE_CLUSTER_AID,
    ThunderfrostStormActionID = THUNDERFROST_STORM_AID,
    ThunderExplosionActionID = THUNDER_EXPLOSION_AID,
    IceExplosionActionID = ICE_EXPLOSION_AID,
    OrbCount = ORB_COUNT,
    OrbRadius = ORB_RADIUS,
    FirstWaveTimeoutMs = FIRST_WAVE_TIMEOUT_MS,
    SecondWaveTimeoutMs = SECOND_WAVE_TIMEOUT_MS,
    NewState = newState,
    EnsureState = ensureState,
    GetConfig = getConfig,
    ApplyBlacklist = applyBlacklist,
    RecordOrb = recordOrb,
    HandleCluster = handleCluster,
    HandleStorm = handleStorm,
    ClearMechanic = clearMechanic,
}

return Feature
end

rawset(_G, 'MuAiOccultCrescentNorthTwoHeadedAevis', Module)
return Module
