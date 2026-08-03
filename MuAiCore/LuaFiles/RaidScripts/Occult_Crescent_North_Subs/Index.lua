local Module = {}

function Module.Create(Context)
    assert(type(Context) == 'table' and type(Context.Common) == 'table')
    local Common = Context.Common
    local finite = Context.finite
    local reliablePosition = Context.reliablePosition
    local resolveEntity = Context.resolveEntity
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
local BALL_RESOLVE_WAIT_MS = 500
local STATE_TTL_MS = 30000

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
    },
})
local getConfig = feature.GetConfig

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
    state.zones = {}
    state.pendingBalls = {}
    state.seen = {}
    state.hazards = {}
    state.lastDiagnostic = nil
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
    local entity = resolveEntity(entityID)
    if type(entity) ~= 'table'
            or tonumber(entity.id) ~= entityID
            or tonumber(entity.contentid) ~= contentID
            or tonumber(entity.modelid) ~= spec.modelID
            or entity.alive == false
            or entity.visible == false
    then
        return spec.kind, nil
    end
    return spec.kind, reliablePosition(entity.pos, false)
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
            if now - pending.startedAt <= BALL_RESOLVE_WAIT_MS then
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
        if finite(hazard.previewAt)
                and finite(hazard.expiresAt)
                and now >= hazard.previewAt
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
    local dx = playerPosition.x - ARENA.x
    local dz = playerPosition.z - ARENA.z
    if dx * dx + dz * dz < 1 then
        return nil
    end
    local playerHeading = math.atan2(dx, dz)
    local axisHeading = dangerHeading
    local delta = wrapPi(playerHeading - axisHeading)
    if delta > math.pi / 2 then
        axisHeading = wrapPi(axisHeading + math.pi)
        delta = wrapPi(playerHeading - axisHeading)
    elseif delta < -math.pi / 2 then
        axisHeading = wrapPi(axisHeading - math.pi)
        delta = wrapPi(playerHeading - axisHeading)
    end
    if math.abs(delta) > ZONE_ANGLE / 2 then
        return nil
    end
    local firstDirection = delta >= 0 and 1 or -1
    local targetHeading = nil
    for _, direction in ipairs({ firstDirection, -firstDirection }) do
        local candidate = axisHeading + direction
                * (ZONE_ANGLE / 2 + GUIDE_INSET)
        if not finite(nextDangerHeading)
                or not angleIsDangerous(candidate, nextDangerHeading)
        then
            targetHeading = candidate
            break
        end
    end
    targetHeading = targetHeading or axisHeading + firstDirection
            * (ZONE_ANGLE / 2 + GUIDE_INSET)
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
                or now - pending.startedAt > BALL_RESOLVE_WAIT_MS
        then
            state.pendingBalls[kind] = nil
        end
    end
end

local Feature = {}

Feature.Init = function(M)
    if type(M.Index) == 'table' then
        clearMechanic(M.Index)
    end
    M.Index = newState()
    M.SetIndexEnabled = function(enabled)
        local cfg = getConfig(M)
        if cfg ~= nil then
            cfg.Enable = enabled == true
        end
        if enabled ~= true and type(M.Index) == 'table' then
            clearMechanic(M.Index)
        end
    end
    M.SetIndexDynamicGuideEnabled = function(enabled)
        local cfg = getConfig(M)
        if cfg ~= nil then
            cfg.DynamicGuide = enabled == true
        end
    end
end

Feature.Clear = function()
    local state = getState()
    if state ~= nil then
        clearMechanic(state)
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

Feature.Update = function(guide, now)
    local state = getState()
    if state == nil or not finite(now) then
        return false
    end
    local cfg = getConfig(guide)
    if cfg ~= nil and cfg.Enable == true then
        prune(state, now)
        if cfg.DynamicGuide == true then
            return drawGuide(state, guide, now)
        end
        return false
    end
    clearMechanic(state)
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
    BallStepRadians = BALL_STEP_RADIANS,
    BallStepMs = BALL_STEP_MS,
    NewState = newState,
    EnsureState = ensureState,
    GetConfig = getConfig,
    RecordGroundEffect = recordGroundEffect,
    RecordBall = recordBall,
    BallActivationAt = ballActivationAt,
    BallPairValid = ballPairValid,
    CompleteBallPair = completeBallPair,
    GuideTarget = guideTarget,
    DrawGuide = drawGuide,
    ClearMechanic = clearMechanic,
}

return Feature
end

rawset(_G, 'MuAiOccultCrescentNorthIndex', Module)
return Module
