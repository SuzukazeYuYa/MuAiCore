local Module = {}

function Module.Create(Context)
    assert(type(Context) == 'table' and type(Context.Common) == 'table')
    local Common = Context.Common
    local finite = Context.finite
    local reliablePosition = Context.reliablePosition

local GREEN_HEAD_CONTENT_ID = 14490
local BLUE_HEAD_CONTENT_ID = 14491
local GREEN_HEAD_MODEL_ID = 19481
local BLUE_HEAD_MODEL_ID = 19482
local THUNDER_ORB_CONTENT_ID = 14492
local ICE_ORB_CONTENT_ID = 14493
local THUNDER_ORB_MODEL_ID = 19478
local ICE_ORB_MODEL_ID = 19479
local CLUSTER_HELPER_MODEL_ID = 9020

local THUNDER_CLUSTER_AID = 50697
local ICE_CLUSTER_AID = 50698
local THUNDERFROST_STORM_AID = 47735
local THUNDER_EXPLOSION_AID = 47706
local ICE_EXPLOSION_AID = 47707
local FULGUROUS_FUGUE_DONUT_AIDS = { [47629] = true, [50727] = true }
local FREZELD_FUGUE_CIRCLE_AIDS = { [47630] = true, [50728] = true }
local FUGUE_RADIUS = 20
local FUGUE_DONUT_INNER_RADIUS = 18
local FUGUE_DONUT_OUTER_RADIUS = 60
local BLAZE_ANNOUNCE = {
    [47671] = { 'cross', 'cross' },
    [47672] = { 'donut', 'donut' },
    [47673] = { 'cross', 'donut' },
    [47674] = { 'donut', 'cross' },
    [47675] = { 'cross', 'cross' },
    [47676] = { 'donut', 'donut' },
    [47677] = { 'cross', 'donut' },
    [47678] = { 'donut', 'cross' },
}
local BLAZE_HELPER_STEP = { [50706] = 1, [50707] = 1, [50708] = 2 }
local BLAZE_RESOLVE_AIDS = {
    [47685] = true, [47686] = true, [47687] = true, [47688] = true,
}
local DUET_MARKER_AIDS = { [50699] = true, [50700] = true }
local DUET_RESOLVE_AIDS = {
    [47649] = true, [47650] = true,
    [47651] = true, [47652] = true,
    [50701] = true, [50702] = true,
}
local BLAZE_CROSS_LENGTH = 100
local BLAZE_CROSS_WIDTH = 10
local BLAZE_DONUT_INNER = 5
local BLAZE_DONUT_OUTER = 45
local DUET_CLUSTER_RADIUS = 15
local EXTREME_SHAPE_TTL_MS = 30000
local BLAZE_HEAD_RESOLVE_MS = 1000

local ORB_COUNT = 4
local ORB_RADIUS = 15
local ORB_SELECTION_DISTANCE_SQ = ORB_RADIUS * ORB_RADIUS
local FIRST_WAVE_TIMEOUT_MS = 10500
local SECOND_WAVE_TIMEOUT_MS = 7800
local ROUND_TIMEOUT_MS = 15000
local ORB_TTL_MS = 30000
local CLUSTER_RESOLVE_DEADLINE_MS = FIRST_WAVE_TIMEOUT_MS
local BLACKLIST_SOURCE = 'MuAiCore - 双头怪鸟冰雷球连锁预测'

local CLUSTER_KIND = {
    [THUNDER_CLUSTER_AID] = 'thunder',
    [ICE_CLUSTER_AID] = 'ice',
}

local ORB_SPEC = {
    thunder = {
        contentID = THUNDER_ORB_CONTENT_ID,
        modelID = THUNDER_ORB_MODEL_ID,
    },
    ice = {
        contentID = ICE_ORB_CONTENT_ID,
        modelID = ICE_ORB_MODEL_ID,
    },
}

local EXPLOSION_AIDS = {
    [THUNDER_EXPLOSION_AID] = true,
    [ICE_EXPLOSION_AID] = true,
}

local OWNED_AIDS = {}
for actionID in pairs(EXPLOSION_AIDS) do OWNED_AIDS[actionID] = true end
for actionID in pairs(BLAZE_RESOLVE_AIDS) do OWNED_AIDS[actionID] = true end
for actionID in pairs(DUET_MARKER_AIDS) do OWNED_AIDS[actionID] = true end
for actionID in pairs(DUET_RESOLVE_AIDS) do OWNED_AIDS[actionID] = true end

local DEFAULTS = {
    Enable = true,
}

local function newState()
    return {
        orbs = {},
        pendingClusters = {},
        round = nil,
        active = {},
        blazeOrders = {},
        pendingBlazeAnnouncements = {},
        blazeSeen = {},
        extremeShapes = {},
        blacklist = { owned = {}, registered = false },
        lastDiagnostic = nil,
    }
end

local function ensureState(state)
    state = type(state) == 'table' and state or newState()
    state.orbs = type(state.orbs) == 'table' and state.orbs or {}
    state.pendingClusters = type(state.pendingClusters) == 'table'
            and state.pendingClusters or {}
    state.active = type(state.active) == 'table' and state.active or {}
    state.blazeOrders = type(state.blazeOrders) == 'table'
            and state.blazeOrders or {}
    state.pendingBlazeAnnouncements =
            type(state.pendingBlazeAnnouncements) == 'table'
            and state.pendingBlazeAnnouncements or {}
    state.blazeSeen = type(state.blazeSeen) == 'table'
            and state.blazeSeen or {}
    state.extremeShapes = type(state.extremeShapes) == 'table'
            and state.extremeShapes or {}
    state.blacklist = type(state.blacklist) == 'table'
            and state.blacklist or {}
    state.blacklist.owned = type(state.blacklist.owned) == 'table'
            and state.blacklist.owned or {}
    state.blacklist.registered = state.blacklist.registered == true
    return state
end

local feature = Common.newFeature({
    key = 'TwoHeadedAevis',
    defaults = DEFAULTS,
    newState = newState,
    ensureState = ensureState,
    diagnosticThrottleMs = 1000,
    diagnosticText = {
        orb_count_invalid = '双头怪鸟冰雷球数量不完整，跳过本轮预测',
        orb_geometry_invalid = '双头怪鸟冰雷球实体几何不可用',
        cluster_geometry_invalid = '双头怪鸟冰雷簇缺少可靠几何',
        fugue_geometry_invalid = '双头怪鸟极乐章危险范围缺少可靠事件几何',
        blaze_head_invalid = '双头怪鸟冰焰连招本体身份不可用',
        blaze_order_missing = '双头怪鸟冰焰连招缺少对应预告顺序',
        blaze_geometry_invalid = '双头怪鸟冰焰连招辅助事件几何无效',
        duet_geometry_invalid = '双头怪鸟吐息二重奏冰雷簇几何无效',
        danger_drawer_unavailable = '双头怪鸟危险范围绘图器不可用',
        danger_drawer_rejected_shape = '双头怪鸟危险范围绘制失败',
    },
})
local getConfig = feature.GetConfig

local function getState()
    return Common.getRuntimeState(
            'TwoHeadedAevis', newState, ensureState)
end

local function diagnostic(state, code, now, context)
    feature.Diagnostic(
            state, rawget(_G, 'MuAiGuide'), code, now, context)
end

local function getBlacklist(create)
    return Common.getMoogleTable('aoeIDUserBlacklist', create)
end

local function ownsBlacklist(state, actionID, current)
    return current ~= nil
            and (current == state.blacklist.owned[actionID]
            or (type(current) == 'table'
                    and current.source == BLACKLIST_SOURCE))
end

local function registerBlacklist(state)
    state = ensureState(state)
    local blacklist = getBlacklist(true)
    if blacklist == nil then
        state.blacklist.registered = false
        return false
    end
    for actionID in pairs(OWNED_AIDS) do
        local current = blacklist[actionID]
        if current == nil then
            local owned = {
                label = '双头怪鸟机制提前预测',
                source = BLACKLIST_SOURCE,
            }
            blacklist[actionID] = owned
            state.blacklist.owned[actionID] = owned
        elseif type(current) == 'table'
                and current.source == BLACKLIST_SOURCE
        then
            state.blacklist.owned[actionID] = current
        else
            state.blacklist.owned[actionID] = nil
        end
    end
    state.blacklist.registered = true
    return true
end

local function unregisterBlacklist(state)
    state = ensureState(state)
    local blacklist = getBlacklist(false)
    if blacklist == nil then
        state.blacklist.registered = false
        return false
    end
    for actionID in pairs(OWNED_AIDS) do
        local current = blacklist[actionID]
        if ownsBlacklist(state, actionID, current) then
            blacklist[actionID] = nil
        end
    end
    state.blacklist.owned = {}
    state.blacklist.registered = false
    return true
end

local function applyBlacklist(state, enabled)
    if enabled == true then
        return registerBlacklist(state)
    end
    return unregisterBlacklist(state)
end

local function deleteActive(state, entityID)
    local entry = type(state) == 'table'
            and type(state.active) == 'table'
            and state.active[entityID] or nil
    if type(entry) ~= 'table' then
        return false
    end
    Common.deleteTimedShape(entry.token)
    state.active[entityID] = nil
    return true
end

local function clearMechanic(state)
    state = ensureState(state)
    local ids = {}
    for entityID in pairs(state.active) do
        ids[#ids + 1] = entityID
    end
    for _, entityID in ipairs(ids) do
        deleteActive(state, entityID)
    end
    for _, active in ipairs(state.extremeShapes) do
        Common.deleteTimedShape(active.token)
    end
    state.orbs = {}
    state.pendingClusters = {}
    state.round = nil
    state.blazeOrders = {}
    state.pendingBlazeAnnouncements = {}
    state.blazeSeen = {}
    state.extremeShapes = {}
    state.lastDiagnostic = nil
end

local function resolveHeadContent(entityID)
    if not finite(entityID) then
        return nil
    end
    local tensorCore = rawget(_G, 'TensorCore')
    if type(tensorCore) ~= 'table'
            or type(tensorCore.entityList) ~= 'function'
    then
        return nil
    end
    local modelByContent = {
        [GREEN_HEAD_CONTENT_ID] = GREEN_HEAD_MODEL_ID,
        [BLUE_HEAD_CONTENT_ID] = BLUE_HEAD_MODEL_ID,
    }
    for contentID, modelID in pairs(modelByContent) do
        local entities = tensorCore.entityList(
                'contentid=' .. tostring(contentID))
        if type(entities) == 'table' then
            for _, entity in pairs(entities) do
                if type(entity) == 'table'
                        and tonumber(entity.id) == entityID
                        and tonumber(entity.contentid) == contentID
                        and Common.entityModelID(entity) == modelID
                        and entity.alive ~= false
                then
                    return contentID
                end
            end
        end
    end
    return nil
end

local function acceptBlazeAnnouncement(state, entityID, actionID, now)
    local sequence = BLAZE_ANNOUNCE[tonumber(actionID)]
    if sequence == nil or not finite(now) then
        return false
    end
    local contentID = resolveHeadContent(entityID)
    if contentID == nil then
        diagnostic(state, 'blaze_head_invalid', now, entityID)
        return false
    end
    state.blazeOrders[contentID] = {
        sequence = { sequence[1], sequence[2] },
        recordedAt = now,
    }
    state.lastDiagnostic = nil
    return true
end

local function recordBlazeAnnouncement(state, entityID, actionID, now)
    state = ensureState(state)
    entityID = tonumber(entityID)
    actionID = tonumber(actionID)
    if BLAZE_ANNOUNCE[actionID] == nil
            or not finite(entityID) or entityID <= 0
            or not finite(now)
    then
        return false
    end
    if resolveHeadContent(entityID) ~= nil then
        state.pendingBlazeAnnouncements[entityID] = nil
        return acceptBlazeAnnouncement(state, entityID, actionID, now)
    end
    local current = state.pendingBlazeAnnouncements[entityID]
    if type(current) == 'table' and current.actionID == actionID then
        return false
    end
    state.pendingBlazeAnnouncements[entityID] = {
        actionID = actionID,
        observedAt = now,
    }
    return true
end

local function resolvePendingBlazeAnnouncements(state, now)
    state = ensureState(state)
    if not finite(now) then
        return false
    end
    local entityIDs = {}
    for entityID in pairs(state.pendingBlazeAnnouncements) do
        entityIDs[#entityIDs + 1] = entityID
    end
    table.sort(entityIDs)
    local resolvedAny = false
    for _, entityID in ipairs(entityIDs) do
        local pending = state.pendingBlazeAnnouncements[entityID]
        if type(pending) ~= 'table'
                or BLAZE_ANNOUNCE[pending.actionID] == nil
                or not finite(pending.observedAt)
        then
            state.pendingBlazeAnnouncements[entityID] = nil
            diagnostic(state, 'blaze_head_invalid', now, entityID)
        elseif resolveHeadContent(entityID) ~= nil then
            state.pendingBlazeAnnouncements[entityID] = nil
            if acceptBlazeAnnouncement(
                    state, entityID, pending.actionID, pending.observedAt)
            then
                resolvedAny = true
            end
        elseif now - pending.observedAt >= BLAZE_HEAD_RESOLVE_MS then
            state.pendingBlazeAnnouncements[entityID] = nil
            diagnostic(state, 'blaze_head_invalid', now, entityID)
        end
    end
    return resolvedAny
end

local function trackExtremeShape(state, token, expiresAt)
    if type(token) ~= 'string' then
        return false
    end
    state.extremeShapes[#state.extremeShapes + 1] = {
        token = token,
        expiresAt = expiresAt,
    }
    return true
end

local function extremeEventKey(aoeInfo)
    return tostring(aoeInfo.entityID) .. ':'
            .. tostring(aoeInfo.aoeID) .. ':'
            .. tostring(math.floor((tonumber(aoeInfo.startTime) or 0) + 0.5))
end

local function drawExtremeAOE(state, aoeInfo, now)
    local actionID = type(aoeInfo) == 'table'
            and tonumber(aoeInfo.aoeID) or nil
    local blazeStep = BLAZE_HELPER_STEP[actionID]
    local duet = DUET_MARKER_AIDS[actionID] == true
    if blazeStep == nil and not duet then
        return false
    end
    local contentID = tonumber(aoeInfo.contentID)
    local position = reliablePosition({
        x = tonumber(aoeInfo.x),
        y = tonumber(aoeInfo.y),
        z = tonumber(aoeInfo.z),
    }, false)
    local duration = tonumber(aoeInfo.duration)
    if position == nil or not finite(duration)
            or duration <= 0 or duration > 30 or not finite(now)
            or (contentID ~= GREEN_HEAD_CONTENT_ID
                    and contentID ~= BLUE_HEAD_CONTENT_ID)
    then
        diagnostic(state, duet and 'duet_geometry_invalid'
                or 'blaze_geometry_invalid', now, actionID)
        return false
    end
    local key = extremeEventKey(aoeInfo)
    if state.blazeSeen[key] ~= nil then
        return false
    end
    local drawer = Common.getMoogleDrawer()
    local timeout = math.floor(duration * 1000 + 0.5)
    local token
    if duet then
        if type(drawer) == 'table'
                and type(drawer.addTimedCircle) == 'function'
                and math.abs((tonumber(aoeInfo.aoeLength) or 0)
                        - DUET_CLUSTER_RADIUS) <= 0.25
        then
            token = drawer:addTimedCircle(
                    timeout, position.x, position.y, position.z,
                    DUET_CLUSTER_RADIUS, 0)
        else
            diagnostic(state, 'duet_geometry_invalid', now, actionID)
            return false
        end
    else
        local order = state.blazeOrders[contentID]
        local kind = type(order) == 'table'
                and type(order.sequence) == 'table'
                and order.sequence[blazeStep] or nil
        if kind == 'cross'
                and type(drawer) == 'table'
                and type(drawer.addTimedCross) == 'function'
        then
            token = drawer:addTimedCross(
                    timeout, position.x, position.y, position.z,
                    BLAZE_CROSS_LENGTH, BLAZE_CROSS_WIDTH,
                    tonumber(aoeInfo.heading) or 0, 0)
        elseif kind == 'donut'
                and type(drawer) == 'table'
                and type(drawer.addTimedDonut) == 'function'
        then
            token = drawer:addTimedDonut(
                    timeout, position.x, position.y, position.z,
                    BLAZE_DONUT_INNER, BLAZE_DONUT_OUTER, 0)
        elseif kind == nil then
            diagnostic(state, 'blaze_order_missing', now, {
                actionID = actionID, contentID = contentID,
            })
            return false
        else
            diagnostic(state, 'danger_drawer_unavailable', now, actionID)
            return false
        end
        if blazeStep == 2 then
            state.blazeOrders[contentID] = nil
        end
    end
    if not trackExtremeShape(state, token, now + timeout) then
        diagnostic(state, 'danger_drawer_rejected_shape', now, actionID)
        return false
    end
    state.blazeSeen[key] = now
    state.lastDiagnostic = nil
    return true
end

local function orbKind(contentID)
    if contentID == THUNDER_ORB_CONTENT_ID then
        return 'thunder'
    end
    if contentID == ICE_ORB_CONTENT_ID then
        return 'ice'
    end
    return nil
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
    if type(entities) ~= 'table' then
        return nil
    end
    return entities
end

local function entityModelID(entityID, entity)
    return Common.entityModelID(entity or entityID)
end

local function recordOrb(state, entityID, contentID, now)
    state = ensureState(state)
    local kind = orbKind(contentID)
    if kind == nil or not finite(entityID) or not finite(now) then
        return false
    end
    state.orbs[entityID] = {
        kind = kind,
        addedAt = now,
    }
    return true
end

local function snapshotRound(state, now)
    local pending = {}
    local count = 0
    local positions = {}
    local neededKinds = {}
    for entityID, tracked in pairs(state.orbs) do
        if type(tracked) ~= 'table'
                or ORB_SPEC[tracked.kind] == nil
        then
            return nil, 'orb_geometry_invalid', entityID
        end
        neededKinds[tracked.kind] = true
    end
    for kind in pairs(neededKinds) do
        local spec = ORB_SPEC[kind]
        local entities = entitiesByContent(spec.contentID)
        if entities == nil then
            return nil, 'orb_geometry_invalid', spec.contentID
        end
        for _, entity in pairs(entities) do
            local entityID = type(entity) == 'table'
                    and tonumber(entity.id) or nil
            local tracked = entityID ~= nil and state.orbs[entityID] or nil
            if type(tracked) == 'table' and tracked.kind == kind then
                if tonumber(entity.contentid) ~= spec.contentID
                        or entityModelID(entityID, entity) ~= spec.modelID
                        or entity.alive == false
                then
                    return nil, 'orb_geometry_invalid', entityID
                end
                local position = reliablePosition(entity.pos, false)
                if position == nil then
                    return nil, 'orb_geometry_invalid', entityID
                end
                positions[entityID] = position
            end
        end
    end
    for entityID, tracked in pairs(state.orbs) do
        local position = positions[entityID]
        if position == nil then
            return nil, 'orb_geometry_invalid', entityID
        end
        count = count + 1
        pending[entityID] = {
            kind = tracked.kind,
            pos = position,
        }
    end
    if count ~= ORB_COUNT then
        return nil, 'orb_count_invalid', count
    end
    return {
        startedAt = now,
        helpers = {},
        pending = pending,
    }
end

local function drawEntries(state, entries, timeoutMs, now)
    if #entries == 0 then
        return true
    end
    local drawer = Common.getMoogleDrawer()
    if drawer == nil or type(drawer.addTimedCircle) ~= 'function' then
        diagnostic(state, 'danger_drawer_unavailable', now)
        return false
    end
    local created = {}
    for _, entry in ipairs(entries) do
        local token = drawer:addTimedCircle(
                timeoutMs,
                entry.pos.x,
                entry.pos.y,
                entry.pos.z,
                ORB_RADIUS,
                0)
        if type(token) ~= 'string' then
            for _, rollback in ipairs(created) do
                Common.deleteTimedShape(rollback.token)
            end
            diagnostic(state, 'danger_drawer_rejected_shape', now)
            return false
        end
        created[#created + 1] = {
            entityID = entry.entityID,
            token = token,
        }
    end
    for _, createdEntry in ipairs(created) do
        deleteActive(state, createdEntry.entityID)
        state.active[createdEntry.entityID] = {
            token = createdEntry.token,
            expiresAt = now + timeoutMs,
        }
    end
    return true
end

local function clusterPosition(entityID, actionID)
    local kind = CLUSTER_KIND[actionID]
    local expectedContentID = kind == 'thunder'
            and GREEN_HEAD_CONTENT_ID or BLUE_HEAD_CONTENT_ID
    local entities = entitiesByContent(expectedContentID)
    if entities == nil then
        return nil
    end
    for _, entity in pairs(entities) do
        if type(entity) == 'table'
                and tonumber(entity.id) == entityID
                and tonumber(entity.contentid) == expectedContentID
                and entityModelID(entityID, entity)
                        == CLUSTER_HELPER_MODEL_ID
                and entity.alive ~= false
        then
            return reliablePosition(entity.pos, false)
        end
    end
    return nil
end

local function handleCluster(
        state, entityID, actionID, center, signalAt, now)
    state = ensureState(state)
    local kind = CLUSTER_KIND[actionID]
    if kind == nil
            or not Common.validXZ(center)
            or not finite(signalAt)
            or not finite(now)
    then
        return false
    end
    if type(state.round) ~= 'table'
            or not finite(state.round.startedAt)
            or now - state.round.startedAt > ROUND_TIMEOUT_MS
    then
        local round, code, context = snapshotRound(state, signalAt)
        if round == nil then
            clearMechanic(state)
            diagnostic(state, code, now, context)
            return false
        end
        state.round = round
    end
    local round = state.round
    if round.helpers[actionID] == true then
        return false
    end
    local selected = {}
    for orbID, orb in pairs(round.pending) do
        if orb.kind == kind then
            local dx = orb.pos.x - center.x
            local dz = orb.pos.z - center.z
            if dx * dx + dz * dz <= ORB_SELECTION_DISTANCE_SQ then
                selected[#selected + 1] = {
                    entityID = orbID,
                    pos = orb.pos,
                }
            end
        end
    end
    table.sort(selected, function(a, b)
        return a.entityID < b.entityID
    end)
    local remaining = math.floor(
            signalAt + FIRST_WAVE_TIMEOUT_MS - now + 0.5)
    if remaining <= 0 then
        clearMechanic(state)
        diagnostic(state, 'cluster_geometry_invalid', now, {
            entityID = entityID,
            actionID = actionID,
        })
        return false
    end
    if not drawEntries(state, selected, remaining, now) then
        local failure = state.lastDiagnostic
        clearMechanic(state)
        state.lastDiagnostic = failure
        return false
    end
    for _, entry in ipairs(selected) do
        round.pending[entry.entityID] = nil
    end
    round.helpers[actionID] = true
    state.lastDiagnostic = nil
    return #selected > 0
end

local function queueCluster(state, entityID, actionID, now)
    state = ensureState(state)
    if CLUSTER_KIND[actionID] == nil
            or not finite(entityID)
            or entityID <= 0
            or not finite(now)
    then
        return false
    end
    local current = state.pendingClusters[entityID]
    if type(current) == 'table' and current.actionID == actionID then
        return false
    end
    state.pendingClusters[entityID] = {
        actionID = actionID,
        recordedAt = now,
    }
    return true
end

local function resolvePendingClusters(state, now)
    state = ensureState(state)
    local entityIDs = {}
    for entityID in pairs(state.pendingClusters) do
        entityIDs[#entityIDs + 1] = entityID
    end
    table.sort(entityIDs)
    local resolvedAny = false
    for _, entityID in ipairs(entityIDs) do
        local pending = state.pendingClusters[entityID]
        if type(pending) ~= 'table'
                or CLUSTER_KIND[pending.actionID] == nil
                or not finite(pending.recordedAt)
        then
            clearMechanic(state)
            diagnostic(state, 'cluster_geometry_invalid', now, {
                entityID = entityID,
                actionID = type(pending) == 'table'
                        and pending.actionID or nil,
            })
            return false
        end
        local deadlineAt = pending.recordedAt
                + CLUSTER_RESOLVE_DEADLINE_MS
        local center = now < deadlineAt
                and clusterPosition(entityID, pending.actionID) or nil
        if center ~= nil then
            state.pendingClusters[entityID] = nil
            handleCluster(
                    state, entityID, pending.actionID,
                    center, pending.recordedAt, now)
            if state.lastDiagnostic ~= nil then
                return false
            end
            resolvedAny = true
        elseif now >= deadlineAt then
            local context = {
                entityID = entityID,
                actionID = pending.actionID,
            }
            clearMechanic(state)
            diagnostic(state, 'cluster_geometry_invalid', now, context)
            return false
        end
    end
    return resolvedAny
end

local function handleStorm(state, entityID, now)
    state = ensureState(state)
    local round = state.round
    if type(round) ~= 'table'
            or not finite(round.startedAt)
            or not finite(entityID)
            or not finite(now)
            or now - round.startedAt > ROUND_TIMEOUT_MS
    then
        return false
    end
    local remaining = {}
    for orbID, orb in pairs(round.pending) do
        local position = type(orb) == 'table'
                and reliablePosition(orb.pos, false) or nil
        if position == nil then
            clearMechanic(state)
            diagnostic(state, 'orb_geometry_invalid', now, orbID)
            return false
        end
        remaining[#remaining + 1] = {
            entityID = orbID,
            pos = position,
        }
    end
    table.sort(remaining, function(a, b)
        return a.entityID < b.entityID
    end)
    if not drawEntries(state, remaining, SECOND_WAVE_TIMEOUT_MS, now) then
        local failure = state.lastDiagnostic
        clearMechanic(state)
        state.lastDiagnostic = failure
        return false
    end
    state.orbs = {}
    state.round = nil
    state.lastDiagnostic = nil
    return #remaining > 0
end

local function handleFugueAOE(state, aoeInfo, now)
    local actionID = type(aoeInfo) == 'table' and aoeInfo.aoeID or nil
    local isDonut = FULGUROUS_FUGUE_DONUT_AIDS[actionID] == true
    local isCircle = FREZELD_FUGUE_CIRCLE_AIDS[actionID] == true
    if not isDonut and not isCircle then
        return false
    end
    local position = reliablePosition({
        x = aoeInfo.x, y = aoeInfo.y, z = aoeInfo.z,
    }, false)
    local duration = tonumber(aoeInfo.duration)
    if position == nil or not finite(duration)
            or duration <= 0 or duration > 30 or not finite(now)
    then
        diagnostic(state, 'fugue_geometry_invalid', now, actionID)
        return false
    end
    local drawer = Common.getMoogleDrawer()
    local draw = isDonut and drawer ~= nil and drawer.addTimedDonut
            or isCircle and drawer ~= nil and drawer.addTimedCircle
    if type(draw) ~= 'function' then
        diagnostic(state, 'danger_drawer_unavailable', now, actionID)
        return false
    end
    local timeout = math.floor(duration * 1000 + 0.5)
    local token = isDonut
            and drawer:addTimedDonut(timeout, position.x, position.y, position.z,
                    FUGUE_DONUT_INNER_RADIUS, FUGUE_DONUT_OUTER_RADIUS)
            or drawer:addTimedCircle(timeout, position.x, position.y, position.z,
                    FUGUE_RADIUS)
    if type(token) ~= 'string' then
        diagnostic(state, 'danger_drawer_rejected_shape', now, actionID)
        return false
    end
    return true
end

local function prune(state, now)
    state = ensureState(state)
    for entityID, tracked in pairs(state.orbs) do
        if type(tracked) ~= 'table'
                or not finite(tracked.addedAt)
                or now - tracked.addedAt > ORB_TTL_MS
        then
            state.orbs[entityID] = nil
        end
    end
    for entityID, active in pairs(state.active) do
        if type(active) ~= 'table'
                or not finite(active.expiresAt)
                or now >= active.expiresAt
        then
            state.active[entityID] = nil
        end
    end
    for index = #state.extremeShapes, 1, -1 do
        local active = state.extremeShapes[index]
        if type(active) ~= 'table'
                or not finite(active.expiresAt)
                or now >= active.expiresAt
        then
            table.remove(state.extremeShapes, index)
        end
    end
    for key, seenAt in pairs(state.blazeSeen) do
        if not finite(seenAt)
                or now - seenAt > EXTREME_SHAPE_TTL_MS
        then
            state.blazeSeen[key] = nil
        end
    end
    for contentID, order in pairs(state.blazeOrders) do
        if type(order) ~= 'table'
                or not finite(order.recordedAt)
                or now - order.recordedAt > EXTREME_SHAPE_TTL_MS
        then
            state.blazeOrders[contentID] = nil
        end
    end
    if type(state.round) == 'table'
            and finite(state.round.startedAt)
            and now - state.round.startedAt > ROUND_TIMEOUT_MS
    then
        clearMechanic(state)
    end
end

local Feature = {}

Feature.Init = function(M)
    if type(M.TwoHeadedAevis) == 'table' then
        applyBlacklist(M.TwoHeadedAevis, false)
        clearMechanic(M.TwoHeadedAevis)
    end
    M.TwoHeadedAevis = newState()
    local cfg = getConfig(M)
    applyBlacklist(M.TwoHeadedAevis, cfg ~= nil and cfg.Enable == true)
    M.SetTwoHeadedAevisEnabled = function(enabled)
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
    if state == nil then
        return
    end
    clearMechanic(state)
    if releaseOwnership == true then
        applyBlacklist(state, false)
    end
end

Feature.OnEntityAdd = function(entityID, contentID, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state ~= nil and cfg ~= nil and cfg.Enable == true then
        return recordOrb(state, entityID, contentID, now)
    end
    return false
end

Feature.OnVisibilityChange = function(entityID, isVisible)
    if isVisible ~= false then
        return false
    end
    local state = getState()
    if state == nil
            or (state.orbs[entityID] == nil
                    and state.active[entityID] == nil)
    then
        return false
    end
    state.orbs[entityID] = nil
    deleteActive(state, entityID)
    if type(state.round) == 'table' then
        state.round.pending[entityID] = nil
    end
    return true
end

Feature.OnEntityChannel = function(entityID, actionID, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state == nil or cfg == nil or cfg.Enable ~= true then
        return false
    end
    if BLAZE_ANNOUNCE[actionID] ~= nil then
        return recordBlazeAnnouncement(
                state, entityID, actionID, now)
    end
    if CLUSTER_KIND[actionID] ~= nil then
        local queued = queueCluster(state, entityID, actionID, now)
        return resolvePendingClusters(state, now) or queued
    end
    if actionID == THUNDERFROST_STORM_AID then
        return handleStorm(state, entityID, now)
    end
    return false
end

Feature.OnEntityCast = function(entityID, actionID)
    if EXPLOSION_AIDS[actionID] ~= true then
        return false
    end
    local state = getState()
    return state ~= nil and deleteActive(state, entityID) or false
end

Feature.OnAOECreate = function(aoeInfo, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state ~= nil and cfg ~= nil and cfg.Enable == true then
        return drawExtremeAOE(state, aoeInfo, now)
                or handleFugueAOE(state, aoeInfo, now)
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
        resolvePendingBlazeAnnouncements(state, now)
        resolvePendingClusters(state, now)
        prune(state, now)
        return true
    end
    clearMechanic(state)
    applyBlacklist(state, false)
    return false
end

Feature.Test = {
    Defaults = DEFAULTS,
    GreenHeadContentID = GREEN_HEAD_CONTENT_ID,
    BlueHeadContentID = BLUE_HEAD_CONTENT_ID,
    ThunderOrbContentID = THUNDER_ORB_CONTENT_ID,
    IceOrbContentID = ICE_ORB_CONTENT_ID,
    ThunderClusterActionID = THUNDER_CLUSTER_AID,
    IceClusterActionID = ICE_CLUSTER_AID,
    ThunderfrostStormActionID = THUNDERFROST_STORM_AID,
    ThunderExplosionActionID = THUNDER_EXPLOSION_AID,
    IceExplosionActionID = ICE_EXPLOSION_AID,
    FulgurousFugueDonutAID = 47629,
    FrezeldFugueCircleAID = 47630,
    BlazeAnnounce = BLAZE_ANNOUNCE,
    BlazeHelperStep = BLAZE_HELPER_STEP,
    DuetMarkerAIDs = DUET_MARKER_AIDS,
    BlazeCrossLength = BLAZE_CROSS_LENGTH,
    BlazeCrossWidth = BLAZE_CROSS_WIDTH,
    BlazeDonutInner = BLAZE_DONUT_INNER,
    BlazeDonutOuter = BLAZE_DONUT_OUTER,
    DuetClusterRadius = DUET_CLUSTER_RADIUS,
    OrbCount = ORB_COUNT,
    OrbRadius = ORB_RADIUS,
    FirstWaveTimeoutMs = FIRST_WAVE_TIMEOUT_MS,
    SecondWaveTimeoutMs = SECOND_WAVE_TIMEOUT_MS,
    ClusterResolveDeadlineMs = CLUSTER_RESOLVE_DEADLINE_MS,
    BlazeHeadResolveMs = BLAZE_HEAD_RESOLVE_MS,
    NewState = newState,
    EnsureState = ensureState,
    GetConfig = getConfig,
    ApplyBlacklist = applyBlacklist,
    RecordOrb = recordOrb,
    HandleCluster = handleCluster,
    QueueCluster = queueCluster,
    ResolvePendingClusters = resolvePendingClusters,
    HandleStorm = handleStorm,
    HandleFugueAOE = handleFugueAOE,
    RecordBlazeAnnouncement = recordBlazeAnnouncement,
    ResolvePendingBlazeAnnouncements = resolvePendingBlazeAnnouncements,
    DrawExtremeAOE = drawExtremeAOE,
    ClearMechanic = clearMechanic,
}

return Feature
end

rawset(_G, 'MuAiOccultCrescentNorthTwoHeadedAevis', Module)
return Module
