local Module = {}

function Module.Create(Context)
    assert(type(Context) == 'table' and type(Context.Common) == 'table')
    local Common = Context.Common
    local finite = Context.finite
    local reliablePosition = Context.reliablePosition

local BOSS_CONTENT_ID = 14503
local BOSS_MODEL_ID = 19429
local EXTREME_BOSS_MODEL_ID = 19431
local HEAD_CONTENT_ID = 14504
local HEAD_MODEL_ID = 19430
local EXTREME_HEAD_MODEL_ID = 19432
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
local ENTITY_RESOLVE_MS = 1000
local FERTILE_GROUND_AID = 47514
local FERTILE_GROUND_HEAD_AURA_BLUE = 2911
local FERTILE_GROUND_HEAD_AURA_PINK = 2912
local FERTILE_GROUND_FIRST_FIRE_MS = 13200
local FERTILE_GROUND_CADENCE_MS = 6000
local FERTILE_GROUND_LEAD_MS = 4500
local FERTILE_GROUND_LIFETIME_MS = 600
local FERTILE_GROUND_HEAD_MIN_DISTANCE = 5
local FERTILE_GROUND_HEAD_MAX_DISTANCE = 50
local FERTILE_GROUND_HALF_ANGLE = math.pi
local FERTILE_GROUND_RADIUS = 30
local FERTILE_ELEMENT_DURATION_MS = 5000
local FERTILE_ELEMENT_AURAS = {
    [2908] = 'fire',
    [2909] = 'ice',
    [2910] = 'thunder',
}
local BLUE_BUFF_ID = 5136
local PINK_BUFF_ID = 5137
local BLACKLIST_SOURCE = 'MuAiCore - 惧死者黑暗奔流扩散预测'

local DEFAULTS = {
    Enable = true,
}

local function newState()
    return {
        active = {},
        seen = {},
        fertileGround = nil,
        pendingFertileGround = nil,
        pendingFertileElements = {},
        pendingVolleys = {},
        volleyHeads = {},
        volleys = {},
        nextVolleyIndex = 0,
        fertileFirstAuraAt = nil,
        fertileElementSeen = {},
        blacklist = { owned = nil, registered = false },
        lastDiagnostic = nil,
    }
end

local function ensureState(state)
    state = type(state) == 'table' and state or newState()
    state.active = type(state.active) == 'table' and state.active or {}
    state.seen = type(state.seen) == 'table' and state.seen or {}
    state.pendingVolleys = type(state.pendingVolleys) == 'table'
            and state.pendingVolleys or {}
    state.pendingFertileElements = type(state.pendingFertileElements) == 'table'
            and state.pendingFertileElements or {}
    state.volleyHeads = type(state.volleyHeads) == 'table'
            and state.volleyHeads or {}
    state.volleys = type(state.volleys) == 'table' and state.volleys or {}
    state.nextVolleyIndex = tonumber(state.nextVolleyIndex) or 0
    state.fertileElementSeen = type(state.fertileElementSeen) == 'table'
            and state.fertileElementSeen or {}
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
        fertile_ground_entity_mismatch = '惧死者极塔沃土实体身份不匹配',
        fertile_ground_geometry_missing = '惧死者极塔沃土缺少可靠几何',
        fertile_ground_player_state_missing = '惧死者极塔沃土缺少唯一元素状态',
        fertile_ground_element_invalid = '惧死者极塔沃土元素范围身份或几何无效',
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
    state.fertileGround = nil
    state.pendingFertileGround = nil
    state.pendingFertileElements = {}
    state.pendingVolleys = {}
    state.volleyHeads = {}
    state.volleys = {}
    state.nextVolleyIndex = 0
    state.fertileFirstAuraAt = nil
    state.fertileElementSeen = {}
    state.lastDiagnostic = nil
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
    return type(entities) == 'table' and entities or nil
end

local function resolveEntity(entityID, contentID, modelID, requireHeading)
    local entities = entitiesByContent(contentID)
    if entities == nil then
        return nil
    end
    for _, entity in pairs(entities) do
        if type(entity) == 'table'
                and tonumber(entity.id) == entityID
                and tonumber(entity.contentid) == contentID
                and Common.entityModelID(entity) == modelID
                and entity.alive ~= false
        then
            local position = reliablePosition(entity.pos, requireHeading)
            if position ~= nil then
                return { entityID = entityID, position = position }
            end
        end
    end
    return nil
end

local function squaredDistance(left, right)
    local dx = left.x - right.x
    local dz = left.z - right.z
    return dx * dx + dz * dz
end

local function playerSafeHeading(center, head, variant)
    local tensorCore = rawget(_G, 'TensorCore')
    if type(tensorCore) ~= 'table'
            or type(tensorCore.mGetPlayer) ~= 'function'
            or type(tensorCore.hasBuff) ~= 'function'
    then
        return nil
    end
    local player = tensorCore.mGetPlayer()
    if type(player) ~= 'table' or not finite(tonumber(player.id)) then
        return nil
    end
    local hasBlue = tensorCore.hasBuff(player.id, BLUE_BUFF_ID) == true
    local hasPink = tensorCore.hasBuff(player.id, PINK_BUFF_ID) == true
    if hasBlue == hasPink then
        return nil
    end
    local towardCenter = math.atan2(center.x - head.x, center.z - head.z)
    local blueHeading = towardCenter + math.pi / 2
    local pinkHeading = towardCenter - math.pi / 2
    if variant == FERTILE_GROUND_HEAD_AURA_PINK then
        blueHeading, pinkHeading = pinkHeading, blueHeading
    end
    return hasPink and blueHeading or pinkHeading
end

local function drawFertileGroundVolley(state, volley, now)
    local safeHeading = playerSafeHeading(
            volley.center, volley.head, volley.variant)
    if safeHeading == nil then
        diagnostic(state, 'fertile_ground_player_state_missing', now)
        return false
    end
    local drawer = Common.getMoogleDrawer()
    if drawer == nil
            or type(drawer.addTimedCone) ~= 'function'
    then
        diagnostic(state, 'danger_drawer_unavailable', now)
        return false
    end
    local delay = math.max(0, volley.fireAt - now - FERTILE_GROUND_LEAD_MS)
    local duration = volley.fireAt - now - delay + FERTILE_GROUND_LIFETIME_MS
    if duration <= 0 then
        return false
    end
    local dangerHeading = safeHeading + math.pi
    local danger = drawer:addTimedCone(
            duration,
            volley.center.x, volley.center.y, volley.center.z,
            FERTILE_GROUND_RADIUS, FERTILE_GROUND_HALF_ANGLE,
            dangerHeading, delay)
    if type(danger) ~= 'string' then
        diagnostic(state, 'danger_drawer_rejected_shape', now)
        return false
    end
    state.active[#state.active + 1] = {
        token = danger, expiresAt = now + delay + duration,
    }
    return true
end

local function acceptFertileGround(state, entityID, startedAt, now)
    local boss = resolveEntity(
            entityID, BOSS_CONTENT_ID, EXTREME_BOSS_MODEL_ID, false)
    if boss == nil then
        return false, now - startedAt >= ENTITY_RESOLVE_MS
    end
    state.fertileGround = { center = boss.position, startedAt = startedAt }
    state.pendingFertileGround = nil
    return true, true
end

local function acceptVolley(
        state, entityID, variant, observedAt, volleyIndex, now)
    local fertileGround = state.fertileGround
    if type(fertileGround) ~= 'table'
            or not finite(fertileGround.startedAt)
            or now - fertileGround.startedAt > 30000
    then
        local pending = state.pendingFertileGround
        return false, type(pending) ~= 'table'
                or now - observedAt >= ENTITY_RESOLVE_MS
    end
    if not finite(state.fertileFirstAuraAt)
            or not finite(volleyIndex)
            or volleyIndex < 1
    then
        return false, true
    end
    local head = resolveEntity(
            entityID, HEAD_CONTENT_ID, EXTREME_HEAD_MODEL_ID, false)
    if head == nil then
        return false, now - observedAt >= ENTITY_RESOLVE_MS
    end
    local distanceSquared = squaredDistance(head.position, fertileGround.center)
    if distanceSquared < FERTILE_GROUND_HEAD_MIN_DISTANCE
            * FERTILE_GROUND_HEAD_MIN_DISTANCE
            or distanceSquared > FERTILE_GROUND_HEAD_MAX_DISTANCE
                    * FERTILE_GROUND_HEAD_MAX_DISTANCE
    then
        return false, true
    end
    if state.volleyHeads[entityID] == true then
        return false, true
    end
    local volley = {
        center = fertileGround.center,
        head = head.position,
        variant = variant,
        fireAt = state.fertileFirstAuraAt + FERTILE_GROUND_FIRST_FIRE_MS
                + (volleyIndex - 1) * FERTILE_GROUND_CADENCE_MS,
    }
    state.volleyHeads[entityID] = true
    state.volleys[volleyIndex] = volley
    return true, true
end

local function handleExtremeChannel(state, entityID, spellID, now)
    if tonumber(spellID) ~= FERTILE_GROUND_AID
            or not finite(entityID) or not finite(now)
    then
        return false
    end
    state.fertileGround = nil
    state.pendingFertileElements = {}
    state.pendingVolleys = {}
    state.volleyHeads = {}
    state.volleys = {}
    state.nextVolleyIndex = 0
    state.fertileFirstAuraAt = nil
    state.fertileElementSeen = {}
    local changed, complete = acceptFertileGround(state, entityID, now, now)
    if complete ~= true then
        state.pendingFertileGround = { entityID = entityID, startedAt = now }
    elseif changed ~= true then
        diagnostic(state, 'fertile_ground_entity_mismatch', now, entityID)
    end
    return changed
end

local function drawFertileElement(state, entityID, aura, now, resolvedBoss)
    local kind = FERTILE_ELEMENT_AURAS[tonumber(aura)]
    if kind == nil or not finite(entityID) or not finite(now) then
        return false
    end
    local fertileGround = state.fertileGround
    if type(fertileGround) ~= 'table'
            or not finite(fertileGround.startedAt)
            or now - fertileGround.startedAt < 0
            or now - fertileGround.startedAt > 30000
    then
        diagnostic(state, 'fertile_ground_geometry_missing', now, entityID)
        return false
    end
    local boss = resolvedBoss or resolveEntity(
            entityID, BOSS_CONTENT_ID, EXTREME_BOSS_MODEL_ID, false)
    if boss == nil then
        diagnostic(state, 'fertile_ground_element_invalid', now, entityID)
        return false
    end
    local key = tostring(entityID) .. ':' .. tostring(aura)
            .. ':' .. tostring(math.floor(fertileGround.startedAt + 0.5))
    if state.fertileElementSeen[key] ~= nil then
        return false
    end
    local drawer = Common.getMoogleDrawer()
    local created = {}
    local function add(token)
        if type(token) ~= 'string' then
            for _, active in ipairs(created) do
                Common.deleteTimedShape(active.token)
            end
            diagnostic(state, 'danger_drawer_rejected_shape', now, aura)
            return false
        end
        created[#created + 1] = {
            token = token,
            expiresAt = now + FERTILE_ELEMENT_DURATION_MS,
        }
        return true
    end
    local pos = boss.position
    if kind == 'fire' then
        if type(drawer) ~= 'table'
                or type(drawer.addTimedCircle) ~= 'function'
                or not add(drawer:addTimedCircle(
                        FERTILE_ELEMENT_DURATION_MS,
                        pos.x, pos.y, pos.z, 18, 0))
        then
            diagnostic(state, 'danger_drawer_unavailable', now, aura)
            return false
        end
    elseif kind == 'ice' then
        if type(drawer) ~= 'table'
                or type(drawer.addTimedCenteredRect) ~= 'function'
        then
            diagnostic(state, 'danger_drawer_unavailable', now, aura)
            return false
        end
        for _, heading in ipairs({ 0, math.pi / 2 }) do
            if not add(drawer:addTimedCenteredRect(
                    FERTILE_ELEMENT_DURATION_MS,
                    pos.x, pos.y, pos.z, 90, 15, heading, 0))
            then
                return false
            end
        end
    else
        if type(drawer) ~= 'table'
                or type(drawer.addTimedCone) ~= 'function'
        then
            diagnostic(state, 'danger_drawer_unavailable', now, aura)
            return false
        end
        for _, heading in ipairs({
            math.pi / 4, -math.pi / 4,
            3 * math.pi / 4, -3 * math.pi / 4,
        }) do
            if not add(drawer:addTimedCone(
                    FERTILE_ELEMENT_DURATION_MS,
                    pos.x, pos.y, pos.z,
                    60, math.rad(45), heading, 0))
            then
                return false
            end
        end
    end
    for _, active in ipairs(created) do
        state.active[#state.active + 1] = active
    end
    state.fertileElementSeen[key] = now
    state.lastDiagnostic = nil
    return true
end

local function fertileElementKey(state, entityID, aura)
    local fertileGround = state.fertileGround
    local startedAt = type(fertileGround) == 'table'
            and tonumber(fertileGround.startedAt) or nil
    if not finite(startedAt) then
        local pending = state.pendingFertileGround
        startedAt = type(pending) == 'table'
                and tonumber(pending.startedAt) or nil
    end
    if not finite(startedAt) then
        return nil
    end
    return tostring(entityID) .. ':' .. tostring(aura)
            .. ':' .. tostring(math.floor(startedAt + 0.5))
end

local function acceptFertileElement(
        state, entityID, aura, observedAt, now)
    if type(state.fertileGround) ~= 'table' then
        return false, type(state.pendingFertileGround) ~= 'table'
                or now - observedAt >= ENTITY_RESOLVE_MS
    end
    local boss = resolveEntity(
            entityID, BOSS_CONTENT_ID, EXTREME_BOSS_MODEL_ID, false)
    if boss == nil then
        return false, now - observedAt >= ENTITY_RESOLVE_MS
    end
    return drawFertileElement(state, entityID, aura, now, boss), true
end

local function processExtremePending(state, now)
    local pending = state.pendingFertileGround
    if type(pending) == 'table' then
        local _, complete = acceptFertileGround(
                state, pending.entityID, pending.startedAt, now)
        if complete == true then state.pendingFertileGround = nil end
    end
    for key, element in pairs(state.pendingFertileElements) do
        local _, complete = acceptFertileElement(
                state, element.entityID, element.aura,
                element.observedAt, now)
        if complete == true then
            state.pendingFertileElements[key] = nil
            if state.fertileElementSeen[key] == nil
                    and state.lastDiagnostic == nil
            then
                diagnostic(state, 'fertile_ground_element_invalid',
                        now, element.entityID)
            end
        end
    end
    for entityID, volley in pairs(state.pendingVolleys) do
        local _, complete = acceptVolley(
                state, entityID, volley.variant, volley.observedAt,
                volley.index, now)
        if complete == true then state.pendingVolleys[entityID] = nil end
    end
    for _, volley in pairs(state.volleys) do
        if volley.drawn ~= true
                and now <= volley.fireAt
                and volley.fireAt - now <= FERTILE_GROUND_LEAD_MS
                and drawFertileGroundVolley(state, volley, now)
        then
            volley.drawn = true
        end
    end
end

local function handleExtremeAura(state, entityID, newAura, now)
    newAura = tonumber(newAura)
    if FERTILE_ELEMENT_AURAS[newAura] ~= nil then
        if not finite(entityID) or not finite(now) then
            return false
        end
        local key = fertileElementKey(state, entityID, newAura)
        if key == nil then
            diagnostic(state, 'fertile_ground_geometry_missing', now, entityID)
            return false
        end
        if state.fertileElementSeen[key] ~= nil
                or state.pendingFertileElements[key] ~= nil
        then
            return false
        end
        local changed, complete = acceptFertileElement(
                state, entityID, newAura, now, now)
        if complete ~= true then
            state.pendingFertileElements[key] = {
                entityID = entityID,
                aura = newAura,
                observedAt = now,
            }
        elseif changed ~= true
                and state.lastDiagnostic == nil
        then
            diagnostic(state, 'fertile_ground_element_invalid', now, entityID)
        end
        return changed
    end
    if (newAura ~= FERTILE_GROUND_HEAD_AURA_BLUE
            and newAura ~= FERTILE_GROUND_HEAD_AURA_PINK)
            or not finite(entityID) or not finite(now)
    then
        return false
    end
    if state.volleyHeads[entityID] == true
            or state.pendingVolleys[entityID] ~= nil
    then
        return false
    end
    local fertileGround = state.fertileGround
    if type(fertileGround) ~= 'table'
            and type(state.pendingFertileGround) ~= 'table'
    then
        diagnostic(state, 'fertile_ground_geometry_missing', now, entityID)
        return false
    end
    state.nextVolleyIndex = state.nextVolleyIndex + 1
    local volleyIndex = state.nextVolleyIndex
    if not finite(state.fertileFirstAuraAt) then
        state.fertileFirstAuraAt = now
    end
    local changed, complete = acceptVolley(
            state, entityID, newAura, now, volleyIndex, now)
    if complete ~= true then
        state.pendingVolleys[entityID] = {
            variant = newAura, observedAt = now, index = volleyIndex,
        }
    elseif changed ~= true then
        diagnostic(state, 'fertile_ground_entity_mismatch', now, entityID)
    end
    return changed
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
    for key, seenAt in pairs(state.fertileElementSeen) do
        if not finite(seenAt) or now - seenAt > 30000 then
            state.fertileElementSeen[key] = nil
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

Feature.OnEntityChannel = function(entityID, spellID, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state ~= nil and cfg ~= nil and cfg.Enable == true then
        return handleExtremeChannel(state, entityID, spellID, now)
    end
    return false
end

Feature.OnAuraChange = function(entityID, _, newActiveAura1, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state ~= nil and cfg ~= nil and cfg.Enable == true then
        return handleExtremeAura(state, entityID, newActiveAura1, now)
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
        processExtremePending(state, now)
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
    ExtremeBossModelID = EXTREME_BOSS_MODEL_ID,
    HeadContentID = HEAD_CONTENT_ID,
    HeadModelID = HEAD_MODEL_ID,
    ExtremeHeadModelID = EXTREME_HEAD_MODEL_ID,
    InitialActionID = INITIAL_AID,
    FollowupActionID = FOLLOWUP_AID,
    InitialLength = INITIAL_LENGTH,
    InitialWidth = INITIAL_WIDTH,
    StepDistance = STEP_DISTANCE,
    FirstStepOffsetMs = FIRST_STEP_OFFSET_MS,
    StepIntervalMs = STEP_INTERVAL_MS,
    FertileGroundActionID = FERTILE_GROUND_AID,
    FertileGroundBlueAuraID = FERTILE_GROUND_HEAD_AURA_BLUE,
    FertileGroundPinkAuraID = FERTILE_GROUND_HEAD_AURA_PINK,
    FertileGroundFirstFireMs = FERTILE_GROUND_FIRST_FIRE_MS,
    FertileGroundCadenceMs = FERTILE_GROUND_CADENCE_MS,
    FertileElementAuras = FERTILE_ELEMENT_AURAS,
    FertileElementDurationMs = FERTILE_ELEMENT_DURATION_MS,
    NewState = newState,
    EnsureState = ensureState,
    GetConfig = getConfig,
    ApplyBlacklist = applyBlacklist,
    ReadInitial = readInitial,
    HandleAOECreate = handleAOECreate,
    HandleExtremeChannel = handleExtremeChannel,
    HandleExtremeAura = handleExtremeAura,
    DrawFertileElement = drawFertileElement,
    ProcessExtremePending = processExtremePending,
    ClearMechanic = clearMechanic,
}

return Feature
end

rawset(_G, 'MuAiOccultCrescentNorthNecrophobia', Module)
return Module
