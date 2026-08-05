local Module = {}

function Module.Create(Context)
    assert(type(Context) == 'table' and type(Context.Common) == 'table')
    local Common = Context.Common
    local finite = Context.finite
    local reliablePosition = Context.reliablePosition

local TORNADO_CONTENT_ID = 14506
local TORNADO_MODEL_ID = 19426
local TORNADO_MARKER_ID = 506
local TEARING_WIND_AID = 47439

local ARENA_CENTER = { x = -150, y = 70, z = -860 }
local INNER_TRACK_RADIUS = 12
local OUTER_TRACK_RADIUS = 20
local INNER_ANGULAR_SPEED = 0.148
local OUTER_ANGULAR_SPEED = 0.172
local INNER_PHASE_ADVANCE = 0.605
local OUTER_PHASE_ADVANCE = 0.702
local TRACK_RADIUS_TOLERANCE = 0.5
local TANGENT_TOLERANCE = 0.15
local ARENA_Y_TOLERANCE = 0.5

local RECT_LENGTH = 60
local RECT_WIDTH = 8
local RECT_HEADINGS = { -math.pi, -3 * math.pi / 4 }
local PREDICTION_TIMEOUT_MS = 5200
local PREDICTION_MATCH_DISTANCE_SQUARED = 1.5 * 1.5
local MARKER_DEDUPE_MS = 1000
local MARKER_RESOLVE_TIMEOUT_MS = 3750
local SEEN_TTL_MS = 15000

local DEFAULTS = {
    Enable = true,
    DrawTearingWindPrediction = true,
}

-- In both complete map-1346 captures, marker 506 appears about 4.1 seconds
-- before Moogle receives 47439. At that instant the moving tornado's
-- heading is tangent to one of two fixed circular tracks, so the final
-- rectangle center can be predicted without a timeline or fixed direction.
local function newState()
    return {
        predictions = {},
        seenMarkers = {},
        pendingMarkers = {},
        nextSequence = 0,
        lastDiagnostic = nil,
    }
end

local function ensureState(state)
    state = type(state) == 'table' and state or newState()
    state.predictions = type(state.predictions) == 'table'
            and state.predictions or {}
    state.seenMarkers = type(state.seenMarkers) == 'table'
            and state.seenMarkers or {}
    state.pendingMarkers = type(state.pendingMarkers) == 'table'
            and state.pendingMarkers or {}
    state.nextSequence = finite(state.nextSequence)
            and state.nextSequence or 0
    return state
end

local feature = Common.newFeature({
    key = 'KidnapDemon',
    defaults = DEFAULTS,
    newState = newState,
    ensureState = ensureState,
    diagnosticThrottleMs = 1000,
    diagnosticText = {
        marker_entity_mismatch = '诱拐魔龙卷风标记实体不匹配',
        track_geometry_invalid = '诱拐魔龙卷风轨迹几何无效',
        tangent_geometry_invalid = '诱拐魔龙卷风旋转方向不可靠',
        danger_drawer_unavailable = '诱拐魔撕裂之风绘图器不可用',
        danger_drawer_rejected_shape = '诱拐魔撕裂之风预测绘制失败',
        aoe_geometry_invalid = '诱拐魔撕裂之风结算几何无效',
    },
})
local getConfig = feature.GetConfig

local function getState()
    return Common.getRuntimeState('KidnapDemon', newState, ensureState)
end

local function diagnostic(state, code, now, context)
    feature.Diagnostic(
            state, rawget(_G, 'MuAiGuide'), code, now, context)
end

local function normalizeHeading(heading)
    if not finite(heading) then
        return nil
    end
    while heading > math.pi do
        heading = heading - 2 * math.pi
    end
    while heading <= -math.pi do
        heading = heading + 2 * math.pi
    end
    return heading
end

local function deletePrediction(state, key)
    state = ensureState(state)
    local entry = state.predictions[key]
    if type(entry) ~= 'table' then
        return false
    end
    if type(entry.tokens) == 'table' then
        for _, token in ipairs(entry.tokens) do
            Common.deleteTimedShape(token)
        end
    end
    state.predictions[key] = nil
    return true
end

local function clearState(state)
    state = ensureState(state)
    local keys = {}
    for key in pairs(state.predictions) do
        keys[#keys + 1] = key
    end
    for _, key in ipairs(keys) do
        deletePrediction(state, key)
    end
    state.predictions = {}
    state.seenMarkers = {}
    state.pendingMarkers = {}
    state.nextSequence = 0
    state.lastDiagnostic = nil
end

local function resolveTornadoEntity(entityID, requireHeading)
    if not finite(entityID) or entityID <= 0 then
        return nil, nil
    end
    local tensorCore = rawget(_G, 'TensorCore')
    if type(tensorCore) ~= 'table'
            or type(tensorCore.entityList) ~= 'function'
    then
        return nil, nil
    end
    -- The moving tornadoes are untargetable. The scoped ContentID query did
    -- not expose them in the 2026-08-05 live capture, while the full entity
    -- index is the documented path for untargetable actors.
    local entities = tensorCore.entityList('')
    if type(entities) ~= 'table' then
        return nil, nil
    end
    for _, entity in pairs(entities) do
        if type(entity) == 'table'
                and tonumber(entity.id) == entityID
                and tonumber(entity.contentid) == TORNADO_CONTENT_ID
                and tonumber(entity.modelid) == TORNADO_MODEL_ID
                and entity.alive ~= false
        then
            return reliablePosition(
                    entity.pos, requireHeading == true), entity
        end
    end
    return nil, nil
end

local function classifyTrack(radius)
    if not finite(radius) then
        return nil
    end
    local innerError = math.abs(radius - INNER_TRACK_RADIUS)
    local outerError = math.abs(radius - OUTER_TRACK_RADIUS)
    if innerError <= TRACK_RADIUS_TOLERANCE
            and innerError < outerError
    then
        return {
            name = 'inner',
            radius = INNER_TRACK_RADIUS,
            angularSpeed = INNER_ANGULAR_SPEED,
            phaseAdvance = INNER_PHASE_ADVANCE,
        }
    end
    if outerError <= TRACK_RADIUS_TOLERANCE
            and outerError < innerError
    then
        return {
            name = 'outer',
            radius = OUTER_TRACK_RADIUS,
            angularSpeed = OUTER_ANGULAR_SPEED,
            phaseAdvance = OUTER_PHASE_ADVANCE,
        }
    end
    return nil
end

local function predictCenter(position)
    if type(position) ~= 'table'
            or not finite(position.x)
            or not finite(position.y)
            or not finite(position.z)
            or not finite(position.h)
            or math.abs(position.y - ARENA_CENTER.y) > ARENA_Y_TOLERANCE
    then
        return nil, 'track_geometry_invalid'
    end
    local dx = position.x - ARENA_CENTER.x
    local dz = position.z - ARENA_CENTER.z
    local measuredRadius = math.sqrt(dx * dx + dz * dz)
    local track = classifyTrack(measuredRadius)
    if track == nil then
        return nil, 'track_geometry_invalid'
    end
    local radialHeading = math.atan2(dx, dz)
    local tangentDelta = normalizeHeading(position.h - radialHeading)
    if tangentDelta == nil
            or math.abs(math.abs(tangentDelta) - math.pi / 2)
                    > TANGENT_TOLERANCE
    then
        return nil, 'tangent_geometry_invalid'
    end
    local direction = tangentDelta > 0 and 1 or -1
    local finalHeading = radialHeading
            + direction * track.phaseAdvance
    return {
        x = ARENA_CENTER.x + measuredRadius * math.sin(finalHeading),
        y = ARENA_CENTER.y,
        z = ARENA_CENTER.z + measuredRadius * math.cos(finalHeading),
        direction = direction,
        measuredRadius = measuredRadius,
        radialHeading = radialHeading,
        finalHeading = normalizeHeading(finalHeading),
        track = track,
    }
end

local function drawPrediction(state, entityID, prediction, now)
    local drawer = Common.getMoogleDrawer()
    if drawer == nil or type(drawer.addTimedRect) ~= 'function' then
        diagnostic(state, 'danger_drawer_unavailable', now, entityID)
        return false
    end
    local tokens = {}
    for _, heading in ipairs(RECT_HEADINGS) do
        local token = drawer:addTimedRect(
                PREDICTION_TIMEOUT_MS,
                prediction.x, prediction.y, prediction.z,
                RECT_LENGTH, RECT_WIDTH, heading, 0)
        if type(token) ~= 'string' then
            for _, rollback in ipairs(tokens) do
                Common.deleteTimedShape(rollback)
            end
            diagnostic(state, 'danger_drawer_rejected_shape', now, entityID)
            return false
        end
        tokens[#tokens + 1] = token
    end
    state.nextSequence = state.nextSequence + 1
    local key = tostring(entityID) .. ':' .. tostring(state.nextSequence)
    state.predictions[key] = {
        key = key,
        entityID = entityID,
        center = { x = prediction.x, y = prediction.y, z = prediction.z },
        track = prediction.track.name,
        direction = prediction.direction,
        createdAt = now,
        expiresAt = now + PREDICTION_TIMEOUT_MS,
        tokens = tokens,
    }
    state.lastDiagnostic = nil
    return true, key
end

local function hasActivePrediction(state, entityID, now)
    for _, entry in pairs(state.predictions) do
        if type(entry) == 'table'
                and entry.entityID == entityID
                and finite(entry.expiresAt)
                and entry.expiresAt >= now
        then
            return true
        end
    end
    return false
end

local function resolveMarker(state, entityID, markerID, now, firstSeenAt)
    local position = resolveTornadoEntity(entityID, true)
    if position == nil then
        if now - firstSeenAt >= MARKER_RESOLVE_TIMEOUT_MS then
            state.pendingMarkers[entityID] = nil
            diagnostic(state, 'marker_entity_mismatch', now, entityID)
        end
        return false
    end
    state.pendingMarkers[entityID] = nil
    local seenKey = tostring(entityID) .. ':' .. tostring(markerID)
    local seenAt = state.seenMarkers[seenKey]
    if finite(seenAt) and now - seenAt <= MARKER_DEDUPE_MS then
        return false
    end
    if hasActivePrediction(state, entityID, now) then
        return false
    end
    local prediction, code = predictCenter(position)
    if prediction == nil then
        diagnostic(state, code, now, entityID)
        return false
    end
    local drawn = drawPrediction(state, entityID, prediction, now)
    if drawn then
        state.pendingMarkers[entityID] = nil
        state.seenMarkers[seenKey] = now
    end
    return drawn
end

local function handleMarkerAdd(state, entityID, markerID, now)
    state = ensureState(state)
    entityID = tonumber(entityID)
    if tonumber(markerID) ~= TORNADO_MARKER_ID
            or not finite(entityID)
            or entityID <= 0
            or not finite(now)
    then
        return false
    end
    local pending = state.pendingMarkers[entityID]
    local firstSeenAt = type(pending) == 'table'
            and pending.firstSeenAt or now
    state.pendingMarkers[entityID] = {
        markerID = TORNADO_MARKER_ID,
        firstSeenAt = firstSeenAt,
    }
    return resolveMarker(
            state, entityID, TORNADO_MARKER_ID, now, firstSeenAt)
end

local function validTearingWindAOE(aoeInfo)
    if type(aoeInfo) ~= 'table'
            or tonumber(aoeInfo.aoeID) ~= TEARING_WIND_AID
    then
        return false, nil
    end
    local entityID = tonumber(aoeInfo.entityID)
    local position = reliablePosition({
        x = aoeInfo.x,
        y = aoeInfo.y,
        z = aoeInfo.z,
    }, false)
    local heading = normalizeHeading(tonumber(aoeInfo.heading))
    local headingValid = false
    if heading ~= nil then
        for _, expected in ipairs(RECT_HEADINGS) do
            local difference = normalizeHeading(heading - expected)
            if difference ~= nil and math.abs(difference) <= 0.02 then
                headingValid = true
                break
            end
        end
    end
    if not finite(entityID)
            or entityID <= 0
            or position == nil
            or tonumber(aoeInfo.contentID) ~= TORNADO_CONTENT_ID
            or tonumber(aoeInfo.aoeCastType) ~= 11
            or tonumber(aoeInfo.aoeType) ~= 0
            or aoeInfo.isAreaTarget ~= false
            or not finite(aoeInfo.aoeLength)
            or math.abs(aoeInfo.aoeLength - RECT_LENGTH) > 0.25
            or not finite(aoeInfo.aoeWidth)
            or math.abs(aoeInfo.aoeWidth - RECT_WIDTH) > 0.25
            or not finite(aoeInfo.duration)
            or math.abs(aoeInfo.duration - 0.7) > 0.15
            or not finite(aoeInfo.delay)
            or math.abs(aoeInfo.delay) > 0.15
            or headingValid ~= true
    then
        return false, entityID
    end
    return true, position
end

local function handleAOECreate(state, aoeInfo, now)
    state = ensureState(state)
    if type(aoeInfo) ~= 'table'
            or tonumber(aoeInfo.aoeID) ~= TEARING_WIND_AID
            or not finite(now)
    then
        return false
    end
    local valid, positionOrEntityID = validTearingWindAOE(aoeInfo)
    if not valid then
        diagnostic(state, 'aoe_geometry_invalid', now, positionOrEntityID)
        return false
    end
    local position = positionOrEntityID
    local bestKey = nil
    local bestDistance = nil
    for key, entry in pairs(state.predictions) do
        local center = type(entry) == 'table' and entry.center or nil
        if type(center) == 'table'
                and finite(center.x) and finite(center.z)
                and finite(entry.createdAt)
                and now >= entry.createdAt
                and now - entry.createdAt <= PREDICTION_TIMEOUT_MS + 500
        then
            local dx = center.x - position.x
            local dz = center.z - position.z
            local distance = dx * dx + dz * dz
            if distance <= PREDICTION_MATCH_DISTANCE_SQUARED
                    and (bestDistance == nil or distance < bestDistance)
            then
                bestKey = key
                bestDistance = distance
            end
        end
    end
    return bestKey ~= nil and deletePrediction(state, bestKey) or false
end

local function pruneState(state, now)
    state = ensureState(state)
    if not finite(now) then
        return false
    end
    local changed = false
    local pendingIDs = {}
    for entityID in pairs(state.pendingMarkers) do
        pendingIDs[#pendingIDs + 1] = entityID
    end
    for _, entityID in ipairs(pendingIDs) do
        local pending = state.pendingMarkers[entityID]
        local firstSeenAt = type(pending) == 'table'
                and pending.firstSeenAt or nil
        if finite(firstSeenAt) then
            changed = resolveMarker(
                    state, entityID, TORNADO_MARKER_ID,
                    now, firstSeenAt) or changed
        else
            state.pendingMarkers[entityID] = nil
        end
    end
    local expired = {}
    for key, entry in pairs(state.predictions) do
        if type(entry) ~= 'table'
                or not finite(entry.expiresAt)
                or now > entry.expiresAt
        then
            expired[#expired + 1] = key
        end
    end
    for _, key in ipairs(expired) do
        deletePrediction(state, key)
        changed = true
    end
    for key, seenAt in pairs(state.seenMarkers) do
        if not finite(seenAt) or now - seenAt > SEEN_TTL_MS then
            state.seenMarkers[key] = nil
        end
    end
    return changed
end

local Feature = {}

Feature.Init = function(M)
    if type(M.KidnapDemon) == 'table' then
        clearState(M.KidnapDemon)
    end
    M.KidnapDemon = newState()
    getConfig(M)
    M.SetKidnapDemonEnabled = function(enabled)
        local cfg = getConfig(M)
        if cfg ~= nil then
            cfg.Enable = enabled == true
        end
        if enabled ~= true then
            clearState(M.KidnapDemon)
        end
    end
    M.SetKidnapDemonPredictionEnabled = function(enabled)
        local cfg = getConfig(M)
        if cfg ~= nil then
            cfg.DrawTearingWindPrediction = enabled == true
        end
        if enabled ~= true then
            clearState(M.KidnapDemon)
        end
    end
end

Feature.Clear = function()
    local state = getState()
    if state ~= nil then
        clearState(state)
    end
end

Feature.OnMarkerAdd = function(entityID, markerID, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state ~= nil and cfg ~= nil
            and cfg.Enable == true
            and cfg.DrawTearingWindPrediction == true
    then
        return handleMarkerAdd(state, entityID, markerID, now)
    end
    return false
end

Feature.OnAOECreate = function(aoeInfo, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state ~= nil and cfg ~= nil
            and cfg.Enable == true
            and cfg.DrawTearingWindPrediction == true
    then
        return handleAOECreate(state, aoeInfo, now)
    end
    return false
end

Feature.Update = function(guide, now)
    local state = getState()
    if state == nil then
        return false
    end
    local cfg = getConfig(guide)
    if cfg ~= nil
            and cfg.Enable == true
            and cfg.DrawTearingWindPrediction == true
    then
        return pruneState(state, now)
    end
    clearState(state)
    return false
end

Feature.Test = {
    Defaults = DEFAULTS,
    TornadoContentID = TORNADO_CONTENT_ID,
    TornadoModelID = TORNADO_MODEL_ID,
    TornadoMarkerID = TORNADO_MARKER_ID,
    TearingWindActionID = TEARING_WIND_AID,
    ArenaCenter = ARENA_CENTER,
    InnerTrackRadius = INNER_TRACK_RADIUS,
    OuterTrackRadius = OUTER_TRACK_RADIUS,
    InnerAngularSpeed = INNER_ANGULAR_SPEED,
    OuterAngularSpeed = OUTER_ANGULAR_SPEED,
    InnerPhaseAdvance = INNER_PHASE_ADVANCE,
    OuterPhaseAdvance = OUTER_PHASE_ADVANCE,
    RectLength = RECT_LENGTH,
    RectWidth = RECT_WIDTH,
    RectHeadings = RECT_HEADINGS,
    PredictionTimeoutMs = PREDICTION_TIMEOUT_MS,
    MarkerResolveTimeoutMs = MARKER_RESOLVE_TIMEOUT_MS,
    NewState = newState,
    EnsureState = ensureState,
    GetConfig = getConfig,
    ClassifyTrack = classifyTrack,
    PredictCenter = predictCenter,
    HandleMarkerAdd = handleMarkerAdd,
    HandleAOECreate = handleAOECreate,
    PruneState = pruneState,
    ClearState = clearState,
}

return Feature
end

rawset(_G, 'MuAiOccultCrescentNorthKidnapDemon', Module)
return Module
