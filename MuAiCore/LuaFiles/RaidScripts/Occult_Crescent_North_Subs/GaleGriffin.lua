local Module = {}

function Module.Create(Context)
    assert(type(Context) == 'table' and type(Context.Common) == 'table')
    local Common = Context.Common
    local finite = Context.finite
    local reliablePosition = Context.reliablePosition
    local resolveEntity = Context.resolveEntity

local BOSS_CONTENT_ID = 14776
local BOSS_MODEL_ID = 19436
local HELPER_MODEL_ID = 19437
local WIND_CONTENT_ID = 14777
local WIND_MODEL_ID = 19493

local AID = {
    CallStorm = 47580,
    WindPressure = 47583,
    FirstOuter = 47585,
    FirstInner = 47586,
    FirstSteel = 47587,
    SecondOuter = 47592,
    SecondInner = 47593,
    SecondSteel = 47594,
    ThirdOuter = 47595,
    ThirdInner = 47596,
    ThirdSteel = 47597,
    FreeFall = 47598,
}

local ARENA_CENTER = { x = -855.772, z = 482.139 }
local ARENA_Y = 70.676
local GUIDE_RADIUS = 32
local GUIDE_GRID_STEP = 1.5
local GUIDE_MARGIN = 0.65
local GUIDE_MOVE_SPEED = 5.5
local GUIDE_MOVE_RESERVE_MS = 350
local FIRST_WIND_AFTER_FREEFALL_MS = 7000
local SECOND_WIND_AFTER_FREEFALL_MS = 17150

local WIND_RADIUS = 7
local WIND_COUNT = 6
local WIND_PREDICTION_TIMEOUT_MS = 11500
local WIND_PREDICTED_FOLLOWUP_COUNT = 3
local WIND_GENERATION_DUPLICATE_MS = 12000
local PENDING_ENTITY_RESOLVE_MS = 1000
local ROUTE_GEOMETRY_MIN_MS = 1000
local ROUTE_GEOMETRY_MAX_MS = 4000
local ROUTE_FINALIZE_GRACE_MS = 5000
local ROUTE_TIMEOUT_MS = 22000
local BATCH_SPAN_MS = 350
local CENTER_MATCH_DISTANCE = 1
local CENTER_MIN_DISTANCE = 15
local CENTER_MAX_DISTANCE = 45
local AOE_DURATION_TOLERANCE = 0.25
local AOE_LENGTH_TOLERANCE = 0.5

local DEFAULTS = {
    Enable = true,
    DrawWindOrbPrediction = true,
    DynamicGuide = true,
}

local GEOMETRY_SPECS = {
    [AID.FirstSteel] = {
        centerIndex = 1,
        kind = 'circle',
        radius = 10,
        duration = 5.7,
        castType = 2,
        aoeType = 181,
        effect = 'er_general_1f',
    },
    [AID.FirstInner] = {
        centerIndex = 1,
        kind = 'donut',
        innerRadius = 10,
        radius = 20,
        duration = 7.7,
        castType = 10,
        aoeType = 111,
        effect = 'gl_sircle_2010bf',
    },
    [AID.FirstOuter] = {
        centerIndex = 1,
        kind = 'donut',
        innerRadius = 20,
        radius = 30,
        duration = 9.7,
        castType = 10,
        aoeType = 112,
        effect = 'gl_sircle_3020bf',
    },
    [AID.SecondSteel] = {
        centerIndex = 2,
        kind = 'circle',
        radius = 10,
        duration = 8.7,
        castType = 2,
        aoeType = 181,
        effect = 'er_general_1f',
    },
    [AID.SecondInner] = {
        centerIndex = 2,
        kind = 'donut',
        innerRadius = 10,
        radius = 20,
        duration = 10.7,
        castType = 10,
        aoeType = 111,
        effect = 'gl_sircle_2010bf',
    },
    [AID.SecondOuter] = {
        centerIndex = 2,
        kind = 'donut',
        innerRadius = 20,
        radius = 30,
        duration = 12.7,
        castType = 10,
        aoeType = 112,
        effect = 'gl_sircle_3020bf',
    },
    [AID.ThirdSteel] = {
        centerIndex = 3,
        kind = 'circle',
        radius = 10,
        duration = 11.2,
        castType = 2,
        aoeType = 181,
        effect = 'er_general_1f',
    },
    [AID.ThirdInner] = {
        centerIndex = 3,
        kind = 'donut',
        innerRadius = 10,
        radius = 20,
        duration = 13.2,
        castType = 10,
        aoeType = 111,
        effect = 'gl_sircle_2010bf',
    },
    [AID.ThirdOuter] = {
        centerIndex = 3,
        kind = 'donut',
        innerRadius = 20,
        radius = 30,
        duration = 15.2,
        castType = 10,
        aoeType = 112,
        effect = 'gl_sircle_3020bf',
    },
}

local STAGE_ACTIONS = {
    AID.FirstSteel,
    AID.FirstInner,
    AID.SecondSteel,
    AID.FirstOuter,
    AID.SecondInner,
    AID.ThirdSteel,
    AID.SecondOuter,
    AID.ThirdInner,
    AID.ThirdOuter,
}

local function newState()
    return {
        windGeneration = nil,
        nextWindGeneration = 0,
        windEntities = {},
        pendingWindEntities = {},
        windPredictions = {},
        round = nil,
        route = nil,
        lastDiagnostic = nil,
    }
end

local function ensureState(state)
    state = type(state) == 'table' and state or newState()
    state.nextWindGeneration = finite(state.nextWindGeneration)
            and state.nextWindGeneration or 0
    state.windGeneration = type(state.windGeneration) == 'table'
            and state.windGeneration or nil
    state.windEntities = type(state.windEntities) == 'table'
            and state.windEntities or {}
    state.pendingWindEntities = type(state.pendingWindEntities) == 'table'
            and state.pendingWindEntities or {}
    state.windPredictions = type(state.windPredictions) == 'table'
            and state.windPredictions or {}
    state.round = type(state.round) == 'table' and state.round or nil
    state.route = type(state.route) == 'table' and state.route or nil
    return state
end

local feature = Common.newFeature({
    key = 'GaleGriffin',
    defaults = DEFAULTS,
    newState = newState,
    ensureState = ensureState,
    diagnosticThrottleMs = 1000,
    diagnosticText = {
        boss_signal_invalid = '呼风狮鹫机制起始信号无效',
        wind_entity_invalid = '呼风狮鹫风球实体字段不匹配',
        wind_drawer_unavailable = '呼风狮鹫风球提前绘图器不可用',
        wind_draw_rejected = '呼风狮鹫风球提前绘图失败',
        wind_handoff_invalid = '呼风狮鹫风压接管事件字段不匹配',
        route_event_outside_window = '呼风狮鹫三角跳几何不在可靠时间窗内',
        route_geometry_invalid = '呼风狮鹫三角跳几何字段不匹配',
        route_geometry_conflict = '呼风狮鹫三角跳同一动作出现冲突几何',
        route_batch_mismatch = '呼风狮鹫三角跳九项几何不属于同一批次',
        route_centers_invalid = '呼风狮鹫三角跳三个落点无法可靠分组',
        route_winds_incomplete = '呼风狮鹫三角跳缺少六个可靠风球位置',
        route_plan_unavailable = '呼风狮鹫三角跳没有完整可达路径',
        route_resolution_out_of_order = '呼风狮鹫三角跳判定顺序与预测不一致',
        guide_unavailable = '呼风狮鹫动态指路接口不可用',
        guide_player_unavailable = '呼风狮鹫动态指路缺少玩家位置',
        guide_target_unavailable = '呼风狮鹫动态指路没有可用目标',
    },
})
local getConfig = feature.GetConfig

local function getState()
    return Common.getRuntimeState('GaleGriffin', newState, ensureState)
end

local function diagnostic(state, code, now, context)
    feature.Diagnostic(
            state, rawget(_G, 'MuAiGuide'), code, now, context)
end

local function countTable(bucket)
    local count = 0
    for _ in pairs(type(bucket) == 'table' and bucket or {}) do
        count = count + 1
    end
    return count
end

local function deleteWindPrediction(state, entityID)
    state = ensureState(state)
    local prediction = state.windPredictions[entityID]
    if type(prediction) ~= 'table' then
        return false
    end
    Common.deleteTimedShape(prediction.token)
    state.windPredictions[entityID] = nil
    return true
end

local function clearWindPredictions(state)
    state = ensureState(state)
    local ids = {}
    for entityID in pairs(state.windPredictions) do
        ids[#ids + 1] = entityID
    end
    for _, entityID in ipairs(ids) do
        deleteWindPrediction(state, entityID)
    end
end

local function clearWindGeneration(state)
    state = ensureState(state)
    clearWindPredictions(state)
    state.windGeneration = nil
    state.windEntities = {}
    state.pendingWindEntities = {}
end

local function clearRoute(state)
    state = ensureState(state)
    state.round = nil
    state.route = nil
end

local function clearState(state)
    state = ensureState(state)
    clearWindGeneration(state)
    clearRoute(state)
    state.lastDiagnostic = nil
end

local function validateBoss(entityID)
    if not finite(entityID) or entityID <= 0 then
        return false
    end
    local entity = resolveEntity(entityID)
    if entity == nil then
        return true
    end
    return tonumber(entity.id) == entityID
            and tonumber(entity.contentid) == BOSS_CONTENT_ID
            and tonumber(entity.modelid) == BOSS_MODEL_ID
            and entity.alive ~= false
end

local function beginWindGeneration(
        state, entityID, channelTimeMax, now)
    state = ensureState(state)
    if not finite(now)
            or not finite(channelTimeMax)
            or math.abs(channelTimeMax - 2.7) > 0.2
            or not validateBoss(entityID)
    then
        diagnostic(state, 'boss_signal_invalid', now, {
            actionID = AID.CallStorm,
            entityID = entityID,
            duration = channelTimeMax,
        })
        return false
    end
    local active = state.windGeneration
    if type(active) == 'table'
            and active.bossID == entityID
            and finite(active.startedAt)
            and now >= active.startedAt
            and now - active.startedAt <= WIND_GENERATION_DUPLICATE_MS
    then
        return false
    end
    clearWindGeneration(state)
    state.nextWindGeneration = state.nextWindGeneration + 1
    state.windGeneration = {
        id = state.nextWindGeneration,
        bossID = entityID,
        startedAt = now,
    }
    state.lastDiagnostic = nil
    return true
end

local function beginOpportunisticWindGeneration(state, now)
    if type(state.windGeneration) == 'table' then
        return state.windGeneration
    end
    state.nextWindGeneration = state.nextWindGeneration + 1
    state.windGeneration = {
        id = state.nextWindGeneration,
        startedAt = now,
        opportunistic = true,
    }
    return state.windGeneration
end

local function getDangerDrawer()
    if type(TensorCore) ~= 'table'
            or type(TensorCore.getMoogleDrawer) ~= 'function'
    then
        return nil
    end
    local drawer = TensorCore.getMoogleDrawer()
    local drawerType = type(drawer)
    return (drawerType == 'table' or drawerType == 'userdata')
            and drawer or nil
end

local function drawWindPrediction(state, entry, now)
    if type(state.windPredictions[entry.entityID]) == 'table' then
        return false
    end
    local drawer = getDangerDrawer()
    if drawer == nil or type(drawer.addTimedCircleOnEnt) ~= 'function' then
        diagnostic(state, 'wind_drawer_unavailable', now, entry.entityID)
        return false
    end
    local token = drawer:addTimedCircleOnEnt(
            WIND_PREDICTION_TIMEOUT_MS, entry.entityID, WIND_RADIUS)
    if type(token) ~= 'string' then
        diagnostic(state, 'wind_draw_rejected', now, entry.entityID)
        return false
    end
    state.windPredictions[entry.entityID] = {
        token = token,
        entityID = entry.entityID,
        createdAt = now,
        expiresAt = now + WIND_PREDICTION_TIMEOUT_MS,
    }
    return true
end

local function resolveWindEntity(state, entityID, contentID, addedAt, now, cfg)
    if not finite(entityID)
            or entityID <= 0
            or tonumber(contentID) ~= WIND_CONTENT_ID
            or not finite(addedAt)
            or not finite(now)
    then
        return false, true
    end
    local entity = resolveEntity(entityID)
    if entity == nil and now - addedAt <= PENDING_ENTITY_RESOLVE_MS then
        return false, false
    end
    local position = type(entity) == 'table'
            and reliablePosition(entity.pos, false) or nil
    if type(entity) ~= 'table'
            or tonumber(entity.id) ~= entityID
            or tonumber(entity.contentid) ~= WIND_CONTENT_ID
            or tonumber(entity.modelid) ~= WIND_MODEL_ID
            or entity.alive == false
            or position == nil
    then
        diagnostic(state, 'wind_entity_invalid', now, {
            entityID = entityID,
            contentID = type(entity) == 'table' and entity.contentid or contentID,
            modelID = type(entity) == 'table' and entity.modelid or nil,
        })
        return false, true
    end
    local generation = beginOpportunisticWindGeneration(state, addedAt)
    local existing = state.windEntities[entityID]
    if type(existing) == 'table'
            and existing.generationID == generation.id
    then
        return false, true
    end
    local entry = {
        entityID = entityID,
        generationID = generation.id,
        position = position,
        addedAt = addedAt,
        pulseCount = 0,
    }
    state.windEntities[entityID] = entry
    if type(cfg) == 'table' and cfg.DrawWindOrbPrediction == true then
        drawWindPrediction(state, entry, now)
    end
    state.lastDiagnostic = nil
    return true, true
end

local function handleWindEntityAdd(state, entityID, contentID, now, cfg)
    if tonumber(contentID) ~= WIND_CONTENT_ID then
        return false
    end
    local changed, complete = resolveWindEntity(
            state, entityID, contentID, now, now, cfg)
    if complete ~= true then
        state.pendingWindEntities[entityID] = {
            entityID = entityID,
            contentID = contentID,
            addedAt = now,
        }
    end
    return changed
end

local function handleWindVisibility(state, entityID, isVisible, now, cfg)
    if isVisible ~= true or not finite(entityID) then
        return false
    end
    local entity = resolveEntity(entityID)
    if type(entity) ~= 'table'
            or tonumber(entity.contentid) ~= WIND_CONTENT_ID
    then
        return false
    end
    return handleWindEntityAdd(
            state, entityID, WIND_CONTENT_ID, now, cfg)
end

local function validateWindAOE(aoeInfo)
    local effect = type(aoeInfo) == 'table'
            and type(aoeInfo.aoeEffectInfo) == 'table'
            and aoeInfo.aoeEffectInfo.aoeEffectName or nil
    return type(aoeInfo) == 'table'
            and tonumber(aoeInfo.aoeID) == AID.WindPressure
            and tonumber(aoeInfo.contentID) == WIND_CONTENT_ID
            and finite(tonumber(aoeInfo.entityID))
            and tonumber(aoeInfo.aoeCastType) == 2
            and tonumber(aoeInfo.aoeType) == 181
            and finite(tonumber(aoeInfo.aoeLength))
            and math.abs(tonumber(aoeInfo.aoeLength) - WIND_RADIUS)
                    <= AOE_LENGTH_TOLERANCE
            and finite(tonumber(aoeInfo.duration))
            and math.abs(tonumber(aoeInfo.duration) - 1.7)
                    <= AOE_DURATION_TOLERANCE
            and effect == 'er_general_1f'
end

local function handoffWindPrediction(state, aoeInfo, now)
    local entityID = type(aoeInfo) == 'table'
            and tonumber(aoeInfo.entityID) or nil
    if not validateWindAOE(aoeInfo) then
        diagnostic(state, 'wind_handoff_invalid', now, {
            entityID = entityID,
            actionID = type(aoeInfo) == 'table' and aoeInfo.aoeID or nil,
        })
        return false
    end
    return deleteWindPrediction(state, entityID)
end

local function handleWindCast(state, entityID, now, cfg)
    local entry = state.windEntities[entityID]
    if type(entry) ~= 'table'
            or not finite(entry.pulseCount)
            or type(state.windGeneration) ~= 'table'
            or entry.generationID ~= state.windGeneration.id
    then
        return false
    end
    -- The entity cast is a fallback handoff when an AOECreate callback was
    -- missed. Captured generations then repeat at fixed intervals; exposing
    -- only the next three known pulses avoids inventing a fifth pulse.
    deleteWindPrediction(state, entityID)
    entry.pulseCount = entry.pulseCount + 1
    if entry.pulseCount <= WIND_PREDICTED_FOLLOWUP_COUNT
            and type(cfg) == 'table'
            and cfg.DrawWindOrbPrediction == true
    then
        return drawWindPrediction(state, entry, now)
    end
    return true
end

local function beginRouteRound(state, entityID, channelTimeMax, now)
    state = ensureState(state)
    if not finite(now)
            or not finite(channelTimeMax)
            or math.abs(channelTimeMax - 3.7) > 0.2
            or not validateBoss(entityID)
    then
        diagnostic(state, 'boss_signal_invalid', now, {
            actionID = AID.FreeFall,
            entityID = entityID,
            duration = channelTimeMax,
        })
        return false
    end
    if type(state.round) == 'table'
            and state.round.bossID == entityID
            and finite(state.round.startedAt)
            and now - state.round.startedAt >= 0
            and now - state.round.startedAt <= ROUTE_GEOMETRY_MAX_MS
    then
        return false
    end
    clearRoute(state)
    state.round = {
        bossID = entityID,
        startedAt = now,
        entries = {},
        count = 0,
        suppressed = false,
    }
    state.lastDiagnostic = nil
    return true
end

local function readRouteAOE(state, aoeInfo, now)
    local actionID = type(aoeInfo) == 'table'
            and tonumber(aoeInfo.aoeID) or nil
    local spec = GEOMETRY_SPECS[actionID]
    if spec == nil then
        return nil, nil
    end
    local source = type(aoeInfo) == 'table' and reliablePosition({
        x = tonumber(aoeInfo.x),
        y = tonumber(aoeInfo.y),
        z = tonumber(aoeInfo.z),
    }, false) or nil
    local effect = type(aoeInfo) == 'table'
            and type(aoeInfo.aoeEffectInfo) == 'table'
            and aoeInfo.aoeEffectInfo.aoeEffectName or nil
    local duration = type(aoeInfo) == 'table'
            and tonumber(aoeInfo.duration) or nil
    local startTime = type(aoeInfo) == 'table'
            and tonumber(aoeInfo.startTime) or nil
    if type(state.round) ~= 'table'
            or state.round.suppressed == true
            or not finite(now)
            or not finite(state.round.startedAt)
    then
        return nil, nil
    end
    local roundAge = now - state.round.startedAt
    if roundAge < ROUTE_GEOMETRY_MIN_MS
            or roundAge > ROUTE_GEOMETRY_MAX_MS
    then
        return nil, 'route_event_outside_window', {
            actionID = actionID,
            age = roundAge,
        }
    end
    if tonumber(aoeInfo.contentID) ~= BOSS_CONTENT_ID
            or not finite(tonumber(aoeInfo.entityID))
            or tonumber(aoeInfo.aoeCastType) ~= spec.castType
            or tonumber(aoeInfo.aoeType) ~= spec.aoeType
            or not finite(tonumber(aoeInfo.aoeLength))
            or math.abs(tonumber(aoeInfo.aoeLength) - spec.radius)
                    > AOE_LENGTH_TOLERANCE
            or not finite(duration)
            or math.abs(duration - spec.duration)
                    > AOE_DURATION_TOLERANCE
            or not finite(startTime)
            or source == nil
            or effect ~= spec.effect
    then
        return nil, 'route_geometry_invalid', {
            actionID = actionID,
            entityID = type(aoeInfo) == 'table' and aoeInfo.entityID or nil,
        }
    end
    return {
        actionID = actionID,
        entityID = tonumber(aoeInfo.entityID),
        source = source,
        startTime = startTime,
        activationAt = startTime + duration * 1000,
        spec = spec,
    }, nil
end

local function sameRouteAOE(left, right)
    local distance = Common.distanceSquared(left.source, right.source)
    return left.actionID == right.actionID
            and left.entityID == right.entityID
            and math.abs(left.startTime - right.startTime) <= 1
            and distance ~= nil
            and distance <= 0.25 * 0.25
end

local function suppressRoute(state, code, now, context)
    if type(state.round) == 'table' then
        state.round.suppressed = true
    end
    state.route = nil
    diagnostic(state, code, now, context)
end

local function copyDanger(entry)
    return {
        kind = entry.spec.kind,
        source = {
            x = entry.source.x,
            y = entry.source.y,
            z = entry.source.z,
        },
        radius = entry.spec.radius,
        innerRadius = entry.spec.innerRadius,
    }
end

local function collectWindDangers(state)
    local entries = {}
    for _, entry in pairs(state.windEntities) do
        if type(entry) == 'table'
                and type(entry.position) == 'table'
                and Common.validXZ(entry.position)
                and type(state.windGeneration) == 'table'
                and entry.generationID == state.windGeneration.id
        then
            entries[#entries + 1] = entry
        end
    end
    table.sort(entries, function(left, right)
        return left.entityID < right.entityID
    end)
    if #entries ~= WIND_COUNT then
        return nil
    end
    local dangers = {}
    for _, entry in ipairs(entries) do
        if not Common.insideCircle(entry.position, ARENA_CENTER, GUIDE_RADIUS + 2) then
            return nil
        end
        dangers[#dangers + 1] = {
            kind = 'circle',
            source = {
                x = entry.position.x,
                y = entry.position.y,
                z = entry.position.z,
            },
            radius = WIND_RADIUS,
            entityID = entry.entityID,
        }
    end
    return dangers
end

local function validateCenters(entries)
    local centers = {}
    for actionID, entry in pairs(entries) do
        local spec = GEOMETRY_SPECS[actionID]
        if spec ~= nil then
            local center = centers[spec.centerIndex]
            if center == nil then
                centers[spec.centerIndex] = entry.source
            else
                local distance = Common.distanceSquared(center, entry.source)
                if distance == nil
                        or distance > CENTER_MATCH_DISTANCE ^ 2
                then
                    return nil
                end
            end
        end
    end
    if #centers ~= 3 then
        return nil
    end
    for left = 1, 2 do
        for right = left + 1, 3 do
            local distanceSquared = Common.distanceSquared(
                    centers[left], centers[right])
            if distanceSquared == nil
                    or distanceSquared < CENTER_MIN_DISTANCE ^ 2
                    or distanceSquared > CENTER_MAX_DISTANCE ^ 2
            then
                return nil
            end
        end
    end
    local areaTwice = math.abs(
            (centers[2].x - centers[1].x)
                    * (centers[3].z - centers[1].z)
            - (centers[2].z - centers[1].z)
                    * (centers[3].x - centers[1].x))
    if areaTwice < 100 then
        return nil
    end
    return centers
end

local function makeCandidates()
    local points = {}
    local byGrid = {}
    local limit = math.floor(GUIDE_RADIUS / GUIDE_GRID_STEP)
    for ix = -limit, limit do
        for iz = -limit, limit do
            local offsetX = ix * GUIDE_GRID_STEP
            local offsetZ = iz * GUIDE_GRID_STEP
            if offsetX * offsetX + offsetZ * offsetZ
                    <= GUIDE_RADIUS * GUIDE_RADIUS
            then
                local point = {
                    x = ARENA_CENTER.x + offsetX,
                    y = ARENA_Y,
                    z = ARENA_CENTER.z + offsetZ,
                    ix = ix,
                    iz = iz,
                }
                points[#points + 1] = point
                byGrid[tostring(ix) .. ':' .. tostring(iz)] = #points
            end
        end
    end
    return points, byGrid
end

local function neighborOffsets(reach)
    local offsets = {}
    local limit = math.floor(reach / GUIDE_GRID_STEP)
    for dx = -limit, limit do
        for dz = -limit, limit do
            local distance = GUIDE_GRID_STEP
                    * math.sqrt(dx * dx + dz * dz)
            if distance <= reach + 0.0001 then
                offsets[#offsets + 1] = {
                    dx = dx,
                    dz = dz,
                    distance = distance,
                }
            end
        end
    end
    return offsets
end

local function maxReachBetween(currentStage, nextStage)
    local gapMs = nextStage.activationAt - currentStage.endAt
            - GUIDE_MOVE_RESERVE_MS
    return math.max(0, gapMs / 1000 * GUIDE_MOVE_SPEED)
end

local function buildRoutePlan(stages)
    local points, byGrid = makeCandidates()
    local costs = {}
    local nextCandidate = {}
    for stageIndex, stage in ipairs(stages) do
        stage.safe = {}
        stage.safeCount = 0
        for candidateIndex, point in ipairs(points) do
            if Common.safeForGroup(
                    point, stage.dangers, ARENA_CENTER,
                    GUIDE_RADIUS, GUIDE_MARGIN)
            then
                stage.safe[candidateIndex] = true
                stage.safeCount = stage.safeCount + 1
            end
        end
        if stage.safeCount == 0 then
            return nil, stageIndex
        end
    end

    local lastIndex = #stages
    costs[lastIndex] = {}
    nextCandidate[lastIndex] = {}
    for candidateIndex = 1, #points do
        costs[lastIndex][candidateIndex] = stages[lastIndex].safe[candidateIndex]
                and 0 or math.huge
    end

    for stageIndex = lastIndex - 1, 1, -1 do
        costs[stageIndex] = {}
        nextCandidate[stageIndex] = {}
        local reach = maxReachBetween(
                stages[stageIndex], stages[stageIndex + 1])
        local offsets = neighborOffsets(reach)
        local feasibleCount = 0
        for candidateIndex, point in ipairs(points) do
            local bestCost = math.huge
            local bestNext = nil
            if stages[stageIndex].safe[candidateIndex] then
                for _, offset in ipairs(offsets) do
                    local key = tostring(point.ix + offset.dx)
                            .. ':' .. tostring(point.iz + offset.dz)
                    local targetIndex = byGrid[key]
                    local futureCost = targetIndex ~= nil
                            and costs[stageIndex + 1][targetIndex] or nil
                    if finite(futureCost) then
                        local total = offset.distance + futureCost
                        if total < bestCost then
                            bestCost = total
                            bestNext = targetIndex
                        end
                    end
                end
            end
            costs[stageIndex][candidateIndex] = bestCost
            nextCandidate[stageIndex][candidateIndex] = bestNext
            if finite(bestCost) then
                feasibleCount = feasibleCount + 1
            end
        end
        if feasibleCount == 0 then
            return nil, stageIndex
        end
    end

    return {
        stages = stages,
        points = points,
        byGrid = byGrid,
        costs = costs,
        nextCandidate = nextCandidate,
        index = 1,
        target = nil,
        resolvedActions = {},
    }, nil
end

local function buildStages(state, round, windDangers)
    local entries = round.entries
    local function withWind(entry)
        local dangers = {}
        for _, danger in ipairs(windDangers) do
            dangers[#dangers + 1] = danger
        end
        dangers[#dangers + 1] = copyDanger(entry)
        return dangers
    end
    local stages = {
        {
            actionID = AID.FirstSteel,
            dangers = withWind(entries[AID.FirstSteel]),
            activationAt = math.min(
                    round.startedAt + FIRST_WIND_AFTER_FREEFALL_MS,
                    entries[AID.FirstSteel].activationAt),
            endAt = entries[AID.FirstSteel].activationAt,
        },
        {
            actionID = AID.FirstInner,
            dangers = { copyDanger(entries[AID.FirstInner]) },
            activationAt = entries[AID.FirstInner].activationAt,
            endAt = entries[AID.FirstInner].activationAt,
        },
        {
            actionID = AID.SecondSteel,
            dangers = { copyDanger(entries[AID.SecondSteel]) },
            activationAt = entries[AID.SecondSteel].activationAt,
            endAt = entries[AID.SecondSteel].activationAt,
        },
        {
            actionID = AID.FirstOuter,
            dangers = { copyDanger(entries[AID.FirstOuter]) },
            activationAt = entries[AID.FirstOuter].activationAt,
            endAt = entries[AID.FirstOuter].activationAt,
        },
        {
            actionID = AID.SecondInner,
            dangers = { copyDanger(entries[AID.SecondInner]) },
            activationAt = entries[AID.SecondInner].activationAt,
            endAt = entries[AID.SecondInner].activationAt,
        },
        {
            actionID = AID.ThirdSteel,
            dangers = { copyDanger(entries[AID.ThirdSteel]) },
            activationAt = entries[AID.ThirdSteel].activationAt,
            endAt = entries[AID.ThirdSteel].activationAt,
        },
        {
            actionID = AID.SecondOuter,
            dangers = { copyDanger(entries[AID.SecondOuter]) },
            activationAt = entries[AID.SecondOuter].activationAt,
            endAt = entries[AID.SecondOuter].activationAt,
        },
        {
            actionID = AID.ThirdInner,
            dangers = { copyDanger(entries[AID.ThirdInner]) },
            activationAt = entries[AID.ThirdInner].activationAt,
            endAt = entries[AID.ThirdInner].activationAt,
        },
        {
            actionID = AID.ThirdOuter,
            dangers = withWind(entries[AID.ThirdOuter]),
            activationAt = math.min(
                    round.startedAt + SECOND_WIND_AFTER_FREEFALL_MS,
                    entries[AID.ThirdOuter].activationAt),
            endAt = entries[AID.ThirdOuter].activationAt,
        },
    }
    for index = 1, #stages - 1 do
        if stages[index + 1].activationAt <= stages[index].endAt then
            return nil
        end
    end
    return stages
end

local function tryFinalizeRoute(state, now)
    local round = state.round
    if type(round) ~= 'table'
            or round.suppressed == true
            or type(state.route) == 'table'
            or round.count ~= 9
    then
        return false
    end
    local batchMin = math.huge
    local batchMax = -math.huge
    for _, entry in pairs(round.entries) do
        batchMin = math.min(batchMin, entry.startTime)
        batchMax = math.max(batchMax, entry.startTime)
    end
    if not finite(batchMin)
            or not finite(batchMax)
            or batchMax - batchMin > BATCH_SPAN_MS
    then
        suppressRoute(state, 'route_batch_mismatch', now, {
            span = batchMax - batchMin,
        })
        return false
    end
    local centers = validateCenters(round.entries)
    if centers == nil then
        suppressRoute(state, 'route_centers_invalid', now, nil)
        return false
    end
    local windDangers = collectWindDangers(state)
    if windDangers == nil then
        diagnostic(state, 'route_winds_incomplete', now, {
            count = countTable(state.windEntities),
        })
        return false
    end
    local stages = buildStages(state, round, windDangers)
    if stages == nil then
        suppressRoute(state, 'route_centers_invalid', now, 'activation_order')
        return false
    end
    local route, failedStage = buildRoutePlan(stages)
    if route == nil then
        suppressRoute(state, 'route_plan_unavailable', now, failedStage)
        return false
    end
    route.startedAt = round.startedAt
    route.batchAt = batchMin
    route.expiresAt = round.startedAt + ROUTE_TIMEOUT_MS
    route.centers = centers
    route.windDangers = windDangers
    state.route = route
    state.lastDiagnostic = nil
    return true
end

local function handleRouteAOE(state, aoeInfo, now)
    local entry, code, context = readRouteAOE(state, aoeInfo, now)
    if entry == nil then
        if code ~= nil then
            suppressRoute(state, code, now, context)
        end
        return false
    end
    local existing = state.round.entries[entry.actionID]
    if type(existing) == 'table' then
        if sameRouteAOE(existing, entry) then
            return false
        end
        suppressRoute(state, 'route_geometry_conflict', now, {
            actionID = entry.actionID,
        })
        return false
    end
    state.round.entries[entry.actionID] = entry
    state.round.count = state.round.count + 1
    return tryFinalizeRoute(state, now) or true
end

local function advanceRoute(state, actionID, now)
    local route = state.route
    if type(route) ~= 'table' or GEOMETRY_SPECS[actionID] == nil then
        return false
    end
    if route.resolvedActions[actionID] == true then
        return false
    end
    local stage = route.stages[route.index]
    if type(stage) ~= 'table' or stage.actionID ~= actionID then
        suppressRoute(state, 'route_resolution_out_of_order', now, {
            expected = type(stage) == 'table' and stage.actionID or nil,
            actual = actionID,
        })
        return false
    end
    route.resolvedActions[actionID] = true
    route.index = route.index + 1
    route.target = nil
    if route.index > #route.stages then
        state.route = nil
        state.round = nil
    end
    return true
end

local function selectGuideTarget(route, playerPosition)
    if type(route) ~= 'table'
            or not Common.validXZ(playerPosition)
            or type(route.stages[route.index]) ~= 'table'
    then
        return nil
    end
    local cached = route.target
    if type(cached) == 'table'
            and cached.stageIndex == route.index
            and finite(route.costs[route.index][cached.candidateIndex])
    then
        return route.points[cached.candidateIndex], cached.candidateIndex
    end
    local bestIndex = nil
    local bestScore = math.huge
    local bestInitialDistance = math.huge
    for candidateIndex, futureCost in ipairs(route.costs[route.index]) do
        if finite(futureCost) then
            local point = route.points[candidateIndex]
            local distanceSquared = Common.distanceSquared(playerPosition, point)
            if distanceSquared ~= nil then
                local initialDistance = math.sqrt(distanceSquared)
                local score = initialDistance + futureCost
                if score < bestScore - 0.0001
                        or (math.abs(score - bestScore) <= 0.0001
                            and initialDistance < bestInitialDistance)
                then
                    bestIndex = candidateIndex
                    bestScore = score
                    bestInitialDistance = initialDistance
                end
            end
        end
    end
    if bestIndex == nil then
        return nil
    end
    route.target = {
        stageIndex = route.index,
        candidateIndex = bestIndex,
        totalDistance = bestScore,
    }
    return route.points[bestIndex], bestIndex
end

local function drawDynamicGuide(state, guide, now)
    local route = state.route
    if type(route) ~= 'table' then
        return false
    end
    if type(guide) ~= 'table'
            or type(guide.FrameDirect) ~= 'function'
    then
        diagnostic(state, 'guide_unavailable', now, nil)
        return false
    end
    local player = type(Context.getPlayer) == 'function'
            and Context.getPlayer(guide) or nil
    if type(player) ~= 'table' or not Common.validXZ(player.pos) then
        diagnostic(state, 'guide_player_unavailable', now, nil)
        return false
    end
    local target = selectGuideTarget(route, player.pos)
    if target == nil then
        diagnostic(state, 'guide_target_unavailable', now, route.index)
        return false
    end
    local color = type(guide.Config) == 'table'
            and type(guide.Config.Main) == 'table'
            and guide.Config.Main.GuideColor
            or { r = 0, g = 1, b = 1, a = 0.5 }
    guide.FrameDirect(target.x, target.z, 0.7, color)
    return true
end

local function pruneState(state, cfg, now)
    state = ensureState(state)
    if not finite(now) then
        return false
    end
    local changed = false
    local pendingIDs = {}
    for entityID in pairs(state.pendingWindEntities) do
        pendingIDs[#pendingIDs + 1] = entityID
    end
    for _, entityID in ipairs(pendingIDs) do
        local pending = state.pendingWindEntities[entityID]
        if type(pending) == 'table' then
            local resolved, complete = resolveWindEntity(
                    state,
                    pending.entityID,
                    pending.contentID,
                    pending.addedAt,
                    now,
                    cfg)
            changed = resolved or changed
            if complete == true
                    or now - pending.addedAt > PENDING_ENTITY_RESOLVE_MS
            then
                state.pendingWindEntities[entityID] = nil
            end
        else
            state.pendingWindEntities[entityID] = nil
        end
    end
    local predictionIDs = {}
    for entityID, prediction in pairs(state.windPredictions) do
        if type(prediction) ~= 'table'
                or not finite(prediction.expiresAt)
                or now > prediction.expiresAt
        then
            predictionIDs[#predictionIDs + 1] = entityID
        end
    end
    for _, entityID in ipairs(predictionIDs) do
        deleteWindPrediction(state, entityID)
        changed = true
    end
    if type(state.round) == 'table'
            and state.round.count == 9
            and state.round.suppressed ~= true
            and state.route == nil
    then
        changed = tryFinalizeRoute(state, now) or changed
        if state.route == nil
                and now - state.round.startedAt > ROUTE_FINALIZE_GRACE_MS
        then
            suppressRoute(state, 'route_winds_incomplete', now, {
                count = countTable(state.windEntities),
            })
        end
    end
    if type(state.route) == 'table'
            and (not finite(state.route.expiresAt)
                or now > state.route.expiresAt)
    then
        clearRoute(state)
        changed = true
    elseif type(state.round) == 'table'
            and finite(state.round.startedAt)
            and now - state.round.startedAt > ROUTE_TIMEOUT_MS
    then
        clearRoute(state)
        changed = true
    end
    return changed
end

local Feature = {}

Feature.Init = function(M)
    if type(M.GaleGriffin) == 'table' then
        clearState(M.GaleGriffin)
    end
    M.GaleGriffin = newState()
    getConfig(M)
    M.SetGaleGriffinEnabled = function(enabled)
        local cfg = getConfig(M)
        if cfg ~= nil then
            cfg.Enable = enabled == true
        end
        if enabled ~= true then
            clearState(M.GaleGriffin)
        end
    end
    M.SetGaleGriffinWindPredictionEnabled = function(enabled)
        local cfg = getConfig(M)
        if cfg ~= nil then
            cfg.DrawWindOrbPrediction = enabled == true
        end
        if enabled ~= true then
            clearWindPredictions(M.GaleGriffin)
        end
    end
    M.SetGaleGriffinDynamicGuideEnabled = function(enabled)
        local cfg = getConfig(M)
        if cfg ~= nil then
            cfg.DynamicGuide = enabled == true
        end
        if enabled ~= true then
            clearRoute(M.GaleGriffin)
        end
    end
end

Feature.Clear = function()
    local state = getState()
    if state ~= nil then
        clearState(state)
    end
end

Feature.OnEntityChannel = function(
        entityID, actionID, channelTimeMax, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state == nil or cfg == nil or cfg.Enable ~= true then
        return false
    end
    if actionID == AID.CallStorm
            and (cfg.DrawWindOrbPrediction == true
                or cfg.DynamicGuide == true)
    then
        return beginWindGeneration(
                state, entityID, channelTimeMax, now)
    end
    if actionID == AID.FreeFall and cfg.DynamicGuide == true then
        return beginRouteRound(
                state, entityID, channelTimeMax, now)
    end
    return false
end

Feature.OnEntityAdd = function(entityID, contentID, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state ~= nil and cfg ~= nil and cfg.Enable == true
            and (cfg.DrawWindOrbPrediction == true
                or cfg.DynamicGuide == true)
    then
        return handleWindEntityAdd(
                state, entityID, contentID, now, cfg)
    end
    return false
end

Feature.OnVisibilityChange = function(entityID, isVisible, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state ~= nil and cfg ~= nil and cfg.Enable == true
            and (cfg.DrawWindOrbPrediction == true
                or cfg.DynamicGuide == true)
    then
        return handleWindVisibility(
                state, entityID, isVisible, now, cfg)
    end
    return false
end

Feature.OnAOECreate = function(aoeInfo, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state == nil or cfg == nil or cfg.Enable ~= true then
        return false
    end
    local actionID = type(aoeInfo) == 'table'
            and tonumber(aoeInfo.aoeID) or nil
    if actionID == AID.WindPressure
            and cfg.DrawWindOrbPrediction == true
    then
        return handoffWindPrediction(state, aoeInfo, now)
    end
    if GEOMETRY_SPECS[actionID] ~= nil and cfg.DynamicGuide == true then
        return handleRouteAOE(state, aoeInfo, now)
    end
    return false
end

Feature.OnEntityCast = function(entityID, actionID, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state == nil or cfg == nil or cfg.Enable ~= true then
        return false
    end
    if actionID == AID.WindPressure then
        return handleWindCast(state, entityID, now, cfg)
    end
    if cfg.DynamicGuide == true then
        return advanceRoute(state, actionID, now)
    end
    return false
end

Feature.Update = function(guide, now)
    local state = getState()
    if state == nil then
        return false
    end
    local cfg = getConfig(guide)
    if cfg == nil or cfg.Enable ~= true then
        clearState(state)
        return false
    end
    pruneState(state, cfg, now)
    if cfg.DynamicGuide == true then
        return drawDynamicGuide(state, guide, now)
    end
    return false
end

Feature.Test = {
    Defaults = DEFAULTS,
    BossContentID = BOSS_CONTENT_ID,
    BossModelID = BOSS_MODEL_ID,
    HelperModelID = HELPER_MODEL_ID,
    WindContentID = WIND_CONTENT_ID,
    WindModelID = WIND_MODEL_ID,
    WindRadius = WIND_RADIUS,
    WindCount = WIND_COUNT,
    WindPredictionTimeoutMs = WIND_PREDICTION_TIMEOUT_MS,
    WindPredictedFollowupCount = WIND_PREDICTED_FOLLOWUP_COUNT,
    ArenaCenter = ARENA_CENTER,
    GuideRadius = GUIDE_RADIUS,
    GuideGridStep = GUIDE_GRID_STEP,
    GuideMargin = GUIDE_MARGIN,
    GuideMoveSpeed = GUIDE_MOVE_SPEED,
    GuideMoveReserveMs = GUIDE_MOVE_RESERVE_MS,
    AID = AID,
    GeometrySpecs = GEOMETRY_SPECS,
    StageActions = STAGE_ACTIONS,
    NewState = newState,
    EnsureState = ensureState,
    BeginWindGeneration = beginWindGeneration,
    HandleWindEntityAdd = handleWindEntityAdd,
    ValidateWindAOE = validateWindAOE,
    HandleWindCast = handleWindCast,
    BeginRouteRound = beginRouteRound,
    ReadRouteAOE = readRouteAOE,
    HandleRouteAOE = handleRouteAOE,
    BuildRoutePlan = buildRoutePlan,
    MaxReachBetween = maxReachBetween,
    SelectGuideTarget = selectGuideTarget,
    AdvanceRoute = advanceRoute,
    PruneState = pruneState,
    ClearState = clearState,
}

return Feature
end

rawset(_G, 'MuAiOccultCrescentNorthGaleGriffin', Module)
return Module
