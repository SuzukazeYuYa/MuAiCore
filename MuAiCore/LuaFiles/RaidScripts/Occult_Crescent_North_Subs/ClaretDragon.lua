local Module = {}

function Module.Create(Context)
    assert(type(Context) == 'table' and type(Context.Common) == 'table')
    local Common = Context.Common
    local finite = Context.finite
    local reliablePosition = Context.reliablePosition

local DRAGON_CONTENT_ID = 14787
local DRAGON_MODEL_ID = 9020
local NECROHAZE_CONTENT_ID = 14788
local NECROHAZE_MODEL_ID = 19527
local CAUTERIZE_AID = 48265

local DASH_LENGTH = 40
local NECROHAZE_LENGTH = 40
local NECROHAZE_WIDTH = 10
local PATH_MATCH_RADIUS = 5.25
local PATH_MATCH_RADIUS_SQUARED = PATH_MATCH_RADIUS * PATH_MATCH_RADIUS
local CHANNEL_MIN_SECONDS = 6.2
local CHANNEL_MAX_SECONDS = 7.2
local DRAW_GRACE_MS = 1800
local RESOLVE_TIMEOUT_MS = 1500
local DEDUPE_MS = 10000
local SEEN_TTL_MS = 30000

local DEFAULTS = {
    Enable = true,
}

local function newState()
    return {
        pending = {},
        active = {},
        seen = {},
        nextSequence = 0,
        lastDiagnostic = nil,
    }
end

local function ensureState(state)
    state = type(state) == 'table' and state or newState()
    state.pending = type(state.pending) == 'table' and state.pending or {}
    state.active = type(state.active) == 'table' and state.active or {}
    state.seen = type(state.seen) == 'table' and state.seen or {}
    state.nextSequence = finite(state.nextSequence)
            and state.nextSequence or 0
    return state
end

local feature = Common.newFeature({
    key = 'ClaretDragon',
    defaults = DEFAULTS,
    newState = newState,
    ensureState = ensureState,
    diagnosticThrottleMs = 1000,
    diagnosticText = {
        channel_entity_unresolved = '赤龙低温俯冲实体未能可靠解析',
        necrohaze_entities_unresolved = '赤龙低温俯冲未能解析僵尸毒气阵列',
        necrohaze_geometry_empty = '赤龙低温俯冲未匹配到有效毒气线',
        danger_drawer_unavailable = '赤龙毒气线绘图器不可用',
        danger_drawer_rejected_shape = '赤龙毒气线绘制失败',
    },
})
local getConfig = feature.GetConfig

local function getState()
    return Common.getRuntimeState('ClaretDragon', newState, ensureState)
end

local function diagnostic(state, code, now, context)
    feature.Diagnostic(
            state, rawget(_G, 'MuAiGuide'), code, now, context)
end

local function clearActive(state)
    for _, entry in pairs(state.active) do
        if type(entry) == 'table' and type(entry.tokens) == 'table' then
            for _, token in ipairs(entry.tokens) do
                Common.deleteTimedShape(token)
            end
        end
    end
    state.active = {}
end

local function clearState(state)
    state = ensureState(state)
    clearActive(state)
    state.pending = {}
    state.seen = {}
    state.nextSequence = 0
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

local function entityVisible(entity)
    local entityID = type(entity) == 'table' and tonumber(entity.id) or nil
    local argus = rawget(_G, 'Argus')
    return finite(entityID)
            and type(argus) == 'table'
            and type(argus.isEntityVisible) == 'function'
            and argus.isEntityVisible(entityID) == true
end

local function resolveDragon(entityID)
    local entities = entitiesByContent(DRAGON_CONTENT_ID)
    if entities == nil then
        return nil
    end
    for _, entity in pairs(entities) do
        if type(entity) == 'table'
                and tonumber(entity.id) == entityID
                and tonumber(entity.contentid) == DRAGON_CONTENT_ID
                and Common.entityModelID(entity) == DRAGON_MODEL_ID
                and entity.alive ~= false
        then
            return reliablePosition(entity.pos, true)
        end
    end
    return nil
end

local function validNecrohaze(entity)
    if type(entity) ~= 'table'
            or tonumber(entity.contentid) ~= NECROHAZE_CONTENT_ID
            or Common.entityModelID(entity) ~= NECROHAZE_MODEL_ID
            or entity.alive == false
            or not entityVisible(entity)
    then
        return nil
    end
    local position = reliablePosition(entity.pos, true)
    if position == nil then
        return nil
    end
    return {
        entityID = tonumber(entity.id),
        position = position,
    }
end

local function matchingNecrohazes(dragonPosition)
    local entities = entitiesByContent(NECROHAZE_CONTENT_ID)
    if entities == nil then
        return nil
    end
    local vx = math.sin(dragonPosition.h) * DASH_LENGTH
    local vz = math.cos(dragonPosition.h) * DASH_LENGTH
    local lengthSquared = vx * vx + vz * vz
    if lengthSquared <= 0 then
        return {}
    end
    local matches = {}
    for _, entity in pairs(entities) do
        local haze = validNecrohaze(entity)
        if haze ~= nil and finite(haze.entityID) and haze.entityID > 0 then
            local position = haze.position
            local wx = position.x - dragonPosition.x
            local wz = position.z - dragonPosition.z
            local along = (wx * vx + wz * vz) / lengthSquared
            if along >= 0 and along <= 1 then
                local nearestX = dragonPosition.x + along * vx
                local nearestZ = dragonPosition.z + along * vz
                local dx = position.x - nearestX
                local dz = position.z - nearestZ
                if dx * dx + dz * dz <= PATH_MATCH_RADIUS_SQUARED then
                    matches[#matches + 1] = haze
                end
            end
        end
    end
    table.sort(matches, function(left, right)
        return left.entityID < right.entityID
    end)
    return matches
end

local function drawNecrohazes(state, pending, hazes, now)
    local drawer = Common.getMoogleDrawer()
    if drawer == nil or type(drawer.addTimedRect) ~= 'function' then
        diagnostic(state, 'danger_drawer_unavailable', now, pending.entityID)
        return false
    end
    local remaining = pending.expiresAt - now
    if remaining <= 0 then
        return false
    end
    local tokens = {}
    for _, haze in ipairs(hazes) do
        local position = haze.position
        local token = drawer:addTimedRect(
                remaining,
                position.x, position.y + 0.02, position.z,
                NECROHAZE_LENGTH, NECROHAZE_WIDTH, position.h, 0)
        if type(token) ~= 'string' then
            for _, rollback in ipairs(tokens) do
                Common.deleteTimedShape(rollback)
            end
            diagnostic(state, 'danger_drawer_rejected_shape', now,
                    haze.entityID)
            return false
        end
        tokens[#tokens + 1] = token
    end
    state.nextSequence = state.nextSequence + 1
    local key = tostring(pending.entityID)
            .. ':' .. tostring(state.nextSequence)
    state.active[key] = {
        entityID = pending.entityID,
        createdAt = now,
        expiresAt = pending.expiresAt,
        tokens = tokens,
    }
    state.lastDiagnostic = nil
    return true
end

local function resolvePending(state, entityID, now)
    local pending = state.pending[entityID]
    if type(pending) ~= 'table' then
        return false
    end
    local dragon = resolveDragon(entityID)
    if dragon == nil then
        if now >= pending.resolveDeadline then
            state.pending[entityID] = nil
            diagnostic(state, 'channel_entity_unresolved', now, entityID)
        end
        return false
    end
    local hazes = matchingNecrohazes(dragon)
    if hazes == nil then
        if now >= pending.resolveDeadline then
            state.pending[entityID] = nil
            diagnostic(state, 'necrohaze_entities_unresolved', now, entityID)
        end
        return false
    end
    if #hazes == 0 then
        if now >= pending.resolveDeadline then
            state.pending[entityID] = nil
            diagnostic(state, 'necrohaze_geometry_empty', now, entityID)
        end
        return false
    end
    if not drawNecrohazes(state, pending, hazes, now) then
        if now >= pending.resolveDeadline then
            state.pending[entityID] = nil
        end
        return false
    end
    state.pending[entityID] = nil
    return true
end

local function recordChannel(
        state, entityID, actionID, channelTimeSeconds, now)
    entityID = tonumber(entityID)
    actionID = tonumber(actionID)
    channelTimeSeconds = tonumber(channelTimeSeconds)
    if actionID ~= CAUTERIZE_AID
            or not finite(entityID)
            or entityID <= 0
            or not finite(channelTimeSeconds)
            or channelTimeSeconds < CHANNEL_MIN_SECONDS
            or channelTimeSeconds > CHANNEL_MAX_SECONDS
            or not finite(now)
    then
        return false
    end
    local key = tostring(entityID) .. ':' .. tostring(actionID)
    if not Common.consumeEvent(state.seen, key, now, DEDUPE_MS) then
        return false
    end
    state.pending[entityID] = {
        entityID = entityID,
        recordedAt = now,
        resolveDeadline = now + RESOLVE_TIMEOUT_MS,
        expiresAt = now + channelTimeSeconds * 1000 + DRAW_GRACE_MS,
    }
    return resolvePending(state, entityID, now)
end

local function prune(state, now)
    for key, entry in pairs(state.active) do
        if type(entry) ~= 'table'
                or not finite(entry.expiresAt)
                or now >= entry.expiresAt
        then
            state.active[key] = nil
        end
    end
    Common.pruneSeen(state.seen, now, SEEN_TTL_MS)
end

local function processPending(state, now)
    local ids = {}
    for entityID in pairs(state.pending) do
        ids[#ids + 1] = entityID
    end
    table.sort(ids)
    local resolved = false
    for _, entityID in ipairs(ids) do
        resolved = resolvePending(state, entityID, now) or resolved
    end
    return resolved
end

local Feature = {}

Feature.Init = function(M)
    if type(M.ClaretDragon) == 'table' then
        clearState(M.ClaretDragon)
    end
    M.ClaretDragon = newState()
    getConfig(M)
    M.SetClaretDragonEnabled = function(enabled)
        local cfg = getConfig(M)
        if cfg ~= nil then
            cfg.Enable = enabled == true
        end
        if enabled ~= true then
            clearState(M.ClaretDragon)
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
        entityID, actionID, channelTimeSeconds, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state ~= nil and cfg ~= nil and cfg.Enable == true then
        return recordChannel(
                state, entityID, actionID, channelTimeSeconds, now)
    end
    return false
end

Feature.Update = function(_, now)
    local state = getState()
    if state == nil or not finite(now) then
        return false
    end
    local cfg = getConfig(rawget(_G, 'MuAiGuide'))
    if cfg == nil or cfg.Enable ~= true then
        clearState(state)
        return false
    end
    prune(state, now)
    return processPending(state, now)
end

Feature.Test = {
    Defaults = DEFAULTS,
    DragonContentID = DRAGON_CONTENT_ID,
    DragonModelID = DRAGON_MODEL_ID,
    NecrohazeContentID = NECROHAZE_CONTENT_ID,
    NecrohazeModelID = NECROHAZE_MODEL_ID,
    CauterizeActionID = CAUTERIZE_AID,
    DashLength = DASH_LENGTH,
    NecrohazeLength = NECROHAZE_LENGTH,
    NecrohazeWidth = NECROHAZE_WIDTH,
    PathMatchRadius = PATH_MATCH_RADIUS,
    ChannelMinSeconds = CHANNEL_MIN_SECONDS,
    ChannelMaxSeconds = CHANNEL_MAX_SECONDS,
    DrawGraceMs = DRAW_GRACE_MS,
    ResolveTimeoutMs = RESOLVE_TIMEOUT_MS,
    NewState = newState,
    MatchingNecrohazes = matchingNecrohazes,
    RecordChannel = recordChannel,
    ResolvePending = resolvePending,
}

    return Feature
end

rawset(_G, 'MuAiOccultCrescentNorthClaretDragon', Module)
return Module
