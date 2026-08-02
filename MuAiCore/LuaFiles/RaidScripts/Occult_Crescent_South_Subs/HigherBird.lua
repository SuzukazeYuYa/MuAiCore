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

local OCCULT_MOOGLE_RANGE_SOURCE = 'MuAiCore - 新月岛范围修正'
local OCCULT_HIGHER_BIRD_CONTENT_ID = 13704
local OCCULT_THREEFOLD_WING_CIRCLE_VISUAL_AID = 42008
local OCCULT_THREEFOLD_WING_CIRCLE_AID = 42009
local OCCULT_THREEFOLD_WING_DONUT_AID = 42012
local OCCULT_THREEFOLD_WING_RADIUS = 10
local OCCULT_THREEFOLD_WING_OUTER_RADIUS = 20
local OCCULT_THREEFOLD_WING_RECT_LENGTH = 80
local OCCULT_THREEFOLD_WING_RECT_WIDTH = 10
local OCCULT_THREEFOLD_WING_MIN_DURATION = 3
local OCCULT_THREEFOLD_WING_MAX_DURATION = 5
local OCCULT_THREEFOLD_WING_FIRST_GRACE_MS = 300
local OCCULT_THREEFOLD_WING_FOLLOWUP_MS = 2200
local OCCULT_THREEFOLD_WING_CHANNEL_WINDOW_MS = 1500
local OCCULT_THREEFOLD_WING_STATE_GRACE_MS = 1000
local OCCULT_PETRIFY_GAZE_AIDS = {
    [42000] = true,
    [42001] = true,
}
local OCCULT_PETRIFY_GAZE_MIN_DURATION = 7.5
local OCCULT_PETRIFY_GAZE_MAX_DURATION = 7.9
local OCCULT_PETRIFY_GAZE_GROUP_WINDOW_MS = 150
local OCCULT_PETRIFY_GAZE_SOURCE_TOLERANCE_SQ = 1
local OCCULT_PETRIFY_GAZE_AUTO_FACE_LEAD_MS = 200
local OCCULT_PETRIFY_GAZE_AUTO_FACE_RELEASE_MS = 150
local OCCULT_PETRIFY_GAZE_GRACE_MS = 1000
local OCCULT_PETRIFY_GAZE_OVERLAP_SQ = 0.25

-- 这些内径均来自地图1252的实际OnAOECreate omen；外径继续使用Argus提供的aoeLength。
-- 显式登记也避免Moogle对无专用条目的月环统一回退到10米内径。
local occultMoogleDonuts = {
    [29827] = { name = '污泥外无双', radius = 10 },
    [30344] = { name = '火炎旋风', radius = 5 },
    [41148] = { name = '陆行鸟旋风', radius = 8 },
    [41777] = { name = '环浪', radius = 10 },
    [41778] = { name = '环浪', radius = 10 },
    [41976] = { name = '雷之记忆', radius = 10 },
    [41981] = { name = '记忆之雷', radius = 10 },
    [41985] = { name = '三重闪雷', radius = 10 },
    [41986] = { name = '三重闪雷', radius = 20 },
    [42012] = { name = '三重风翼', radius = 10 },
    [42162] = { name = '大地震动', radius = 10 },
}

local function newOccultMoogleRangeState()
    return {
        registered = false,
        owned = {},
        previous = {},
        previousKnown = {},
        seenTimedCircles = {},
        timedCircles = {},
        threefoldBoss = nil,
        gazeQueue = {},
        gazeSuppression = nil,
        faceLock = Common.newFaceLock(),
    }
end

local function ensureOccultMoogleRangeState(state)
    state.registered = state.registered == true
    state.owned = type(state.owned) == 'table' and state.owned or {}
    state.previous = type(state.previous) == 'table' and state.previous or {}
    state.previousKnown = type(state.previousKnown) == 'table'
            and state.previousKnown or {}
    state.seenTimedCircles = type(state.seenTimedCircles) == 'table'
            and state.seenTimedCircles or {}
    state.timedCircles = type(state.timedCircles) == 'table'
            and state.timedCircles or {}
    state.threefoldBoss = type(state.threefoldBoss) == 'table'
            and state.threefoldBoss or nil
    state.gazeQueue = type(state.gazeQueue) == 'table'
            and state.gazeQueue or {}
    state.faceLock = type(state.faceLock) == 'table'
            and state.faceLock or Common.newFaceLock()
    state.faceLock.active = state.faceLock.active == true
    state.gazeSuppression = type(state.gazeSuppression) == 'table'
            and state.gazeSuppression or nil
    return state
end

local occultMoogleFeature = Common.newFeature({
    key = 'OccultMoogleRanges',
    configKey = 'HigherBird',
    defaults = {
        Enable = true,
        AutoFacePetrifyingGaze = true,
    },
    newState = newOccultMoogleRangeState,
    ensureState = ensureOccultMoogleRangeState,
})
local getOccultMoogleRangeState = occultMoogleFeature.GetRuntimeState
local getHigherBirdConfig = occultMoogleFeature.GetConfig

local occultMoogleDonutRegistry = Common.newMoogleDonutRegistry({
    entries = occultMoogleDonuts,
    source = OCCULT_MOOGLE_RANGE_SOURCE,
    ensureState = ensureOccultMoogleRangeState,
})
local applyOccultMoogleRanges = occultMoogleDonutRegistry.Apply

local occultMoogleFinite = Common.finite

local deleteOccultMoogleTimedCircle = Common.deleteTimedShape

local function clearOccultPetrifyingGaze(state)
    ensureOccultMoogleRangeState(state)
    Common.releaseAutoFace(state)
    state.gazeQueue = {}
    state.gazeSuppression = nil
end

local function clearOccultMoogleTimedCircles(state)
    ensureOccultMoogleRangeState(state)
    for _, entry in pairs(state.timedCircles) do
        if type(entry) == 'table' then
            if type(entry.tokens) == 'table' then
                for _, token in ipairs(entry.tokens) do
                    deleteOccultMoogleTimedCircle(token)
                end
            else
                deleteOccultMoogleTimedCircle(entry.token)
            end
        end
    end
    state.seenTimedCircles = {}
    state.timedCircles = {}
    state.threefoldBoss = nil
end

local function clearOccultHigherBirdState(state)
    clearOccultMoogleTimedCircles(state)
    clearOccultPetrifyingGaze(state)
end

local function sortOccultPetrifyingGazes(queue)
    table.sort(queue, function(left, right)
        if left.activationAt ~= right.activationAt then
            return left.activationAt < right.activationAt
        end
        return left.key < right.key
    end)
end

local function suppressOccultPetrifyingGaze(state, now)
    if #state.gazeQueue == 0 then
        return false
    end
    Common.releaseAutoFace(state)
    local expiresAt = now
    for _, gaze in ipairs(state.gazeQueue) do
        if occultMoogleFinite(gaze.expiresAt) then
            expiresAt = math.max(expiresAt, gaze.expiresAt)
        end
    end
    if state.gazeSuppression == nil then
        state.gazeSuppression = {
            at = now,
            expiresAt = expiresAt,
        }
    else
        state.gazeSuppression.expiresAt = math.max(
                state.gazeSuppression.expiresAt or expiresAt,
                expiresAt)
    end
    return true
end

local function recordOccultPetrifyingGaze(
        state,
        entityID,
        spellID,
        channelTimeMax,
        now)
    if OCCULT_PETRIFY_GAZE_AIDS[spellID] ~= true then
        return false
    end
    ensureOccultMoogleRangeState(state)
    if not occultMoogleFinite(entityID)
            or entityID <= 0
            or not occultMoogleFinite(channelTimeMax)
            or channelTimeMax < OCCULT_PETRIFY_GAZE_MIN_DURATION
            or channelTimeMax > OCCULT_PETRIFY_GAZE_MAX_DURATION
            or not occultMoogleFinite(now)
            or type(TensorCore) ~= 'table'
            or type(TensorCore.mGetEntity) ~= 'function'
    then
        suppressOccultPetrifyingGaze(
                state, occultMoogleFinite(now) and now or getNow())
        return false
    end
    local entity = TensorCore.mGetEntity(entityID)
    local pos = type(entity) == 'table' and entity.pos or nil
    if type(entity) ~= 'table'
            or tonumber(entity.id) ~= entityID
            or tonumber(entity.contentid) ~= OCCULT_HIGHER_BIRD_CONTENT_ID
            or entity.alive == false
            or type(pos) ~= 'table'
            or not occultMoogleFinite(pos.x)
            or not occultMoogleFinite(pos.z)
    then
        suppressOccultPetrifyingGaze(state, now)
        return false
    end

    local activationAt = now + channelTimeMax * 1000
    for _, gaze in ipairs(state.gazeQueue) do
        if math.abs(gaze.activationAt - activationAt)
                <= OCCULT_PETRIFY_GAZE_GROUP_WINDOW_MS
        then
            local dx = gaze.source.x - pos.x
            local dz = gaze.source.z - pos.z
            if dx * dx + dz * dz
                    > OCCULT_PETRIFY_GAZE_SOURCE_TOLERANCE_SQ
            then
                suppressOccultPetrifyingGaze(state, now)
                return false
            end
            local isNew = gaze.entities[entityID] ~= true
            gaze.entities[entityID] = true
            return isNew
        end
    end

    local gaze = {
        key = tostring(math.floor(activationAt / 100)),
        activationAt = activationAt,
        expiresAt = activationAt + OCCULT_PETRIFY_GAZE_GRACE_MS,
        source = { x = pos.x, z = pos.z },
        entities = { [entityID] = true },
    }
    state.gazeQueue[#state.gazeQueue + 1] = gaze
    sortOccultPetrifyingGazes(state.gazeQueue)
    return true
end

local function occultPetrifyingGazeHeading(playerPos, sourcePos)
    if type(playerPos) ~= 'table'
            or type(sourcePos) ~= 'table'
            or not occultMoogleFinite(playerPos.x)
            or not occultMoogleFinite(playerPos.y)
            or not occultMoogleFinite(playerPos.z)
            or not occultMoogleFinite(sourcePos.x)
            or not occultMoogleFinite(sourcePos.z)
    then
        return nil
    end
    local dx = playerPos.x - sourcePos.x
    local dz = playerPos.z - sourcePos.z
    if dx * dx + dz * dz <= OCCULT_PETRIFY_GAZE_OVERLAP_SQ then
        return nil
    end
    return math.atan2(dx, dz)
end

local function pruneOccultPetrifyingGaze(state, now)
    ensureOccultMoogleRangeState(state)
    if not occultMoogleFinite(now) then
        return
    end
    for index = #state.gazeQueue, 1, -1 do
        local gaze = state.gazeQueue[index]
        if not occultMoogleFinite(gaze.expiresAt)
                or now > gaze.expiresAt
        then
            Common.releaseAutoFace(state, gaze.key)
            table.remove(state.gazeQueue, index)
        end
    end
    if #state.gazeQueue == 0 then
        Common.releaseAutoFace(state)
        state.gazeSuppression = nil
    elseif state.gazeSuppression ~= nil
            and (not occultMoogleFinite(state.gazeSuppression.expiresAt)
                    or now > state.gazeSuppression.expiresAt)
    then
        clearOccultPetrifyingGaze(state)
    end
end

local function updateOccultPetrifyingGaze(
        guide,
        cfg,
        state,
        now)
    ensureOccultMoogleRangeState(state)
    if cfg.Enable ~= true then
        clearOccultHigherBirdState(state)
        return false
    end
    pruneOccultPetrifyingGaze(state, now)
    local gaze = state.gazeQueue[1]
    local lock = state.faceLock
    if lock.active == true
            and (cfg.AutoFacePetrifyingGaze ~= true
                    or state.gazeSuppression ~= nil
                    or gaze == nil
                    or lock.key ~= gaze.key
                    or not occultMoogleFinite(lock.releaseAt)
                    or now > lock.releaseAt)
    then
        Common.releaseAutoFace(state)
    end
    if cfg.AutoFacePetrifyingGaze ~= true
            or state.gazeSuppression ~= nil
            or gaze == nil
            or now < gaze.activationAt
                    - OCCULT_PETRIFY_GAZE_AUTO_FACE_LEAD_MS
            or now > gaze.activationAt
                    + OCCULT_PETRIFY_GAZE_AUTO_FACE_RELEASE_MS
    then
        return false
    end
    local player = type(guide) == 'table'
            and type(guide.GetPlayer) == 'function'
            and guide.GetPlayer() or nil
    local heading = occultPetrifyingGazeHeading(
            type(player) == 'table' and player.pos or nil,
            gaze.source)
    if heading == nil then
        Common.releaseAutoFace(state)
        return false
    end
    local applied = Common.applyAutoFace(
            state,
            gaze.key,
            heading,
            now,
            gaze.activationAt
                    + OCCULT_PETRIFY_GAZE_AUTO_FACE_RELEASE_MS)
    if not applied then
        Common.releaseAutoFace(state)
    end
    return applied
end

local function pruneOccultMoogleTimedCircles(state, now)
    ensureOccultMoogleRangeState(state)
    if not occultMoogleFinite(now) then
        return
    end
    for key, expiresAt in pairs(state.seenTimedCircles) do
        if not occultMoogleFinite(expiresAt) or now >= expiresAt then
            state.seenTimedCircles[key] = nil
            state.timedCircles[key] = nil
        end
    end
    if type(state.threefoldBoss) == 'table'
            and (not occultMoogleFinite(state.threefoldBoss.expiresAt)
                    or now >= state.threefoldBoss.expiresAt)
    then
        state.threefoldBoss = nil
    end
end

local function occultMoogleTimedCircleKey(aoeInfo)
    if type(aoeInfo) ~= 'table'
            or not occultMoogleFinite(aoeInfo.entityID)
            or not occultMoogleFinite(aoeInfo.startTime)
    then
        return nil
    end
    return tostring(aoeInfo.entityID)
            .. ':' .. tostring(math.floor(aoeInfo.startTime * 1000 + 0.5))
end

local function recordOccultThreefoldChannel(
        state,
        entityID,
        spellID,
        channelTimeMax,
        now)
    if spellID ~= OCCULT_THREEFOLD_WING_CIRCLE_VISUAL_AID
            and spellID ~= OCCULT_THREEFOLD_WING_DONUT_AID
    then
        return false
    end
    ensureOccultMoogleRangeState(state)
    pruneOccultMoogleTimedCircles(state, now)

    if not occultMoogleFinite(entityID)
            or not occultMoogleFinite(channelTimeMax)
            or channelTimeMax < OCCULT_THREEFOLD_WING_MIN_DURATION
            or channelTimeMax > OCCULT_THREEFOLD_WING_MAX_DURATION
            or not occultMoogleFinite(now)
            or type(TensorCore) ~= 'table'
            or type(TensorCore.mGetEntity) ~= 'function'
    then
        return false
    end
    local entity = TensorCore.mGetEntity(entityID)
    local pos = type(entity) == 'table' and entity.pos or nil
    if type(entity) ~= 'table'
            or entity.id ~= entityID
            or entity.contentid ~= OCCULT_HIGHER_BIRD_CONTENT_ID
            or type(pos) ~= 'table'
            or not occultMoogleFinite(pos.x)
            or not occultMoogleFinite(pos.y)
            or pos.y == 0
            or not occultMoogleFinite(pos.z)
            or not occultMoogleFinite(pos.h)
    then
        return false
    end
    state.threefoldBoss = {
        entityID = entityID,
        spellID = spellID,
        x = pos.x,
        y = pos.y,
        z = pos.z,
        heading = pos.h,
        startedAt = now,
        expiresAt = now
                + math.floor(channelTimeMax * 1000 + 0.5)
                + OCCULT_THREEFOLD_WING_STATE_GRACE_MS,
    }
    return true
end

local function occultThreefoldBossGeometry(state, aoeInfo, now)
    if aoeInfo.aoeID == OCCULT_THREEFOLD_WING_DONUT_AID then
        if occultMoogleFinite(aoeInfo.heading) then
            return {
                x = aoeInfo.x,
                y = aoeInfo.y,
                z = aoeInfo.z,
                heading = aoeInfo.heading,
            }
        end
        return nil
    end
    local boss = state.threefoldBoss
    if type(boss) ~= 'table'
            or boss.spellID ~= OCCULT_THREEFOLD_WING_CIRCLE_VISUAL_AID
            or not occultMoogleFinite(boss.startedAt)
            or math.abs(now - boss.startedAt)
                    > OCCULT_THREEFOLD_WING_CHANNEL_WINDOW_MS
            or not occultMoogleFinite(boss.x)
            or not occultMoogleFinite(boss.y)
            or boss.y == 0
            or not occultMoogleFinite(boss.z)
            or not occultMoogleFinite(boss.heading)
    then
        return nil
    end
    local dx = boss.x - aoeInfo.x
    local dz = boss.z - aoeInfo.z
    if dx * dx + dz * dz > 1 then
        return nil
    end
    return boss
end

local function handleOccultMissingAOE(state, aoeInfo, now)
    if type(aoeInfo) ~= 'table'
            or (aoeInfo.aoeID ~= OCCULT_THREEFOLD_WING_CIRCLE_AID
                    and aoeInfo.aoeID
                            ~= OCCULT_THREEFOLD_WING_DONUT_AID)
    then
        return false
    end
    ensureOccultMoogleRangeState(state)
    pruneOccultMoogleTimedCircles(state, now)

    local key = occultMoogleTimedCircleKey(aoeInfo)
    local expectedLength = aoeInfo.aoeID
                    == OCCULT_THREEFOLD_WING_CIRCLE_AID
            and OCCULT_THREEFOLD_WING_RADIUS
            or OCCULT_THREEFOLD_WING_OUTER_RADIUS
    if aoeInfo.contentID ~= OCCULT_HIGHER_BIRD_CONTENT_ID
            or key == nil
            or not occultMoogleFinite(now)
            or not occultMoogleFinite(aoeInfo.x)
            or not occultMoogleFinite(aoeInfo.y)
            or aoeInfo.y == 0
            or not occultMoogleFinite(aoeInfo.z)
            or not occultMoogleFinite(aoeInfo.aoeLength)
            or math.abs(aoeInfo.aoeLength - expectedLength) > 0.25
            or not occultMoogleFinite(aoeInfo.duration)
            or aoeInfo.duration < OCCULT_THREEFOLD_WING_MIN_DURATION
            or aoeInfo.duration > OCCULT_THREEFOLD_WING_MAX_DURATION
            or state.seenTimedCircles[key] ~= nil
    then
        return false
    end
    if type(TensorCore) ~= 'table'
            or type(TensorCore.getMoogleDrawer) ~= 'function'
    then
        return false
    end
    local drawer = TensorCore.getMoogleDrawer()
    if drawer == nil
            or type(drawer.addTimedCircle) ~= 'function'
            or type(drawer.addTimedDonut) ~= 'function'
            or type(drawer.addTimedCenteredRect) ~= 'function'
    then
        return false
    end

    local boss = occultThreefoldBossGeometry(state, aoeInfo, now)
    if boss == nil then
        return false
    end

    local firstTimeout = math.floor(aoeInfo.duration * 1000 + 0.5)
            + OCCULT_THREEFOLD_WING_FIRST_GRACE_MS
    local secondDelay = firstTimeout
    local thirdDelay = secondDelay + OCCULT_THREEFOLD_WING_FOLLOWUP_MS
    local tokens = {}
    local function rememberToken(token)
        if type(token) == 'string' then
            tokens[#tokens + 1] = token
        end
    end
    local firstIsCircle = aoeInfo.aoeID
            == OCCULT_THREEFOLD_WING_CIRCLE_AID
    if firstIsCircle then
        rememberToken(drawer:addTimedCircle(
                firstTimeout,
                aoeInfo.x,
                aoeInfo.y,
                aoeInfo.z,
                OCCULT_THREEFOLD_WING_RADIUS,
                0,
                nil,
                false))
        rememberToken(drawer:addTimedDonut(
                OCCULT_THREEFOLD_WING_FOLLOWUP_MS,
                aoeInfo.x,
                aoeInfo.y,
                aoeInfo.z,
                OCCULT_THREEFOLD_WING_RADIUS,
                OCCULT_THREEFOLD_WING_OUTER_RADIUS,
                secondDelay,
                nil,
                false))
    else
        rememberToken(drawer:addTimedDonut(
                firstTimeout,
                aoeInfo.x,
                aoeInfo.y,
                aoeInfo.z,
                OCCULT_THREEFOLD_WING_RADIUS,
                OCCULT_THREEFOLD_WING_OUTER_RADIUS,
                0,
                nil,
                false))
        rememberToken(drawer:addTimedCircle(
                OCCULT_THREEFOLD_WING_FOLLOWUP_MS,
                aoeInfo.x,
                aoeInfo.y,
                aoeInfo.z,
                OCCULT_THREEFOLD_WING_RADIUS,
                secondDelay,
                nil,
                false))
    end
    rememberToken(drawer:addTimedCenteredRect(
            OCCULT_THREEFOLD_WING_FOLLOWUP_MS,
            boss.x,
            boss.y,
            boss.z,
            OCCULT_THREEFOLD_WING_RECT_LENGTH,
            OCCULT_THREEFOLD_WING_RECT_WIDTH,
            boss.heading,
            thirdDelay,
            nil,
            false))
    local expiresAt = now
            + thirdDelay
            + OCCULT_THREEFOLD_WING_FOLLOWUP_MS
            + OCCULT_THREEFOLD_WING_STATE_GRACE_MS
    state.seenTimedCircles[key] = expiresAt
    state.timedCircles[key] = {
        tokens = tokens,
        expiresAt = expiresAt,
    }
    state.threefoldBoss = nil
    return true
end

return {
    Source = OCCULT_MOOGLE_RANGE_SOURCE,
    Donuts = occultMoogleDonuts,
    HigherBirdContentID = OCCULT_HIGHER_BIRD_CONTENT_ID,
    PetrifyingGazeAIDs = OCCULT_PETRIFY_GAZE_AIDS,
    PetrifyingGazeAutoFaceLeadMs = OCCULT_PETRIFY_GAZE_AUTO_FACE_LEAD_MS,
    PetrifyingGazeAutoFaceReleaseMs = OCCULT_PETRIFY_GAZE_AUTO_FACE_RELEASE_MS,
    ThreefoldWingCircleVisualAID = OCCULT_THREEFOLD_WING_CIRCLE_VISUAL_AID,
    ThreefoldWingHelperAID = OCCULT_THREEFOLD_WING_CIRCLE_AID,
    ThreefoldWingDonutAID = OCCULT_THREEFOLD_WING_DONUT_AID,
    ThreefoldWingRadius = OCCULT_THREEFOLD_WING_RADIUS,
    ThreefoldWingOuterRadius = OCCULT_THREEFOLD_WING_OUTER_RADIUS,
    ThreefoldWingRectLength = OCCULT_THREEFOLD_WING_RECT_LENGTH,
    ThreefoldWingRectWidth = OCCULT_THREEFOLD_WING_RECT_WIDTH,
    NewState = newOccultMoogleRangeState,
    EnsureState = ensureOccultMoogleRangeState,
    GetRuntimeState = getOccultMoogleRangeState,
    GetHigherBirdConfig = getHigherBirdConfig,
    Apply = applyOccultMoogleRanges,
    RecordThreefoldChannel = recordOccultThreefoldChannel,
    RecordPetrifyingGaze = recordOccultPetrifyingGaze,
    PetrifyingGazeHeading = occultPetrifyingGazeHeading,
    UpdatePetrifyingGaze = updateOccultPetrifyingGaze,
    ReleaseAutoFace = Common.releaseAutoFace,
    HandleMissingAOE = handleOccultMissingAOE,
    PruneTimedCircles = pruneOccultMoogleTimedCircles,
    PrunePetrifyingGaze = pruneOccultPetrifyingGaze,
    ClearTimedCircles = clearOccultMoogleTimedCircles,
    ClearState = clearOccultHigherBirdState,
}
end

rawset(_G, 'MuAiOccultCrescentSouthHigherBird', Module)
return Module
