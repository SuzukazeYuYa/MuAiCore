local Module = {}

function Module.Create(Context)
    assert(type(Context) == 'table' and type(Context.Common) == 'table')
    local Common = Context.Common
    local finite = Context.finite

local BOSS_CONTENT_ID = 14503
local INITIAL_AID = 47477
local FOLLOWUP_AID = 47478
local INITIAL_CAST_TYPE = 12
local INITIAL_LENGTH = 60
local INITIAL_WIDTH = 10
local INITIAL_DURATION = 5.2
local STEP_DISTANCE = 10
local FIRST_STEP_OFFSET_MS = 6560
local STEP_INTERVAL_MS = 2080
local RESOLVE_GRACE_MS = 200
local ROUND_TTL_MS = 12000
local BLACKLIST_SOURCE = 'MuAiCore - 惧死者黑暗奔流扩散预测'

local DEFAULTS = {
    Enable = true,
}

local function newState()
    return {
        active = {},
        seen = {},
        blacklist = { owned = nil, registered = false },
        lastDiagnostic = nil,
    }
end

local function ensureState(state)
    state = type(state) == 'table' and state or newState()
    state.active = type(state.active) == 'table' and state.active or {}
    state.seen = type(state.seen) == 'table' and state.seen or {}
    state.blacklist = type(state.blacklist) == 'table'
            and state.blacklist or {}
    state.blacklist.registered = state.blacklist.registered == true
    return state
end

local feature = Common.newFeature({
    key = 'Necrophobia',
    defaults = DEFAULTS,
    newState = newState,
    ensureState = ensureState,
    diagnosticThrottleMs = 1000,
    diagnosticText = {
        initial_event_invalid = '惧死者黑暗奔流预兆字段不完整',
        initial_event_stale = '惧死者黑暗奔流预兆不是当前事件',
        initial_geometry_mismatch = '惧死者黑暗奔流预兆几何与实战样本不符',
        danger_drawer_unavailable = '惧死者黑暗奔流扩散绘图器不可用',
        danger_drawer_rejected_shape = '惧死者黑暗奔流扩散绘制失败',
    },
})
local getConfig = feature.GetConfig

local function getState()
    return Common.getRuntimeState('Necrophobia', newState, ensureState)
end

local function diagnostic(state, code, now, context)
    feature.Diagnostic(
            state, rawget(_G, 'MuAiGuide'), code, now, context)
end

local function applyBlacklist(state, enabled)
    state = ensureState(state)
    local blacklist = Common.getMoogleTable(
            'aoeIDUserBlacklist', enabled == true)
    if blacklist == nil then
        state.blacklist.registered = false
        return false
    end
    local current = blacklist[FOLLOWUP_AID]
    local owned = current == state.blacklist.owned
            or (type(current) == 'table'
                    and current.source == BLACKLIST_SOURCE)
    if enabled == true then
        if current == nil then
            current = {
                label = '惧死者黑暗奔流扩散预测',
                source = BLACKLIST_SOURCE,
            }
            blacklist[FOLLOWUP_AID] = current
            state.blacklist.owned = current
        elseif owned then
            state.blacklist.owned = current
        else
            state.blacklist.owned = nil
        end
        state.blacklist.registered = true
        return true
    end
    if owned then
        blacklist[FOLLOWUP_AID] = nil
    end
    state.blacklist.owned = nil
    state.blacklist.registered = false
    return true
end

local function clearMechanic(state)
    state = ensureState(state)
    for _, active in ipairs(state.active) do
        Common.deleteTimedShape(active.token)
    end
    state.active = {}
    state.seen = {}
    state.lastDiagnostic = nil
end

local function readInitial(aoeInfo, now)
    if type(aoeInfo) ~= 'table'
            or tonumber(aoeInfo.aoeID) ~= INITIAL_AID
    then
        return nil, nil
    end
    local entityID = tonumber(aoeInfo.entityID)
    local startTime = tonumber(aoeInfo.startTime)
    local duration = tonumber(aoeInfo.duration)
    local heading = tonumber(aoeInfo.heading)
    local x = tonumber(aoeInfo.x)
    local y = tonumber(aoeInfo.y)
    local z = tonumber(aoeInfo.z)
    local length = tonumber(aoeInfo.aoeLength)
    local width = tonumber(aoeInfo.aoeWidth)
    if not finite(now)
            or not finite(entityID)
            or not finite(startTime)
            or not finite(duration)
            or not finite(heading)
            or not finite(x)
            or not finite(y)
            or y == 0
            or not finite(z)
            or tonumber(aoeInfo.contentID) ~= BOSS_CONTENT_ID
            or tonumber(aoeInfo.aoeCastType) ~= INITIAL_CAST_TYPE
            or not finite(length)
            or not finite(width)
    then
        return nil, 'initial_event_invalid'
    end
    local age = now - startTime
    if age > 1000 or age < -250 then
        return nil, 'initial_event_stale', { age = age }
    end
    if math.abs(duration - INITIAL_DURATION) > 0.15
            or math.abs(length - INITIAL_LENGTH) > 0.25
            or math.abs(width - INITIAL_WIDTH) > 0.25
    then
        return nil, 'initial_geometry_mismatch', {
            duration = duration,
            length = length,
            width = width,
        }
    end
    return {
        entityID = entityID,
        startTime = startTime,
        heading = heading,
        seed = {
            x = x + math.sin(heading) * length / 2,
            y = y,
            z = z + math.cos(heading) * length / 2,
        },
    }
end

local function offsetRight(position, heading, distance)
    return {
        x = position.x + math.cos(heading) * distance,
        y = position.y,
        z = position.z - math.sin(heading) * distance,
    }
end

local function drawPrediction(state, initial, now)
    local drawer = Common.getMoogleDrawer()
    if drawer == nil
            or type(drawer.addTimedCenteredRect) ~= 'function'
    then
        diagnostic(state, 'danger_drawer_unavailable', now)
        return false
    end
    local created = {}
    for step = 1, 2 do
        local delay = step == 1 and 0 or FIRST_STEP_OFFSET_MS
        local duration = step == 1
                and FIRST_STEP_OFFSET_MS + RESOLVE_GRACE_MS
                or STEP_INTERVAL_MS + RESOLVE_GRACE_MS
        local centerDistance = step * STEP_DISTANCE
        for _, side in ipairs({ -1, 1 }) do
            local center = offsetRight(
                    initial.seed, initial.heading,
                    side * centerDistance)
            local token = drawer:addTimedCenteredRect(
                    duration,
                    center.x, center.y, center.z,
                    INITIAL_LENGTH, INITIAL_WIDTH,
                    initial.heading,
                    delay)
            if type(token) ~= 'string' then
                for _, active in ipairs(created) do
                    Common.deleteTimedShape(active.token)
                end
                diagnostic(state, 'danger_drawer_rejected_shape', now)
                return false
            end
            created[#created + 1] = {
                token = token,
                expiresAt = now + delay + duration,
            }
        end
    end
    for _, active in ipairs(created) do
        state.active[#state.active + 1] = active
    end
    state.lastDiagnostic = nil
    return true
end

local function handleAOECreate(state, aoeInfo, now)
    local initial, code, context = readInitial(aoeInfo, now)
    if initial == nil then
        if code ~= nil then
            diagnostic(state, code, now, context)
        end
        return false
    end
    local key = tostring(initial.entityID)
            .. ':' .. tostring(math.floor(initial.startTime + 0.5))
    if state.seen[key] ~= nil then
        return false
    end
    state.seen[key] = now
    return drawPrediction(state, initial, now)
end

local function prune(state, now)
    for index = #state.active, 1, -1 do
        if now >= state.active[index].expiresAt then
            table.remove(state.active, index)
        end
    end
    for key, seenAt in pairs(state.seen) do
        if not finite(seenAt) or now - seenAt > ROUND_TTL_MS then
            state.seen[key] = nil
        end
    end
end

local Feature = {}

Feature.Init = function(M)
    if type(M.Necrophobia) == 'table' then
        applyBlacklist(M.Necrophobia, false)
        clearMechanic(M.Necrophobia)
    end
    M.Necrophobia = newState()
    local cfg = getConfig(M)
    applyBlacklist(M.Necrophobia, cfg ~= nil and cfg.Enable == true)
    M.SetNecrophobiaEnabled = function(enabled)
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
    if state ~= nil then
        clearMechanic(state)
        if releaseOwnership == true then
            applyBlacklist(state, false)
        end
    end
end

Feature.OnAOECreate = function(aoeInfo, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state ~= nil and cfg ~= nil and cfg.Enable == true then
        return handleAOECreate(state, aoeInfo, now)
    end
    return false
end

Feature.Update = function(_, now)
    local state = getState()
    if state == nil or not finite(now) then
        return false
    end
    local cfg = getConfig(rawget(_G, 'MuAiGuide'))
    if cfg ~= nil and cfg.Enable == true then
        applyBlacklist(state, true)
        prune(state, now)
        return false
    end
    clearMechanic(state)
    applyBlacklist(state, false)
    return false
end

Feature.Test = {
    Defaults = DEFAULTS,
    BossContentID = BOSS_CONTENT_ID,
    InitialActionID = INITIAL_AID,
    FollowupActionID = FOLLOWUP_AID,
    InitialLength = INITIAL_LENGTH,
    InitialWidth = INITIAL_WIDTH,
    StepDistance = STEP_DISTANCE,
    FirstStepOffsetMs = FIRST_STEP_OFFSET_MS,
    StepIntervalMs = STEP_INTERVAL_MS,
    NewState = newState,
    EnsureState = ensureState,
    GetConfig = getConfig,
    ApplyBlacklist = applyBlacklist,
    ReadInitial = readInitial,
    HandleAOECreate = handleAOECreate,
    ClearMechanic = clearMechanic,
}

return Feature
end

rawset(_G, 'MuAiOccultCrescentNorthNecrophobia', Module)
return Module
