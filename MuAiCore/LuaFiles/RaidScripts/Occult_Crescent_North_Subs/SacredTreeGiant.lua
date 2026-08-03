local Module = {}

function Module.Create(Context)
    assert(type(Context) == 'table' and type(Context.Common) == 'table')
    local Common = Context.Common
    local finite = Context.finite
    local reliablePosition = Context.reliablePosition
    local resolveEntity = Context.resolveEntity

local GIANT_CONTENT_ID = 14508
local BLADE_HELPER_MODEL_ID = 9020
local FIGHTING_SPIRIT_BLADE_AID = 47531

-- The blade helpers report 47531 about once per second while moving. The
-- reference layout is a 4-yalm-radius capsule extending 10 yalms forward.
local BLADE_SIGNAL_TTL_MS = 1750
local BLADE_RADIUS = 4
local BLADE_LENGTH = 10
local BLADE_WIDTH = BLADE_RADIUS * 2

local DEFAULTS = {
    Enable = true,
}

local function newState()
    return {
        blades = {},
        lastDiagnostic = nil,
    }
end

local function ensureState(state)
    state = type(state) == 'table' and state or newState()
    state.blades = type(state.blades) == 'table' and state.blades or {}
    return state
end

local feature = Common.newFeature({
    key = 'SacredTreeGiant',
    defaults = DEFAULTS,
    newState = newState,
    ensureState = ensureState,
    diagnosticThrottleMs = 1000,
    diagnosticText = {
        blade_signal_invalid = '神木巨人斗气刃实体信号无效',
        danger_drawer_unavailable = '神木巨人危险范围绘图器不可用',
    },
})
local getConfig = feature.GetConfig

local function getState()
    return Common.getRuntimeState(
            'SacredTreeGiant', newState, ensureState)
end

local function diagnostic(state, code, now, context)
    feature.Diagnostic(
            state, rawget(_G, 'MuAiGuide'), code, now, context)
end

local function clearState(state)
    state = ensureState(state)
    state.blades = {}
    state.lastDiagnostic = nil
end

local function bladeGeometry(entityID)
    if not finite(entityID) or entityID <= 0 then
        return nil
    end
    local entity = resolveEntity(entityID)
    if type(entity) ~= 'table'
            or tonumber(entity.id) ~= entityID
            or tonumber(entity.contentid) ~= GIANT_CONTENT_ID
            or tonumber(entity.modelid) ~= BLADE_HELPER_MODEL_ID
            or entity.alive == false
            or entity.visible == false
    then
        return nil
    end
    local position = reliablePosition(entity.pos, true)
    if position == nil or not finite(position.h) then
        return nil
    end
    return position
end

local function handleBladeSignal(state, entityID, now)
    state = ensureState(state)
    if not finite(now) or bladeGeometry(entityID) == nil then
        diagnostic(state, 'blade_signal_invalid', now, entityID)
        return false
    end
    state.blades[entityID] = now
    state.lastDiagnostic = nil
    return true
end

local function drawBlades(state, now)
    state = ensureState(state)
    if not finite(now) then
        return false
    end
    local drawer = Common.getMoogleDrawer()
    if drawer == nil
            or type(drawer.addCircle) ~= 'function'
            or type(drawer.addRect) ~= 'function'
    then
        diagnostic(state, 'danger_drawer_unavailable', now)
        return false
    end
    local drawn = false
    for entityID, lastSeenAt in pairs(state.blades) do
        if not finite(lastSeenAt)
                or now - lastSeenAt > BLADE_SIGNAL_TTL_MS
        then
            state.blades[entityID] = nil
        else
            local position = bladeGeometry(entityID)
            if position ~= nil then
                drawer:addCircle(
                        position.x, position.y, position.z,
                        BLADE_RADIUS)
                drawer:addRect(
                        position.x, position.y, position.z,
                        BLADE_LENGTH, BLADE_WIDTH, position.h)
                drawn = true
            end
        end
    end
    return drawn
end

local Feature = {}

Feature.Init = function(M)
    if type(M.SacredTreeGiant) == 'table' then
        clearState(M.SacredTreeGiant)
    end
    M.SacredTreeGiant = newState()
    getConfig(M)
    M.SetSacredTreeGiantEnabled = function(enabled)
        local cfg = getConfig(M)
        if cfg ~= nil then
            cfg.Enable = enabled == true
        end
        if enabled ~= true then
            clearState(M.SacredTreeGiant)
        end
    end
end

Feature.Clear = function()
    local state = getState()
    if state ~= nil then
        clearState(state)
    end
end

Feature.OnEntityCast = function(entityID, actionID, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state ~= nil and cfg ~= nil
            and cfg.Enable == true
            and actionID == FIGHTING_SPIRIT_BLADE_AID
    then
        return handleBladeSignal(state, entityID, now)
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
        return drawBlades(state, now)
    end
    clearState(state)
    return false
end

Feature.Test = {
    Defaults = DEFAULTS,
    GiantContentID = GIANT_CONTENT_ID,
    BladeHelperModelID = BLADE_HELPER_MODEL_ID,
    FightingSpiritBladeActionID = FIGHTING_SPIRIT_BLADE_AID,
    BladeSignalTtlMs = BLADE_SIGNAL_TTL_MS,
    BladeRadius = BLADE_RADIUS,
    BladeLength = BLADE_LENGTH,
    BladeWidth = BLADE_WIDTH,
    NewState = newState,
    EnsureState = ensureState,
    GetConfig = getConfig,
    BladeGeometry = bladeGeometry,
    HandleBladeSignal = handleBladeSignal,
    DrawBlades = drawBlades,
    ClearState = clearState,
}

return Feature
end

rawset(_G, 'MuAiOccultCrescentNorthSacredTreeGiant', Module)
return Module
