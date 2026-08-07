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
local BOSS_CONTENT_ID = 14717
local BOSS_MODEL_ID = 19303
local QUADRILOGY_AURA_KIND = {
    [2764] = 'bow',
    [2765] = 'sword',
    [2766] = 'bell',
    [2767] = 'harp',
}
local QUADRILOGY_DELAYS_MS = { 2750, 6000, 9300, 12500 }
local QUADRILOGY_DURATION_MS = 3100
local QUADRILOGY_PLATFORMS = {
    { x = -17.754, y = -684, z = -638.25 },
    { x = 17.754, y = -684, z = -638.25 },
    { x = 0, y = -684, z = -607.5 },
}
local QUADRILOGY_PLATFORM_HEADINGS = { 0, 2.0944, -2.0944 }
local QUADRILOGY_LETTER_HEADINGS = { math.pi, 1.0472, -1.0472 }
local QUADRILOGY_RESULT_AIDS = {
    [48912] = true, [48913] = true, [48914] = true, [48915] = true,
}
local INTEGRATE_CHANNEL_AID = 48434
local EXTREME_BALL_SPEC = {
    [14723] = { kind = 'ice', modelID = 19971 },
    [14724] = { kind = 'fire', modelID = 19972 },
    [14725] = { kind = 'thunder', modelID = 19973 },
}
local INTEGRATE_BALL_COUNT = 3
local INTEGRATE_DURATION_MS = 6000
local INTEGRATE_TTL_MS = 25000
local OMNI_MAP_EFFECT = { 0, 1, 2 }
local OMNI_RING_DURATION_MS = 7500
local OMNI_MARKER_DURATION_MS = 12000
local OMNI_MARKER_RADIUS = 13
local OMNI_MARKER_KIND = { [670] = 'thunder', [671] = 'fire', [672] = 'ice' }
local EXAFLARE_AID = 48445
local EXAFLARE_MODEL_ID = 9020
local EXAFLARE_RADIUS = 6
local EXAFLARE_FIRST_HIT_MS = 7100
local EXAFLARE_STEP_MS = 2000
local EXAFLARE_PREVIEW_MS = 4000
local EXAFLARE_GRACE_MS = 300
local EXAFLARE_RESOLVE_MS = 1000
local EXAFLARE_CANONICAL = {
    { x = 3.25, z = 21 },
    { x = 3.25, z = 15 },
    { x = 3.25, z = 9 },
    { x = 7.79, z = 4.5 },
    { x = 9.42, z = -1.68 },
    { x = 14.62, z = -4.68 },
    { x = 19.81, z = -7.68 },
    { x = 25.01, z = -10.68 },
}
local BLACKLIST_SOURCE = 'MuAiCore - 极塔目录机制提前预测'
local BLACKLIST_AIDS = {}
for actionID in pairs(QUADRILOGY_RESULT_AIDS) do
    BLACKLIST_AIDS[actionID] = '目录四连武器提前预测'
end

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
        quadrilogy = { order = {}, startedAt = nil },
        pendingQuadrilogy = {},
        integrate = nil,
        pendingVariantBalls = {},
        omni = { active = false, directions = {}, rings = {} },
        pendingExaflares = {},
        exaflareSeen = {},
        blacklist = { owned = {}, registered = false },
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
    state.quadrilogy = type(state.quadrilogy) == 'table'
            and state.quadrilogy or {}
    state.quadrilogy.order = type(state.quadrilogy.order) == 'table'
            and state.quadrilogy.order or {}
    state.pendingQuadrilogy = type(state.pendingQuadrilogy) == 'table'
            and state.pendingQuadrilogy or {}
    state.pendingVariantBalls = type(state.pendingVariantBalls) == 'table'
            and state.pendingVariantBalls or {}
    state.omni = type(state.omni) == 'table' and state.omni or {}
    state.omni.active = state.omni.active == true
    state.omni.directions = type(state.omni.directions) == 'table'
            and state.omni.directions or {}
    state.omni.rings = type(state.omni.rings) == 'table'
            and state.omni.rings or {}
    state.pendingExaflares = type(state.pendingExaflares) == 'table'
            and state.pendingExaflares or {}
    state.exaflareSeen = type(state.exaflareSeen) == 'table'
            and state.exaflareSeen or {}
    state.blacklist = type(state.blacklist) == 'table'
            and state.blacklist or {}
    state.blacklist.owned = type(state.blacklist.owned) == 'table'
            and state.blacklist.owned or {}
    state.blacklist.registered = state.blacklist.registered == true
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
        quadrilogy_entity_invalid = '目录四连武器本体身份不可用',
        quadrilogy_draw_failed = '目录四连武器范围绘制失败',
        integrate_ball_invalid = '目录元素整合球身份或几何无效',
        integrate_drawer_unavailable = '目录元素整合安全区绘图器不可用',
        omni_event_invalid = '目录全能元素事件字段无效',
        omni_marker_zone_missing = '目录属性点名缺少对应元素轴',
        exaflare_event_invalid = '目录石化地火事件身份或几何无效',
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

local function applyBlacklist(state, enabled)
    state = ensureState(state)
    local blacklist = Common.getMoogleTable(
            'aoeIDUserBlacklist', enabled == true)
    if blacklist == nil then
        state.blacklist.registered = false
        return false
    end
    if enabled == true then
        for actionID, label in pairs(BLACKLIST_AIDS) do
            local current = blacklist[actionID]
            if current == nil then
                current = { label = label, source = BLACKLIST_SOURCE }
                blacklist[actionID] = current
                state.blacklist.owned[actionID] = current
            elseif current == state.blacklist.owned[actionID]
                    or (type(current) == 'table'
                            and current.source == BLACKLIST_SOURCE)
            then
                state.blacklist.owned[actionID] = current
            else
                state.blacklist.owned[actionID] = nil
            end
        end
        state.blacklist.registered = true
        return true
    end
    for actionID in pairs(BLACKLIST_AIDS) do
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
    for _, ring in pairs(state.omni.rings) do
        for _, token in ipairs(ring.tokens or {}) do
            Common.deleteTimedShape(token)
        end
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
    state.quadrilogy = { order = {}, startedAt = nil }
    state.pendingQuadrilogy = {}
    state.integrate = nil
    state.pendingVariantBalls = {}
    state.omni = { active = false, directions = {}, rings = {} }
    state.pendingExaflares = {}
    state.exaflareSeen = {}
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
    for _, entity in pairs(entities) do
        if type(entity) == 'table' then
            local liveModelID = Common.entityModelID(entity)
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

local function appendExtremeHazard(state, token, expiresAt, source)
    if type(token) ~= 'string' or not finite(expiresAt) then
        return false
    end
    state.extremeHazards[#state.extremeHazards + 1] = {
        token = token,
        expiresAt = expiresAt,
        source = source,
    }
    return true
end

local function drawQuadrilogy(state, now)
    local drawer = Common.getMoogleDrawer()
    if type(drawer) ~= 'table'
            or type(drawer.addTimedCircle) ~= 'function'
            or type(drawer.addTimedCone) ~= 'function'
    then
        diagnostic(state, 'danger_drawer_unavailable', now, 'quadrilogy')
        return false
    end
    local created = {}
    local function add(token, expiresAt)
        if type(token) ~= 'string' then
            for _, entry in ipairs(created) do
                Common.deleteTimedShape(entry.token)
            end
            diagnostic(state, 'quadrilogy_draw_failed', now)
            return false
        end
        created[#created + 1] = { token = token, expiresAt = expiresAt }
        return true
    end
    for index, kind in ipairs(state.quadrilogy.order) do
        local delay = QUADRILOGY_DELAYS_MS[index]
        local expiresAt = now + delay + QUADRILOGY_DURATION_MS
        if kind == 'harp' then
            if not add(drawer:addTimedCircle(
                    QUADRILOGY_DURATION_MS,
                    ARENA.x, ARENA.y, ARENA.z, 16, delay), expiresAt)
            then return false end
        elseif kind == 'bow' then
            for _, pos in ipairs(QUADRILOGY_PLATFORMS) do
                if not add(drawer:addTimedCircle(
                        QUADRILOGY_DURATION_MS,
                        pos.x, pos.y, pos.z, 11, delay), expiresAt)
                then return false end
            end
        else
            local headings = kind == 'sword'
                    and QUADRILOGY_PLATFORM_HEADINGS
                    or QUADRILOGY_LETTER_HEADINGS
            local radius = kind == 'sword' and 32 or 25
            for _, heading in ipairs(headings) do
                if not add(drawer:addTimedCone(
                        QUADRILOGY_DURATION_MS,
                        ARENA.x, ARENA.y, ARENA.z,
                        radius, math.rad(60), heading, delay), expiresAt)
                then return false end
            end
        end
    end
    for _, entry in ipairs(created) do
        appendExtremeHazard(
                state, entry.token, entry.expiresAt, 'quadrilogy')
    end
    state.quadrilogy.completedAt = now
    activateExtreme(state)
    state.lastDiagnostic = nil
    return true
end

local function recordQuadrilogyAura(state, entityID, aura, now)
    local kind = QUADRILOGY_AURA_KIND[tonumber(aura)]
    if kind == nil or not finite(entityID) or not finite(now) then
        return false
    end
    local _, position = resolveStrictEntity(
            entityID, BOSS_CONTENT_ID, BOSS_MODEL_ID)
    if position == nil then
        local key = tostring(entityID) .. ':' .. tostring(aura)
        if state.pendingQuadrilogy[key] == nil then
            state.pendingQuadrilogy[key] = {
                entityID = entityID,
                aura = aura,
                startedAt = now,
            }
            return true
        end
        return false
    end
    local round = state.quadrilogy
    if finite(round.completedAt) and now - round.completedAt <= 8000 then
        return false
    end
    if not finite(round.startedAt)
            or now - round.startedAt > 8000
    then
        round = { order = {}, seen = {}, startedAt = now }
        state.quadrilogy = round
    end
    round.seen = type(round.seen) == 'table' and round.seen or {}
    if round.seen[kind] == true or #round.order >= 4 then
        return false
    end
    round.seen[kind] = true
    round.order[#round.order + 1] = kind
    if #round.order < 4 then
        return true
    end
    return drawQuadrilogy(state, now)
end

local function resolvePendingQuadrilogy(state, now)
    for key, pending in pairs(state.pendingQuadrilogy) do
        if type(pending) ~= 'table' or not finite(pending.startedAt) then
            state.pendingQuadrilogy[key] = nil
        else
            local _, position = resolveStrictEntity(
                    pending.entityID, BOSS_CONTENT_ID, BOSS_MODEL_ID)
            if position ~= nil then
                state.pendingQuadrilogy[key] = nil
                recordQuadrilogyAura(
                        state, pending.entityID, pending.aura, now)
            elseif now >= pending.startedAt + EXAFLARE_RESOLVE_MS then
                state.pendingQuadrilogy[key] = nil
                diagnostic(
                        state, 'quadrilogy_entity_invalid', now,
                        pending.entityID)
            end
        end
    end
end

local function recordIntegrateChannel(state, entityID, actionID, now)
    if tonumber(actionID) ~= INTEGRATE_CHANNEL_AID
            or not finite(entityID) or not finite(now)
    then
        return false
    end
    local _, bossPosition = resolveStrictEntity(
            entityID, BOSS_CONTENT_ID, BOSS_MODEL_ID)
    state.integrate = {
        armed = true,
        startedAt = now,
        expiresAt = now + INTEGRATE_TTL_MS,
        bossEntityID = entityID,
        identityPending = bossPosition == nil,
        balls = {},
        seen = {},
    }
    if bossPosition ~= nil then activateExtreme(state) end
    return true
end

local function recordIntegrateBall(state, guide, entityID, contentID, now)
    local integrate = state.integrate
    local spec = EXTREME_BALL_SPEC[tonumber(contentID)]
    if type(integrate) ~= 'table' or spec == nil
            or not finite(entityID) or not finite(now)
            or now > integrate.expiresAt
    then
        return false, true
    end
    if integrate.armed ~= true then
        return false, true
    end
    if integrate.identityPending == true then
        return false, false
    end
    if integrate.seen[entityID] == true then
        return false, true
    end
    local _, position = resolveStrictEntity(entityID, contentID, spec.modelID)
    if position == nil then
        return false, false
    end
    local dx = position.x - ARENA.x
    local dz = position.z - ARENA.z
    local radius = math.sqrt(dx * dx + dz * dz)
    if radius < 17 or radius > 23 then
        diagnostic(state, 'integrate_ball_invalid', now, entityID)
        return false, true
    end
    for _, ball in ipairs(integrate.balls) do
        local bx = ball.position.x - position.x
        local bz = ball.position.z - position.z
        if bx * bx + bz * bz <= 1 then
            integrate.seen[entityID] = true
            return false, true
        end
    end
    local drawer = integrate.drawer
    if drawer == nil and type(guide) == 'table'
            and type(guide.CreateDrawer) == 'function'
    then
        drawer = guide.CreateDrawer(0, 1, 0, 0.28, 2, 0)
        integrate.drawer = drawer
    end
    if type(drawer) ~= 'table' or type(drawer.addTimedCone) ~= 'function' then
        diagnostic(state, 'integrate_drawer_unavailable', now)
        return false, true
    end
    local heading = math.atan2(dx, dz)
    local token = drawer:addTimedCone(
            INTEGRATE_DURATION_MS,
            ARENA.x, ARENA.y, ARENA.z,
            60, math.rad(60), heading, 0)
    if not appendExtremeHazard(
            state, token, now + INTEGRATE_DURATION_MS, 'integrate')
    then
        diagnostic(state, 'danger_drawer_rejected_shape', now, entityID)
        return false, true
    end
    integrate.seen[entityID] = true
    integrate.balls[#integrate.balls + 1] = {
        entityID = entityID,
        contentID = contentID,
        position = position,
    }
    if #integrate.balls >= INTEGRATE_BALL_COUNT then
        integrate.armed = false
    end
    state.lastDiagnostic = nil
    return true, true
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

local function recordOmniMapEffect(state, a1, a2, a3, now)
    if tonumber(a1) ~= OMNI_MAP_EFFECT[1]
            or tonumber(a2) ~= OMNI_MAP_EFFECT[2]
            or tonumber(a3) ~= OMNI_MAP_EFFECT[3]
            or not finite(now)
    then
        return false
    end
    for _, ring in pairs(state.omni.rings) do
        for _, token in ipairs(ring.tokens or {}) do
            Common.deleteTimedShape(token)
        end
    end
    state.omni = {
        active = true,
        startedAt = now,
        expiresAt = now + STATE_TTL_MS,
        directions = {},
        rings = {},
        marker = nil,
    }
    activateExtreme(state)
    return true
end

local function recordOmniGroundEffect(state, args, now)
    if state.omni.active ~= true or type(args) ~= 'table' then
        return false
    end
    local entityID = tonumber(args[1])
    local effectType = tonumber(args[2])
    local flags = tonumber(args[3])
    local keyID = tonumber(args[5])
    local heading = tonumber(args[12])
    local stateValue = tonumber(args[15])
    local position = reliablePosition({
        x = tonumber(args[17]), y = tonumber(args[18]), z = tonumber(args[19]),
    }, false)
    local zoneKind = ZONE_KIND[keyID]
    local ringKind = RING_KIND[keyID]
    if zoneKind == nil and ringKind == nil then
        return false
    end
    if not finite(entityID) or not finite(now)
            or effectType ~= 7 or flags ~= 5 or stateValue ~= 1
            or not finite(heading) or not validArenaPosition(position)
    then
        diagnostic(state, 'omni_event_invalid', now, keyID)
        return false
    end
    if zoneKind ~= nil then
        state.omni.directions[zoneKind] = wrapPi(heading)
        return true
    end
    if state.omni.rings[entityID] ~= nil then
        return false
    end
    local drawer = Common.getMoogleDrawer()
    if type(drawer) ~= 'table' or type(drawer.addTimedCone) ~= 'function' then
        diagnostic(state, 'danger_drawer_unavailable', now, ringKind)
        return false
    end
    local elementHeading = state.omni.directions[ringKind]
    if not finite(elementHeading) then
        diagnostic(state, 'zone_missing', now, ringKind)
        return false
    end
    local tokens = {}
    for _, offset in ipairs({ 0, math.pi }) do
        local token = drawer:addTimedCone(
                OMNI_RING_DURATION_MS,
                ARENA.x, ARENA.y, ARENA.z,
                32, math.rad(60),
                wrapPi(elementHeading + offset), 0)
        if type(token) ~= 'string' then
            for _, rollback in ipairs(tokens) do
                Common.deleteTimedShape(rollback)
            end
            diagnostic(state, 'danger_drawer_rejected_shape', now, ringKind)
            return false
        end
        tokens[#tokens + 1] = token
    end
    state.omni.rings[entityID] = {
        kind = ringKind,
        tokens = tokens,
        expiresAt = now + OMNI_RING_DURATION_MS,
    }
    state.lastDiagnostic = nil
    return true
end

local function clearOmniRing(state, entityID, a2)
    if tonumber(a2) ~= 3 then
        return false
    end
    local ring = state.omni.rings[entityID]
    if type(ring) ~= 'table' then
        return false
    end
    for _, token in ipairs(ring.tokens or {}) do
        Common.deleteTimedShape(token)
    end
    state.omni.rings[entityID] = nil
    return true
end

local function recordOmniMarker(state, guide, entityID, markerID, now)
    local kind = OMNI_MARKER_KIND[tonumber(markerID)]
    if kind == nil or state.omni.active ~= true
            or not finite(entityID) or not finite(now)
    then
        return false
    end
    local player = getPlayer(guide)
    if type(player) ~= 'table' or tonumber(player.id) ~= entityID then
        return false
    end
    local position = reliablePosition(player.pos, false)
    local heading = state.omni.directions[kind]
    if position == nil or not finite(heading) then
        diagnostic(state, 'omni_marker_zone_missing', now, kind)
        return false
    end
    local selected = nil
    local selectedDistance = nil
    for _, offset in ipairs({ 0, math.pi }) do
        local axis = heading + offset
        local target = {
            x = ARENA.x + math.sin(axis) * OMNI_MARKER_RADIUS,
            z = ARENA.z + math.cos(axis) * OMNI_MARKER_RADIUS,
        }
        local dx = target.x - position.x
        local dz = target.z - position.z
        local distance = dx * dx + dz * dz
        if selectedDistance == nil or distance < selectedDistance then
            selected = target
            selectedDistance = distance
        end
    end
    state.omni.marker = {
        kind = kind,
        target = selected,
        expiresAt = now + OMNI_MARKER_DURATION_MS,
    }
    state.lastDiagnostic = nil
    return true
end

local function drawOmniMarkerGuide(state, guide, now)
    local marker = state.omni.marker
    if type(marker) ~= 'table' or now >= marker.expiresAt
            or type(marker.target) ~= 'table'
            or type(guide) ~= 'table'
            or type(guide.FrameDirect) ~= 'function'
    then
        if type(marker) == 'table' and now >= marker.expiresAt then
            state.omni.marker = nil
        end
        return false
    end
    local color = type(guide.Config) == 'table'
            and type(guide.Config.Main) == 'table'
            and guide.Config.Main.GuideColor
            or { r = 0, g = 1, b = 1, a = 0.5 }
    guide.FrameDirect(marker.target.x, marker.target.z, 0.7, color)
    return true
end

local function exaflareKey(aoeInfo)
    return tostring(aoeInfo.entityID) .. ':'
            .. tostring(math.floor((tonumber(aoeInfo.startTime) or 0) + 0.5))
end

local function exaflareNodes(position)
    if position == nil or math.abs(position.y - ARENA.y) > 2 then
        return nil
    end
    local dx = position.x - ARENA.x
    local dz = position.z - ARENA.z
    local radius = math.sqrt(dx * dx + dz * dz)
    if radius < 24 or radius > 40 then
        return nil
    end
    local entry = math.atan2(dx, dz)
    local axisStep = 2 * math.pi / 3
    local axis = math.floor(entry / axisStep + 0.5) * axisStep
    local lateral = wrapPi(entry - axis)
    local mirror = lateral < 0 and -1 or 1
    local sinAxis = math.sin(axis)
    local cosAxis = math.cos(axis)
    local nodes = {}
    for _, canonical in ipairs(EXAFLARE_CANONICAL) do
        local localX = canonical.x * mirror
        nodes[#nodes + 1] = {
            x = ARENA.x + localX * cosAxis + canonical.z * sinAxis,
            y = ARENA.y,
            z = ARENA.z - localX * sinAxis + canonical.z * cosAxis,
        }
    end
    return nodes
end

local function completeExaflare(state, key, now)
    local pending = state.pendingExaflares[key]
    if type(pending) ~= 'table' then
        return false
    end
    local _, bossPosition = resolveStrictEntity(
            pending.entityID, BOSS_CONTENT_ID, EXAFLARE_MODEL_ID)
    local nodes = bossPosition ~= nil and exaflareNodes(pending.position) or nil
    if nodes == nil then
        if now < pending.startedAt + EXAFLARE_RESOLVE_MS then
            return false
        end
        state.pendingExaflares[key] = nil
        diagnostic(state, 'exaflare_event_invalid', now, pending.entityID)
        return false
    end
    local drawer = Common.getMoogleDrawer()
    if type(drawer) ~= 'table' or type(drawer.addTimedCircle) ~= 'function' then
        state.pendingExaflares[key] = nil
        diagnostic(state, 'danger_drawer_unavailable', now, EXAFLARE_AID)
        return false
    end
    local created = {}
    for index, node in ipairs(nodes) do
        local hitAt = pending.startedAt + EXAFLARE_FIRST_HIT_MS
                + (index - 1) * EXAFLARE_STEP_MS
        local delay = math.max(0, hitAt - now - EXAFLARE_PREVIEW_MS)
        local duration = hitAt - now - delay + EXAFLARE_GRACE_MS
        if duration <= 0 then
            for _, entry in ipairs(created) do
                Common.deleteTimedShape(entry.token)
            end
            state.pendingExaflares[key] = nil
            diagnostic(state, 'exaflare_event_invalid', now, index)
            return false
        end
        local token = drawer:addTimedCircle(
                math.floor(duration + 0.5),
                node.x, node.y, node.z,
                EXAFLARE_RADIUS, math.floor(delay + 0.5))
        if type(token) ~= 'string' then
            for _, entry in ipairs(created) do
                Common.deleteTimedShape(entry.token)
            end
            state.pendingExaflares[key] = nil
            diagnostic(state, 'danger_drawer_rejected_shape', now, EXAFLARE_AID)
            return false
        end
        created[#created + 1] = {
            token = token,
            expiresAt = hitAt + EXAFLARE_GRACE_MS,
        }
    end
    state.pendingExaflares[key] = nil
    state.exaflareSeen[key] = now
    for _, entry in ipairs(created) do
        appendExtremeHazard(
                state, entry.token, entry.expiresAt, 'exaflare')
    end
    activateExtreme(state)
    state.lastDiagnostic = nil
    return true
end

local function recordExaflareAOE(state, aoeInfo, now)
    if type(aoeInfo) ~= 'table'
            or tonumber(aoeInfo.aoeID) ~= EXAFLARE_AID
    then
        return false
    end
    local entityID = tonumber(aoeInfo.entityID)
    local contentID = tonumber(aoeInfo.contentID)
    local position = reliablePosition({
        x = tonumber(aoeInfo.x), y = tonumber(aoeInfo.y), z = tonumber(aoeInfo.z),
    }, false)
    if not finite(entityID) or contentID ~= BOSS_CONTENT_ID
            or not finite(now) or exaflareNodes(position) == nil
    then
        diagnostic(state, 'exaflare_event_invalid', now, entityID)
        return false
    end
    local key = exaflareKey(aoeInfo)
    if state.exaflareSeen[key] ~= nil
            or state.pendingExaflares[key] ~= nil
    then
        return false
    end
    state.pendingExaflares[key] = {
        entityID = entityID,
        position = position,
        startedAt = now,
    }
    return completeExaflare(state, key, now)
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
    for _, entity in pairs(entities) do
        if type(entity) == 'table' then
            local liveModelID = Common.entityModelID(entity)
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

local function recordBallEntity(state, guide, entityID, contentID, now)
    local integrate = state.integrate
    if type(integrate) == 'table'
            and finite(integrate.expiresAt)
            and now <= integrate.expiresAt
            and EXTREME_BALL_SPEC[tonumber(contentID)] ~= nil
    then
        local changed, complete = recordIntegrateBall(
                state, guide, entityID, contentID, now)
        if complete ~= true then
            state.pendingVariantBalls[entityID] = {
                contentID = contentID,
                startedAt = now,
            }
            return true
        end
        state.pendingVariantBalls[entityID] = nil
        return changed
    end
    return recordBall(state, entityID, contentID, now)
end

local function resolvePendingVariantBalls(state, guide, now)
    for entityID, pending in pairs(state.pendingVariantBalls) do
        if type(pending) ~= 'table'
                or not finite(pending.startedAt)
                or now >= pending.startedAt + BALL_RESOLVE_DEADLINE_MS
        then
            state.pendingVariantBalls[entityID] = nil
            diagnostic(state, 'integrate_ball_invalid', now, entityID)
        else
            local _, complete = recordIntegrateBall(
                    state, guide, entityID, pending.contentID, now)
            if complete == true then
                state.pendingVariantBalls[entityID] = nil
            end
        end
    end
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

local function prune(state, guide, now)
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
    resolvePendingQuadrilogy(state, now)
    if type(state.integrate) == 'table'
            and state.integrate.identityPending == true
    then
        local _, position = resolveStrictEntity(
                state.integrate.bossEntityID,
                BOSS_CONTENT_ID, BOSS_MODEL_ID)
        if position ~= nil then
            state.integrate.identityPending = false
            activateExtreme(state)
        elseif now >= state.integrate.startedAt + EXAFLARE_RESOLVE_MS then
            diagnostic(state, 'integrate_ball_invalid', now,
                    state.integrate.bossEntityID)
            state.integrate = nil
            state.pendingVariantBalls = {}
        end
    end
    resolvePendingVariantBalls(state, guide, now)
    for key in pairs(state.pendingExaflares) do
        completeExaflare(state, key, now)
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
    if type(state.integrate) == 'table'
            and now > state.integrate.expiresAt
    then
        state.integrate = nil
        state.pendingVariantBalls = {}
    end
    for entityID, ring in pairs(state.omni.rings) do
        if type(ring) ~= 'table'
                or not finite(ring.expiresAt)
                or now >= ring.expiresAt
        then
            state.omni.rings[entityID] = nil
        end
    end
    if state.omni.active == true
            and finite(state.omni.expiresAt)
            and now >= state.omni.expiresAt
    then
        state.omni = { active = false, directions = {}, rings = {} }
    end
    for key, seenAt in pairs(state.exaflareSeen) do
        if not finite(seenAt) or now - seenAt > STATE_TTL_MS then
            state.exaflareSeen[key] = nil
        end
    end
end

local Feature = {}

Feature.Init = function(M)
    if type(M.Index) == 'table' then
        applyMoogleDonuts(M.Index, false)
        applyBlacklist(M.Index, false)
        clearMechanic(M.Index)
    end
    M.Index = newState()
    local cfg = getConfig(M)
    applyMoogleDonuts(M.Index, cfg ~= nil and cfg.Enable == true)
    applyBlacklist(M.Index, cfg ~= nil and cfg.Enable == true)
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
            applyBlacklist(state, enabled == true)
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
            applyBlacklist(state, false)
        end
    end
end

Feature.OnAddGroundEffect = function(args, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state ~= nil and cfg ~= nil and cfg.Enable == true then
        return recordOmniGroundEffect(state, args, now)
                or recordGroundEffect(state, args, now)
    end
    return false
end

Feature.OnEntityAdd = function(entityID, contentID, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state ~= nil and cfg ~= nil and cfg.Enable == true then
        return recordBallEntity(state, guide, entityID, contentID, now)
    end
    return false
end

Feature.OnAuraChange = function(entityID, oldActiveAura1, newActiveAura1, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state ~= nil and cfg ~= nil and cfg.Enable == true then
        return recordQuadrilogyAura(
                state, entityID, newActiveAura1, now)
                or recordExtremeAura(state, entityID, newActiveAura1, now)
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
        return recordIntegrateChannel(state, entityID, actionID, now)
                or recordExtremeChannel(
                state, entityID, actionID, channelTimeMax, now)
    end
    return false
end

Feature.OnMapEffect = function(a1, a2, a3, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state ~= nil and cfg ~= nil and cfg.Enable == true then
        return recordOmniMapEffect(state, a1, a2, a3, now)
    end
    return false
end

Feature.OnEventObjectScriptFunc = function(entityID, _, a2)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state ~= nil and cfg ~= nil and cfg.Enable == true then
        return clearOmniRing(state, entityID, a2)
    end
    return false
end

Feature.OnMarkerAdd = function(entityID, markerID, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state ~= nil and cfg ~= nil and cfg.Enable == true then
        return recordOmniMarker(
                state, guide, entityID, markerID, now)
    end
    return false
end

Feature.OnAOECreate = function(aoeInfo, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state ~= nil and cfg ~= nil and cfg.Enable == true then
        return recordExaflareAOE(state, aoeInfo, now)
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
        applyBlacklist(state, true)
        prune(state, guide, now)
        if cfg.DynamicGuide == true then
            return drawExtremeKnockbackGuide(state, guide, now)
                    or drawOmniMarkerGuide(state, guide, now)
                    or drawGuide(state, guide, now)
        end
        return false
    end
    clearMechanic(state)
    applyMoogleDonuts(state, false)
    applyBlacklist(state, false)
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
    BossContentID = BOSS_CONTENT_ID,
    BossModelID = BOSS_MODEL_ID,
    QuadrilogyAuraKind = QUADRILOGY_AURA_KIND,
    QuadrilogyDelaysMs = QUADRILOGY_DELAYS_MS,
    QuadrilogyDurationMs = QUADRILOGY_DURATION_MS,
    QuadrilogyPlatforms = QUADRILOGY_PLATFORMS,
    QuadrilogyPlatformHeadings = QUADRILOGY_PLATFORM_HEADINGS,
    QuadrilogyLetterHeadings = QUADRILOGY_LETTER_HEADINGS,
    IntegrateChannelActionID = INTEGRATE_CHANNEL_AID,
    ExtremeBallSpec = EXTREME_BALL_SPEC,
    IntegrateBallCount = INTEGRATE_BALL_COUNT,
    IntegrateDurationMs = INTEGRATE_DURATION_MS,
    OmniMarkerKind = OMNI_MARKER_KIND,
    OmniRingDurationMs = OMNI_RING_DURATION_MS,
    OmniMarkerDurationMs = OMNI_MARKER_DURATION_MS,
    OmniMarkerRadius = OMNI_MARKER_RADIUS,
    ExaflareActionID = EXAFLARE_AID,
    ExaflareModelID = EXAFLARE_MODEL_ID,
    ExaflareCanonical = EXAFLARE_CANONICAL,
    ExaflareNodes = exaflareNodes,
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
    RecordQuadrilogyAura = recordQuadrilogyAura,
    DrawQuadrilogy = drawQuadrilogy,
    RecordIntegrateChannel = recordIntegrateChannel,
    RecordIntegrateBall = recordIntegrateBall,
    RecordBallEntity = recordBallEntity,
    RecordOmniMapEffect = recordOmniMapEffect,
    RecordOmniGroundEffect = recordOmniGroundEffect,
    ClearOmniRing = clearOmniRing,
    RecordOmniMarker = recordOmniMarker,
    DrawOmniMarkerGuide = drawOmniMarkerGuide,
    RecordExaflareAOE = recordExaflareAOE,
    CompleteExaflare = completeExaflare,
    DrawExtremeKnockbackGuide = drawExtremeKnockbackGuide,
    GuideTarget = guideTarget,
    DrawGuide = drawGuide,
    ApplyMoogleDonuts = applyMoogleDonuts,
    ApplyBlacklist = applyBlacklist,
    ClearMechanic = clearMechanic,
}

return Feature
end

rawset(_G, 'MuAiOccultCrescentNorthIndex', Module)
return Module
