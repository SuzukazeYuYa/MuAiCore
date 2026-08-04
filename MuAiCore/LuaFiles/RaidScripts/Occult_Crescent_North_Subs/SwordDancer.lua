local Module = {}

function Module.Create(Context)
    assert(type(Context) == 'table' and type(Context.Common) == 'table')
    local Common = Context.Common
    local finite = Context.finite
    local reliablePosition = Context.reliablePosition
    local resolveEntity = Context.resolveEntity

local BOSS_CONTENT_ID = 14820
local BOSS_MODEL_ID = 19830
local SWORD_CONTENT_ID = 14825
local SWORD_MODEL_ID = 19833
local ARENA_CENTER = { x = 600, z = 704 }

local LEAP_FIRST_AID = 49596
local LEAP_NEXT_AID = 49597
local SWORD_BURST_AID = 49685
local BLADE_DANCE_AID = 49614
local BLADE_GROUND_EFFECT_ID = 2015283
local SWORD_DONUT_SMALL_AID = 49589
local SWORD_DONUT_LARGE_AID = 49590
local SWORD_CIRCLE_AID = 49592

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
local LEGACY_DONUT_SOURCE = 'MuAiCore - 剑舞者月环内径修正'
local SPIN_OUTER_RADIUS = 30
local SPIN_CIRCLE_RADIUS = 15
local SPIN_PREVIEW_MS = 14000
local SPIN_BY_ANIMATION = {
    [210] = {
        actionID = SWORD_DONUT_SMALL_AID,
        kind = 'donut',
        inner = 15,
    },
    [211] = {
        actionID = SWORD_DONUT_LARGE_AID,
        kind = 'donut',
        inner = 20,
    },
    [5896] = {
        actionID = SWORD_CIRCLE_AID,
        kind = 'circle',
        radius = SPIN_CIRCLE_RADIUS,
    },
}
local BLACKLIST_LABELS = {
    [BLADE_DANCE_AID] = '剑舞者剑舞矩形预测',
    [SWORD_DONUT_SMALL_AID] = '剑舞者舞动之剑提前预测',
    [SWORD_DONUT_LARGE_AID] = '剑舞者舞动之剑提前预测',
    [SWORD_CIRCLE_AID] = '剑舞者舞动之剑提前预测',
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
        spinPreviews = {},
        blacklist = { owned = {}, registered = false },
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
    state.spinPreviews = type(state.spinPreviews) == 'table'
            and state.spinPreviews or {}
    state.blacklist = type(state.blacklist) == 'table'
            and state.blacklist or {}
    state.blacklist.owned = type(state.blacklist.owned) == 'table'
            and state.blacklist.owned or {}
    state.blacklist.registered = state.blacklist.registered == true
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
        spin_geometry_invalid = '剑舞者舞动之剑预兆几何不可用',
        leap_geometry_invalid = '剑舞者跃进步法落点不可用',
        leap_count_invalid = '剑舞者跃进步法落点数量不完整',
    },
})
local getConfig = feature.GetConfig

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
    if enabled == true then
        for actionID, label in pairs(BLACKLIST_LABELS) do
            local current = blacklist[actionID]
            local owned = current == state.blacklist.owned[actionID]
                    or (type(current) == 'table'
                            and current.source == BLACKLIST_SOURCE)
            if current == nil then
                current = {
                    label = label,
                    source = BLACKLIST_SOURCE,
                }
                blacklist[actionID] = current
                state.blacklist.owned[actionID] = current
            elseif owned then
                state.blacklist.owned[actionID] = current
            else
                state.blacklist.owned[actionID] = nil
            end
        end
        state.blacklist.registered = true
        return true
    end
    for actionID in pairs(BLACKLIST_LABELS) do
        local current = blacklist[actionID]
        if current == state.blacklist.owned[actionID]
                or (type(current) == 'table'
                        and current.source == BLACKLIST_SOURCE)
        then
            blacklist[actionID] = nil
        end
    end
    state.blacklist.owned = {}
    state.blacklist.registered = false
    return true
end

local function releaseLegacyDonutSettings(state)
    local bucket = type(state) == 'table' and state.moogleDonuts or nil
    if type(bucket) ~= 'table' then
        return false
    end
    local donuts = Common.getMoogleTable('aoeIDUserSetDonuts', false)
    if type(donuts) ~= 'table' then
        return false
    end
    local ownedEntries = type(bucket.owned) == 'table'
            and bucket.owned or {}
    local previous = type(bucket.previous) == 'table'
            and bucket.previous or {}
    local previousKnown = type(bucket.previousKnown) == 'table'
            and bucket.previousKnown or {}
    for _, actionID in ipairs({
        SWORD_DONUT_SMALL_AID,
        SWORD_DONUT_LARGE_AID,
    }) do
        local current = donuts[actionID]
        if current == ownedEntries[actionID]
                or (type(current) == 'table'
                        and current.source == LEGACY_DONUT_SOURCE)
        then
            donuts[actionID] = previousKnown[actionID]
                    and previous[actionID] or nil
        end
    end
    state.moogleDonuts = nil
    return true
end

local function clearMechanic(state)
    state = ensureState(state)
    for _, active in ipairs(state.active) do
        Common.deleteTimedShape(active.token)
    end
    for _, preview in pairs(state.spinPreviews) do
        Common.deleteTimedShape(preview.token)
    end
    state.groundEffects = {}
    state.bladeOrder = {}
    state.bladeSeen = {}
    state.leapPositions = {}
    state.guide = nil
    state.active = {}
    state.spinPreviews = {}
    state.lastDiagnostic = nil
end

local function resolveSword(entityID)
    if not finite(entityID) then
        return nil
    end
    local tensorCore = rawget(_G, 'TensorCore')
    if type(tensorCore) ~= 'table'
            or type(tensorCore.entityList) ~= 'function'
    then
        return nil
    end
    local entities = tensorCore.entityList(
            'contentid=' .. tostring(SWORD_CONTENT_ID))
    if type(entities) ~= 'table' then
        return nil
    end
    for _, entity in pairs(entities) do
        if type(entity) == 'table'
                and tonumber(entity.id) == entityID
                and tonumber(entity.contentid) == SWORD_CONTENT_ID
                and tonumber(entity.modelid) == SWORD_MODEL_ID
                and entity.alive ~= false
        then
            return reliablePosition(entity.pos, false)
        end
    end
    return nil
end

local function deleteSpinPreview(state, entityID)
    local preview = type(state) == 'table'
            and type(state.spinPreviews) == 'table'
            and state.spinPreviews[entityID] or nil
    if type(preview) ~= 'table' then
        return false
    end
    Common.deleteTimedShape(preview.token)
    state.spinPreviews[entityID] = nil
    return true
end

local function recordSpinAnimation(
        state, entityID, index, newAnimationID, now)
    local spec = tonumber(index) == 1
            and SPIN_BY_ANIMATION[tonumber(newAnimationID)] or nil
    if spec == nil or not finite(now) then
        return false
    end
    local current = state.spinPreviews[entityID]
    if type(current) == 'table'
            and current.actionID == spec.actionID
    then
        return false
    end
    local position = resolveSword(entityID)
    if position == nil then
        diagnostic(state, 'spin_geometry_invalid', now, entityID)
        return false
    end
    local drawer = Common.getMoogleDrawer()
    local token
    if spec.kind == 'circle'
            and type(drawer) == 'table'
            and type(drawer.addTimedCircle) == 'function'
    then
        token = drawer:addTimedCircle(
                SPIN_PREVIEW_MS,
                position.x, position.y, position.z,
                spec.radius,
                0)
    elseif spec.kind == 'donut'
            and type(drawer) == 'table'
            and type(drawer.addTimedDonut) == 'function'
    then
        token = drawer:addTimedDonut(
                SPIN_PREVIEW_MS,
                position.x, position.y, position.z,
                spec.inner, SPIN_OUTER_RADIUS,
                0)
    else
        diagnostic(state, 'danger_drawer_unavailable', now, spec.actionID)
        return false
    end
    if type(token) ~= 'string' then
        diagnostic(state, 'danger_drawer_rejected_shape', now, spec.actionID)
        return false
    end
    deleteSpinPreview(state, entityID)
    state.spinPreviews[entityID] = {
        token = token,
        actionID = spec.actionID,
        expiresAt = now + SPIN_PREVIEW_MS,
    }
    state.lastDiagnostic = nil
    return true
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
    for entityID, preview in pairs(state.spinPreviews) do
        if type(preview) ~= 'table'
                or not finite(preview.expiresAt)
                or now >= preview.expiresAt
        then
            state.spinPreviews[entityID] = nil
        end
    end
end

local Feature = {}

Feature.Init = function(M)
    if type(M.SwordDancer) == 'table' then
        releaseLegacyDonutSettings(M.SwordDancer)
        applyBlacklist(M.SwordDancer, false)
        clearMechanic(M.SwordDancer)
    end
    M.SwordDancer = newState()
    local cfg = getConfig(M)
    applyBlacklist(M.SwordDancer, cfg ~= nil and cfg.Enable == true)
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
        end
    end
end

Feature.OnAnimationChange = function(
        entityID, index, oldAnimationID, newAnimationID, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state ~= nil and cfg ~= nil and cfg.Enable == true then
        return recordSpinAnimation(
                state, entityID, index, newAnimationID, now)
    end
    return false
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
        if BLACKLIST_LABELS[actionID] ~= nil
                and actionID ~= BLADE_DANCE_AID
        then
            return deleteSpinPreview(state, entityID)
        end
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
        prune(state, now)
        if cfg.DynamicGuide == true then
            return drawGuide(state, guide, now)
        end
        state.guide = nil
        return false
    end
    clearMechanic(state)
    applyBlacklist(state, false)
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
    SwordCircleActionID = SWORD_CIRCLE_AID,
    SpinOuterRadius = SPIN_OUTER_RADIUS,
    SpinCircleRadius = SPIN_CIRCLE_RADIUS,
    SpinPreviewMs = SPIN_PREVIEW_MS,
    SpinByAnimation = SPIN_BY_ANIMATION,
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
    RecordSpinAnimation = recordSpinAnimation,
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
