local Module = {}

function Module.Create(Context)
    assert(type(Context) == 'table' and type(Context.Common) == 'table')
    local Common = Context.Common
    local finite = Context.finite
    local nowMs = Context.nowMs
    local reliablePosition = Context.reliablePosition
    local resolveEntity = Context.resolveEntity

local BOSS_CONTENT_ID = 14517

local FIRST_SLASH_AID = 50691
local SECOND_SLASH_AID = 50692
local SLASH_RADIUS = 60
local SLASH_ANGLE = math.pi

local SLIDE_SPECS = {
    [49052] = { minLength = 14, maxLength = 16,
        minDuration = 5, maxDuration = 7 },
    [49053] = { minLength = 25, maxLength = 27,
        minDuration = 0.2, maxDuration = 1.5 },
}

-- 47054/47057/47058 resolve the first slash 90 degrees to the boss's left
-- heading. The 47055/47056/47059 variant mirrors the order. The offsets are
-- repeated consistently across all nine slide destinations in the capture.
local ORDER_OFFSETS = {
    [47054] = -math.pi / 2,
    [47057] = -math.pi / 2,
    [47058] = -math.pi / 2,
    [47055] = math.pi / 2,
    [47056] = math.pi / 2,
    [47059] = math.pi / 2,
}

local HAIR_RETURN_AIDS = {
    [47062] = true,
    [47065] = true,
}

local PATH_EXTRA_MS = 4000
local EXACT_GRACE_MS = 750
local SECOND_TIMEOUT_MS = 3000
local SEQUENCE_TIMEOUT_MS = 15000
local PAIR_WINDOW_MS = 1000
local POSITION_TOLERANCE_SQ = 0.5 * 0.5
local HEADING_TOLERANCE = math.rad(3)

local BLACKLIST_SOURCE = 'MuAiCore - 卡洛菲斯提莉二重身预测'
local OWNED_AIDS = {
    [FIRST_SLASH_AID] = true,
    [SECOND_SLASH_AID] = true,
}

local DEFAULTS = {
    Enable = true,
}

local function normalizeHeading(heading)
    return (heading + math.pi) % (2 * math.pi) - math.pi
end

local function headingsMatch(actual, expected)
    return finite(actual)
            and finite(expected)
            and math.abs(normalizeHeading(actual - expected))
                    <= HEADING_TOLERANCE
end

local function newState()
    return {
        orderOffset = nil,
        slash = nil,
        pendingSecond = nil,
        blacklist = { owned = {}, registered = false },
        lastDiagnostic = nil,
    }
end

local function ensureState(state)
    state = type(state) == 'table' and state or newState()
    state.slash = type(state.slash) == 'table' and state.slash or nil
    state.pendingSecond = type(state.pendingSecond) == 'table'
            and state.pendingSecond or nil
    state.blacklist = type(state.blacklist) == 'table'
            and state.blacklist or {}
    state.blacklist.owned = type(state.blacklist.owned) == 'table'
            and state.blacklist.owned or {}
    state.blacklist.registered = state.blacklist.registered == true
    return state
end

local feature = Common.newFeature({
    key = 'CalofisteriDoppelganger',
    defaults = DEFAULTS,
    newState = newState,
    ensureState = ensureState,
    diagnosticThrottleMs = 1000,
    diagnosticText = {
        boss_entity_mismatch = '卡洛菲斯提莉二重身事件实体不匹配',
        slide_geometry_mismatch = '卡洛菲斯提莉二重身滑斩几何不匹配',
        slash_geometry_mismatch = '卡洛菲斯提莉二重身双重魔发斩几何不匹配',
        slash_pair_mismatch = '卡洛菲斯提莉二重身双重魔发斩两段几何不一致',
        slash_pair_missing = '卡洛菲斯提莉二重身缺少第二段魔发斩几何',
        prediction_geometry_mismatch = '卡洛菲斯提莉二重身提前预测与实战几何不一致',
        danger_drawer_unavailable = '卡洛菲斯提莉二重身危险范围绘图器不可用',
        danger_drawer_rejected_shape = '卡洛菲斯提莉二重身危险范围绘制失败',
    },
})
local getConfig = feature.GetConfig

local function getState()
    return Common.getRuntimeState(
            'CalofisteriDoppelganger', newState, ensureState)
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
                label = '卡洛菲斯提莉二重身预测',
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

local function deleteToken(entry)
    if type(entry) ~= 'table' or type(entry.token) ~= 'string' then
        return false
    end
    Common.deleteTimedShape(entry.token)
    entry.token = nil
    return true
end

local function clearSlash(state)
    state = ensureState(state)
    deleteToken(state.slash)
    state.slash = nil
    state.pendingSecond = nil
end

local function clearState(state)
    state = ensureState(state)
    clearSlash(state)
    state.orderOffset = nil
    state.lastDiagnostic = nil
end

local function validPosition(aoeInfo)
    if type(aoeInfo) ~= 'table' then
        return nil
    end
    return reliablePosition({
        x = aoeInfo.x,
        y = aoeInfo.y,
        z = aoeInfo.z,
        h = aoeInfo.heading,
    }, true)
end

local function samePosition(left, right)
    local distance = Common.distanceSquared(left, right)
    return finite(distance) and distance <= POSITION_TOLERANCE_SQ
end

local function drawSlash(state, entry, heading, timeout, now)
    local position = type(entry) == 'table'
            and reliablePosition(entry.origin, false) or nil
    if position == nil
            or not finite(heading)
            or not finite(timeout)
            or timeout <= 0
    then
        diagnostic(state, 'slash_geometry_mismatch', nowMs(), entry)
        return false
    end
    local drawer = Common.getMoogleDrawer()
    if drawer == nil or type(drawer.addTimedCone) ~= 'function' then
        diagnostic(state, 'danger_drawer_unavailable', now, entry.entityID)
        return false
    end
    local token = drawer:addTimedCone(
            timeout,
            position.x, position.y, position.z,
            SLASH_RADIUS, SLASH_ANGLE,
            normalizeHeading(heading))
    if type(token) ~= 'string' then
        diagnostic(state, 'danger_drawer_rejected_shape', now, entry.entityID)
        return false
    end
    deleteToken(entry)
    entry.token = token
    state.lastDiagnostic = nil
    return true
end

local function isBoss(entityID)
    local entity = resolveEntity(entityID)
    return type(entity) == 'table'
            and tonumber(entity.id) == entityID
            and tonumber(entity.contentid) == BOSS_CONTENT_ID
end

local function setOrder(state, entityID, actionID, now)
    local offset = ORDER_OFFSETS[actionID]
    if offset == nil then
        return false
    end
    if not finite(entityID) or not isBoss(entityID) then
        diagnostic(state, 'boss_entity_mismatch', now, {
            entityID = entityID,
            actionID = actionID,
        })
        return false
    end
    state.orderOffset = offset
    state.lastDiagnostic = nil
    return true
end

local function validSlide(aoeInfo)
    local spec = type(aoeInfo) == 'table'
            and SLIDE_SPECS[aoeInfo.aoeID] or nil
    local position = validPosition(aoeInfo)
    if spec == nil
            or position == nil
            or aoeInfo.contentID ~= BOSS_CONTENT_ID
            or aoeInfo.aoeCastType ~= 8
            or not finite(aoeInfo.aoeLength)
            or aoeInfo.aoeLength < spec.minLength
            or aoeInfo.aoeLength > spec.maxLength
            or not finite(aoeInfo.aoeWidth)
            or math.abs(aoeInfo.aoeWidth - 10) > 0.5
            or not finite(aoeInfo.duration)
            or aoeInfo.duration < spec.minDuration
            or aoeInfo.duration > spec.maxDuration
    then
        return nil
    end
    return position
end

local function predictFromSlide(state, aoeInfo, now)
    if SLIDE_SPECS[type(aoeInfo) == 'table'
            and aoeInfo.aoeID or nil] == nil
    then
        return false
    end
    if not finite(state.orderOffset) then
        return false
    end
    local start = validSlide(aoeInfo)
    if start == nil then
        diagnostic(state, 'slide_geometry_mismatch', now, aoeInfo.aoeID)
        clearSlash(state)
        return false
    end
    local origin = {
        x = start.x + math.sin(start.h) * aoeInfo.aoeLength,
        y = start.y,
        z = start.z + math.cos(start.h) * aoeInfo.aoeLength,
    }
    local firstHeading = normalizeHeading(start.h + state.orderOffset)
    local entry = {
        entityID = aoeInfo.entityID,
        origin = origin,
        firstHeading = firstHeading,
        secondHeading = normalizeHeading(firstHeading + math.pi),
        phase = 1,
        predicted = true,
        secondValidated = false,
        expiresAt = now + SEQUENCE_TIMEOUT_MS,
    }
    clearSlash(state)
    state.slash = entry
    local timeout = math.floor(aoeInfo.duration * 1000 + 0.5)
            + PATH_EXTRA_MS
    if not drawSlash(state, entry, firstHeading, timeout, now) then
        state.slash = nil
        return false
    end
    return true
end

local function validExactSlash(aoeInfo, actionID)
    local position = validPosition(aoeInfo)
    local expectedDuration = actionID == FIRST_SLASH_AID and 2.5 or 4.5
    if position == nil
            or aoeInfo.contentID ~= BOSS_CONTENT_ID
            or aoeInfo.aoeCastType ~= 13
            or not finite(aoeInfo.aoeLength)
            or math.abs(aoeInfo.aoeLength - SLASH_RADIUS) > 0.1
            or not finite(aoeInfo.duration)
            or math.abs(aoeInfo.duration - expectedDuration) > 0.5
            or not finite(aoeInfo.entityID)
            or aoeInfo.entityID <= 0
    then
        return nil
    end
    return position
end

local function secondMatches(entry, second)
    return type(entry) == 'table'
            and type(second) == 'table'
            and samePosition(entry.origin, second.origin)
            and headingsMatch(second.heading, entry.secondHeading)
end

local function attachSecond(state, entry, second, now)
    if not secondMatches(entry, second) then
        diagnostic(state, 'slash_pair_mismatch', now, {
            firstEntityID = entry.entityID,
            secondEntityID = second.entityID,
        })
        clearSlash(state)
        return false
    end
    entry.secondEntityID = second.entityID
    entry.secondHeading = second.heading
    entry.secondValidated = true
    state.pendingSecond = nil
    state.lastDiagnostic = nil
    return true
end

local function storeSecond(state, aoeInfo, now)
    local position = validExactSlash(aoeInfo, SECOND_SLASH_AID)
    if position == nil then
        diagnostic(state, 'slash_geometry_mismatch', now, SECOND_SLASH_AID)
        clearSlash(state)
        return false
    end
    local second = {
        entityID = aoeInfo.entityID,
        origin = position,
        heading = normalizeHeading(position.h),
        receivedAt = now,
    }
    if type(state.slash) == 'table' and state.slash.phase == 1 then
        return attachSecond(state, state.slash, second, now)
    end
    state.pendingSecond = second
    return true
end

local function startExactFirst(state, aoeInfo, now)
    local position = validExactSlash(aoeInfo, FIRST_SLASH_AID)
    if position == nil then
        diagnostic(state, 'slash_geometry_mismatch', now, FIRST_SLASH_AID)
        clearSlash(state)
        return false
    end
    local firstHeading = normalizeHeading(position.h)
    local predicted = state.slash
    local predictedSecond = type(predicted) == 'table'
            and predicted.secondValidated == true
            and {
                entityID = predicted.secondEntityID,
                origin = predicted.origin,
                heading = predicted.secondHeading,
                receivedAt = now,
            } or nil
    if type(predicted) == 'table'
            and predicted.predicted == true
            and (not samePosition(predicted.origin, position)
                    or not headingsMatch(
                            predicted.firstHeading, firstHeading))
    then
        diagnostic(state, 'prediction_geometry_mismatch', now, {
            predictedHeading = predicted.firstHeading,
            actualHeading = firstHeading,
        })
        clearSlash(state)
        return false
    end
    deleteToken(predicted)
    local entry = {
        entityID = aoeInfo.entityID,
        origin = position,
        firstHeading = firstHeading,
        secondHeading = normalizeHeading(firstHeading + math.pi),
        phase = 1,
        predicted = false,
        secondValidated = false,
        expiresAt = now + SEQUENCE_TIMEOUT_MS,
    }
    state.slash = entry
    local second = state.pendingSecond or predictedSecond
    if type(second) == 'table'
            and finite(second.receivedAt)
            and now - second.receivedAt <= PAIR_WINDOW_MS
    then
        if not attachSecond(state, entry, second, now) then
            return false
        end
    else
        state.pendingSecond = nil
    end
    local timeout = math.floor(aoeInfo.duration * 1000 + 0.5)
            + EXACT_GRACE_MS
    if not drawSlash(state, entry, firstHeading, timeout, now) then
        state.slash = nil
        return false
    end
    return true
end

local function handleAOECreate(state, aoeInfo, now)
    local actionID = type(aoeInfo) == 'table' and aoeInfo.aoeID or nil
    if SLIDE_SPECS[actionID] ~= nil then
        return predictFromSlide(state, aoeInfo, now)
    end
    if actionID == SECOND_SLASH_AID then
        return storeSecond(state, aoeInfo, now)
    end
    if actionID == FIRST_SLASH_AID then
        return startExactFirst(state, aoeInfo, now)
    end
    return false
end

local function handleCast(state, entityID, actionID, now)
    if ORDER_OFFSETS[actionID] ~= nil then
        return setOrder(state, entityID, actionID, now)
    end
    if HAIR_RETURN_AIDS[actionID] == true then
        state.orderOffset = nil
        clearSlash(state)
        return true
    end
    local entry = state.slash
    if type(entry) ~= 'table' then
        return false
    end
    if actionID == FIRST_SLASH_AID
            and entry.phase == 1
            and entry.entityID == entityID
    then
        deleteToken(entry)
        if entry.secondValidated ~= true then
            diagnostic(state, 'slash_pair_missing', now, entityID)
            clearSlash(state)
            return false
        end
        entry.phase = 2
        entry.expiresAt = now + SECOND_TIMEOUT_MS + EXACT_GRACE_MS
        return drawSlash(
                state, entry, entry.secondHeading,
                SECOND_TIMEOUT_MS, now)
    end
    if actionID == SECOND_SLASH_AID
            and entry.phase == 2
            and entry.secondEntityID == entityID
    then
        clearSlash(state)
        return true
    end
    return false
end

local function pruneState(state, now)
    state = ensureState(state)
    if not finite(now) then
        return false
    end
    if type(state.pendingSecond) == 'table'
            and (not finite(state.pendingSecond.receivedAt)
                    or now - state.pendingSecond.receivedAt > PAIR_WINDOW_MS)
    then
        state.pendingSecond = nil
    end
    if type(state.slash) == 'table'
            and (not finite(state.slash.expiresAt)
                    or now > state.slash.expiresAt)
    then
        clearSlash(state)
        return true
    end
    return false
end

local Feature = {}

Feature.Init = function(M)
    if type(M.CalofisteriDoppelganger) == 'table' then
        clearState(M.CalofisteriDoppelganger)
        applyBlacklist(M.CalofisteriDoppelganger, false)
    end
    M.CalofisteriDoppelganger = newState()
    local cfg = getConfig(M)
    M.SetCalofisteriDoppelgangerEnabled = function(enabled)
        local current = getConfig(M)
        if current ~= nil then
            current.Enable = enabled == true
        end
        if enabled == true then
            applyBlacklist(M.CalofisteriDoppelganger, true)
        else
            clearState(M.CalofisteriDoppelganger)
            applyBlacklist(M.CalofisteriDoppelganger, false)
        end
    end
    if cfg ~= nil and cfg.Enable == true then
        applyBlacklist(M.CalofisteriDoppelganger, true)
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

Feature.OnEntityChannel = function(entityID, actionID, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state ~= nil and cfg ~= nil and cfg.Enable == true then
        return setOrder(state, entityID, actionID, now)
    end
    return false
end

Feature.OnEntityCast = function(entityID, actionID, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state ~= nil and cfg ~= nil and cfg.Enable == true then
        return handleCast(state, entityID, actionID, now)
    end
    return false
end

Feature.OnAOECreate = function(aoeInfo, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state ~= nil and cfg ~= nil and cfg.Enable == true then
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
    if cfg ~= nil and cfg.Enable == true then
        applyBlacklist(state, true)
        return pruneState(state, now)
    end
    clearState(state)
    applyBlacklist(state, false)
    return false
end

Feature.Test = {
    BossContentID = BOSS_CONTENT_ID,
    FirstSlashAID = FIRST_SLASH_AID,
    SecondSlashAID = SECOND_SLASH_AID,
    SlashRadius = SLASH_RADIUS,
    SlashAngle = SLASH_ANGLE,
    SlideSpecs = SLIDE_SPECS,
    OrderOffsets = ORDER_OFFSETS,
    PathExtraMs = PATH_EXTRA_MS,
    SecondTimeoutMs = SECOND_TIMEOUT_MS,
    Defaults = DEFAULTS,
    BlacklistSource = BLACKLIST_SOURCE,
    NewState = newState,
    EnsureState = ensureState,
    GetConfig = getConfig,
    NormalizeHeading = normalizeHeading,
    ApplyBlacklist = applyBlacklist,
    HandleAOECreate = handleAOECreate,
    HandleCast = handleCast,
    PruneState = pruneState,
    ClearState = clearState,
}

return Feature
end

rawset(_G, 'MuAiOccultCrescentNorthCalofisteriDoppelganger', Module)
return Module
