local Module = {}

function Module.Create(Context)
    assert(type(Context) == 'table' and type(Context.Common) == 'table')
    local Common = Context.Common
    local finite = Context.finite
    local nowMs = Context.nowMs
    local reliablePosition = Context.reliablePosition

local IAMBE_CONTENT_ID = 14765
local SEED_CONTENT_ID = 14766
local SEED_MODEL_ID = 19523

local DIRECT_SOWING_AID = 48029
local SPROUTING_REFRAIN_AID = 48032
local SEED_EXPLOSION_AID = 48033

local SPROUTING_AOE_TYPE = 181
local SPROUTING_CAST_TYPE = 2
local SPROUTING_RADIUS = 5
local SPROUTING_RADIUS_TOLERANCE = 0.1
local SEED_EXPLOSION_RADIUS = 15
local EXPECTED_SEED_COUNT = 8
local EXPECTED_AOE_COUNT = 8
local EXPECTED_DANGER_COUNT = 4
local DIRECT_SOWING_CHANNEL_MIN = 2.5
local DIRECT_SOWING_CHANNEL_MAX = 2.9
local SEED_ADD_MIN_MS = 4000
local SEED_ADD_MAX_MS = 7000
local SPROUTING_MIN_MS = 15500
local SPROUTING_MAX_MS = 18000
local SPROUTING_DURATION_MIN = 5.5
local SPROUTING_DURATION_MAX = 5.9
local PREDICTED_HIT_OFFSET_MS = 26050
local PREDICTION_HARD_END_MS = 27000
local ROUND_TIMEOUT_MS = 30000
local TOKEN_GRACE_MS = 1000
local BLACKLIST_SOURCE = 'MuAiCore - 伊阿姆柏种子AOE命中预测'

local DEFAULTS = {
    Enable = true,
    DrawSeedExplosionPrediction = true,
}

-- The eight 48032 circles are the first reliable statement of which seeds
-- will explode. OnEntityAdd supplies stable IDs only; the complete seed
-- geometry is resolved once through entityList when all eight circles exist.
local function newState()
    return {
        round = nil,
        seedIDs = {},
        aoes = {},
        predictions = {},
        blacklist = {
            registered = false,
            owned = nil,
        },
        lastDiagnostic = nil,
    }
end

local function ensureState(state)
    state = type(state) == 'table' and state or newState()
    state.round = type(state.round) == 'table' and state.round or nil
    state.seedIDs = type(state.seedIDs) == 'table' and state.seedIDs or {}
    state.aoes = type(state.aoes) == 'table' and state.aoes or {}
    state.predictions = type(state.predictions) == 'table'
            and state.predictions or {}
    state.blacklist = type(state.blacklist) == 'table'
            and state.blacklist or {}
    state.blacklist.registered = state.blacklist.registered == true
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
        aoe_geometry_invalid = '伊阿姆柏育芽AOE几何无效',
        seed_geometry_unavailable = '伊阿姆柏本轮种子几何不可用',
        danger_set_mismatch = '伊阿姆柏AOE命中种子数量不符',
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

local function countEntries(values)
    local count = 0
    for _ in pairs(values) do
        count = count + 1
    end
    return count
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

local function clearMechanic(state)
    state = ensureState(state)
    for seedID in pairs(state.predictions) do
        deletePrediction(state, seedID)
    end
    state.round = nil
    state.seedIDs = {}
    state.aoes = {}
    state.predictions = {}
end

local function clearState(state)
    clearMechanic(state)
    state.lastDiagnostic = nil
end

local function ownsBlacklist(state, current)
    return current ~= nil
            and (current == state.blacklist.owned
                or (type(current) == 'table'
                    and current.source == BLACKLIST_SOURCE))
end

local function applyBlacklist(state, enabled)
    state = ensureState(state)
    local blacklist = Common.getMoogleTable(
            'aoeIDUserBlacklist', enabled == true)
    if blacklist == nil then
        state.blacklist.registered = false
        state.blacklist.owned = nil
        return false
    end
    local current = blacklist[SEED_EXPLOSION_AID]
    if enabled == true then
        if current == nil then
            current = {
                label = '伊阿姆柏种子AOE命中预测',
                source = BLACKLIST_SOURCE,
            }
            blacklist[SEED_EXPLOSION_AID] = current
        end
        state.blacklist.owned = ownsBlacklist(state, current)
                and current or nil
        state.blacklist.registered = true
        return true
    end
    if ownsBlacklist(state, current) then
        blacklist[SEED_EXPLOSION_AID] = nil
    end
    state.blacklist.registered = false
    state.blacklist.owned = nil
    return true
end

local function roundAge(state, at)
    local startedAt = type(state.round) == 'table'
            and state.round.startedAt or nil
    if not finite(startedAt) or not finite(at) then
        return nil
    end
    return at - startedAt
end

local function beginRound(
        state, entityID, targetID, channelTimeMax, now)
    state = ensureState(state)
    if not finite(entityID)
            or entityID <= 0
            or not finite(targetID)
            or targetID ~= entityID
            or not finite(channelTimeMax)
            or channelTimeMax < DIRECT_SOWING_CHANNEL_MIN
            or channelTimeMax > DIRECT_SOWING_CHANNEL_MAX
            or not finite(now)
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
    clearMechanic(state)
    state.round = {
        bossID = entityID,
        startedAt = now,
        evaluated = false,
    }
    state.lastDiagnostic = nil
    return true
end

local function handleEntityAdd(state, entityID, contentID, now)
    state = ensureState(state)
    local age = roundAge(state, now)
    if contentID ~= SEED_CONTENT_ID
            or not finite(entityID)
            or entityID <= 0
            or age == nil
            or age < SEED_ADD_MIN_MS
            or age > SEED_ADD_MAX_MS
            or state.seedIDs[entityID] ~= nil
    then
        return false
    end
    if countEntries(state.seedIDs) >= EXPECTED_SEED_COUNT then
        return false
    end
    state.seedIDs[entityID] = { addedAt = now }
    return true
end

local function collectSeedGeometry(state)
    if countEntries(state.seedIDs) ~= EXPECTED_SEED_COUNT then
        return nil
    end
    local tensorCore = rawget(_G, 'TensorCore')
    if type(tensorCore) ~= 'table'
            or type(tensorCore.entityList) ~= 'function'
    then
        return nil
    end
    local entities = tensorCore.entityList(
            'contentid=' .. tostring(SEED_CONTENT_ID))
    if type(entities) ~= 'table' then
        return nil
    end
    local found = {}
    for _, entity in pairs(entities) do
        local entityID = type(entity) == 'table' and tonumber(entity.id) or nil
        if finite(entityID) and state.seedIDs[entityID] ~= nil then
            local position = reliablePosition(entity.pos, false)
            if tonumber(entity.contentid) == SEED_CONTENT_ID
                    and tonumber(entity.modelid) == SEED_MODEL_ID
                    and entity.alive ~= false
                    and position ~= nil
            then
                found[entityID] = {
                    entityID = entityID,
                    position = position,
                }
            end
        end
    end
    if countEntries(found) ~= EXPECTED_SEED_COUNT then
        return nil
    end
    local seeds = {}
    for _, seed in pairs(found) do
        seeds[#seeds + 1] = seed
    end
    table.sort(seeds, function(left, right)
        return left.entityID < right.entityID
    end)
    return seeds
end

local function readSproutingAOE(state, aoeInfo, now)
    if type(aoeInfo) ~= 'table'
            or aoeInfo.aoeID ~= SPROUTING_REFRAIN_AID
    then
        return nil, false
    end
    local age = roundAge(state, now)
    local position = reliablePosition({
        x = aoeInfo.x,
        y = aoeInfo.y,
        z = aoeInfo.z,
    }, false)
    if age == nil
            or age < SPROUTING_MIN_MS
            or age > SPROUTING_MAX_MS
            or aoeInfo.contentID ~= IAMBE_CONTENT_ID
            or aoeInfo.aoeType ~= SPROUTING_AOE_TYPE
            or aoeInfo.aoeCastType ~= SPROUTING_CAST_TYPE
            or not finite(aoeInfo.aoeLength)
            or math.abs(aoeInfo.aoeLength - SPROUTING_RADIUS)
                    > SPROUTING_RADIUS_TOLERANCE
            or not finite(aoeInfo.duration)
            or aoeInfo.duration < SPROUTING_DURATION_MIN
            or aoeInfo.duration > SPROUTING_DURATION_MAX
            or not finite(aoeInfo.entityID)
            or aoeInfo.entityID <= 0
            or position == nil
    then
        diagnostic(state, 'aoe_geometry_invalid', now, {
            age = age,
            actionID = aoeInfo.aoeID,
            entityID = aoeInfo.entityID,
            contentID = aoeInfo.contentID,
            aoeType = aoeInfo.aoeType,
            aoeCastType = aoeInfo.aoeCastType,
            radius = aoeInfo.aoeLength,
            duration = aoeInfo.duration,
        })
        return nil, true
    end
    return {
        entityID = aoeInfo.entityID,
        position = position,
        radius = aoeInfo.aoeLength,
    }, true
end

local function selectDangerSeeds(seeds, aoes)
    if type(seeds) ~= 'table'
            or #seeds ~= EXPECTED_SEED_COUNT
            or type(aoes) ~= 'table'
            or countEntries(aoes) ~= EXPECTED_AOE_COUNT
    then
        return nil
    end
    local selected = {}
    for _, seed in ipairs(seeds) do
        local hit = false
        for _, aoe in pairs(aoes) do
            local dx = seed.position.x - aoe.position.x
            local dz = seed.position.z - aoe.position.z
            local radius = aoe.radius + SPROUTING_RADIUS_TOLERANCE
            if dx * dx + dz * dz <= radius * radius then
                hit = true
                break
            end
        end
        if hit then
            selected[#selected + 1] = seed
        end
    end
    return #selected == EXPECTED_DANGER_COUNT and selected or nil
end

local function drawDangerSeeds(state, seeds, now)
    local round = state.round
    if type(round) ~= 'table' or not finite(round.startedAt) then
        return false
    end
    local timeout = round.startedAt + PREDICTION_HARD_END_MS - now
    if timeout <= 0 then
        return false
    end
    local drawer = Common.getMoogleDrawer()
    if drawer == nil or type(drawer.addTimedCircle) ~= 'function' then
        diagnostic(state, 'danger_drawer_unavailable', now)
        return false
    end
    local created = {}
    for _, seed in ipairs(seeds) do
        local token = drawer:addTimedCircle(
                math.floor(timeout + 0.5),
                seed.position.x,
                seed.position.y,
                seed.position.z,
                SEED_EXPLOSION_RADIUS)
        if type(token) ~= 'string' then
            for _, seedID in ipairs(created) do
                deletePrediction(state, seedID)
            end
            diagnostic(state, 'danger_drawer_rejected_shape', now, {
                seedID = seed.entityID,
            })
            return false
        end
        state.predictions[seed.entityID] = {
            token = token,
            seedID = seed.entityID,
            predictedAt = now,
            expectedHitAt = round.startedAt + PREDICTED_HIT_OFFSET_MS,
            expiresAt = round.startedAt + PREDICTION_HARD_END_MS
                    + TOKEN_GRACE_MS,
        }
        created[#created + 1] = seed.entityID
    end
    state.lastDiagnostic = nil
    return true
end

local function handleAOECreate(state, aoeInfo, now)
    state = ensureState(state)
    if type(state.round) ~= 'table'
            or state.round.evaluated == true
    then
        return false
    end
    local aoe, relevant = readSproutingAOE(state, aoeInfo, now)
    if relevant ~= true or aoe == nil then
        return false
    end
    if state.aoes[aoe.entityID] ~= nil then
        return false
    end
    if countEntries(state.aoes) >= EXPECTED_AOE_COUNT then
        return false
    end
    state.aoes[aoe.entityID] = aoe
    if countEntries(state.aoes) < EXPECTED_AOE_COUNT then
        return true
    end
    state.round.evaluated = true
    local seeds = collectSeedGeometry(state)
    if seeds == nil then
        diagnostic(state, 'seed_geometry_unavailable', now, {
            observedSeedIDs = countEntries(state.seedIDs),
        })
        return false
    end
    local dangerous = selectDangerSeeds(seeds, state.aoes)
    if dangerous == nil then
        diagnostic(state, 'danger_set_mismatch', now, {
            aoes = countEntries(state.aoes),
            seeds = #seeds,
        })
        return false
    end
    return drawDangerSeeds(state, dangerous, now)
end

local function resolveSeedExplosion(state, entityID)
    state = ensureState(state)
    local seed = state.seedIDs[entityID]
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
        clearMechanic(state)
        changed = true
    end
    return changed
end

local Feature = {}

Feature.Init = function(M)
    if type(M.Iambe) == 'table' then
        clearState(M.Iambe)
        applyBlacklist(M.Iambe, false)
    end
    M.Iambe = newState()
    local cfg = getConfig(M)
    applyBlacklist(M.Iambe, cfg ~= nil
            and cfg.Enable == true
            and cfg.DrawSeedExplosionPrediction == true)
    M.SetIambeEnabled = function(enabled)
        local current = getConfig(M)
        if current ~= nil then
            current.Enable = enabled == true
        end
        if enabled ~= true then
            clearState(M.Iambe)
        end
        local active = current ~= nil
                and current.Enable == true
                and current.DrawSeedExplosionPrediction == true
        applyBlacklist(M.Iambe, active)
    end
    M.SetIambePredictionEnabled = function(enabled)
        local current = getConfig(M)
        if current ~= nil then
            current.DrawSeedExplosionPrediction = enabled == true
        end
        if enabled ~= true then
            clearState(M.Iambe)
        end
        local active = current ~= nil
                and current.Enable == true
                and current.DrawSeedExplosionPrediction == true
        applyBlacklist(M.Iambe, active)
    end
end

Feature.Clear = function(releaseOwnership)
    local state = getState()
    if state ~= nil then
        clearState(state)
        if releaseOwnership == true then
            applyBlacklist(state, false)
        end
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
        return type(state.predictions[entityID]) == 'table'
    end
    return false
end

Feature.OnAOECreate = function(aoeInfo, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state ~= nil and cfg ~= nil
            and cfg.Enable == true
            and cfg.DrawSeedExplosionPrediction == true
    then
        return handleAOECreate(state, aoeInfo, now)
    end
    return false
end

Feature.OnEntityCast = function(entityID, actionID)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state ~= nil and cfg ~= nil
            and cfg.Enable == true
            and cfg.DrawSeedExplosionPrediction == true
            and actionID == SEED_EXPLOSION_AID
    then
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
        applyBlacklist(state, true)
        return pruneState(state, now)
    end
    clearState(state)
    applyBlacklist(state, false)
    return false
end

Feature.Test = {
    Defaults = DEFAULTS,
    IambeContentID = IAMBE_CONTENT_ID,
    SeedContentID = SEED_CONTENT_ID,
    SeedModelID = SEED_MODEL_ID,
    DirectSowingActionID = DIRECT_SOWING_AID,
    SproutingRefrainActionID = SPROUTING_REFRAIN_AID,
    SeedExplosionActionID = SEED_EXPLOSION_AID,
    SproutingAOEType = SPROUTING_AOE_TYPE,
    SproutingCastType = SPROUTING_CAST_TYPE,
    SproutingRadius = SPROUTING_RADIUS,
    SproutingRadiusTolerance = SPROUTING_RADIUS_TOLERANCE,
    SeedExplosionRadius = SEED_EXPLOSION_RADIUS,
    ExpectedSeedCount = EXPECTED_SEED_COUNT,
    ExpectedAOECount = EXPECTED_AOE_COUNT,
    ExpectedDangerCount = EXPECTED_DANGER_COUNT,
    PredictedHitOffsetMs = PREDICTED_HIT_OFFSET_MS,
    PredictionHardEndMs = PREDICTION_HARD_END_MS,
    BlacklistSource = BLACKLIST_SOURCE,
    NewState = newState,
    EnsureState = ensureState,
    GetConfig = getConfig,
    ApplyBlacklist = applyBlacklist,
    BeginRound = beginRound,
    HandleEntityAdd = handleEntityAdd,
    CollectSeedGeometry = collectSeedGeometry,
    ReadSproutingAOE = readSproutingAOE,
    SelectDangerSeeds = selectDangerSeeds,
    HandleAOECreate = handleAOECreate,
    ResolveSeedExplosion = resolveSeedExplosion,
    PruneState = pruneState,
    ClearState = clearState,
}

return Feature
end

rawset(_G, 'MuAiOccultCrescentNorthIambe', Module)
return Module
