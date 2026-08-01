local Module = {}

function Module.Create(Context)
    assert(type(Context) == 'table' and type(Context.Common) == 'table')
    local Common = Context.Common
    local finite = Context.finite
    local nowMs = Context.nowMs
    local reliablePosition = Context.reliablePosition
    local resolveEntity = Context.resolveEntity

local PREDICTION_TIMEOUT_MS = 6500
local PREDICTION_TOKEN_GRACE_MS = 1000
local VISIBILITY_SEEN_TTL_MS = 60000

local DEFAULTS = {
    Enable = true,
    DrawRevealPrediction = true,
}

-- The 2026-08-01 map-1346 capture contains 108/108 explorer reveals and
-- 36/36 pirate reveals exactly 5.015-5.141 seconds before their channels.
-- Entity-add is intentionally not used: 36 of 144 explorer spawns never cast.
local REVEAL_SPECS = {
    [14515] = {
        modelID = 19394,
        actionID = 47175,
        kind = 'circle',
        radius = 8,
    },
    [14514] = {
        modelID = 19395,
        actionID = 47176,
        kind = 'cross',
        length = 75,
        width = 7,
    },
}

local function newState()
    return {
        active = {},
        seenVisibility = {},
        lastDiagnostic = nil,
    }
end

local function ensureState(state)
    state = type(state) == 'table' and state or newState()
    state.active = type(state.active) == 'table' and state.active or {}
    state.seenVisibility = type(state.seenVisibility) == 'table'
            and state.seenVisibility or {}
    return state
end

local feature = Common.newFeature({
    key = 'MagiNecromancer',
    defaults = DEFAULTS,
    newState = newState,
    ensureState = ensureState,
    diagnosticThrottleMs = 1000,
    diagnosticText = {
        reveal_identity_missing = '魔亡灵法师显形事件缺少实体标识',
        reveal_entity_mismatch = '魔亡灵法师显形实体不匹配',
        reveal_geometry_missing = '魔亡灵法师显形范围缺少可靠几何',
        danger_drawer_unavailable = '魔亡灵法师危险范围绘图器不可用',
        danger_drawer_rejected_shape = '魔亡灵法师危险范围绘制失败',
    },
})
local getConfig = feature.GetConfig

local function getState()
    return Common.getRuntimeState(
            'MagiNecromancer', newState, ensureState)
end

local function diagnostic(state, code, now, context)
    feature.Diagnostic(
            state, rawget(_G, 'MuAiGuide'), code, now, context)
end

local function deleteEntry(state, key)
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

local function clearState(state)
    state = ensureState(state)
    for key in pairs(state.active) do
        deleteEntry(state, key)
    end
    state.active = {}
    state.seenVisibility = {}
    state.lastDiagnostic = nil
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

local function drawPrediction(drawer, spec, position)
    if spec.kind == 'circle'
            and type(drawer.addTimedCircle) == 'function'
    then
        return drawer:addTimedCircle(
                PREDICTION_TIMEOUT_MS,
                position.x, position.y, position.z,
                spec.radius)
    end
    if spec.kind == 'cross'
            and type(drawer.addTimedCross) == 'function'
    then
        return drawer:addTimedCross(
                PREDICTION_TIMEOUT_MS,
                position.x, position.y, position.z,
                spec.length, spec.width, position.h)
    end
    return nil
end

local function handleVisibilityChange(
        state,
        entityID,
        wasVisible,
        isVisible,
        now)
    state = ensureState(state)
    if wasVisible ~= false or isVisible ~= true then
        return false
    end
    if not finite(entityID) or entityID <= 0 or not finite(now) then
        diagnostic(state, 'reveal_identity_missing', nowMs(), entityID)
        return false
    end
    local key = tostring(entityID) .. ':reveal'
    local seenAt = state.seenVisibility[key]
    if finite(seenAt) and now - seenAt <= VISIBILITY_SEEN_TTL_MS then
        return false
    end
    local entity = resolveEntity(entityID)
    local contentID = type(entity) == 'table'
            and tonumber(entity.contentid) or nil
    local spec = REVEAL_SPECS[contentID]
    if type(entity) ~= 'table'
            or tonumber(entity.id) ~= entityID
            or spec == nil
            or tonumber(entity.modelid) ~= spec.modelID
            or entity.alive == false
    then
        if spec ~= nil then
            diagnostic(state, 'reveal_entity_mismatch', now, {
                entityID = entityID,
                contentID = contentID,
                modelID = type(entity) == 'table' and entity.modelid or nil,
            })
        end
        return false
    end
    local position = reliablePosition(
            entity.pos, spec.kind == 'cross')
    if position == nil then
        diagnostic(state, 'reveal_geometry_missing', now, {
            entityID = entityID,
            contentID = contentID,
        })
        return false
    end
    local drawer = getDangerDrawer()
    if drawer == nil then
        diagnostic(state, 'danger_drawer_unavailable', now, contentID)
        return false
    end
    local token = drawPrediction(drawer, spec, position)
    if type(token) ~= 'string' then
        diagnostic(state, 'danger_drawer_rejected_shape', now, {
            entityID = entityID,
            contentID = contentID,
            kind = spec.kind,
        })
        return false
    end
    state.seenVisibility[key] = now
    state.active[key] = {
        token = token,
        entityID = entityID,
        contentID = contentID,
        actionID = spec.actionID,
        expiresAt = now + PREDICTION_TIMEOUT_MS
                + PREDICTION_TOKEN_GRACE_MS,
    }
    state.lastDiagnostic = nil
    return true
end

local function handleActionStart(state, entityID, actionID)
    state = ensureState(state)
    if not finite(entityID) or not finite(actionID) then
        return false
    end
    local key = tostring(entityID) .. ':reveal'
    local entry = state.active[key]
    if type(entry) ~= 'table' or entry.actionID ~= actionID then
        return false
    end
    return deleteEntry(state, key)
end

local function pruneState(state, now)
    state = ensureState(state)
    if not finite(now) then
        return false
    end
    local removed = false
    for key, entry in pairs(state.active) do
        if not finite(entry.expiresAt) or now > entry.expiresAt then
            deleteEntry(state, key)
            removed = true
        end
    end
    Common.pruneSeen(
            state.seenVisibility, now, VISIBILITY_SEEN_TTL_MS)
    return removed
end

local Feature = {}

Feature.Init = function(M)
    if type(M.MagiNecromancer) == 'table' then
        clearState(M.MagiNecromancer)
    end
    M.MagiNecromancer = newState()
    getConfig(M)
    M.SetMagiNecromancerEnabled = function(enabled)
        local cfg = getConfig(M)
        if cfg ~= nil then
            cfg.Enable = enabled == true
        end
        if enabled ~= true then
            clearState(M.MagiNecromancer)
        end
    end
    M.SetMagiNecromancerPredictionEnabled = function(enabled)
        local cfg = getConfig(M)
        if cfg ~= nil then
            cfg.DrawRevealPrediction = enabled == true
        end
        if enabled ~= true then
            clearState(M.MagiNecromancer)
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
    if state ~= nil
            and cfg ~= nil
            and cfg.Enable == true
            and cfg.DrawRevealPrediction == true
    then
        return handleVisibilityChange(
                state, entityID, wasVisible, isVisible, now)
    end
    return false
end

Feature.OnEntityChannel = function(entityID, actionID)
    local state = getState()
    return state ~= nil
            and handleActionStart(state, entityID, actionID) or false
end

Feature.OnEntityCast = Feature.OnEntityChannel

Feature.Update = function(guide, now)
    local state = getState()
    if state == nil then
        return false
    end
    local cfg = getConfig(guide)
    if cfg ~= nil
            and cfg.Enable == true
            and cfg.DrawRevealPrediction == true
    then
        return pruneState(state, now)
    end
    clearState(state)
    return false
end

Feature.Test = {
    Defaults = DEFAULTS,
    RevealSpecs = REVEAL_SPECS,
    PredictionTimeoutMs = PREDICTION_TIMEOUT_MS,
    NewState = newState,
    EnsureState = ensureState,
    GetConfig = getConfig,
    HandleVisibilityChange = handleVisibilityChange,
    HandleActionStart = handleActionStart,
    PruneState = pruneState,
    ClearState = clearState,
}

return Feature
end

rawset(_G, 'MuAiOccultCrescentNorthMagiNecromancer', Module)
return Module
