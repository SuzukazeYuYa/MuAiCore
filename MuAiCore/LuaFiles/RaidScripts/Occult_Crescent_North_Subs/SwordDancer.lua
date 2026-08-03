local Module = {}

function Module.Create(Context)
    assert(type(Context) == 'table' and type(Context.Common) == 'table')
    local Common = Context.Common
    local finite = Context.finite
    local reliablePosition = Context.reliablePosition
    local resolveEntity = Context.resolveEntity

local BOSS_CONTENT_ID = 14820
local BOSS_MODEL_ID = 19830
local ARENA_CENTER = { x = 600, z = 704 }

local LEAP_FIRST_AID = 49596
local LEAP_NEXT_AID = 49597
local SWORD_BURST_AID = 49685
local BLADE_DANCE_AID = 49614
local BLADE_GROUND_EFFECT_ID = 2015283
local SWORD_DONUT_SMALL_AID = 49589
local SWORD_DONUT_LARGE_AID = 49590

local BLADE_RECT_LENGTH = 60
local BLADE_RECT_WIDTH = 20
local BLADE_FIRST_PREVIEW_MS = 6400
local BLADE_INTERVAL_MS = 2500
local LEAP_COUNT = 4
local LEAP_INWARD_DISTANCE = 9
local LEAP_FIRST_GUIDE_MS = 5000
local LEAP_GUIDE_INTERVAL_MS = 2500
local ROUND_TTL_MS = 20000
local BLACKLIST_SOURCE = 'MuAiCore - 剑舞者剑舞矩形预测'
local DONUT_SOURCE = 'MuAiCore - 剑舞者月环内径修正'
local SWORD_DONUTS = {
    [SWORD_DONUT_SMALL_AID] = {
        name = '舞动之剑月环（内径15）',
        radius = 15,
    },
    [SWORD_DONUT_LARGE_AID] = {
        name = '舞动之剑月环（内径20）',
        radius = 20,
    },
}

local DEFAULTS = {
    Enable = true,
    DynamicGuide = true,
}

local function newState()
    return {
        groundEffects = {},
        bladeOrder = {},
        bladeSeen = {},
        leapPositions = {},
        guide = nil,
        active = {},
        blacklist = { owned = nil, registered = false },
        moogleDonuts = {
            registered = false,
            owned = {},
            previous = {},
            previousKnown = {},
        },
        lastDiagnostic = nil,
    }
end

local function ensureState(state)
    state = type(state) == 'table' and state or newState()
    state.groundEffects = type(state.groundEffects) == 'table'
            and state.groundEffects or {}
    state.bladeOrder = type(state.bladeOrder) == 'table'
            and state.bladeOrder or {}
    state.bladeSeen = type(state.bladeSeen) == 'table'
            and state.bladeSeen or {}
    state.leapPositions = type(state.leapPositions) == 'table'
            and state.leapPositions or {}
    state.active = type(state.active) == 'table' and state.active or {}
    state.blacklist = type(state.blacklist) == 'table'
            and state.blacklist or {}
    state.blacklist.registered = state.blacklist.registered == true
    state.moogleDonuts = type(state.moogleDonuts) == 'table'
            and state.moogleDonuts or {}
    state.moogleDonuts.registered = state.moogleDonuts.registered == true
    state.moogleDonuts.owned = type(state.moogleDonuts.owned) == 'table'
            and state.moogleDonuts.owned or {}
    state.moogleDonuts.previous = type(state.moogleDonuts.previous) == 'table'
            and state.moogleDonuts.previous or {}
    state.moogleDonuts.previousKnown =
            type(state.moogleDonuts.previousKnown) == 'table'
            and state.moogleDonuts.previousKnown or {}
    return state
end

local feature = Common.newFeature({
    key = 'SwordDancer',
    defaults = DEFAULTS,
    newState = newState,
    ensureState = ensureState,
    diagnosticThrottleMs = 1000,
    diagnosticText = {
        ground_effect_invalid = '剑舞者剑舞地面物件信号无效',
        blade_activation_missing = '剑舞者剑舞激活信号缺少对应物件',
        danger_drawer_unavailable = '剑舞者危险范围绘图器不可用',
        danger_drawer_rejected_shape = '剑舞者危险范围绘制失败',
        leap_geometry_invalid = '剑舞者跃进步法落点不可用',
        leap_count_invalid = '剑舞者跃进步法落点数量不完整',
    },
})
local getConfig = feature.GetConfig

local donutRegistry = Common.newMoogleDonutRegistry({
    entries = SWORD_DONUTS,
    source = DONUT_SOURCE,
    ensureState = ensureState,
    getBucket = function(state)
        return state.moogleDonuts
    end,
})
local applyMoogleDonuts = donutRegistry.Apply

local function getState()
    return Common.getRuntimeState('SwordDancer', newState, ensureState)
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
    local current = blacklist[BLADE_DANCE_AID]
    local owned = current == state.blacklist.owned
            or (type(current) == 'table'
                    and current.source == BLACKLIST_SOURCE)
    if enabled == true then
        if current == nil then
            current = {
                label = '剑舞者剑舞矩形预测',
                source = BLACKLIST_SOURCE,
            }
            blacklist[BLADE_DANCE_AID] = current
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
        blacklist[BLADE_DANCE_AID] = nil
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
    state.groundEffects = {}
    state.bladeOrder = {}
    state.bladeSeen = {}
    state.leapPositions = {}
    state.guide = nil
    state.active = {}
    state.lastDiagnostic = nil
end

local function bossValid(entityID)
    local entity = resolveEntity(entityID)
    return type(entity) == 'table'
            and tonumber(entity.id) == entityID
            and tonumber(entity.contentid) == BOSS_CONTENT_ID
            and tonumber(entity.modelid) == BOSS_MODEL_ID
            and entity.alive ~= false
            and entity.visible ~= false
end

local function recordGroundEffect(state, args, now)
    state = ensureState(state)
    local entityID = tonumber(args[1])
    local effectType = tonumber(args[2])
    local flags = tonumber(args[3])
    local keyID = tonumber(args[5])
    local heading = tonumber(args[12])
    local stateValue = tonumber(args[15])
    local position = reliablePosition({
        x = tonumber(args[17]),
        y = tonumber(args[18]),
        z = tonumber(args[19]),
    }, false)
    if keyID ~= BLADE_GROUND_EFFECT_ID then
        return false
    end
    if not finite(entityID)
            or effectType ~= 7
            or flags ~= 5
            or stateValue ~= 4
            or not finite(heading)
            or position == nil
            or not finite(now)
    then
        diagnostic(state, 'ground_effect_invalid', now, entityID)
        return false
    end
    state.groundEffects[entityID] = {
        pos = position,
        heading = heading,
        addedAt = now,
    }
    return true
end

local function drawBladeSequence(state, now)
    local drawer = Common.getMoogleDrawer()
    if drawer == nil
            or type(drawer.addTimedCenteredRect) ~= 'function'
    then
        diagnostic(state, 'danger_drawer_unavailable', now)
        return false
    end
    local created = {}
    for index, entry in ipairs(state.bladeOrder) do
        local delay = index == 1 and 0
                or BLADE_FIRST_PREVIEW_MS
                        + (index - 2) * BLADE_INTERVAL_MS
        local duration = index == 1
                and BLADE_FIRST_PREVIEW_MS or BLADE_INTERVAL_MS
        local token = drawer:addTimedCenteredRect(
                duration,
                entry.pos.x, entry.pos.y, entry.pos.z,
                BLADE_RECT_LENGTH, BLADE_RECT_WIDTH,
                entry.heading,
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
    for _, active in ipairs(created) do
        state.active[#state.active + 1] = active
    end
    return true
end

local function recordBladeActivation(
        state, entityID, a1, a2, now)
    state = ensureState(state)
    if tonumber(a1) ~= 1 or tonumber(a2) ~= 2 then
        return false
    end
    if state.bladeSeen[entityID] == true then
        return false
    end
    local effect = state.groundEffects[entityID]
    if type(effect) ~= 'table' then
        diagnostic(state, 'blade_activation_missing', now, entityID)
        state.groundEffects = {}
        state.bladeOrder = {}
        state.bladeSeen = {}
        return false
    end
    state.bladeSeen[entityID] = true
    state.bladeOrder[#state.bladeOrder + 1] = effect
    if #state.bladeOrder < 4 then
        return true
    end
    local drawn = drawBladeSequence(state, now)
    state.groundEffects = {}
    state.bladeOrder = {}
    state.bladeSeen = {}
    if drawn then
        state.lastDiagnostic = nil
    end
    return drawn
end

local function recordLeap(state, entityID, actionID, castPos, now)
    if actionID ~= LEAP_FIRST_AID and actionID ~= LEAP_NEXT_AID then
        return false
    end
    if not bossValid(entityID) or not finite(now) then
        diagnostic(state, 'leap_geometry_invalid', now, actionID)
        return false
    end
    local position = reliablePosition(castPos, false)
    if position == nil then
        diagnostic(state, 'leap_geometry_invalid', now, actionID)
        return false
    end
    if actionID == LEAP_FIRST_AID then
        state.leapPositions = {}
        state.guide = nil
    end
    for _, existing in ipairs(state.leapPositions) do
        local dx = existing.x - position.x
        local dz = existing.z - position.z
        if dx * dx + dz * dz <= 1 then
            return false
        end
    end
    state.leapPositions[#state.leapPositions + 1] = position
    return true
end

local function inwardPoint(position)
    local dx = ARENA_CENTER.x - position.x
    local dz = ARENA_CENTER.z - position.z
    local length = math.sqrt(dx * dx + dz * dz)
    if length <= 0.001 then
        return nil
    end
    return {
        x = position.x + dx / length * LEAP_INWARD_DISTANCE,
        y = position.y,
        z = position.z + dz / length * LEAP_INWARD_DISTANCE,
    }
end

local function startGuide(state, entityID, now)
    if not bossValid(entityID) or not finite(now) then
        return false
    end
    if #state.leapPositions ~= LEAP_COUNT then
        diagnostic(
                state, 'leap_count_invalid', now, #state.leapPositions)
        state.leapPositions = {}
        return false
    end
    local points = {}
    for _, position in ipairs(state.leapPositions) do
        local point = inwardPoint(position)
        if point == nil then
            diagnostic(state, 'leap_geometry_invalid', now)
            state.leapPositions = {}
            return false
        end
        points[#points + 1] = point
    end
    state.guide = {
        startedAt = now,
        expiresAt = now + LEAP_FIRST_GUIDE_MS
                + (LEAP_COUNT - 1) * LEAP_GUIDE_INTERVAL_MS,
        points = points,
    }
    state.leapPositions = {}
    state.lastDiagnostic = nil
    return true
end

local function drawGuide(state, guide, now)
    local route = state.guide
    if type(route) ~= 'table' or now >= route.expiresAt then
        state.guide = nil
        return false
    end
    local elapsed = now - route.startedAt
    local index = elapsed < LEAP_FIRST_GUIDE_MS and 1
            or 2 + math.floor(
                    (elapsed - LEAP_FIRST_GUIDE_MS)
                    / LEAP_GUIDE_INTERVAL_MS)
    local point = route.points[index]
    if type(point) ~= 'table'
            or type(guide) ~= 'table'
            or type(guide.FrameDirect) ~= 'function'
    then
        return false
    end
    local color = type(guide.Config) == 'table'
            and type(guide.Config.Main) == 'table'
            and guide.Config.Main.GuideColor
            or { r = 0, g = 1, b = 1, a = 0.5 }
    guide.FrameDirect(point.x, point.z, 0.7, color)
    return true
end

local function prune(state, now)
    for entityID, effect in pairs(state.groundEffects) do
        if type(effect) ~= 'table'
                or not finite(effect.addedAt)
                or now - effect.addedAt > ROUND_TTL_MS
        then
            state.groundEffects[entityID] = nil
        end
    end
    for index = #state.active, 1, -1 do
        if now >= state.active[index].expiresAt then
            table.remove(state.active, index)
        end
    end
end

local Feature = {}

Feature.Init = function(M)
    if type(M.SwordDancer) == 'table' then
        applyBlacklist(M.SwordDancer, false)
        applyMoogleDonuts(M.SwordDancer, false)
        clearMechanic(M.SwordDancer)
    end
    M.SwordDancer = newState()
    local cfg = getConfig(M)
    applyBlacklist(M.SwordDancer, cfg ~= nil and cfg.Enable == true)
    applyMoogleDonuts(M.SwordDancer, cfg ~= nil and cfg.Enable == true)
    M.SetSwordDancerEnabled = function(enabled)
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
            applyMoogleDonuts(state, enabled == true)
        end
    end
    M.SetSwordDancerDynamicGuideEnabled = function(enabled)
        local current = getConfig(M)
        if current ~= nil then
            current.DynamicGuide = enabled == true
        end
        if enabled ~= true and type(M.SwordDancer) == 'table' then
            M.SwordDancer.guide = nil
        end
    end
end

Feature.Clear = function(releaseOwnership)
    local state = getState()
    if state ~= nil then
        clearMechanic(state)
        if releaseOwnership == true then
            applyBlacklist(state, false)
            applyMoogleDonuts(state, false)
        end
    end
end

Feature.OnAddGroundEffect = function(args, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state ~= nil and cfg ~= nil and cfg.Enable == true
            and type(args) == 'table'
    then
        return recordGroundEffect(state, args, now)
    end
    return false
end

Feature.OnEventObjectScriptFunc = function(
        entityID, a1, a2, a3, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state ~= nil and cfg ~= nil and cfg.Enable == true then
        return recordBladeActivation(state, entityID, a1, a2, now)
    end
    return false
end

Feature.OnEntityCast = function(entityID, actionID, castPos, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state ~= nil and cfg ~= nil and cfg.Enable == true then
        return recordLeap(state, entityID, actionID, castPos, now)
    end
    return false
end

Feature.OnEntityChannel = function(entityID, actionID, now)
    if actionID ~= SWORD_BURST_AID then
        return false
    end
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state ~= nil and cfg ~= nil and cfg.Enable == true
            and cfg.DynamicGuide == true
    then
        return startGuide(state, entityID, now)
    end
    return false
end

Feature.Update = function(guide, now)
    local state = getState()
    if state == nil or not finite(now) then
        return false
    end
    local cfg = getConfig(guide)
    if cfg ~= nil and cfg.Enable == true then
        applyBlacklist(state, true)
        applyMoogleDonuts(state, true)
        prune(state, now)
        if cfg.DynamicGuide == true then
            return drawGuide(state, guide, now)
        end
        state.guide = nil
        return false
    end
    clearMechanic(state)
    applyBlacklist(state, false)
    applyMoogleDonuts(state, false)
    return false
end

Feature.Test = {
    Defaults = DEFAULTS,
    BossContentID = BOSS_CONTENT_ID,
    BossModelID = BOSS_MODEL_ID,
    BladeDanceActionID = BLADE_DANCE_AID,
    BladeGroundEffectID = BLADE_GROUND_EFFECT_ID,
    SwordDonutSmallActionID = SWORD_DONUT_SMALL_AID,
    SwordDonutLargeActionID = SWORD_DONUT_LARGE_AID,
    SwordDonuts = SWORD_DONUTS,
    LeapFirstActionID = LEAP_FIRST_AID,
    LeapNextActionID = LEAP_NEXT_AID,
    SwordBurstActionID = SWORD_BURST_AID,
    BladeRectLength = BLADE_RECT_LENGTH,
    BladeRectWidth = BLADE_RECT_WIDTH,
    BladeFirstPreviewMs = BLADE_FIRST_PREVIEW_MS,
    BladeIntervalMs = BLADE_INTERVAL_MS,
    LeapInwardDistance = LEAP_INWARD_DISTANCE,
    LeapFirstGuideMs = LEAP_FIRST_GUIDE_MS,
    LeapGuideIntervalMs = LEAP_GUIDE_INTERVAL_MS,
    NewState = newState,
    EnsureState = ensureState,
    GetConfig = getConfig,
    ApplyBlacklist = applyBlacklist,
    ApplyMoogleDonuts = applyMoogleDonuts,
    RecordGroundEffect = recordGroundEffect,
    RecordBladeActivation = recordBladeActivation,
    RecordLeap = recordLeap,
    StartGuide = startGuide,
    DrawGuide = drawGuide,
    ClearMechanic = clearMechanic,
}

return Feature
end

rawset(_G, 'MuAiOccultCrescentNorthSwordDancer', Module)
return Module
