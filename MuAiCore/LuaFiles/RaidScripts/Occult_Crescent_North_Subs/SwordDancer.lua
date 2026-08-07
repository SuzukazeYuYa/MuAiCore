local Module = {}

function Module.Create(Context)
    assert(type(Context) == 'table' and type(Context.Common) == 'table')
    local Common = Context.Common
    local finite = Context.finite
    local reliablePosition = Context.reliablePosition

local BOSS_CONTENT_ID = 14820
local BOSS_MODEL_ID = 19830
local SWORD_CONTENT_ID = 14825
local SWORD_MODEL_ID = 19833
local EXTREME_SWORD_MODEL_ID = 19841
local SWORD_MODEL_IDS = {
    [SWORD_MODEL_ID] = true,
    [EXTREME_SWORD_MODEL_ID] = true,
}
local ARENA_CENTER = { x = 600, z = 704 }

local LEAP_FIRST_AID = 49596
local LEAP_NEXT_AID = 49597
local SWORD_BURST_AID = 49685
local EXTREME_LEAP_FIRST_AID = 49656
local EXTREME_LEAP_NEXT_AID = 49657
local EXTREME_SWORD_BURST_AID = 49687
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
local EXTREME_RING_PREVIEW_MS = 20000
local EXTREME_RING_SECOND_MS = 6000
local EXTREME_RING_OUTER_RADIUS = 31
local EXTREME_RING_RADIUS_BY_AURA = {
    [2942] = 10,
    [2943] = 15,
    [2944] = 20,
}
local EXTREME_FIRST_BY_ANIMATION = {
    [3604] = 'circle', [5896] = 'circle', [6847] = 'circle',
    [209] = 'donut', [210] = 'donut', [211] = 'donut',
}
local EXTREME_RING_SPIN_AIDS = {
    [49648] = true, [49649] = true, [49650] = true,
    [49651] = true, [49652] = true, [49653] = true,
}
local EXTREME_RING_DONUT_AIDS = {
    [49648] = true, [49649] = true, [49650] = true,
}
local EXTREME_RING_FLIP_AIDS = {
    [50431] = true, [50432] = true, [50433] = true,
    [50434] = true, [50435] = true, [50436] = true,
}
local SWEEP_AIDS = {
    [49635] = true, [49636] = true, [49637] = true,
    [49639] = true, [50063] = true, [50064] = true,
}
local SWEEP_TYPE_STEP = { [750] = -math.pi / 2, [752] = math.pi / 2 }
local SWEEP_ANGLE = math.rad(90)
local SWEEP_NEXT_PREVIEW_MS = 4400
-- Hidden swords become queryable about four to six seconds after their pose
-- animation. Keep that verified pose until its own prediction window ends.
local SPIN_RESOLVE_TIMEOUT_MS = SPIN_PREVIEW_MS
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
for actionID in pairs(EXTREME_RING_SPIN_AIDS) do
    BLACKLIST_LABELS[actionID] = '极塔剑舞者回旋剑提前预测'
end
for actionID in pairs(SWEEP_AIDS) do
    BLACKLIST_LABELS[actionID] = '极塔剑舞者回旋扇形修正'
end

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
        leapSourceID = nil,
        leapStartedAt = nil,
        leapExpectedCount = nil,
        guide = nil,
        active = {},
        spinPreviews = {},
        swordIDs = {},
        pendingSpins = {},
        extremeRingOrders = {},
        extremeRings = {},
        pendingExtremeRings = {},
        sweepSeen = {},
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
    state.swordIDs = type(state.swordIDs) == 'table'
            and state.swordIDs or {}
    state.pendingSpins = type(state.pendingSpins) == 'table'
            and state.pendingSpins or {}
    state.extremeRingOrders = type(state.extremeRingOrders) == 'table'
            and state.extremeRingOrders or {}
    state.extremeRings = type(state.extremeRings) == 'table'
            and state.extremeRings or {}
    state.pendingExtremeRings = type(state.pendingExtremeRings) == 'table'
            and state.pendingExtremeRings or {}
    state.sweepSeen = type(state.sweepSeen) == 'table'
            and state.sweepSeen or {}
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
        danger_drawer_unavailable = '剑舞者危险范围绘图器不可用',
        danger_drawer_rejected_shape = '剑舞者危险范围绘制失败',
        spin_geometry_invalid = '剑舞者舞动之剑预兆几何不可用',
        leap_geometry_invalid = '剑舞者跃进步法落点不可用',
        leap_source_mismatch = '剑舞者跃进步法施法者不一致',
        leap_count_invalid = '剑舞者跃进步法落点数量不完整',
        extreme_ring_entity_invalid = '极塔剑舞者回旋剑实体身份或位置不可用',
        extreme_ring_order_missing = '极塔剑舞者回旋剑缺少可靠姿态顺序',
        sweep_geometry_invalid = '极塔剑舞者回旋扇形事件几何无效',
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
    for _, ring in pairs(state.extremeRings) do
        Common.deleteTimedShape(ring.token)
    end
    state.groundEffects = {}
    state.bladeOrder = {}
    state.bladeSeen = {}
    state.leapPositions = {}
    state.leapSourceID = nil
    state.leapStartedAt = nil
    state.leapExpectedCount = nil
    state.guide = nil
    state.active = {}
    state.spinPreviews = {}
    state.swordIDs = {}
    state.pendingSpins = {}
    state.extremeRingOrders = {}
    state.extremeRings = {}
    state.pendingExtremeRings = {}
    state.sweepSeen = {}
    state.lastDiagnostic = nil
end

local function entityModelID(entityID, entity)
    return Common.entityModelID(entity or entityID)
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
                and SWORD_MODEL_IDS[entityModelID(entityID, entity)] == true
                and entity.alive ~= false
        then
            return reliablePosition(entity.pos, false),
                    entityModelID(entityID, entity)
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

local function recordSwordEntity(state, entityID, contentID, now)
    state = ensureState(state)
    if tonumber(contentID) ~= SWORD_CONTENT_ID
            or not finite(entityID)
            or not finite(now)
    then
        return false
    end
    state.swordIDs[entityID] = now
    return true
end

local function drawSpinPreview(
        state, entityID, spec, position, timeout, now)
    local current = state.spinPreviews[entityID]
    if type(current) == 'table'
            and current.actionID == spec.actionID
    then
        return false
    end
    local drawer = Common.getMoogleDrawer()
    local token
    if spec.kind == 'circle'
            and type(drawer) == 'table'
            and type(drawer.addTimedCircle) == 'function'
    then
        token = drawer:addTimedCircle(
                timeout,
                position.x, position.y, position.z,
                spec.radius,
                0)
    elseif spec.kind == 'donut'
            and type(drawer) == 'table'
            and type(drawer.addTimedDonut) == 'function'
    then
        token = drawer:addTimedDonut(
                timeout,
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
        expiresAt = now + timeout,
    }
    state.lastDiagnostic = nil
    return true
end

local function deleteExtremeRing(state, entityID)
    local ring = state.extremeRings[entityID]
    if type(ring) ~= 'table' then
        return false
    end
    Common.deleteTimedShape(ring.token)
    ring.token = nil
    return true
end

local function drawExtremeRing(
        state, entityID, ring, shape, timeout, now)
    local drawer = Common.getMoogleDrawer()
    local token
    if shape == 'circle'
            and type(drawer) == 'table'
            and type(drawer.addTimedCircle) == 'function'
    then
        token = drawer:addTimedCircle(
                timeout,
                ring.pos.x, ring.pos.y, ring.pos.z,
                ring.radius, 0)
    elseif shape == 'donut'
            and type(drawer) == 'table'
            and type(drawer.addTimedDonut) == 'function'
    then
        token = drawer:addTimedDonut(
                timeout,
                ring.pos.x, ring.pos.y, ring.pos.z,
                ring.radius, EXTREME_RING_OUTER_RADIUS, 0)
    else
        diagnostic(state, 'danger_drawer_unavailable', now, shape)
        return false
    end
    if type(token) ~= 'string' then
        diagnostic(state, 'danger_drawer_rejected_shape', now, shape)
        return false
    end
    deleteExtremeRing(state, entityID)
    ring.token = token
    ring.expiresAt = now + timeout
    ring.shown = shape
    state.lastDiagnostic = nil
    return true
end

local function applyExtremeRingOrder(
        state, entityID, first, now)
    local previous = state.extremeRingOrders[entityID]
    if type(previous) == 'table'
            and previous.first == first
            and finite(previous.recordedAt)
            and now - previous.recordedAt < 1000
    then
        return false
    end
    state.extremeRingOrders[entityID] = {
        first = first,
        recordedAt = now,
    }
    local ring = state.extremeRings[entityID]
    if type(ring) == 'table' and ring.stage == 1 then
        ring.first = first
        ring.second = first == 'donut' and 'circle' or 'donut'
        return drawExtremeRing(
                state, entityID, ring, first,
                EXTREME_RING_PREVIEW_MS, now)
    end
    return true
end

local function applySpinAnimation(
        state, entityID, newAnimationID, position, modelID, now, timeout)
    if modelID == EXTREME_SWORD_MODEL_ID then
        local first = EXTREME_FIRST_BY_ANIMATION[newAnimationID]
        if first == nil then
            return false
        end
        return applyExtremeRingOrder(
                state, entityID, first, now)
    end
    local spec = SPIN_BY_ANIMATION[newAnimationID]
    if modelID ~= SWORD_MODEL_ID or spec == nil then
        return false
    end
    return drawSpinPreview(
            state, entityID, spec, position,
            timeout or SPIN_PREVIEW_MS, now)
end

local function recordSpinAnimation(
        state, entityID, index, newAnimationID, now)
    state = ensureState(state)
    newAnimationID = tonumber(newAnimationID)
    if tonumber(index) ~= 1
            or (SPIN_BY_ANIMATION[newAnimationID] == nil
                    and EXTREME_FIRST_BY_ANIMATION[newAnimationID] == nil)
            or not finite(entityID) or not finite(now)
    then
        return false
    end
    local position, modelID = resolveSword(entityID)
    if state.swordIDs[entityID] == nil then
        if position == nil then
            return false
        end
        state.swordIDs[entityID] = now
    end
    if position ~= nil then
        state.pendingSpins[entityID] = nil
        return applySpinAnimation(
                state, entityID, newAnimationID,
                position, modelID, now)
    end
    state.pendingSpins[entityID] = {
        animationID = newAnimationID,
        expiresAt = now + SPIN_RESOLVE_TIMEOUT_MS,
    }
    return true
end

local function resolvePendingSpins(state, now)
    local changed = false
    for entityID, pending in pairs(state.pendingSpins) do
        if type(pending) ~= 'table'
                or (SPIN_BY_ANIMATION[pending.animationID] == nil
                        and EXTREME_FIRST_BY_ANIMATION[
                                pending.animationID] == nil)
                or not finite(pending.expiresAt)
        then
            state.pendingSpins[entityID] = nil
            changed = true
        else
            local position, modelID
            if now < pending.expiresAt then
                position, modelID = resolveSword(entityID)
            end
            if position ~= nil then
                state.pendingSpins[entityID] = nil
                local remaining = math.floor(
                        pending.expiresAt - now + 0.5)
                if remaining > 0 then
                    applySpinAnimation(
                            state, entityID, pending.animationID,
                            position, modelID, now, remaining)
                end
                changed = true
            elseif now >= pending.expiresAt then
                state.pendingSpins[entityID] = nil
                diagnostic(state, 'spin_geometry_invalid', now, entityID)
                changed = true
            end
        end
    end
    return changed
end

local function completeExtremeRing(state, entityID, aura, startedAt, now)
    local radius = EXTREME_RING_RADIUS_BY_AURA[aura]
    if radius == nil then
        return false, true
    end
    local position, modelID = resolveSword(entityID)
    if position == nil or modelID ~= EXTREME_SWORD_MODEL_ID then
        if now >= startedAt + SPIN_RESOLVE_TIMEOUT_MS then
            diagnostic(state, 'extreme_ring_entity_invalid', now, entityID)
            return false, true
        end
        return false, false
    end
    local order = state.extremeRingOrders[entityID]
    local first = type(order) == 'table' and order.first or nil
    local ring = {
        aura = aura,
        radius = radius,
        pos = position,
        first = first,
        second = first == 'donut' and 'circle'
                or first == 'circle' and 'donut' or nil,
        stage = 1,
        hits = 0,
        startedAt = startedAt,
        expiresAt = startedAt + EXTREME_RING_PREVIEW_MS,
    }
    state.extremeRings[entityID] = ring
    state.pendingExtremeRings[entityID] = nil
    if first == nil then
        return true, true
    end
    local remaining = math.floor(
            ring.expiresAt - now + 0.5)
    if remaining <= 0 then
        diagnostic(state, 'extreme_ring_entity_invalid', now, entityID)
        return false, true
    end
    return drawExtremeRing(
            state, entityID, ring, first, remaining, now), true
end

local function recordExtremeRingAura(
        state, entityID, newAura, now)
    newAura = tonumber(newAura)
    if EXTREME_RING_RADIUS_BY_AURA[newAura] == nil
            or not finite(entityID) or not finite(now)
    then
        return false
    end
    local current = state.extremeRings[entityID]
    if type(current) == 'table' and current.stage ~= 'done' then
        return false
    end
    local changed, complete = completeExtremeRing(
            state, entityID, newAura, now, now)
    if complete ~= true then
        state.pendingExtremeRings[entityID] = {
            aura = newAura,
            startedAt = now,
        }
    end
    return changed
end

local function resolvePendingExtremeRings(state, now)
    local changed = false
    for entityID, pending in pairs(state.pendingExtremeRings) do
        if type(pending) ~= 'table'
                or not finite(pending.startedAt)
                or EXTREME_RING_RADIUS_BY_AURA[pending.aura] == nil
        then
            state.pendingExtremeRings[entityID] = nil
            changed = true
        else
            local completed, complete = completeExtremeRing(
                    state, entityID, pending.aura,
                    pending.startedAt, now)
            if complete == true then
                state.pendingExtremeRings[entityID] = nil
                changed = completed or changed
            end
        end
    end
    return changed
end

local function handleExtremeRingCast(state, entityID, actionID, now)
    local isSpin = EXTREME_RING_SPIN_AIDS[actionID] == true
    local isFlip = EXTREME_RING_FLIP_AIDS[actionID] == true
    if not isSpin and not isFlip then
        return false
    end
    local ring = state.extremeRings[entityID]
    if type(ring) ~= 'table' or ring.stage == 'done' then
        return false
    end
    if isFlip then
        if ring.stage == 1 and ring.second ~= nil then
            ring.stage = 2
            return drawExtremeRing(
                    state, entityID, ring, ring.second,
                    EXTREME_RING_SECOND_MS, now)
        end
        return false
    end
    ring.hits = (tonumber(ring.hits) or 0) + 1
    if ring.hits >= 2 then
        deleteExtremeRing(state, entityID)
        ring.stage = 'done'
        return true
    end
    local first = EXTREME_RING_DONUT_AIDS[actionID]
            and 'donut' or 'circle'
    ring.first = first
    ring.second = first == 'donut' and 'circle' or 'donut'
    ring.stage = 2
    return drawExtremeRing(
            state, entityID, ring, ring.second,
            EXTREME_RING_SECOND_MS, now)
end

local function sweepKey(aoeInfo)
    return tostring(aoeInfo.entityID) .. ':'
            .. tostring(aoeInfo.aoeID) .. ':'
            .. tostring(math.floor((tonumber(aoeInfo.startTime) or 0) + 0.5))
end

local function handleSweepAOE(state, aoeInfo, now)
    if type(aoeInfo) ~= 'table'
            or tonumber(aoeInfo.aoeCastType) ~= 10
    then
        return false
    end
    local aoeType = tonumber(aoeInfo.aoeType)
    local length = tonumber(aoeInfo.aoeLength)
    local heading = tonumber(aoeInfo.heading)
    local delaySeconds = tonumber(aoeInfo.delay) or 0
    local durationSeconds = tonumber(aoeInfo.duration)
    local position = reliablePosition({
        x = tonumber(aoeInfo.x),
        y = tonumber(aoeInfo.y),
        z = tonumber(aoeInfo.z),
    }, false)
    if not finite(aoeType) or aoeType < 750 or aoeType > 755
            or tonumber(aoeInfo.contentID) ~= 14821
            or not finite(length) or length <= 5 or length > 30
            or not finite(heading) or position == nil
            or not finite(durationSeconds) or durationSeconds <= 0
            or delaySeconds < 0 or delaySeconds > 10
            or not finite(now)
    then
        diagnostic(state, 'sweep_geometry_invalid', now, aoeType)
        return false
    end
    local key = sweepKey(aoeInfo)
    if state.sweepSeen[key] ~= nil then
        return false
    end
    local drawer = Common.getMoogleDrawer()
    if type(drawer) ~= 'table'
            or type(drawer.addTimedDonutCone) ~= 'function'
    then
        diagnostic(state, 'danger_drawer_unavailable', now, aoeType)
        return false
    end
    local hitMs = math.floor(
            (delaySeconds + durationSeconds) * 1000 + 0.5) - 1200
    if hitMs <= 0 or hitMs > 15000 then
        diagnostic(state, 'sweep_geometry_invalid', now, hitMs)
        return false
    end
    local inner = length - 5
    local created = {}
    local token = drawer:addTimedDonutCone(
            hitMs,
            position.x, position.y, position.z,
            inner, length, SWEEP_ANGLE, heading, 0)
    if type(token) ~= 'string' then
        diagnostic(state, 'danger_drawer_rejected_shape', now, aoeType)
        return false
    end
    created[#created + 1] = {
        token = token, expiresAt = now + hitMs,
    }
    local step = SWEEP_TYPE_STEP[aoeType]
    if step ~= nil then
        local nextToken = drawer:addTimedDonutCone(
                SWEEP_NEXT_PREVIEW_MS,
                position.x, position.y, position.z,
                inner, length, SWEEP_ANGLE,
                heading + step, 0)
        if type(nextToken) ~= 'string' then
            Common.deleteTimedShape(token)
            diagnostic(state, 'danger_drawer_rejected_shape', now, aoeType)
            return false
        end
        created[#created + 1] = {
            token = nextToken,
            expiresAt = now + SWEEP_NEXT_PREVIEW_MS,
        }
    end
    for _, active in ipairs(created) do
        state.active[#state.active + 1] = active
    end
    state.sweepSeen[key] = now
    state.lastDiagnostic = nil
    return true
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
    local expectedCount = actionID == LEAP_FIRST_AID and LEAP_COUNT
            or actionID == EXTREME_LEAP_FIRST_AID and 5 or nil
    local isNext = actionID == LEAP_NEXT_AID
            or actionID == EXTREME_LEAP_NEXT_AID
    if expectedCount == nil and not isNext then
        return false
    end
    if not finite(entityID) or entityID <= 0 or not finite(now) then
        diagnostic(state, 'leap_geometry_invalid', now, actionID)
        return false
    end
    local position = reliablePosition(castPos, false)
    if position == nil then
        diagnostic(state, 'leap_geometry_invalid', now, actionID)
        return false
    end
    if expectedCount ~= nil then
        state.leapPositions = {}
        state.leapSourceID = entityID
        state.leapStartedAt = now
        state.leapExpectedCount = expectedCount
        state.guide = nil
    elseif state.leapSourceID ~= entityID then
        diagnostic(state, 'leap_source_mismatch', now, {
            expected = state.leapSourceID,
            actual = entityID,
        })
        state.leapPositions = {}
        state.leapSourceID = nil
        state.leapStartedAt = nil
        state.leapExpectedCount = nil
        return false
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
    if not finite(entityID) or entityID <= 0 or not finite(now)
            or state.leapSourceID ~= entityID
    then
        diagnostic(state, 'leap_source_mismatch', now, {
            expected = state.leapSourceID,
            actual = entityID,
        })
        state.leapPositions = {}
        state.leapSourceID = nil
        state.leapStartedAt = nil
        state.leapExpectedCount = nil
        return false
    end
    local expectedCount = tonumber(state.leapExpectedCount)
    if expectedCount ~= LEAP_COUNT and expectedCount ~= 5 then
        expectedCount = LEAP_COUNT
    end
    if #state.leapPositions ~= expectedCount then
        diagnostic(
                state, 'leap_count_invalid', now, #state.leapPositions)
        state.leapPositions = {}
        state.leapSourceID = nil
        state.leapStartedAt = nil
        state.leapExpectedCount = nil
        return false
    end
    local points = {}
    for _, position in ipairs(state.leapPositions) do
        local point = inwardPoint(position)
        if point == nil then
            diagnostic(state, 'leap_geometry_invalid', now)
            state.leapPositions = {}
            state.leapSourceID = nil
            state.leapStartedAt = nil
            state.leapExpectedCount = nil
            return false
        end
        points[#points + 1] = point
    end
    state.guide = {
        startedAt = now,
        expiresAt = now + LEAP_FIRST_GUIDE_MS
                + (expectedCount - 1) * LEAP_GUIDE_INTERVAL_MS,
        points = points,
    }
    state.leapPositions = {}
    state.leapSourceID = nil
    state.leapStartedAt = nil
    state.leapExpectedCount = nil
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
    for entityID, order in pairs(state.extremeRingOrders) do
        if type(order) ~= 'table'
                or not finite(order.recordedAt)
                or now - order.recordedAt > ROUND_TTL_MS
        then
            state.extremeRingOrders[entityID] = nil
        end
    end
    for entityID, ring in pairs(state.extremeRings) do
        if type(ring) ~= 'table'
                or not finite(ring.expiresAt)
                or now >= ring.expiresAt
        then
            if type(ring) == 'table' then
                Common.deleteTimedShape(ring.token)
            end
            if type(ring) == 'table' and ring.first == nil then
                diagnostic(state, 'extreme_ring_order_missing', now, entityID)
            end
            state.extremeRings[entityID] = nil
        end
    end
    for key, seenAt in pairs(state.sweepSeen) do
        if not finite(seenAt) or now - seenAt > ROUND_TTL_MS then
            state.sweepSeen[key] = nil
        end
    end
    if finite(state.leapStartedAt)
            and now - state.leapStartedAt > ROUND_TTL_MS
    then
        state.leapPositions = {}
        state.leapSourceID = nil
        state.leapStartedAt = nil
        state.leapExpectedCount = nil
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

Feature.OnEntityAdd = function(entityID, entityName, contentID, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state ~= nil and cfg ~= nil and cfg.Enable == true then
        return recordSwordEntity(state, entityID, contentID, now)
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

Feature.OnAuraChange = function(entityID, _, newActiveAura1, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state ~= nil and cfg ~= nil and cfg.Enable == true then
        return recordExtremeRingAura(
                state, entityID, newActiveAura1, now)
    end
    return false
end

Feature.OnAOECreate = function(aoeInfo, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state ~= nil and cfg ~= nil and cfg.Enable == true then
        return handleSweepAOE(state, aoeInfo, now)
    end
    return false
end

Feature.OnEntityCast = function(entityID, actionID, castPos, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state ~= nil and cfg ~= nil and cfg.Enable == true then
        if handleExtremeRingCast(state, entityID, actionID, now) then
            return true
        end
        if actionID == SWORD_DONUT_SMALL_AID
                or actionID == SWORD_DONUT_LARGE_AID
                or actionID == SWORD_CIRCLE_AID
        then
            state.pendingSpins[entityID] = nil
            return deleteSpinPreview(state, entityID)
        end
        return recordLeap(state, entityID, actionID, castPos, now)
    end
    return false
end

Feature.OnEntityChannel = function(entityID, actionID, now)
    if actionID ~= SWORD_BURST_AID
            and actionID ~= EXTREME_SWORD_BURST_AID
    then
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
        resolvePendingSpins(state, now)
        resolvePendingExtremeRings(state, now)
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
    SwordContentID = SWORD_CONTENT_ID,
    SwordModelID = SWORD_MODEL_ID,
    ExtremeSwordModelID = EXTREME_SWORD_MODEL_ID,
    SpinOuterRadius = SPIN_OUTER_RADIUS,
    SpinCircleRadius = SPIN_CIRCLE_RADIUS,
    SpinPreviewMs = SPIN_PREVIEW_MS,
    SpinResolveTimeoutMs = SPIN_RESOLVE_TIMEOUT_MS,
    SpinByAnimation = SPIN_BY_ANIMATION,
    LeapFirstActionID = LEAP_FIRST_AID,
    LeapNextActionID = LEAP_NEXT_AID,
    SwordBurstActionID = SWORD_BURST_AID,
    ExtremeLeapFirstActionID = EXTREME_LEAP_FIRST_AID,
    ExtremeLeapNextActionID = EXTREME_LEAP_NEXT_AID,
    ExtremeSwordBurstActionID = EXTREME_SWORD_BURST_AID,
    ExtremeRingRadiusByAura = EXTREME_RING_RADIUS_BY_AURA,
    ExtremeFirstByAnimation = EXTREME_FIRST_BY_ANIMATION,
    SweepTypeStep = SWEEP_TYPE_STEP,
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
    RecordSwordEntity = recordSwordEntity,
    RecordSpinAnimation = recordSpinAnimation,
    ResolvePendingSpins = resolvePendingSpins,
    RecordExtremeRingAura = recordExtremeRingAura,
    ResolvePendingExtremeRings = resolvePendingExtremeRings,
    HandleExtremeRingCast = handleExtremeRingCast,
    HandleSweepAOE = handleSweepAOE,
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
