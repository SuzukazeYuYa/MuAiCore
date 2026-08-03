local Module = {}

function Module.Create(Context)
    assert(type(Context) == 'table' and type(Context.Common) == 'table')
    local Common = Context.Common
    local finite = Context.finite
    local nowMs = Context.nowMs
    local reliablePosition = Context.reliablePosition
    local resolveEntity = Context.resolveEntity

local IAMBE_CONTENT_ID = 14765
local IAMBE_BOSS_MODEL_ID = 19521
local IAMBE_HELPER_MODEL_ID = 19522
local SEED_CONTENT_ID = 14766
local SEED_MODEL_ID = 19523

local DIRECT_SOWING_AID = 48029
local SPROUTING_REFRAIN_AID = 48032
local SEED_EXPLOSION_AID = 48033

local SEED_EXPLOSION_RADIUS = 15
local MATCH_DISTANCE_SQUARED = 0.5 * 0.5
local DIRECT_SOWING_CHANNEL_MIN = 2.5
local DIRECT_SOWING_CHANNEL_MAX = 2.9
local SEED_ADD_MIN_MS = 4000
local SEED_ADD_MAX_MS = 6500
local HELPER_ADD_MIN_MS = 10500
local HELPER_ADD_MAX_MS = 13000
local HELPER_CAST_MIN_MS = 20500
local HELPER_CAST_MAX_MS = 24500
local PREDICTED_HIT_OFFSET_MS = 26050
local PREDICTION_HARD_END_MS = 27000
local PENDING_RESOLVE_MS = 1000
local ROUND_TIMEOUT_MS = 30000
local TOKEN_GRACE_MS = 1000

local DEFAULTS = {
    Enable = true,
    DrawSeedExplosionPrediction = true,
}

-- Map-1346 captures show that the four dangerous helpers are already
-- co-located with their selected seeds when the helpers become visible. The
-- other four helpers have no seed within 0.5m. Visibility is the first signal
-- where these new entities can be resolved reliably; 48032 completion is only
-- a late handoff when that transition was unavailable.
local function newState()
    return {
        round = nil,
        seeds = {},
        handledHelpers = {},
        pendingAdds = {},
        predictions = {},
        lastDiagnostic = nil,
    }
end

local function ensureState(state)
    state = type(state) == 'table' and state or newState()
    state.seeds = type(state.seeds) == 'table' and state.seeds or {}
    state.handledHelpers = type(state.handledHelpers) == 'table'
            and state.handledHelpers or {}
    state.pendingAdds = type(state.pendingAdds) == 'table'
            and state.pendingAdds or {}
    state.predictions = type(state.predictions) == 'table'
            and state.predictions or {}
    state.round = type(state.round) == 'table' and state.round or nil
    return state
end

local feature = Common.newFeature({
    key = 'Iambe',
    defaults = DEFAULTS,
    newState = newState,
    ensureState = ensureState,
    diagnosticThrottleMs = 1000,
    diagnosticText = {
        round_signal_invalid = '伊阿姆柏播种轮次信号无效',
        entity_mismatch = '伊阿姆柏预兆实体不匹配',
        geometry_missing = '伊阿姆柏种子爆炸预测缺少可靠几何',
        seed_match_ambiguous = '伊阿姆柏危险种子同位匹配不唯一',
        danger_drawer_unavailable = '伊阿姆柏危险范围绘图器不可用',
        danger_drawer_rejected_shape = '伊阿姆柏种子爆炸预测绘制失败',
    },
})
local getConfig = feature.GetConfig

local function getState()
    return Common.getRuntimeState('Iambe', newState, ensureState)
end

local function diagnostic(state, code, now, context)
    feature.Diagnostic(
            state, rawget(_G, 'MuAiGuide'), code, now, context)
end

local function deletePrediction(state, seedID)
    state = ensureState(state)
    local entry = state.predictions[seedID]
    if type(entry) ~= 'table' then
        return false
    end
    Common.deleteTimedShape(entry.token)
    state.predictions[seedID] = nil
    return true
end

local function clearRound(state)
    state = ensureState(state)
    for seedID in pairs(state.predictions) do
        deletePrediction(state, seedID)
    end
    state.round = nil
    state.seeds = {}
    state.handledHelpers = {}
    state.pendingAdds = {}
    state.predictions = {}
end

local function clearState(state)
    clearRound(state)
    state.lastDiagnostic = nil
end

local function resolveExpectedEntity(entityID, contentID, modelID)
    if not finite(entityID) or entityID <= 0 then
        return nil, nil
    end
    local entity = resolveEntity(entityID)
    if type(entity) ~= 'table'
            or tonumber(entity.id) ~= entityID
            or tonumber(entity.contentid) ~= contentID
            or tonumber(entity.modelid) ~= modelID
            or entity.alive == false
    then
        return nil, entity
    end
    local position = reliablePosition(entity.pos, false)
    return position, entity
end

local function roundAge(state, at)
    local startedAt = type(state.round) == 'table'
            and state.round.startedAt or nil
    if not finite(startedAt) or not finite(at) then
        return nil
    end
    return at - startedAt
end

local function drawSeedPrediction(state, seed, helperID, now)
    if type(seed) ~= 'table'
            or type(seed.position) ~= 'table'
            or type(state.round) ~= 'table'
            or type(state.predictions[seed.entityID]) == 'table'
            or not finite(now)
    then
        return false
    end
    local timeout = state.round.startedAt + PREDICTION_HARD_END_MS - now
    if timeout <= 0 then
        return false
    end
    local drawer = Common.getMoogleDrawer()
    if drawer == nil or type(drawer.addTimedCircle) ~= 'function' then
        diagnostic(state, 'danger_drawer_unavailable', now, seed.entityID)
        return false
    end
    local token = drawer:addTimedCircle(
            math.floor(timeout + 0.5),
            seed.position.x,
            seed.position.y,
            seed.position.z,
            SEED_EXPLOSION_RADIUS)
    if type(token) ~= 'string' then
        diagnostic(state, 'danger_drawer_rejected_shape', now, {
            seedID = seed.entityID,
            helperID = helperID,
        })
        return false
    end
    seed.helperID = helperID
    seed.predicted = true
    state.handledHelpers[helperID] = seed.entityID
    state.predictions[seed.entityID] = {
        token = token,
        seedID = seed.entityID,
        helperID = helperID,
        predictedAt = now,
        expectedHitAt = state.round.startedAt + PREDICTED_HIT_OFFSET_MS,
        expiresAt = state.round.startedAt + PREDICTION_HARD_END_MS
                + TOKEN_GRACE_MS,
    }
    state.lastDiagnostic = nil
    return true
end

local function matchSeedAtPosition(state, position, helperID, now)
    if type(position) ~= 'table'
            or not finite(position.x)
            or not finite(position.z)
    then
        diagnostic(state, 'geometry_missing', now, helperID)
        return false
    end
    local seedCount = 0
    for _ in pairs(state.seeds) do
        seedCount = seedCount + 1
    end
    if seedCount ~= 8 then
        return false
    end
    local predictionCount = 0
    for _ in pairs(state.predictions) do
        predictionCount = predictionCount + 1
    end
    if predictionCount >= 4 then
        return false
    end
    local candidate = nil
    local count = 0
    local nearestDistanceSquared = nil
    for _, seed in pairs(state.seeds) do
        if type(seed) == 'table'
                and seed.resolved ~= true
                and seed.predicted ~= true
                and type(seed.position) == 'table'
        then
            local dx = position.x - seed.position.x
            local dy = position.y - seed.position.y
            local dz = position.z - seed.position.z
            local distanceSquared = dx * dx + dy * dy + dz * dz
            if distanceSquared <= MATCH_DISTANCE_SQUARED then
                count = count + 1
                candidate = seed
                nearestDistanceSquared = nearestDistanceSquared == nil
                        and distanceSquared
                        or math.min(nearestDistanceSquared, distanceSquared)
            end
        end
    end
    if count == 0 then
        return false
    end
    if count ~= 1 then
        diagnostic(state, 'seed_match_ambiguous', now, {
            helperID = helperID,
            candidates = count,
            nearestDistanceSquared = nearestDistanceSquared,
        })
        return false
    end
    return drawSeedPrediction(state, candidate, helperID, now)
end

local function beginRound(
        state, entityID, targetID, channelTimeMax, now)
    state = ensureState(state)
    if not finite(entityID)
            or entityID <= 0
            or not finite(targetID)
            or targetID ~= entityID
            or not finite(now)
            or not finite(channelTimeMax)
            or channelTimeMax < DIRECT_SOWING_CHANNEL_MIN
            or channelTimeMax > DIRECT_SOWING_CHANNEL_MAX
    then
        diagnostic(state, 'round_signal_invalid', nowMs(), {
            entityID = entityID,
            targetID = targetID,
            channelTimeMax = channelTimeMax,
        })
        return false
    end
    if type(state.round) == 'table'
            and state.round.bossID == entityID
            and finite(state.round.startedAt)
            and now - state.round.startedAt <= ROUND_TIMEOUT_MS
    then
        return false
    end
    clearRound(state)
    state.round = {
        bossID = entityID,
        startedAt = now,
    }
    state.lastDiagnostic = nil
    return true
end

local function processAddedEntity(
        state, entityID, contentID, addedAt, now)
    state = ensureState(state)
    local age = roundAge(state, addedAt)
    if age == nil then
        return false, true
    end
    local expectedModelID = nil
    if contentID == SEED_CONTENT_ID
            and age >= SEED_ADD_MIN_MS and age <= SEED_ADD_MAX_MS
    then
        expectedModelID = SEED_MODEL_ID
    elseif contentID == IAMBE_CONTENT_ID
            and age >= HELPER_ADD_MIN_MS and age <= HELPER_ADD_MAX_MS
    then
        expectedModelID = IAMBE_HELPER_MODEL_ID
    else
        return false, true
    end
    if contentID == SEED_CONTENT_ID
            and state.seeds[entityID] ~= nil
    then
        return false, true
    end
    if contentID == IAMBE_CONTENT_ID
            and state.handledHelpers[entityID] ~= nil
    then
        return false, true
    end
    local position, entity = resolveExpectedEntity(
            entityID, contentID, expectedModelID)
    if position == nil then
        if entity == nil and now - addedAt <= PENDING_RESOLVE_MS then
            return false, false
        end
        diagnostic(state, 'entity_mismatch', now, {
            entityID = entityID,
            contentID = type(entity) == 'table' and entity.contentid or contentID,
            modelID = type(entity) == 'table' and entity.modelid or nil,
        })
        return false, true
    end
    if contentID == SEED_CONTENT_ID then
        state.seeds[entityID] = {
            entityID = entityID,
            position = position,
            addedAt = addedAt,
        }
        return true, true
    end
    if state.handledHelpers[entityID] ~= nil then
        return false, true
    end
    return matchSeedAtPosition(state, position, entityID, now), true
end

local function handleEntityAdd(state, entityID, contentID, now)
    if not finite(entityID)
            or not finite(contentID)
            or not finite(now)
            or (contentID ~= IAMBE_CONTENT_ID
                and contentID ~= SEED_CONTENT_ID)
    then
        return false
    end
    local changed, complete = processAddedEntity(
            state, entityID, contentID, now, now)
    if complete ~= true then
        state.pendingAdds[entityID] = {
            entityID = entityID,
            contentID = contentID,
            addedAt = now,
        }
    end
    return changed
end

local function handleVisibilityChange(
        state, entityID, wasVisible, isVisible, now)
    if wasVisible == true
            or isVisible ~= true
            or not finite(entityID)
            or not finite(now)
    then
        return false
    end
    state = ensureState(state)
    if type(state.round) ~= 'table' then
        return false
    end
    local entity = resolveEntity(entityID)
    if type(entity) ~= 'table'
            or tonumber(entity.id) ~= entityID
            or entity.alive == false
    then
        return false
    end
    local contentID = tonumber(entity.contentid)
    local modelID = tonumber(entity.modelid)
    if not ((contentID == SEED_CONTENT_ID and modelID == SEED_MODEL_ID)
            or (contentID == IAMBE_CONTENT_ID
                and modelID == IAMBE_HELPER_MODEL_ID))
    then
        return false
    end
    local pending = state.pendingAdds[entityID]
    local addedAt = type(pending) == 'table'
            and finite(pending.addedAt)
            and pending.addedAt
            or now
    local changed, complete = processAddedEntity(
            state, entityID, contentID, addedAt, now)
    if complete == true then
        state.pendingAdds[entityID] = nil
    end
    return changed
end

local function handleHelperCast(
        state, entityID, castPosition, now)
    state = ensureState(state)
    local age = roundAge(state, now)
    if state.handledHelpers[entityID] ~= nil
            or age == nil
            or age < HELPER_CAST_MIN_MS
            or age > HELPER_CAST_MAX_MS
    then
        return false
    end
    local livePosition, entity = resolveExpectedEntity(
            entityID, IAMBE_CONTENT_ID, IAMBE_HELPER_MODEL_ID)
    if livePosition == nil then
        diagnostic(state, 'entity_mismatch', now, {
            entityID = entityID,
            contentID = type(entity) == 'table' and entity.contentid or nil,
            modelID = type(entity) == 'table' and entity.modelid or nil,
        })
        return false
    end
    local position = reliablePosition(castPosition, false) or livePosition
    return matchSeedAtPosition(state, position, entityID, now)
end

local function resolveSeedExplosion(state, entityID)
    state = ensureState(state)
    local seed = state.seeds[entityID]
    if type(seed) ~= 'table' then
        return false
    end
    seed.resolved = true
    return deletePrediction(state, entityID)
end

local function pruneState(state, now)
    state = ensureState(state)
    if not finite(now) then
        return false
    end
    local changed = false
    local pendingIDs = {}
    for entityID in pairs(state.pendingAdds) do
        pendingIDs[#pendingIDs + 1] = entityID
    end
    for _, entityID in ipairs(pendingIDs) do
        local pending = state.pendingAdds[entityID]
        if type(pending) == 'table' then
            local resolved, complete = processAddedEntity(
                    state,
                    pending.entityID,
                    pending.contentID,
                    pending.addedAt,
                    now)
            changed = resolved or changed
            if complete == true or now - pending.addedAt > PENDING_RESOLVE_MS then
                state.pendingAdds[entityID] = nil
            end
        else
            state.pendingAdds[entityID] = nil
        end
    end
    for seedID, entry in pairs(state.predictions) do
        if type(entry) ~= 'table'
                or not finite(entry.expiresAt)
                or now > entry.expiresAt
        then
            deletePrediction(state, seedID)
            changed = true
        end
    end
    if type(state.round) == 'table'
            and finite(state.round.startedAt)
            and now - state.round.startedAt > ROUND_TIMEOUT_MS
    then
        clearRound(state)
        changed = true
    end
    return changed
end

local Feature = {}

Feature.Init = function(M)
    if type(M.Iambe) == 'table' then
        clearState(M.Iambe)
    end
    M.Iambe = newState()
    getConfig(M)
    M.SetIambeEnabled = function(enabled)
        local cfg = getConfig(M)
        if cfg ~= nil then
            cfg.Enable = enabled == true
        end
        if enabled ~= true then
            clearState(M.Iambe)
        end
    end
    M.SetIambePredictionEnabled = function(enabled)
        local cfg = getConfig(M)
        if cfg ~= nil then
            cfg.DrawSeedExplosionPrediction = enabled == true
        end
        if enabled ~= true then
            clearState(M.Iambe)
        end
    end
end

Feature.Clear = function()
    local state = getState()
    if state ~= nil then
        clearState(state)
    end
end

Feature.OnEntityAdd = function(entityID, contentID, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state ~= nil and cfg ~= nil
            and cfg.Enable == true
            and cfg.DrawSeedExplosionPrediction == true
    then
        return handleEntityAdd(state, entityID, contentID, now)
    end
    return false
end

Feature.OnVisibilityChange = function(
        entityID, wasVisible, isVisible, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state ~= nil and cfg ~= nil
            and cfg.Enable == true
            and cfg.DrawSeedExplosionPrediction == true
    then
        return handleVisibilityChange(
                state, entityID, wasVisible, isVisible, now)
    end
    return false
end

Feature.OnEntityChannel = function(
        entityID, actionID, targetID, channelTimeMax, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state == nil or cfg == nil
            or cfg.Enable ~= true
            or cfg.DrawSeedExplosionPrediction ~= true
    then
        return false
    end
    if actionID == DIRECT_SOWING_AID then
        return beginRound(
                state, entityID, targetID, channelTimeMax, now)
    end
    if actionID == SEED_EXPLOSION_AID then
        return resolveSeedExplosion(state, entityID)
    end
    return false
end

Feature.OnEntityCast = function(entityID, actionID, castPosition, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state == nil or cfg == nil
            or cfg.Enable ~= true
            or cfg.DrawSeedExplosionPrediction ~= true
    then
        return false
    end
    if actionID == SPROUTING_REFRAIN_AID then
        return handleHelperCast(state, entityID, castPosition, now)
    end
    if actionID == SEED_EXPLOSION_AID then
        return resolveSeedExplosion(state, entityID)
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
            and cfg.DrawSeedExplosionPrediction == true
    then
        return pruneState(state, now)
    end
    clearState(state)
    return false
end

Feature.Test = {
    Defaults = DEFAULTS,
    IambeContentID = IAMBE_CONTENT_ID,
    BossModelID = IAMBE_BOSS_MODEL_ID,
    HelperModelID = IAMBE_HELPER_MODEL_ID,
    SeedContentID = SEED_CONTENT_ID,
    SeedModelID = SEED_MODEL_ID,
    DirectSowingActionID = DIRECT_SOWING_AID,
    SproutingRefrainActionID = SPROUTING_REFRAIN_AID,
    SeedExplosionActionID = SEED_EXPLOSION_AID,
    SeedExplosionRadius = SEED_EXPLOSION_RADIUS,
    MatchDistanceSquared = MATCH_DISTANCE_SQUARED,
    PredictedHitOffsetMs = PREDICTED_HIT_OFFSET_MS,
    PredictionHardEndMs = PREDICTION_HARD_END_MS,
    NewState = newState,
    EnsureState = ensureState,
    GetConfig = getConfig,
    BeginRound = beginRound,
    HandleEntityAdd = handleEntityAdd,
    HandleVisibilityChange = handleVisibilityChange,
    HandleHelperCast = handleHelperCast,
    ResolveSeedExplosion = resolveSeedExplosion,
    PruneState = pruneState,
    ClearState = clearState,
}

return Feature
end

rawset(_G, 'MuAiOccultCrescentNorthIambe', Module)
return Module
