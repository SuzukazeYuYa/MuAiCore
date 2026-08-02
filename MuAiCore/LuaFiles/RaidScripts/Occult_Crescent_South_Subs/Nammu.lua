local Module = {}

function Module.Create(Context)
    assert(type(Context) == 'table')
    local Common = assert(Context.Common)
    local getNow = assert(Context.GetNow)
    local validXZ = Common.validXZ
    local validXYZ = assert(Context.ValidXYZ)
    local copyPosition = assert(Context.CopyPosition)
    local copyReliablePosition = assert(Context.CopyReliablePosition)
    local entityPosition = assert(Context.EntityPosition)
    local reliableEntityPosition = assert(Context.ReliableEntityPosition)
    local eventPosition = assert(Context.EventPosition)
    local eventHeading = assert(Context.EventHeading)
    local distanceSquared = Common.distanceSquared
    local normalized = Common.normalized
    local greenGuideColor = Context.GreenGuideColor

local NAMMU_CONTENT_ID = 13701
local NAMMU_SOURCE = 'MuAiCore - 纳木触手连击'
local NAMMU_RANGE = 60
local NAMMU_ANGLE = math.pi
local NAMMU_MIN_DURATION = 4
local NAMMU_MAX_DURATION = 5.5
local NAMMU_FIRST_GRACE_MS = 300
local NAMMU_FOLLOWUP_MS = 2200
local NAMMU_STATE_GRACE_MS = 1000
local NAMMU_AID = {
    LeftTwinTentacle = 41779,
    LeftTentacle = 41780,
    RightTwinTentacle = 41781,
    RightTentacle = 41782,
}
local NAMMU_FOLLOWUP_BY_START = {
    [NAMMU_AID.LeftTwinTentacle] = NAMMU_AID.RightTentacle,
    [NAMMU_AID.RightTwinTentacle] = NAMMU_AID.LeftTentacle,
}
local NAMMU_BLACKLIST = {
    [NAMMU_AID.LeftTwinTentacle] = '左触手连击',
    [NAMMU_AID.LeftTentacle] = '左触手',
    [NAMMU_AID.RightTwinTentacle] = '右触手连击',
    [NAMMU_AID.RightTentacle] = '右触手',
}

local finite = Common.finite

local function normalizeHeading(heading)
    return (heading + math.pi) % (2 * math.pi) - math.pi
end

local function newState()
    return {
        blacklistRegistered = false,
        blacklistOwned = {},
        blacklistPrevious = {},
        blacklistPreviousKnown = {},
        seen = {},
        draws = {},
    }
end

local function ensureState(state)
    state.blacklistRegistered = state.blacklistRegistered == true
    state.blacklistOwned = type(state.blacklistOwned) == 'table'
            and state.blacklistOwned or {}
    state.blacklistPrevious = type(state.blacklistPrevious) == 'table'
            and state.blacklistPrevious or {}
    state.blacklistPreviousKnown = type(state.blacklistPreviousKnown) == 'table'
            and state.blacklistPreviousKnown or {}
    state.seen = type(state.seen) == 'table' and state.seen or {}
    state.draws = type(state.draws) == 'table' and state.draws or {}
    return state
end

local feature = Common.newFeature({
    key = 'Nammu',
    defaults = { Enable = true },
    newState = newState,
    ensureState = ensureState,
})
local getConfig = feature.GetConfig
local getRuntimeState = feature.GetRuntimeState

local function getBlacklistTable(create)
    return Common.getMoogleTable('aoeIDUserBlacklist', create)
end

local function ownsBlacklist(state, aoeID, current)
    return current == state.blacklistOwned[aoeID]
            or (type(current) == 'table' and current.source == NAMMU_SOURCE)
end

local function resetBlacklistOwnership(state)
    state.blacklistRegistered = false
    state.blacklistOwned = {}
    state.blacklistPrevious = {}
    state.blacklistPreviousKnown = {}
end

local function registerBlacklist(state)
    ensureState(state)
    local blacklist = getBlacklistTable(true)
    if blacklist == nil then
        state.blacklistRegistered = false
        return false
    end
    for aoeID, label in pairs(NAMMU_BLACKLIST) do
        local current = blacklist[aoeID]
        if ownsBlacklist(state, aoeID, current) then
            if type(current) ~= 'table' or current.label ~= label then
                local owned = { label = label, source = NAMMU_SOURCE }
                blacklist[aoeID] = owned
                state.blacklistOwned[aoeID] = owned
            end
        elseif current ~= nil then
            -- 已被用户或其他模块禁用时无需争抢所有权。
            state.blacklistOwned[aoeID] = nil
        elseif not state.blacklistPreviousKnown[aoeID] then
            state.blacklistPreviousKnown[aoeID] = true
            state.blacklistPrevious[aoeID] = nil
            local owned = { label = label, source = NAMMU_SOURCE }
            blacklist[aoeID] = owned
            state.blacklistOwned[aoeID] = owned
        else
            -- 其他来源撤销后可以恢复本模块先前拥有的禁用项。
            local owned = { label = label, source = NAMMU_SOURCE }
            blacklist[aoeID] = owned
            state.blacklistOwned[aoeID] = owned
        end
    end
    state.blacklistRegistered = true
    return true
end

local function unregisterBlacklist(state)
    ensureState(state)
    local blacklist = getBlacklistTable(false)
    if blacklist == nil then
        state.blacklistRegistered = false
        return false
    end
    for aoeID in pairs(NAMMU_BLACKLIST) do
        local current = blacklist[aoeID]
        if ownsBlacklist(state, aoeID, current) then
            if state.blacklistPreviousKnown[aoeID] then
                blacklist[aoeID] = state.blacklistPrevious[aoeID]
            else
                blacklist[aoeID] = nil
            end
        end
    end
    resetBlacklistOwnership(state)
    return true
end

local function applyBlacklist(state, enabled)
    if enabled then
        return registerBlacklist(state)
    end
    return unregisterBlacklist(state)
end

local deleteToken = Common.deleteTimedShape

local function clearState(state)
    ensureState(state)
    for _, draw in pairs(state.draws) do
        if type(draw) == 'table' then
            deleteToken(draw.firstToken)
            deleteToken(draw.secondToken)
        end
    end
    state.seen = {}
    state.draws = {}
end

local function pruneState(state, now)
    ensureState(state)
    if not finite(now) then
        return
    end
    for key, expiresAt in pairs(state.seen) do
        if not finite(expiresAt) or now >= expiresAt then
            state.seen[key] = nil
            state.draws[key] = nil
        end
    end
end

local function eventKey(aoeInfo)
    if type(aoeInfo) ~= 'table'
            or not finite(aoeInfo.entityID)
            or not finite(aoeInfo.startTime)
    then
        return nil
    end
    return tostring(aoeInfo.entityID)
            .. ':' .. tostring(math.floor(aoeInfo.startTime * 1000 + 0.5))
end

local function handleAOECreate(state, aoeInfo, now)
    local followupAID = type(aoeInfo) == 'table'
            and NAMMU_FOLLOWUP_BY_START[aoeInfo.aoeID] or nil
    if followupAID == nil then
        return false
    end
    ensureState(state)
    pruneState(state, now)
    local key = eventKey(aoeInfo)
    if aoeInfo.contentID ~= NAMMU_CONTENT_ID
            or key == nil
            or state.seen[key] ~= nil
            or not finite(now)
            or not finite(aoeInfo.x)
            or not finite(aoeInfo.y)
            or aoeInfo.y == 0
            or not finite(aoeInfo.z)
            or not finite(aoeInfo.heading)
            or not finite(aoeInfo.duration)
            or aoeInfo.duration < NAMMU_MIN_DURATION
            or aoeInfo.duration > NAMMU_MAX_DURATION
            or not finite(aoeInfo.aoeLength)
            or math.abs(aoeInfo.aoeLength - NAMMU_RANGE) > 0.25
            or type(TensorCore) ~= 'table'
            or type(TensorCore.getMoogleDrawer) ~= 'function'
    then
        return false
    end
    local drawer = TensorCore.getMoogleDrawer()
    if drawer == nil or type(drawer.addTimedCone) ~= 'function' then
        return false
    end

    -- OnAOECreate.heading 已是第一刀扇形中线；第二刀固定覆盖其正对面。
    local firstHeading = normalizeHeading(aoeInfo.heading)
    local secondHeading = normalizeHeading(firstHeading + math.pi)
    local firstTimeout = math.floor(aoeInfo.duration * 1000 + 0.5)
            + NAMMU_FIRST_GRACE_MS
    local secondTimeout = firstTimeout + NAMMU_FOLLOWUP_MS
    local firstToken = drawer:addTimedCone(
            firstTimeout,
            aoeInfo.x,
            aoeInfo.y,
            aoeInfo.z,
            NAMMU_RANGE,
            NAMMU_ANGLE,
            firstHeading,
            0,
            nil,
            false)
    local secondToken = drawer:addTimedCone(
            secondTimeout,
            aoeInfo.x,
            aoeInfo.y,
            aoeInfo.z,
            NAMMU_RANGE,
            NAMMU_ANGLE,
            secondHeading,
            0,
            nil,
            false)
    local expiresAt = now + secondTimeout + NAMMU_STATE_GRACE_MS
    state.seen[key] = expiresAt
    state.draws[key] = {
        entityID = aoeInfo.entityID,
        startAID = aoeInfo.aoeID,
        followupAID = followupAID,
        firstHeading = firstHeading,
        secondHeading = secondHeading,
        firstToken = firstToken,
        secondToken = secondToken,
        expiresAt = expiresAt,
    }
    return true
end

local function handleEntityCast(state, entityID, spellID)
    if NAMMU_BLACKLIST[spellID] == nil then
        return false
    end
    ensureState(state)
    for key, draw in pairs(state.draws) do
        if type(draw) == 'table' and draw.entityID == entityID then
            if spellID == draw.startAID then
                deleteToken(draw.firstToken)
                draw.firstToken = nil
                return true
            end
            if spellID == draw.followupAID then
                deleteToken(draw.firstToken)
                deleteToken(draw.secondToken)
                draw.firstToken = nil
                draw.secondToken = nil
                state.draws[key] = nil
                return true
            end
        end
    end
    return false
end

return {
    ContentID = NAMMU_CONTENT_ID,
    Source = NAMMU_SOURCE,
    AID = NAMMU_AID,
    FollowupByStart = NAMMU_FOLLOWUP_BY_START,
    Blacklist = NAMMU_BLACKLIST,
    Range = NAMMU_RANGE,
    Angle = NAMMU_ANGLE,
    FirstGraceMS = NAMMU_FIRST_GRACE_MS,
    FollowupMS = NAMMU_FOLLOWUP_MS,
    NewState = newState,
    EnsureState = ensureState,
    GetConfig = getConfig,
    GetRuntimeState = getRuntimeState,
    ApplyBlacklist = applyBlacklist,
    ClearState = clearState,
    PruneState = pruneState,
    HandleAOECreate = handleAOECreate,
    HandleEntityCast = handleEntityCast,
    NormalizeHeading = normalizeHeading,
}
end

rawset(_G, 'MuAiOccultCrescentSouthNammu', Module)
return Module
