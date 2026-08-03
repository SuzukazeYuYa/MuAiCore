local Module = {}

function Module.Create(Context)
    assert(type(Context) == 'table' and type(Context.Common) == 'table')
    local Common = Context.Common
    local finite = Context.finite
    local nowMs = Context.nowMs
    local reliablePosition = Context.reliablePosition

local BOSS_CONTENT_ID = 14520
local FIRST_SLASH_AID = 47302
local SECOND_SLASH_AID = 47303
local SLASH_RADIUS = 30
local SLASH_ANGLE = math.pi
local FIRST_SLASH_DURATION = 3.7
local SECOND_SLASH_DURATION = 0.7
local SECOND_PREDICTION_MS = 4500
local SHAPE_GRACE_MS = 500
local HEADING_TOLERANCE = math.rad(3)

local ARENA_CENTER = { x = 659, y = 132.05, z = 659 }
local PAGE_RADIUS = 25
local PAGE_CHANNEL_TIME = 10.7
local PAGE_BATCH_WINDOW_MS = 250
local PAGE_SPECS = {
    [47315] = { contentID = 3915, modelID = 19412, divisor = 5 },
    [47316] = { contentID = 14521, modelID = 19413, divisor = 3 },
    [47317] = { contentID = 14522, modelID = 19414, divisor = 4 },
    [47318] = { contentID = 14528, modelID = 19415, prime = true },
}
local PRIMES = {
    [23] = true, [29] = true, [31] = true,
    [37] = true, [41] = true, [43] = true,
}

local BLACKLIST_SOURCE = 'MuAiCore - 古术魔典预测'
local LEGACY_BLACKLIST_SOURCE = 'Occult Reactions - Folios CE'
local OWNED_AIDS = {
    [FIRST_SLASH_AID] = true,
    [SECOND_SLASH_AID] = true,
    [47308] = true, [47309] = true, [47310] = true,
    [47311] = true, [47312] = true, [47313] = true,
    [47314] = true,
    [50554] = true, [50555] = true, [50556] = true,
    [50557] = true, [50558] = true, [50559] = true,
    [50560] = true, [50561] = true,
    [49879] = true,
}

local DEFAULTS = {
    Enable = true,
}

local function normalizeHeading(heading)
    return (heading + math.pi) % (2 * math.pi) - math.pi
end

local function newState()
    return {
        slash = nil,
        pageBatch = nil,
        pageTokens = {},
        blacklist = { owned = {}, registered = false },
        lastDiagnostic = nil,
    }
end

local function ensureState(state)
    state = type(state) == 'table' and state or newState()
    state.slash = type(state.slash) == 'table' and state.slash or nil
    state.pageBatch = type(state.pageBatch) == 'table'
            and state.pageBatch or nil
    state.pageTokens = type(state.pageTokens) == 'table'
            and state.pageTokens or {}
    state.blacklist = type(state.blacklist) == 'table'
            and state.blacklist or {}
    state.blacklist.owned = type(state.blacklist.owned) == 'table'
            and state.blacklist.owned or {}
    state.blacklist.registered = state.blacklist.registered == true
    return state
end

local feature = Common.newFeature({
    key = 'OccultGrimoire',
    defaults = DEFAULTS,
    newState = newState,
    ensureState = ensureState,
    diagnosticThrottleMs = 1000,
    diagnosticText = {
        slash_event_mismatch = '古术魔典前后刀事件实体不匹配',
        slash_geometry_mismatch = '古术魔典前后刀几何与实战样本不符',
        slash_prediction_mismatch = '古术魔典第二刀预测与实战几何不符',
        page_event_mismatch = '古术魔典书页事件实体不匹配',
        page_batch_incomplete = '古术魔典书页批次数量不完整',
        knowledge_level_unavailable = '古术魔典无法读取有效知见等级',
        danger_drawer_unavailable = '古术魔典危险范围绘图器不可用',
        danger_drawer_rejected_shape = '古术魔典危险范围绘制失败',
    },
})
local getConfig = feature.GetConfig

local function getState()
    return Common.getRuntimeState('OccultGrimoire', newState, ensureState)
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
    for actionID in pairs(OWNED_AIDS) do
        local current = blacklist[actionID]
        local owned = current == state.blacklist.owned[actionID]
                or (type(current) == 'table'
                        and current.source == BLACKLIST_SOURCE)
        local legacy = type(current) == 'table'
                and current.source == LEGACY_BLACKLIST_SOURCE
        if enabled == true then
            if current == nil or legacy then
                local replacement = {
                    label = '古术魔典预测',
                    source = BLACKLIST_SOURCE,
                }
                blacklist[actionID] = replacement
                state.blacklist.owned[actionID] = replacement
            elseif owned then
                state.blacklist.owned[actionID] = current
            else
                state.blacklist.owned[actionID] = nil
            end
        elseif owned then
            blacklist[actionID] = nil
        end
        if enabled ~= true then
            state.blacklist.owned[actionID] = nil
        end
    end
    state.blacklist.registered = enabled == true
    return true
end

local function deleteToken(token)
    if type(token) == 'string' then
        Common.deleteTimedShape(token)
    end
end

local function clearSlash(state)
    if type(state.slash) == 'table' then
        deleteToken(state.slash.token)
    end
    state.slash = nil
end

local function clearPages(state)
    for _, entry in pairs(state.pageTokens) do
        deleteToken(entry.token)
    end
    state.pageTokens = {}
    state.pageBatch = nil
end

local function clearMechanic(state)
    state = ensureState(state)
    clearSlash(state)
    clearPages(state)
    state.lastDiagnostic = nil
end

local function aoePosition(aoeInfo)
    if type(aoeInfo) ~= 'table' then
        return nil
    end
    return reliablePosition({
        x = tonumber(aoeInfo.x),
        y = tonumber(aoeInfo.y),
        z = tonumber(aoeInfo.z),
        h = tonumber(aoeInfo.heading),
    }, true)
end

local function hasSlashEffect(aoeInfo)
    return type(aoeInfo.aoeEffectInfo) == 'table'
            and aoeInfo.aoeEffectInfo.aoeEffectName == 'gl_fan180_1bf'
end

local function validSlashAOE(aoeInfo, actionID)
    local expectedDuration = actionID == FIRST_SLASH_AID
            and FIRST_SLASH_DURATION or SECOND_SLASH_DURATION
    local entityID = type(aoeInfo) == 'table'
            and tonumber(aoeInfo.entityID) or nil
    local position = aoePosition(aoeInfo)
    if position == nil
            or tonumber(aoeInfo.aoeID) ~= actionID
            or tonumber(aoeInfo.contentID) ~= BOSS_CONTENT_ID
            or tonumber(aoeInfo.aoeCastType) ~= 13
            or tonumber(aoeInfo.aoeType) ~= 107
            or math.abs((tonumber(aoeInfo.aoeLength) or -1)
                    - SLASH_RADIUS) > 0.1
            or math.abs((tonumber(aoeInfo.aoeWidth) or -1)) > 0.1
            or math.abs((tonumber(aoeInfo.duration) or -1)
                    - expectedDuration) > 0.15
            or not finite(tonumber(aoeInfo.startTime))
            or not hasSlashEffect(aoeInfo)
            or not finite(entityID) or entityID <= 0
    then
        return nil
    end
    return {
        entityID = entityID,
        startTime = tonumber(aoeInfo.startTime),
        origin = position,
        heading = normalizeHeading(position.h),
        duration = tonumber(aoeInfo.duration),
    }
end

local function drawCone(state, timeout, origin, radius, angle, heading, now)
    if not finite(timeout) or timeout <= 0
            or reliablePosition(origin, false) == nil
            or not finite(radius) or not finite(angle) or not finite(heading)
    then
        diagnostic(state, 'slash_geometry_mismatch', nowMs())
        return nil
    end
    local drawer = Common.getMoogleDrawer()
    if drawer == nil or type(drawer.addTimedCone) ~= 'function' then
        diagnostic(state, 'danger_drawer_unavailable', now)
        return nil
    end
    local token = drawer:addTimedCone(
            timeout,
            origin.x, origin.y, origin.z,
            radius, angle, normalizeHeading(heading))
    if type(token) ~= 'string' then
        diagnostic(state, 'danger_drawer_rejected_shape', now)
        return nil
    end
    return token
end

local function startSlash(state, aoeInfo, now)
    local slash = validSlashAOE(aoeInfo, FIRST_SLASH_AID)
    if slash == nil then
        diagnostic(state, 'slash_geometry_mismatch', now,
                type(aoeInfo) == 'table' and aoeInfo.aoeID or nil)
        return false
    end
    if type(state.slash) == 'table'
            and state.slash.entityID == slash.entityID
            and state.slash.startTime == slash.startTime
    then
        return false
    end
    clearSlash(state)
    slash.phase = 1
    slash.expectedSecondHeading = normalizeHeading(slash.heading + math.pi)
    slash.expiresAt = now + math.floor(slash.duration * 1000 + 0.5)
            + SHAPE_GRACE_MS
    slash.token = drawCone(
            state,
            math.floor(slash.duration * 1000 + 0.5) + SHAPE_GRACE_MS,
            slash.origin, SLASH_RADIUS, SLASH_ANGLE, slash.heading, now)
    if slash.token == nil then
        return false
    end
    state.slash = slash
    state.lastDiagnostic = nil
    return true
end

local function validateSecondSlash(state, aoeInfo, now)
    local actual = validSlashAOE(aoeInfo, SECOND_SLASH_AID)
    local slash = state.slash
    if actual == nil or type(slash) ~= 'table'
            or slash.phase ~= 2 or slash.entityID ~= actual.entityID
    then
        diagnostic(state, 'slash_event_mismatch', now)
        clearSlash(state)
        return false
    end
    local positionDistance = Common.distanceSquared(slash.origin, actual.origin)
    local headingDifference = Common.headingDifference(
            slash.expectedSecondHeading, actual.heading)
    if not finite(positionDistance) or positionDistance > 0.25
            or not finite(headingDifference)
            or headingDifference > HEADING_TOLERANCE
    then
        diagnostic(state, 'slash_prediction_mismatch', now, {
            expected = slash.expectedSecondHeading,
            actual = actual.heading,
        })
        clearSlash(state)
        return false
    end
    slash.secondValidated = true
    state.lastDiagnostic = nil
    return true
end

local function handleSlashCast(state, entityID, actionID, now)
    local slash = state.slash
    if type(slash) ~= 'table' or slash.entityID ~= entityID then
        return false
    end
    if actionID == FIRST_SLASH_AID and slash.phase == 1 then
        deleteToken(slash.token)
        slash.token = drawCone(
                state, SECOND_PREDICTION_MS,
                slash.origin, SLASH_RADIUS, SLASH_ANGLE,
                slash.expectedSecondHeading, now)
        if slash.token == nil then
            state.slash = nil
            return false
        end
        slash.phase = 2
        slash.expiresAt = now + SECOND_PREDICTION_MS
        state.lastDiagnostic = nil
        return true
    end
    if actionID == SECOND_SLASH_AID and slash.phase == 2 then
        clearSlash(state)
        return true
    end
    return false
end

local function handlePageChannel(state, entityID, actionID, channelTime, now)
    local spec = PAGE_SPECS[actionID]
    if spec == nil then
        return false
    end
    if not finite(entityID) or entityID <= 0
            or not finite(channelTime)
            or math.abs(channelTime - PAGE_CHANNEL_TIME) > 0.15
            or not finite(now)
    then
        diagnostic(state, 'page_event_mismatch', nowMs(), {
            entityID = entityID,
            actionID = actionID,
        })
        return false
    end
    local batch = state.pageBatch
    if type(batch) ~= 'table'
            or now - batch.startedAt > PAGE_BATCH_WINDOW_MS
    then
        if type(batch) == 'table' then
            diagnostic(state, 'page_batch_incomplete', now, batch.count)
        end
        batch = {
            startedAt = now,
            resolveAt = now + PAGE_BATCH_WINDOW_MS,
            endsAt = now + math.floor(channelTime * 1000 + 0.5),
            entries = {},
            count = 0,
        }
        state.pageBatch = batch
    end
    if batch.entries[entityID] ~= nil then
        return false
    end
    batch.entries[entityID] = {
        entityID = entityID,
        actionID = actionID,
        spec = spec,
    }
    batch.count = batch.count + 1
    batch.endsAt = math.min(batch.endsAt,
            now + math.floor(channelTime * 1000 + 0.5))
    state.lastDiagnostic = nil
    return true
end

local function resolvePagePositions(batch)
    local tensorCore = rawget(_G, 'TensorCore')
    if type(tensorCore) ~= 'table'
            or type(tensorCore.entityList) ~= 'function'
    then
        return false
    end
    for entityID, entry in pairs(batch.entries) do
        local entities = tensorCore.entityList(
                'contentid=' .. tostring(entry.spec.contentID))
        local position = nil
        if type(entities) == 'table' then
            for _, entity in pairs(entities) do
                if type(entity) == 'table'
                        and tonumber(entity.id) == entityID
                        and tonumber(entity.contentid) == entry.spec.contentID
                        and tonumber(entity.modelid) == entry.spec.modelID
                then
                    position = reliablePosition(entity.pos, false)
                    break
                end
            end
        end
        if position == nil then
            return false
        end
        entry.position = position
    end
    return true
end

local function knowledgeLevel()
    if type(TensorCore) ~= 'table'
            or type(TensorCore.getOccultCrescentInfo) ~= 'function'
    then
        return nil
    end
    local _, _, _, level = TensorCore.getOccultCrescentInfo()
    level = tonumber(level)
    if not finite(level) or level <= 0 or level ~= math.floor(level) then
        return nil
    end
    return level
end

local function pageIsUnsafe(spec, level)
    if spec.prime == true then
        return PRIMES[level] == true
    end
    return level % spec.divisor == 0
end

local function resolvePageBatch(state, now)
    local batch = state.pageBatch
    if type(batch) ~= 'table' or now < batch.resolveAt then
        return false
    end
    state.pageBatch = nil
    if batch.count ~= 2 and batch.count ~= 3 then
        diagnostic(state, 'page_batch_incomplete', now, batch.count)
        return false
    end
    if not resolvePagePositions(batch) then
        diagnostic(state, 'page_event_mismatch', now, batch.count)
        return false
    end
    local level = knowledgeLevel()
    if level == nil then
        diagnostic(state, 'knowledge_level_unavailable', now)
        return false
    end
    local duration = batch.endsAt - now + SHAPE_GRACE_MS
    if duration <= 0 then
        diagnostic(state, 'page_batch_incomplete', now, batch.count)
        return false
    end
    local angle = batch.count == 2 and math.pi or math.rad(120)
    local created = {}
    for entityID, entry in pairs(batch.entries) do
        if pageIsUnsafe(entry.spec, level) then
            local dx = entry.position.x - ARENA_CENTER.x
            local dz = entry.position.z - ARENA_CENTER.z
            local heading = math.atan2(dx, dz)
            local token = drawCone(
                    state, duration,
                    ARENA_CENTER, PAGE_RADIUS, angle, heading, now)
            if token == nil then
                for _, createdEntry in pairs(created) do
                    deleteToken(createdEntry.token)
                end
                return false
            end
            created[entityID] = {
                token = token,
                actionID = entry.actionID,
                expiresAt = now + duration,
            }
        end
    end
    for entityID, entry in pairs(created) do
        local previous = state.pageTokens[entityID]
        if type(previous) == 'table' then
            deleteToken(previous.token)
        end
        state.pageTokens[entityID] = entry
    end
    state.lastDiagnostic = nil
    return true
end

local function clearPageCast(state, entityID, actionID)
    if PAGE_SPECS[actionID] == nil then
        return false
    end
    local active = state.pageTokens[entityID]
    if type(active) == 'table' and active.actionID == actionID then
        deleteToken(active.token)
        state.pageTokens[entityID] = nil
        return true
    end
    return false
end

local function prune(state, now)
    if type(state.slash) == 'table' and now >= state.slash.expiresAt then
        clearSlash(state)
    end
    for entityID, entry in pairs(state.pageTokens) do
        if not finite(entry.expiresAt) or now >= entry.expiresAt then
            state.pageTokens[entityID] = nil
        end
    end
end

local Feature = {}

Feature.Init = function(M)
    if type(M.OccultGrimoire) == 'table' then
        applyBlacklist(M.OccultGrimoire, false)
        clearMechanic(M.OccultGrimoire)
    end
    M.OccultGrimoire = newState()
    local cfg = getConfig(M)
    applyBlacklist(M.OccultGrimoire, cfg ~= nil and cfg.Enable == true)
    M.SetOccultGrimoireEnabled = function(enabled)
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

Feature.OnEntityChannel = function(entityID, actionID, channelTime, now)
    local cfg = getConfig(rawget(_G, 'MuAiGuide'))
    local state = getState()
    if state ~= nil and cfg ~= nil and cfg.Enable == true then
        return handlePageChannel(
                state, entityID, actionID, channelTime, now)
    end
    return false
end

Feature.OnAOECreate = function(aoeInfo, now)
    local cfg = getConfig(rawget(_G, 'MuAiGuide'))
    local state = getState()
    if state == nil or cfg == nil or cfg.Enable ~= true then
        return false
    end
    local actionID = type(aoeInfo) == 'table'
            and tonumber(aoeInfo.aoeID) or nil
    if actionID == FIRST_SLASH_AID then
        return startSlash(state, aoeInfo, now)
    end
    if actionID == SECOND_SLASH_AID then
        return validateSecondSlash(state, aoeInfo, now)
    end
    return false
end

Feature.OnEntityCast = function(entityID, actionID, now)
    local cfg = getConfig(rawget(_G, 'MuAiGuide'))
    local state = getState()
    if state == nil or cfg == nil or cfg.Enable ~= true then
        return false
    end
    if actionID == FIRST_SLASH_AID or actionID == SECOND_SLASH_AID then
        return handleSlashCast(state, entityID, actionID, now)
    end
    return clearPageCast(state, entityID, actionID)
end

Feature.Update = function(_, now)
    local state = getState()
    if state == nil or not finite(now) then
        return false
    end
    local cfg = getConfig(rawget(_G, 'MuAiGuide'))
    if cfg ~= nil and cfg.Enable == true then
        applyBlacklist(state, true)
        resolvePageBatch(state, now)
        prune(state, now)
        return false
    end
    clearMechanic(state)
    applyBlacklist(state, false)
    return false
end

Feature.Test = {
    Defaults = DEFAULTS,
    BossContentID = BOSS_CONTENT_ID,
    FirstSlashAID = FIRST_SLASH_AID,
    SecondSlashAID = SECOND_SLASH_AID,
    SlashRadius = SLASH_RADIUS,
    SlashAngle = SLASH_ANGLE,
    SecondPredictionMs = SECOND_PREDICTION_MS,
    PageRadius = PAGE_RADIUS,
    PageBatchWindowMs = PAGE_BATCH_WINDOW_MS,
    BlacklistSource = BLACKLIST_SOURCE,
    OwnedAIDs = OWNED_AIDS,
    NormalizeHeading = normalizeHeading,
    NewState = newState,
    EnsureState = ensureState,
    ApplyBlacklist = applyBlacklist,
    ClearMechanic = clearMechanic,
}

return Feature
end

rawset(_G, 'MuAiOccultCrescentNorthOccultGrimoire', Module)
return Module
