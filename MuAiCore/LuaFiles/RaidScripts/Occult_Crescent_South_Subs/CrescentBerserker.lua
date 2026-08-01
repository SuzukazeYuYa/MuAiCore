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
    local getGreenDrawer = assert(Context.GetGreenDrawer)
    local greenGuideColor = Context.GreenGuideColor

local BERSERKER_CONTENT_ID = 13759
local STATE_TIMEOUT_AFTER_CIRCLE_MS = 6000
local BOSS_MISSING_CLEAR_MS = 1000
local RING_DELAY_MS = 2100
local MOOGLE_SOURCE = 'MuAiCore - 新月狂战士'
local landingRadiusByID = {
    [37323] = 8,
    [37041] = 8,
    [30873] = 16,
    [30872] = 24,
}

local ringRadiusByID = {
    [37805] = 24,
    [37806] = 16,
    [37807] = 8,
}

local ringIDByRadius = {
    [8] = 37807,
    [16] = 37806,
    [24] = 37805,
}

local moogleDonuts = {
    [37805] = { name = '地面隆起', radius = 24, source = MOOGLE_SOURCE },
    [37806] = { name = '地面隆起', radius = 16, source = MOOGLE_SOURCE },
    [37807] = { name = '地面隆起', radius = 8, source = MOOGLE_SOURCE },
}

local greenGuideColor = { r = 0, g = 1, b = 0, a = 0.5 }
local function newState()
    return {
        items = {},
        seenKeys = {},
        sequence = 0,
        bossLastSeenAt = nil,
        moogle = {
            registered = false,
            owned = {},
            previous = {},
            previousKnown = {},
        },
    }
end

local function ensureState(state)
    state.items = type(state.items) == 'table' and state.items or {}
    state.seenKeys = type(state.seenKeys) == 'table' and state.seenKeys or {}
    state.sequence = type(state.sequence) == 'number' and state.sequence or 0
    state.moogle = type(state.moogle) == 'table' and state.moogle or {}
    state.moogle.registered = state.moogle.registered == true
    state.moogle.owned = type(state.moogle.owned) == 'table' and state.moogle.owned or {}
    state.moogle.previous = type(state.moogle.previous) == 'table' and state.moogle.previous or {}
    state.moogle.previousKnown = type(state.moogle.previousKnown) == 'table'
            and state.moogle.previousKnown or {}
    return state
end

local berserkerFeature = Common.newFeature({
    key = 'CrescentBerserker',
    newState = newState,
    ensureState = ensureState,
})
local getConfig = berserkerFeature.GetConfig
local getRuntimeState = berserkerFeature.GetRuntimeState

local function clearMechanicState(state)
    ensureState(state)
    state.items = {}
    state.seenKeys = {}
    state.sequence = 0
    state.bossLastSeenAt = nil
end

local function itemActivation(item)
    if item.circleResolvedAt ~= nil then
        return item.ringExpectedAt or (item.circleResolvedAt + RING_DELAY_MS)
    end
    return item.circleExpectedAt
end

local function selectNextItem(items)
    local selected
    for _, item in ipairs(items or {}) do
        if item.ringResolvedAt == nil then
            local activation = itemActivation(item)
            local selectedActivation = selected ~= nil and itemActivation(selected) or nil
            if selected == nil
                    or activation < selectedActivation
                    or (activation == selectedActivation and item.sequence < selected.sequence)
            then
                selected = item
            end
        end
    end
    return selected
end

local function removeItem(state, target)
    for index, item in ipairs(state.items) do
        if item == target then
            table.remove(state.items, index)
            return true
        end
    end
    return false
end

local function pruneExpired(state, now)
    for index = #state.items, 1, -1 do
        if now > state.items[index].expiresAt then
            table.remove(state.items, index)
        end
    end
    for key, seenAt in pairs(state.seenKeys) do
        if now - seenAt > 35000 then
            state.seenKeys[key] = nil
        end
    end
end

local function findItem(state, entityID, radius, castID, requireUnresolvedCircle)
    local selected
    for _, item in ipairs(state.items) do
        if item.entityID == entityID
                and item.radius == radius
                and (castID == nil or item.castID == castID)
                and item.ringResolvedAt == nil
                and (not requireUnresolvedCircle or item.circleResolvedAt == nil)
        then
            if selected == nil
                    or itemActivation(item) < itemActivation(selected)
                    or (itemActivation(item) == itemActivation(selected) and item.sequence < selected.sequence)
            then
                selected = item
            end
        end
    end
    return selected
end

local function eventKey(aoeInfo, startTime)
    return tostring(aoeInfo.entityID)
            .. ':' .. tostring(aoeInfo.aoeID)
            .. ':' .. tostring(math.floor(startTime))
end

local function addLanding(state, aoeInfo, now)
    local radius = landingRadiusByID[aoeInfo.aoeID]
    if radius == nil
            or aoeInfo.contentID ~= BERSERKER_CONTENT_ID
            or type(aoeInfo.entityID) ~= 'number'
            or type(aoeInfo.x) ~= 'number'
            or type(aoeInfo.y) ~= 'number'
            or type(aoeInfo.z) ~= 'number'
            or type(aoeInfo.duration) ~= 'number'
            or aoeInfo.duration < 0
            or aoeInfo.duration > 30
    then
        return false
    end

    local startTime = type(aoeInfo.startTime) == 'number' and aoeInfo.startTime or now
    local key = eventKey(aoeInfo, startTime)
    if state.seenKeys[key] ~= nil then
        return false
    end

    local circleExpectedAt = startTime + aoeInfo.duration * 1000
    state.sequence = state.sequence + 1
    state.seenKeys[key] = now
    state.bossLastSeenAt = now
    state.items[#state.items + 1] = {
        key = key,
        sequence = state.sequence,
        entityID = aoeInfo.entityID,
        castID = aoeInfo.aoeID,
        ringID = ringIDByRadius[radius],
        radius = radius,
        x = aoeInfo.x,
        y = aoeInfo.y,
        z = aoeInfo.z,
        heading = type(aoeInfo.heading) == 'number' and aoeInfo.heading or 0,
        seenAt = now,
        circleExpectedAt = circleExpectedAt,
        circleResolvedAt = nil,
        ringExpectedAt = circleExpectedAt + RING_DELAY_MS,
        ringResolvedAt = nil,
        expiresAt = circleExpectedAt + STATE_TIMEOUT_AFTER_CIRCLE_MS,
    }
    return true
end

local function observeRing(state, aoeInfo, now)
    local radius = ringRadiusByID[aoeInfo.aoeID]
    if radius == nil
            or aoeInfo.contentID ~= BERSERKER_CONTENT_ID
            or type(aoeInfo.entityID) ~= 'number'
    then
        return false
    end

    local item = findItem(state, aoeInfo.entityID, radius)
    if item == nil then
        return false
    end

    if item.circleResolvedAt == nil then
        item.circleResolvedAt = now
    end
    if type(aoeInfo.startTime) == 'number' and type(aoeInfo.duration) == 'number'
            and aoeInfo.duration >= 0 and aoeInfo.duration <= 10
    then
        item.ringExpectedAt = aoeInfo.startTime + aoeInfo.duration * 1000
    end
    item.expiresAt = item.ringExpectedAt + 2000
    return true
end

local function handleAOECreate(state, aoeInfo, now)
    if type(state) ~= 'table' or type(aoeInfo) ~= 'table' then
        return false
    end
    ensureState(state)
    now = type(now) == 'number' and now or getNow()
    if landingRadiusByID[aoeInfo.aoeID] ~= nil then
        return addLanding(state, aoeInfo, now)
    end
    if ringRadiusByID[aoeInfo.aoeID] ~= nil then
        return observeRing(state, aoeInfo, now)
    end
    return false
end

local function handleEntityCast(state, entityID, spellID, now)
    if type(state) ~= 'table' or type(entityID) ~= 'number' or type(spellID) ~= 'number' then
        return false
    end
    ensureState(state)
    now = type(now) == 'number' and now or getNow()

    local radius = landingRadiusByID[spellID]
    if radius ~= nil then
        local item = findItem(state, entityID, radius, spellID, true)
        if item == nil then
            return false
        end
        item.circleResolvedAt = now
        item.ringExpectedAt = now + RING_DELAY_MS
        item.expiresAt = now + STATE_TIMEOUT_AFTER_CIRCLE_MS
        return true
    end

    radius = ringRadiusByID[spellID]
    if radius ~= nil then
        local item = findItem(state, entityID, radius)
        if item == nil then
            return false
        end
        item.ringResolvedAt = now
        removeItem(state, item)
        return true
    end
    return false
end

local function nearestPreparationPoint(center, playerPos, radius)
    if type(center) ~= 'table' or type(playerPos) ~= 'table'
            or type(center.x) ~= 'number' or type(center.z) ~= 'number'
            or type(playerPos.x) ~= 'number' or type(playerPos.z) ~= 'number'
            or type(radius) ~= 'number'
    then
        return nil
    end

    local dx = playerPos.x - center.x
    local dz = playerPos.z - center.z
    local distance = math.sqrt(dx * dx + dz * dz)
    -- 给两侧边界各留 0.5 米，避免指路点和玩家判定压在危险圆边缘。
    local targetDistance = math.max(radius + 0.5, math.min(radius + 1.5, distance))
    if distance < 0.001 then
        return { x = center.x + targetDistance, y = center.y, z = center.z }
    end
    local scale = targetDistance / distance
    return {
        x = center.x + dx * scale,
        y = center.y,
        z = center.z + dz * scale,
    }
end

local function getMoogleDonutTable(create)
    return Common.getMoogleTable('aoeIDUserSetDonuts', create)
end

local function registerMoogleDonuts(state)
    ensureState(state)
    local donuts = getMoogleDonutTable(true)
    if donuts == nil then
        state.moogle.registered = false
        return false
    end

    for aoeID, desired in pairs(moogleDonuts) do
        local current = donuts[aoeID]
        if type(current) ~= 'table' or current.radius ~= desired.radius then
            if not state.moogle.previousKnown[aoeID] then
                state.moogle.previousKnown[aoeID] = true
                if type(current) == 'table' and current.source ~= MOOGLE_SOURCE then
                    state.moogle.previous[aoeID] = current
                end
            end
            local owned = {
                name = desired.name,
                radius = desired.radius,
                source = desired.source,
            }
            donuts[aoeID] = owned
            state.moogle.owned[aoeID] = owned
        end
    end
    state.moogle.registered = true
    return true
end

local function unregisterMoogleDonuts(state)
    ensureState(state)
    local donuts = getMoogleDonutTable(false)
    if donuts == nil then
        state.moogle.registered = false
        return false
    end

    for aoeID in pairs(moogleDonuts) do
        local current = donuts[aoeID]
        if current == state.moogle.owned[aoeID]
                or (type(current) == 'table' and current.source == MOOGLE_SOURCE)
        then
            if state.moogle.previousKnown[aoeID] then
                donuts[aoeID] = state.moogle.previous[aoeID]
            else
                donuts[aoeID] = nil
            end
        end
        state.moogle.owned[aoeID] = nil
        state.moogle.previous[aoeID] = nil
        state.moogle.previousKnown[aoeID] = nil
    end
    state.moogle.registered = false
    return true
end

local function applyMoogleDonuts(state, enabled)
    if enabled then
        return registerMoogleDonuts(state)
    end
    return unregisterMoogleDonuts(state)
end

local function hasLiveBerserker()
    if type(TensorCore) ~= 'table' or type(TensorCore.entityList) ~= 'function' then
        return nil
    end
    local entities = TensorCore.entityList('contentid=' .. tostring(BERSERKER_CONTENT_ID))
    if type(entities) ~= 'table' then
        return nil
    end
    for _, entity in pairs(entities) do
        if entity ~= nil
                and entity.contentid == BERSERKER_CONTENT_ID
                and entity.alive ~= false
        then
            return true
        end
    end
    return false
end

local function drawSelected(guide, cfg, item)
    local drawer = getGreenDrawer(guide)
    if drawer == nil then
        return
    end

    if item.circleResolvedAt == nil then
        if cfg.DrawPreparationRing then
            drawer:addDonut(item.x, item.y, item.z, item.radius, item.radius + 2)
        end
        if cfg.DrawGuideArrow and type(guide.FrameDirect) == 'function' then
            local player = type(guide.GetPlayer) == 'function' and guide.GetPlayer() or nil
            if player ~= nil and player.pos ~= nil then
                local target = nearestPreparationPoint(item, player.pos, item.radius)
                if target ~= nil then
                    guide.FrameDirect(target.x, target.z, 0.5, greenGuideColor)
                end
            end
        end
    elseif cfg.DrawSafeZone then
        drawer:addCircle(item.x, item.y, item.z, item.radius)
    end
end


return {
    ContentID = BERSERKER_CONTENT_ID,
    BossMissingClearMs = BOSS_MISSING_CLEAR_MS,
    LandingRadiusByID = landingRadiusByID,
    RingRadiusByID = ringRadiusByID,
    RingIDByRadius = ringIDByRadius,
    NewState = newState,
    EnsureState = ensureState,
    ClearState = clearMechanicState,
    GetConfig = getConfig,
    GetRuntimeState = getRuntimeState,
    PruneExpired = pruneExpired,
    SelectNextItem = selectNextItem,
    HandleAOECreate = handleAOECreate,
    HandleEntityCast = handleEntityCast,
    NearestPreparationPoint = nearestPreparationPoint,
    ApplyMoogleDonuts = applyMoogleDonuts,
    HasLive = hasLiveBerserker,
    DrawSelected = drawSelected,
}
end

rawset(_G, 'MuAiOccultCrescentSouthCrescentBerserker', Module)
return Module
