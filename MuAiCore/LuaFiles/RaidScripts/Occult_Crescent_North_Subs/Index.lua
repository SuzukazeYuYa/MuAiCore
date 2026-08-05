local Module = {}

function Module.Create(Context)
    assert(type(Context) == 'table' and type(Context.Common) == 'table')
    local Common = Context.Common
    local finite = Context.finite
    local reliablePosition = Context.reliablePosition
    local getPlayer = Context.getPlayer

local ARENA = { x = 0, y = -684, z = -628 }
local ZONE_RADIUS = 30
local ZONE_ANGLE = math.rad(60)
local PREVIEW_MS = 3000
local RESOLVE_GRACE_MS = 1000
local RING_OFFSET_MS = 7000
local BALL_BASE_OFFSET_MS = 7000
local BALL_STEP_RADIANS = math.rad(30)
local BALL_STEP_MS = 1000
local GUIDE_RADIUS = 9
local GUIDE_INSET = math.rad(10)
local BALL_RESOLVE_DEADLINE_MS = BALL_BASE_OFFSET_MS
local STATE_TTL_MS = 30000
local EXTREME_PREDICTION_DURATION_MS = 10400
local EXTREME_PREDICTION_ROTATION = -math.rad(60)
local EXTREME_PREDICTION_LANDING_RADIUS = 15.55
local EXTREME_KNOCKBACK_EARLY_OFFSET_MS = 6100
local EXTREME_KNOCKBACK_WINDOW_MS = 8500
local EXTREME_KNOCKBACK_REANCHOR_GRACE_MS = 250
local EXTREME_KNOCKBACK_DISTANCE = 10
local CLEANSING_DONUT_AID = 48414
local CLEANSING_DONUT_INNER_RADIUS = 5
local MOOGLE_DONUT_SOURCE = 'MuAiCore - 目录天崩地裂月环内径修正'

local ZONE_KIND = {
    [2015240] = 'fire',
    [2015241] = 'ice',
    [2015242] = 'thunder',
}
local RING_KIND = {
    [2015243] = 'fire',
    [2015244] = 'ice',
    [2015245] = 'thunder',
}
local BALL_SPEC = {
    [14723] = { kind = 'ice', modelID = 19300 },
    [14724] = { kind = 'fire', modelID = 19301 },
    [14725] = { kind = 'thunder', modelID = 19302 },
}
local EXTREME_PREDICTION_SPEC = {
    [2890] = { shape = 'donut', inner = 3, outer = 15 },
    [2891] = { shape = 'circle', radius = 10 },
}
local EXTREME_PREDICTION_CONTENT_ID = 14722
local EXTREME_PREDICTION_MODEL_ID = 19299
local EXTREME_KNOCKBACK_CAST_AID = 48404
local EXTREME_KNOCKBACK_CHANNEL_AID = 48405

local DEFAULTS = {
    Enable = true,
    DynamicGuide = true,
}

local function newState()
    return {
        zones = {},
        pendingBalls = {},
        seen = {},
        hazards = {},
        extremeActive = false,
        extremeSeen = {},
        pendingExtremePredictions = {},
        extremeHazards = {},
        extremeKnockback = nil,
        moogleDonuts = {},
        lastDiagnostic = nil,
    }
end

local function ensureState(state)
    state = type(state) == 'table' and state or newState()
    state.zones = type(state.zones) == 'table' and state.zones or {}
    state.pendingBalls = type(state.pendingBalls) == 'table'
            and state.pendingBalls or {}
    state.seen = type(state.seen) == 'table' and state.seen or {}
    state.hazards = type(state.hazards) == 'table'
            and state.hazards or {}
    state.extremeActive = state.extremeActive == true
    state.extremeSeen = type(state.extremeSeen) == 'table'
            and state.extremeSeen or {}
    state.pendingExtremePredictions =
            type(state.pendingExtremePredictions) == 'table'
            and state.pendingExtremePredictions or {}
    state.extremeHazards = type(state.extremeHazards) == 'table'
            and state.extremeHazards or {}
    state.moogleDonuts = type(state.moogleDonuts) == 'table'
            and state.moogleDonuts or {}
    return state
end

local feature = Common.newFeature({
    key = 'Index',
    defaults = DEFAULTS,
    newState = newState,
    ensureState = ensureState,
    diagnosticThrottleMs = 1000,
    diagnosticText = {
        ground_effect_invalid = '目录元素地面物件信号无效',
        zone_missing = '目录元素危险区缺少对应区域朝向',
        ball_geometry_invalid = '目录元素球实体或位置不可用',
        ball_pair_invalid = '目录元素球未形成中心对称的一组',
        danger_drawer_unavailable = '目录元素危险区绘图器不可用',
        danger_drawer_rejected_shape = '目录元素危险区绘制失败',
        extreme_prediction_entity_invalid = '目录极限预言现象实体或位置不可用',
        extreme_prediction_drawer_unavailable = '目录极限预言现象绘图器不可用',
        extreme_prediction_drawer_rejected_shape = '目录极限预言现象绘制失败',
        extreme_knockback_source_invalid = '目录极限推进冲击波来源不可用',
    },
})
local getConfig = feature.GetConfig

local moogleDonutRegistry = Common.newMoogleDonutRegistry({
    entries = {
        [CLEANSING_DONUT_AID] = {
            name = '目录天崩地裂',
            radius = CLEANSING_DONUT_INNER_RADIUS,
        },
    },
    source = MOOGLE_DONUT_SOURCE,
    ensureState = ensureState,
    getBucket = function(state)
        return state.moogleDonuts
    end,
})
local applyMoogleDonuts = moogleDonutRegistry.Apply

local function getState()
    return Common.getRuntimeState('Index', newState, ensureState)
end

local function diagnostic(state, code, now, context)
    feature.Diagnostic(
            state, rawget(_G, 'MuAiGuide'), code, now, context)
end

local function wrapPi(value)
    return (value + math.pi) % (2 * math.pi) - math.pi
end

local function clearMechanic(state)
    state = ensureState(state)
    for _, hazard in ipairs(state.hazards) do
        for _, token in ipairs(hazard.tokens or {}) do
            Common.deleteTimedShape(token)
        end
    end
    for _, hazard in ipairs(state.extremeHazards) do
        Common.deleteTimedShape(hazard.token)
    end
    state.zones = {}
    state.pendingBalls = {}
    state.seen = {}
    state.hazards = {}
    state.extremeActive = false
    state.extremeSeen = {}
    state.pendingExtremePredictions = {}
    state.extremeHazards = {}
    state.extremeKnockback = nil
    state.lastDiagnostic = nil
end

local function activateExtreme(state)
    if state.extremeActive == true then
        return
    end
    for _, hazard in ipairs(state.hazards) do
        for _, token in ipairs(hazard.tokens or {}) do
            Common.deleteTimedShape(token)
        end
    end
    state.zones = {}
    state.pendingBalls = {}
    state.seen = {}
    state.hazards = {}
    state.extremeActive = true
end

local function resolveStrictEntity(entityID, contentID, modelID)
    if not finite(entityID) then
        return nil, nil
    end
    local tensorCore = rawget(_G, 'TensorCore')
    if type(tensorCore) ~= 'table'
            or type(tensorCore.entityList) ~= 'function'
    then
        return nil, nil
    end
    local entities = tensorCore.entityList(
            'contentid=' .. tostring(contentID))
    if type(entities) ~= 'table' then
        return nil, nil
    end
    local argus = rawget(_G, 'Argus')
    for _, entity in pairs(entities) do
        if type(entity) == 'table' then
            local liveModelID = type(argus) == 'table'
                    and type(argus.getEntityModel) == 'function'
                    and tonumber(argus.getEntityModel(entityID)) or nil
            if not finite(liveModelID) then
                liveModelID = tonumber(entity.modelid)
            end
            if tonumber(entity.id) == entityID
                    and tonumber(entity.contentid) == contentID
                    and liveModelID == modelID
                    and entity.alive ~= false
            then
                return entity, reliablePosition(entity.pos, false)
            end
        end
    end
    return nil, nil
end

local function validExtremePosition(position, minRadius, maxRadius)
    if position == nil or math.abs(position.y - ARENA.y) > 2 then
        return false
    end
    local dx = position.x - ARENA.x
    local dz = position.z - ARENA.z
    local radius = math.sqrt(dx * dx + dz * dz)
    return radius >= minRadius and radius <= maxRadius
end

local function predictionLanding(position)
    if not validExtremePosition(position, 8, 10) then
        return nil
    end
    local spawnHeading = math.atan2(
            position.x - ARENA.x, position.z - ARENA.z)
    local landingHeading = spawnHeading + EXTREME_PREDICTION_ROTATION
    return {
        x = ARENA.x + EXTREME_PREDICTION_LANDING_RADIUS
                * math.sin(landingHeading),
        y = ARENA.y,
        z = ARENA.z + EXTREME_PREDICTION_LANDING_RADIUS
                * math.cos(landingHeading),
    }
end

local function completeExtremePrediction(state, entityID, now)
    local pending = state.pendingExtremePredictions[entityID]
    if type(pending) ~= 'table' then
        return false
    end
    local _, position = resolveStrictEntity(
            entityID,
            EXTREME_PREDICTION_CONTENT_ID,
            EXTREME_PREDICTION_MODEL_ID)
    local landing = predictionLanding(position)
    if landing == nil then
        if now < pending.startedAt + EXTREME_PREDICTION_DURATION_MS then
            return false
        end
        state.pendingExtremePredictions[entityID] = nil
        diagnostic(state, 'extreme_prediction_entity_invalid', now, entityID)
        return false
    end
    local spec = EXTREME_PREDICTION_SPEC[pending.aura]
    local drawer = Common.getMoogleDrawer()
    local method = spec ~= nil and spec.shape == 'circle'
            and 'addTimedCircle' or 'addTimedDonut'
    if spec == nil or drawer == nil or type(drawer[method]) ~= 'function' then
        state.pendingExtremePredictions[entityID] = nil
        diagnostic(state, 'extreme_prediction_drawer_unavailable', now,
                pending.aura)
        return false
    end
    local expiresAt = pending.startedAt + EXTREME_PREDICTION_DURATION_MS
    local remaining = expiresAt - now
    if remaining <= 0 then
        state.pendingExtremePredictions[entityID] = nil
        diagnostic(state, 'extreme_prediction_entity_invalid', now, entityID)
        return false
    end
    local token
    if spec.shape == 'circle' then
        token = drawer:addTimedCircle(
                math.floor(remaining + 0.5),
                landing.x, landing.y, landing.z, spec.radius)
    else
        token = drawer:addTimedDonut(
                math.floor(remaining + 0.5),
                landing.x, landing.y, landing.z,
                spec.inner, spec.outer)
    end
    state.pendingExtremePredictions[entityID] = nil
    if type(token) ~= 'string' then
        diagnostic(state, 'extreme_prediction_drawer_rejected_shape', now,
                pending.aura)
        return false
    end
    state.extremeHazards[#state.extremeHazards + 1] = {
        token = token,
        entityID = entityID,
        aura = pending.aura,
        landing = landing,
        expiresAt = expiresAt,
    }
    activateExtreme(state)
    state.lastDiagnostic = nil
    return true
end

local function recordExtremeAura(state, entityID, aura, now)
    if EXTREME_PREDICTION_SPEC[aura] == nil
            or not finite(entityID)
            or not finite(now)
    then
        return false
    end
    local eventKey = tostring(entityID) .. ':' .. tostring(aura)
    if state.extremeSeen[eventKey] ~= nil then
        return false
    end
    state.extremeSeen[eventKey] = now
    state.pendingExtremePredictions[entityID] = {
        aura = aura,
        startedAt = now,
    }
    return completeExtremePrediction(state, entityID, now)
end

local function recordExtremeCast(
        state, entityID, actionID, castPosition, now)
    if actionID ~= EXTREME_KNOCKBACK_CAST_AID
            or not finite(entityID)
            or not finite(now)
    then
        return false
    end
    local position = reliablePosition(castPosition, false)
    if not validExtremePosition(position, 14, 17) then
        diagnostic(state, 'extreme_knockback_source_invalid', now, entityID)
        return false
    end
    local knockback = state.extremeKnockback
    if type(knockback) ~= 'table'
            or now > knockback.expiresAt
            or now - knockback.startedAt > 2500
    then
        knockback = {
            startedAt = now,
            hitAt = now + EXTREME_KNOCKBACK_EARLY_OFFSET_MS,
            expiresAt = now + EXTREME_KNOCKBACK_WINDOW_MS,
            sourceIDs = {},
            sources = {},
        }
        state.extremeKnockback = knockback
    end
    if knockback.sourceIDs[entityID] then
        return false
    end
    knockback.sourceIDs[entityID] = true
    knockback.sources[#knockback.sources + 1] = {
        entityID = entityID,
        x = position.x,
        y = position.y,
        z = position.z,
    }
    activateExtreme(state)
    state.lastDiagnostic = nil
    return true
end

local function recordExtremeChannel(
        state, entityID, actionID, channelTimeMax, now)
    if actionID ~= EXTREME_KNOCKBACK_CHANNEL_AID
            or not finite(entityID)
            or not finite(channelTimeMax)
            or channelTimeMax <= 0
            or channelTimeMax > 10
            or not finite(now)
    then
        return false
    end
    local knockback = state.extremeKnockback
    if type(knockback) ~= 'table'
            or now > knockback.expiresAt
            or finite(knockback.reanchoredAt)
    then
        return false
    end
    knockback.hitAt = now + math.floor(channelTimeMax * 1000)
            + EXTREME_KNOCKBACK_REANCHOR_GRACE_MS
    knockback.expiresAt = knockback.hitAt + 1200
    knockback.reanchoredAt = now
    activateExtreme(state)
    state.lastDiagnostic = nil
    return true
end

local function drawExtremeKnockbackGuide(state, guide, now)
    local knockback = state.extremeKnockback
    if type(knockback) ~= 'table'
            or not finite(knockback.hitAt)
            or now > knockback.hitAt + 300
            or type(knockback.sources) ~= 'table'
            or #knockback.sources == 0
            or type(guide) ~= 'table'
            or type(guide.FrameDirect) ~= 'function'
    then
        return false
    end
    local player = getPlayer(guide)
    local position = type(player) == 'table'
            and reliablePosition(player.pos, false) or nil
    if not validExtremePosition(position, 0, 30) then
        return false
    end
    local nearest = nil
    local nearestDistance = nil
    for _, source in ipairs(knockback.sources) do
        local dx = position.x - source.x
        local dz = position.z - source.z
        local distance = dx * dx + dz * dz
        if nearestDistance == nil or distance < nearestDistance then
            nearest = source
            nearestDistance = distance
        end
    end
    if nearest == nil or nearestDistance <= 0.04 then
        return false
    end
    local length = math.sqrt(nearestDistance)
    local target = {
        x = position.x + (position.x - nearest.x) / length
                * EXTREME_KNOCKBACK_DISTANCE,
        z = position.z + (position.z - nearest.z) / length
                * EXTREME_KNOCKBACK_DISTANCE,
    }
    local targetDx = target.x - ARENA.x
    local targetDz = target.z - ARENA.z
    if targetDx * targetDx + targetDz * targetDz > ZONE_RADIUS * ZONE_RADIUS then
        return false
    end
    local color = type(guide.Config) == 'table'
            and type(guide.Config.Main) == 'table'
            and guide.Config.Main.GuideColor
            or { r = 0, g = 1, b = 1, a = 0.5 }
    guide.FrameDirect(target.x, target.z, 0.7, color)
    return true
end

local function validArenaPosition(position)
    if position == nil then
        return false
    end
    local dx = position.x - ARENA.x
    local dz = position.z - ARENA.z
    return dx * dx + dz * dz <= 1
end

local function drawHazard(state, kind, activationAt, now, source)
    local heading = state.zones[kind]
    if not finite(heading) then
        diagnostic(state, 'zone_missing', now, kind)
        return false
    end
    if not finite(activationAt) or activationAt <= now then
        return false
    end
    local drawer = Common.getMoogleDrawer()
    if drawer == nil or type(drawer.addTimedCone) ~= 'function' then
        diagnostic(state, 'danger_drawer_unavailable', now, kind)
        return false
    end
    local remaining = activationAt - now
    local delay = math.max(0, remaining - PREVIEW_MS)
    local duration = math.min(PREVIEW_MS, remaining)
            + RESOLVE_GRACE_MS
    local tokens = {}
    for _, offset in ipairs({ 0, math.pi }) do
        local token = drawer:addTimedCone(
                math.floor(duration + 0.5),
                ARENA.x, ARENA.y, ARENA.z,
                ZONE_RADIUS, ZONE_ANGLE,
                wrapPi(heading + offset),
                math.floor(delay + 0.5))
        if type(token) ~= 'string' then
            for _, rollback in ipairs(tokens) do
                Common.deleteTimedShape(rollback)
            end
            diagnostic(state, 'danger_drawer_rejected_shape', now, kind)
            return false
        end
        tokens[#tokens + 1] = token
    end
    state.hazards[#state.hazards + 1] = {
        kind = kind,
        source = source,
        heading = wrapPi(heading),
        previewAt = activationAt - PREVIEW_MS,
        activationAt = activationAt,
        expiresAt = activationAt + RESOLVE_GRACE_MS,
        tokens = tokens,
    }
    state.lastDiagnostic = nil
    return true
end

local function recordGroundEffect(state, args, now)
    if state.extremeActive == true then
        return false
    end
    if type(args) ~= 'table' then
        return false
    end
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
    local zoneKind = ZONE_KIND[keyID]
    local ringKind = RING_KIND[keyID]
    if zoneKind == nil and ringKind == nil then
        return false
    end
    if not finite(entityID)
            or not finite(now)
            or effectType ~= 7
            or flags ~= 5
            or stateValue ~= 1
            or not finite(heading)
            or not validArenaPosition(position)
    then
        diagnostic(state, 'ground_effect_invalid', now, keyID)
        return false
    end
    if state.seen[entityID] ~= nil then
        return false
    end
    state.seen[entityID] = now
    if zoneKind ~= nil then
        state.zones[zoneKind] = wrapPi(heading)
        return true
    end
    return drawHazard(
            state, ringKind, now + RING_OFFSET_MS, now, 'ring')
end

local function resolveBall(entityID, contentID)
    local spec = BALL_SPEC[contentID]
    if spec == nil or not finite(entityID) then
        return nil, nil
    end
    local tensorCore = rawget(_G, 'TensorCore')
    if type(tensorCore) ~= 'table'
            or type(tensorCore.entityList) ~= 'function'
    then
        return spec.kind, nil
    end
    local entities = tensorCore.entityList(
            'contentid=' .. tostring(contentID))
    if type(entities) ~= 'table' then
        return spec.kind, nil
    end
    local argus = rawget(_G, 'Argus')
    for _, entity in pairs(entities) do
        if type(entity) == 'table' then
            local liveModelID = type(argus) == 'table'
                    and type(argus.getEntityModel) == 'function'
                    and tonumber(argus.getEntityModel(entityID)) or nil
            if not finite(liveModelID) then
                liveModelID = tonumber(entity.modelid)
            end
            if tonumber(entity.id) == entityID
                    and tonumber(entity.contentid) == contentID
                    and liveModelID == spec.modelID
                    and entity.alive ~= false
            then
                return spec.kind, reliablePosition(entity.pos, false)
            end
        end
    end
    return spec.kind, nil
end

local function ballActivationAt(position, zoneHeading, now)
    local dx = position.x - ARENA.x
    local dz = position.z - ARENA.z
    if dx * dx + dz * dz < 1 then
        return nil
    end
    local ballHeading = math.atan2(dx, dz)
    local delta = (ballHeading - zoneHeading) % math.pi
    return now + BALL_BASE_OFFSET_MS
            + delta / BALL_STEP_RADIANS * BALL_STEP_MS
end

local function ballPairValid(first, second)
    local firstDx = first.x - ARENA.x
    local firstDz = first.z - ARENA.z
    local secondDx = second.x - ARENA.x
    local secondDz = second.z - ARENA.z
    local firstRadius = math.sqrt(firstDx * firstDx + firstDz * firstDz)
    local secondRadius = math.sqrt(
            secondDx * secondDx + secondDz * secondDz)
    return firstRadius >= 18 and firstRadius <= 23
            and secondRadius >= 18 and secondRadius <= 23
            and math.abs(firstDx + secondDx) <= 1
            and math.abs(firstDz + secondDz) <= 1
end

local function completeBallPair(state, kind, now)
    local pending = state.pendingBalls[kind]
    if type(pending) ~= 'table'
            or type(pending.entities) ~= 'table'
            or #pending.entities < 2
    then
        return false
    end
    local positions = {}
    for _, tracked in ipairs(pending.entities) do
        local resolvedKind, position = resolveBall(
                tracked.entityID, tracked.contentID)
        if resolvedKind ~= kind or position == nil then
            if now < pending.startedAt + BALL_RESOLVE_DEADLINE_MS then
                return false
            end
            state.pendingBalls[kind] = nil
            diagnostic(state, 'ball_geometry_invalid', now, tracked.entityID)
            return false
        end
        positions[#positions + 1] = position
    end
    state.pendingBalls[kind] = nil
    if not ballPairValid(positions[1], positions[2]) then
        diagnostic(state, 'ball_pair_invalid', now, kind)
        return false
    end
    local zoneHeading = state.zones[kind]
    if not finite(zoneHeading) then
        diagnostic(state, 'zone_missing', now, kind)
        return false
    end
    local activationAt = ballActivationAt(
            positions[1], zoneHeading, pending.startedAt)
    if activationAt == nil then
        diagnostic(state, 'ball_geometry_invalid', now, kind)
        return false
    end
    return drawHazard(state, kind, activationAt, now, 'ball')
end

local function recordBall(state, entityID, contentID, now)
    if state.extremeActive == true then
        return false
    end
    local spec = BALL_SPEC[contentID]
    if spec == nil then
        return false
    end
    if not finite(entityID)
            or not finite(now)
            or state.seen[entityID] ~= nil
    then
        return false
    end
    state.seen[entityID] = now
    local kind = spec.kind
    local pending = state.pendingBalls[kind]
    if type(pending) ~= 'table'
            or not finite(pending.startedAt)
            or now - pending.startedAt > 1000
    then
        pending = { startedAt = now, entities = {} }
        state.pendingBalls[kind] = pending
    end
    pending.entities[#pending.entities + 1] = {
        entityID = entityID,
        contentID = contentID,
    }
    if #pending.entities < 2 then
        return true
    end
    return completeBallPair(state, kind, now)
end

local function activeGuideHazard(state, now)
    local selected = nil
    for _, hazard in ipairs(state.hazards) do
        if finite(hazard.activationAt)
                and finite(hazard.expiresAt)
                and now < hazard.expiresAt
                and (selected == nil
                        or hazard.activationAt < selected.activationAt)
        then
            selected = hazard
        end
    end
    return selected
end

local function axisDelta(angle, heading)
    local delta = wrapPi(angle - heading)
    if delta > math.pi / 2 then
        delta = delta - math.pi
    elseif delta < -math.pi / 2 then
        delta = delta + math.pi
    end
    return delta
end

local function angleIsDangerous(angle, heading)
    return math.abs(axisDelta(angle, heading)) <= ZONE_ANGLE / 2
end

local function nextGuideHazard(state, current)
    local selected = nil
    for _, hazard in ipairs(state.hazards) do
        if hazard ~= current
                and finite(hazard.activationAt)
                and hazard.activationAt > current.activationAt
                and hazard.activationAt - current.activationAt <= 5000
                and (selected == nil
                        or hazard.activationAt < selected.activationAt)
        then
            selected = hazard
        end
    end
    return selected
end

local function guideTarget(
        playerPosition, dangerHeading, nextDangerHeading)
    if type(playerPosition) ~= 'table'
            or not finite(playerPosition.x)
            or not finite(playerPosition.z)
            or not finite(dangerHeading)
    then
        return nil
    end
    local dx = playerPosition.x - ARENA.x
    local dz = playerPosition.z - ARENA.z
    if dx * dx + dz * dz < 1 then
        return nil
    end
    local playerHeading = math.atan2(dx, dz)
    local candidates = { playerHeading }
    local function addBoundaryCandidates(heading)
        if not finite(heading) then
            return
        end
        local axisHeading = heading
        local delta = wrapPi(playerHeading - axisHeading)
        if delta > math.pi / 2 then
            axisHeading = wrapPi(axisHeading + math.pi)
            delta = wrapPi(playerHeading - axisHeading)
        elseif delta < -math.pi / 2 then
            axisHeading = wrapPi(axisHeading - math.pi)
            delta = wrapPi(playerHeading - axisHeading)
        end
        local firstDirection = delta >= 0 and 1 or -1
        for _, direction in ipairs({ firstDirection, -firstDirection }) do
            candidates[#candidates + 1] = axisHeading + direction
                    * (ZONE_ANGLE / 2 + GUIDE_INSET)
        end
    end
    addBoundaryCandidates(dangerHeading)
    addBoundaryCandidates(nextDangerHeading)

    local targetHeading = nil
    local shortest = nil
    for _, candidate in ipairs(candidates) do
        if not angleIsDangerous(candidate, dangerHeading)
                and (not finite(nextDangerHeading)
                        or not angleIsDangerous(
                                candidate, nextDangerHeading))
        then
            local distance = math.abs(wrapPi(candidate - playerHeading))
            if shortest == nil or distance < shortest then
                targetHeading = candidate
                shortest = distance
            end
        end
    end
    if targetHeading == nil then
        return nil
    end
    return {
        x = ARENA.x + math.sin(targetHeading) * GUIDE_RADIUS,
        z = ARENA.z + math.cos(targetHeading) * GUIDE_RADIUS,
    }
end

local function drawGuide(state, guide, now)
    local hazard = activeGuideHazard(state, now)
    if hazard == nil
            or type(guide) ~= 'table'
            or type(guide.FrameDirect) ~= 'function'
    then
        return false
    end
    local player = getPlayer(guide)
    local nextHazard = nextGuideHazard(state, hazard)
    local target = type(player) == 'table'
            and guideTarget(
                    player.pos,
                    hazard.heading,
                    nextHazard and nextHazard.heading or nil)
            or nil
    if target == nil then
        return false
    end
    local color = type(guide.Config) == 'table'
            and type(guide.Config.Main) == 'table'
            and guide.Config.Main.GuideColor
            or { r = 0, g = 1, b = 1, a = 0.5 }
    guide.FrameDirect(target.x, target.z, 0.7, color)
    return true
end

local function prune(state, now)
    for index = #state.hazards, 1, -1 do
        if now >= state.hazards[index].expiresAt then
            table.remove(state.hazards, index)
        end
    end
    for key, seenAt in pairs(state.seen) do
        if not finite(seenAt) or now - seenAt > STATE_TTL_MS then
            state.seen[key] = nil
        end
    end
    for kind, pending in pairs(state.pendingBalls) do
        if type(pending) == 'table'
                and type(pending.entities) == 'table'
                and #pending.entities >= 2
        then
            completeBallPair(state, kind, now)
        elseif type(pending) ~= 'table'
                or not finite(pending.startedAt)
                or now >= pending.startedAt + BALL_RESOLVE_DEADLINE_MS
        then
            state.pendingBalls[kind] = nil
        end
    end
    for entityID in pairs(state.pendingExtremePredictions) do
        completeExtremePrediction(state, entityID, now)
    end
    for index = #state.extremeHazards, 1, -1 do
        if now >= state.extremeHazards[index].expiresAt then
            table.remove(state.extremeHazards, index)
        end
    end
    local knockback = state.extremeKnockback
    if type(knockback) == 'table' and now > knockback.expiresAt then
        state.extremeKnockback = nil
    end
end

local Feature = {}

Feature.Init = function(M)
    if type(M.Index) == 'table' then
        applyMoogleDonuts(M.Index, false)
        clearMechanic(M.Index)
    end
    M.Index = newState()
    local cfg = getConfig(M)
    applyMoogleDonuts(M.Index, cfg ~= nil and cfg.Enable == true)
    M.SetIndexEnabled = function(enabled)
        local current = getConfig(M)
        if current ~= nil then
            current.Enable = enabled == true
        end
        local state = getState()
        if state ~= nil then
            if enabled ~= true then
                clearMechanic(state)
            end
            applyMoogleDonuts(state, enabled == true)
        end
    end
    M.SetIndexDynamicGuideEnabled = function(enabled)
        local cfg = getConfig(M)
        if cfg ~= nil then
            cfg.DynamicGuide = enabled == true
        end
    end
end

Feature.Clear = function(releaseOwnership)
    local state = getState()
    if state ~= nil then
        clearMechanic(state)
        if releaseOwnership == true then
            applyMoogleDonuts(state, false)
        end
    end
end

Feature.OnAddGroundEffect = function(args, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state ~= nil and cfg ~= nil and cfg.Enable == true then
        return recordGroundEffect(state, args, now)
    end
    return false
end

Feature.OnEntityAdd = function(entityID, contentID, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state ~= nil and cfg ~= nil and cfg.Enable == true then
        return recordBall(state, entityID, contentID, now)
    end
    return false
end

Feature.OnAuraChange = function(entityID, oldActiveAura1, newActiveAura1, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state ~= nil and cfg ~= nil and cfg.Enable == true then
        return recordExtremeAura(state, entityID, newActiveAura1, now)
    end
    return false
end

Feature.OnEntityCast = function(entityID, actionID, castPosition, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state ~= nil and cfg ~= nil and cfg.Enable == true then
        return recordExtremeCast(
                state, entityID, actionID, castPosition, now)
    end
    return false
end

Feature.OnEntityChannel = function(
        entityID, actionID, channelTimeMax, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state ~= nil and cfg ~= nil and cfg.Enable == true then
        return recordExtremeChannel(
                state, entityID, actionID, channelTimeMax, now)
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
        applyMoogleDonuts(state, true)
        prune(state, now)
        if cfg.DynamicGuide == true then
            return drawExtremeKnockbackGuide(state, guide, now)
                    or drawGuide(state, guide, now)
        end
        return false
    end
    clearMechanic(state)
    applyMoogleDonuts(state, false)
    return false
end

Feature.Test = {
    Defaults = DEFAULTS,
    Arena = ARENA,
    ZoneKind = ZONE_KIND,
    RingKind = RING_KIND,
    BallSpec = BALL_SPEC,
    ZoneRadius = ZONE_RADIUS,
    ZoneAngle = ZONE_ANGLE,
    PreviewMs = PREVIEW_MS,
    RingOffsetMs = RING_OFFSET_MS,
    BallBaseOffsetMs = BALL_BASE_OFFSET_MS,
    BallResolveDeadlineMs = BALL_RESOLVE_DEADLINE_MS,
    BallStepRadians = BALL_STEP_RADIANS,
    BallStepMs = BALL_STEP_MS,
    ExtremePredictionSpec = EXTREME_PREDICTION_SPEC,
    ExtremePredictionContentID = EXTREME_PREDICTION_CONTENT_ID,
    ExtremePredictionModelID = EXTREME_PREDICTION_MODEL_ID,
    ExtremePredictionDurationMs = EXTREME_PREDICTION_DURATION_MS,
    ExtremePredictionRotation = EXTREME_PREDICTION_ROTATION,
    ExtremePredictionLandingRadius = EXTREME_PREDICTION_LANDING_RADIUS,
    ExtremeKnockbackCastActionID = EXTREME_KNOCKBACK_CAST_AID,
    ExtremeKnockbackChannelActionID = EXTREME_KNOCKBACK_CHANNEL_AID,
    ExtremeKnockbackDistance = EXTREME_KNOCKBACK_DISTANCE,
    CleansingDonutActionID = CLEANSING_DONUT_AID,
    CleansingDonutInnerRadius = CLEANSING_DONUT_INNER_RADIUS,
    MoogleDonutSource = MOOGLE_DONUT_SOURCE,
    NewState = newState,
    EnsureState = ensureState,
    GetConfig = getConfig,
    RecordGroundEffect = recordGroundEffect,
    RecordBall = recordBall,
    BallActivationAt = ballActivationAt,
    BallPairValid = ballPairValid,
    CompleteBallPair = completeBallPair,
    PredictionLanding = predictionLanding,
    RecordExtremeAura = recordExtremeAura,
    CompleteExtremePrediction = completeExtremePrediction,
    RecordExtremeCast = recordExtremeCast,
    RecordExtremeChannel = recordExtremeChannel,
    DrawExtremeKnockbackGuide = drawExtremeKnockbackGuide,
    GuideTarget = guideTarget,
    DrawGuide = drawGuide,
    ApplyMoogleDonuts = applyMoogleDonuts,
    ClearMechanic = clearMechanic,
}

return Feature
end

rawset(_G, 'MuAiOccultCrescentNorthIndex', Module)
return Module
