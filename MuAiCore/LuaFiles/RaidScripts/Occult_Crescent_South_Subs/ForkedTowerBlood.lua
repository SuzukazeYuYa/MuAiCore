local Module = {}

function Module.Create(Context)
    assert(type(Context) == 'table')
    local Common = assert(Context.Common)
    local getNow = assert(Context.GetNow)
    local getGreenDrawer = assert(Context.GetGreenDrawer)

local SOURCE = 'MuAiCore - Forked Tower Blood'
local TOKEN_GRACE_MS = 1000
local PENDING_ENTITY_MS = 1500
local MAGITAUR_CENTER = { x = 700, y = -476, z = -674 }

local AID = {
    FrozenFallout = 42461,
    RedPuddle = 42463,
    BluePuddle = 42464,
    DecisiveBattle = 42490,
    Axeblow = 41543,
    Lanceblow = 41547,
    HolyLance = 41557,
    AssassinsDagger = 41569,
}

local CONTENT_ID = {
    DemonTablet = 13760,
    NereidTarget = 13731,
    NereidFireball = 13857,
    PhobosFireball = 13733,
    Magitaur = 13947,
    MagitaurLance = 13948,
    Dagger = 13950,
    CirclePuddle = 2014546,
    CrossPuddle = 2014547,
}

local BLACKLIST = {
    [42463] = 'Frozen Fallout',
    [42464] = 'Frozen Fallout',
    [30210] = 'Imitation Blizzard',
    [30228] = 'Imitation Blizzard',
    [41569] = "Assassin's Dagger",
}

local DEFAULTS = { Enable = true }

local function newState()
    return {
        redPuddleCount = 0,
        bluePuddleCount = 0,
        active = {},
        seen = {},
        pendingVisibility = {},
        pendingObjects = {},
        blacklist = {
            owned = {},
            previous = {},
            previousKnown = {},
            registered = false,
        },
        lastDiagnostic = nil,
    }
end

local function ensureState(state)
    state = type(state) == 'table' and state or newState()
    state.redPuddleCount = Common.finite(state.redPuddleCount)
            and math.max(0, state.redPuddleCount) or 0
    state.bluePuddleCount = Common.finite(state.bluePuddleCount)
            and math.max(0, state.bluePuddleCount) or 0
    state.active = type(state.active) == 'table' and state.active or {}
    state.seen = type(state.seen) == 'table' and state.seen or {}
    state.pendingVisibility = type(state.pendingVisibility) == 'table'
            and state.pendingVisibility or {}
    state.pendingObjects = type(state.pendingObjects) == 'table'
            and state.pendingObjects or {}
    state.blacklist = type(state.blacklist) == 'table'
            and state.blacklist or {}
    state.blacklist.owned = type(state.blacklist.owned) == 'table'
            and state.blacklist.owned or {}
    state.blacklist.previous = type(state.blacklist.previous) == 'table'
            and state.blacklist.previous or {}
    state.blacklist.previousKnown =
            type(state.blacklist.previousKnown) == 'table'
                    and state.blacklist.previousKnown or {}
    state.blacklist.registered = state.blacklist.registered == true
    return state
end

local feature = Common.newFeature({
    key = 'ForkedTowerBlood',
    defaults = DEFAULTS,
    newState = newState,
    ensureState = ensureState,
    diagnosticThrottleMs = 1000,
})
local getConfig = feature.GetConfig
local getRuntimeState = feature.GetRuntimeState

local function diagnostic(state, code, now, context)
    feature.Diagnostic(
            state, rawget(_G, 'MuAiGuide'), code, now, context)
end

local function trackToken(state, token, expiresAt)
    if type(token) ~= 'string' then
        return false
    end
    state.active[token] = expiresAt
    return true
end

local function deleteTokens(state)
    for token in pairs(state.active) do
        Common.deleteTimedShape(token)
    end
    state.active = {}
end

local function resetEncounterState(state)
    state.redPuddleCount = 0
    state.bluePuddleCount = 0
    state.seen = {}
    state.pendingVisibility = {}
    state.pendingObjects = {}
end

local function clearState(state)
    state = ensureState(state)
    deleteTokens(state)
    resetEncounterState(state)
    state.lastDiagnostic = nil
end

local function getBlacklist(create)
    return Common.getMoogleTable('aoeIDUserBlacklist', create)
end

local function applyBlacklist(state, enabled)
    state = ensureState(state)
    local blacklist = getBlacklist(enabled == true)
    if blacklist == nil then
        state.blacklist.registered = false
        return false
    end
    if enabled == true then
        for aoeID, label in pairs(BLACKLIST) do
            local current = blacklist[aoeID]
            if state.blacklist.owned[aoeID] == nil then
                state.blacklist.previousKnown[aoeID] = current ~= nil
                state.blacklist.previous[aoeID] = current
            end
            if current == nil
                    or current == state.blacklist.owned[aoeID]
                    or type(current) == 'table' and current.source == SOURCE
            then
                local owned = {
                    label = label,
                    source = SOURCE,
                }
                blacklist[aoeID] = owned
                state.blacklist.owned[aoeID] = owned
            end
        end
        state.blacklist.registered = true
        return true
    end
    for aoeID, owned in pairs(state.blacklist.owned) do
        local current = blacklist[aoeID]
        if current == owned
                or type(current) == 'table' and current.source == SOURCE
        then
            if state.blacklist.previousKnown[aoeID] == true then
                blacklist[aoeID] = state.blacklist.previous[aoeID]
            else
                blacklist[aoeID] = nil
            end
        end
    end
    state.blacklist.owned = {}
    state.blacklist.previous = {}
    state.blacklist.previousKnown = {}
    state.blacklist.registered = false
    return true
end

local function getEntity(entityID)
    if not Common.finite(entityID)
            or type(TensorCore) ~= 'table'
            or type(TensorCore.mGetEntity) ~= 'function'
    then
        return nil
    end
    local entity = TensorCore.mGetEntity(entityID)
    return type(entity) == 'table' and entity or nil
end

local function validEntityPosition(entity)
    return type(entity) == 'table'
            and entity.alive ~= false
            and Common.copyPosition(entity.pos, false) or nil
end

local function contentID(entity)
    return type(entity) == 'table' and tonumber(entity.contentid) or nil
end

local function findEntity(filter, expectedContentID)
    if type(TensorCore) ~= 'table'
            or type(TensorCore.entityList) ~= 'function'
    then
        return nil
    end
    local entities = TensorCore.entityList(filter)
    if type(entities) ~= 'table' then
        return nil
    end
    local found = nil
    for _, entity in pairs(entities) do
        if contentID(entity) == expectedContentID
                and entity.alive ~= false
                and validEntityPosition(entity) ~= nil
        then
            if found ~= nil then
                return nil
            end
            found = entity
        end
    end
    return found
end

local function getDangerDrawer()
    return Common.getMoogleDrawer(true)
end

local function drawArrow(
        state, drawer, now, timeout, position, heading, length, width)
    if type(drawer) ~= 'table' and type(drawer) ~= 'userdata'
            or type(drawer.addTimedArrow) ~= 'function'
            or not Common.validXZ(position)
            or not Common.finite(position.y)
            or not Common.finite(heading)
    then
        return false
    end
    local token = drawer:addTimedArrow(
            timeout, position.x, position.y, position.z,
            heading, length, width, 3, 4)
    return trackToken(state, token, now + timeout + TOKEN_GRACE_MS)
end

local function drawCircle(
        state, drawer, now, timeout, position, radius, delay)
    delay = delay or 0
    if type(drawer) ~= 'table' and type(drawer) ~= 'userdata'
            or type(drawer.addTimedCircle) ~= 'function'
            or not Common.validXZ(position)
            or not Common.finite(position.y)
            or not Common.finite(radius) or radius <= 0
    then
        return false
    end
    local token = drawer:addTimedCircle(
            timeout, position.x, position.y, position.z, radius, delay)
    return trackToken(state, token,
            now + delay + timeout + TOKEN_GRACE_MS)
end

local function drawCircleOnEntity(
        state, drawer, now, timeout, entityID, radius, delay)
    delay = delay or 0
    if type(drawer) ~= 'table' and type(drawer) ~= 'userdata'
            or type(drawer.addTimedCircleOnEnt) ~= 'function'
            or not Common.finite(entityID)
    then
        return false
    end
    local token = drawer:addTimedCircleOnEnt(
            timeout, entityID, radius, delay)
    return trackToken(state, token,
            now + delay + timeout + TOKEN_GRACE_MS)
end

local function drawCrossOnEntity(
        state, drawer, now, timeout, entityID, length, width)
    if type(drawer) ~= 'table' and type(drawer) ~= 'userdata'
            or type(drawer.addTimedCrossOnEnt) ~= 'function'
            or not Common.finite(entityID)
    then
        return false
    end
    local token = drawer:addTimedCrossOnEnt(
            timeout, entityID, length, width)
    return trackToken(state, token, now + timeout + TOKEN_GRACE_MS)
end

local function drawCenteredRect(
        state, drawer, now, timeout, position,
        length, width, heading, delay)
    delay = delay or 0
    if type(drawer) ~= 'table' and type(drawer) ~= 'userdata'
            or type(drawer.addTimedCenteredRect) ~= 'function'
            or not Common.validXZ(position)
            or not Common.finite(position.y)
            or not Common.finite(heading)
    then
        return false
    end
    local token = drawer:addTimedCenteredRect(
            timeout, position.x, position.y, position.z,
            length, width, heading, delay)
    return trackToken(state, token,
            now + delay + timeout + TOKEN_GRACE_MS)
end

local function drawRect(
        state, drawer, now, timeout, position,
        length, width, heading, delay)
    delay = delay or 0
    if type(drawer) ~= 'table' and type(drawer) ~= 'userdata'
            or type(drawer.addTimedRect) ~= 'function'
            or not Common.validXZ(position)
            or not Common.finite(position.y)
            or not Common.finite(heading)
    then
        return false
    end
    local token = drawer:addTimedRect(
            timeout, position.x, position.y, position.z,
            length, width, heading, delay)
    return trackToken(state, token,
            now + delay + timeout + TOKEN_GRACE_MS)
end

local function drawDonut(
        state, drawer, now, timeout, position, inner, outer)
    if type(drawer) ~= 'table' and type(drawer) ~= 'userdata'
            or type(drawer.addTimedDonut) ~= 'function'
            or not Common.validXZ(position)
            or not Common.finite(position.y)
    then
        return false
    end
    local token = drawer:addTimedDonut(
            timeout, position.x, position.y, position.z, inner, outer)
    return trackToken(state, token, now + timeout + TOKEN_GRACE_MS)
end

local function getPlayer(guide)
    if type(guide) == 'table' and type(guide.GetPlayer) == 'function' then
        local player = guide.GetPlayer()
        if type(player) == 'table' then
            return player
        end
    end
    if type(TensorCore) == 'table'
            and type(TensorCore.mGetPlayer) == 'function'
    then
        local player = TensorCore.mGetPlayer()
        return type(player) == 'table' and player or nil
    end
    return nil
end

local function buffStacks(entityID, buffID)
    if type(TensorCore) ~= 'table'
            or type(TensorCore.getBuff) ~= 'function'
    then
        return 0
    end
    local buff = TensorCore.getBuff(entityID, buffID)
    return type(buff) == 'table' and tonumber(buff.stacks) or 0
end

local function eventKey(prefix, entityID, value, now)
    return table.concat({
        prefix, tostring(entityID), tostring(value),
        tostring(math.floor(now / 50)),
    }, ':')
end

local function handleMarkerAdd(
        state, guide, entityID, markerID, now)
    local player = getPlayer(guide)
    if type(player) ~= 'table' or tonumber(player.id) ~= tonumber(entityID)
            or markerID ~= 574 and markerID ~= 575
    then
        return false
    end
    local key = eventKey('marker', entityID, markerID, now)
    if state.seen[key] ~= nil then
        return false
    end
    local tablet = findEntity(
            'contentid=' .. tostring(CONTENT_ID.DemonTablet) .. ',attackable',
            CONTENT_ID.DemonTablet)
    local position = validEntityPosition(tablet)
    local drawer = getGreenDrawer(guide)
    if position == nil or drawer == nil then
        diagnostic(state, 'stack_arrow_geometry_missing', now, markerID)
        return false
    end
    local heading = markerID == 574 and 0 or math.pi
    if not drawArrow(state, drawer, now, 17000,
            position, heading, 5, 5)
    then
        diagnostic(state, 'stack_arrow_drawer_unavailable', now, markerID)
        return false
    end
    state.seen[key] = now
    return true
end

local function handlePuddleAOE(state, guide, aoeInfo, now)
    local actionID = tonumber(aoeInfo.aoeID)
    if actionID ~= AID.RedPuddle and actionID ~= AID.BluePuddle then
        return false
    end
    local position = Common.copyPosition({
        x = aoeInfo.x, y = aoeInfo.y, z = aoeInfo.z,
    }, false)
    local radius = tonumber(aoeInfo.aoeLength)
    local player = getPlayer(guide)
    if position == nil or not Common.finite(radius) or radius <= 0
            or type(player) ~= 'table' or not Common.finite(player.id)
    then
        diagnostic(state, 'puddle_geometry_missing', now, actionID)
        return false
    end
    local key = table.concat({
        'puddle', tostring(aoeInfo.entityID), tostring(actionID),
        tostring(aoeInfo.startTime),
    }, ':')
    if state.seen[key] ~= nil then
        return false
    end
    local count, opposingBuff
    if actionID == AID.RedPuddle then
        count = state.redPuddleCount
        opposingBuff = 4442
    else
        count = state.bluePuddleCount
        opposingBuff = 4441
    end
    local safe = count < buffStacks(player.id, opposingBuff)
    local drawer = safe and getGreenDrawer(guide) or getDangerDrawer()
    local timeout = count == 0 and 11500 or 5500
    local delay = count == 0 and 0 or 8900 + 3100 * (count - 1)
    if not drawCircle(
            state, drawer, now, timeout, position, radius, delay)
    then
        diagnostic(state, 'puddle_drawer_unavailable', now, actionID)
        return false
    end
    if actionID == AID.RedPuddle then
        state.redPuddleCount = count + 1
    else
        state.bluePuddleCount = count + 1
    end
    state.seen[key] = now
    return true
end

local function handleDaggerAOE(state, aoeInfo, now)
    if tonumber(aoeInfo.aoeID) ~= AID.AssassinsDagger
            or tonumber(aoeInfo.contentID) ~= CONTENT_ID.Dagger
    then
        return false
    end
    local heading = tonumber(aoeInfo.heading)
    local length = tonumber(aoeInfo.aoeLength)
    local width = tonumber(aoeInfo.aoeWidth)
    if not Common.finite(heading)
            or not Common.finite(length) or length <= 0
            or not Common.finite(width) or width <= 0
    then
        diagnostic(state, 'dagger_geometry_missing', now, aoeInfo.entityID)
        return false
    end
    local key = table.concat({
        'dagger', tostring(aoeInfo.entityID),
        tostring(aoeInfo.startTime),
    }, ':')
    if state.seen[key] ~= nil then
        return false
    end
    local drawer = getDangerDrawer()
    if drawer == nil then
        diagnostic(state, 'dagger_drawer_unavailable', now, nil)
        return false
    end
    local success = drawRect(state, drawer, now, 5000,
            MAGITAUR_CENTER, length, width, heading, 0)
    success = drawRect(state, drawer, now, 2000,
            MAGITAUR_CENTER, length, width, heading, 5000) and success
    local rotation = math.rad(50)
    for set = 1, 5 do
        local setHeading = heading - rotation * set
        for slot = 1, 2 do
            local delay = 5000 + 2000 * ((set - 1) * 2 + slot)
            success = drawRect(state, drawer, now, 2000,
                    MAGITAUR_CENTER, length, width,
                    setHeading, delay) and success
        end
    end
    if not success then
        diagnostic(state, 'dagger_drawer_rejected', now, nil)
        return false
    end
    state.seen[key] = now
    return true
end

local function handleAOECreate(state, guide, aoeInfo, now)
    if type(aoeInfo) ~= 'table' then
        return false
    end
    return handlePuddleAOE(state, guide, aoeInfo, now)
            or handleDaggerAOE(state, aoeInfo, now)
end

local function drawFireball(state, guide, entityID, now)
    local entity = getEntity(entityID)
    local id = contentID(entity)
    if id ~= CONTENT_ID.NereidFireball
            and id ~= CONTENT_ID.PhobosFireball
    then
        return id == nil and nil or false
    end
    if validEntityPosition(entity) == nil then
        return nil
    end
    local drawer = id == CONTENT_ID.NereidFireball
            and getGreenDrawer(guide) or getDangerDrawer()
    if not drawCircleOnEntity(
            state, drawer, now, 10500, entityID, 5, 0)
    then
        diagnostic(state, 'fireball_drawer_unavailable', now, id)
        return false
    end
    return true
end

local function handleVisibilityChange(
        state, guide, entityID, wasVisible, isVisible, now)
    if wasVisible ~= false or isVisible ~= true then
        state.pendingVisibility[entityID] = nil
        return false
    end
    local result = drawFireball(state, guide, entityID, now)
    if result == nil then
        state.pendingVisibility[entityID] = now + PENDING_ENTITY_MS
        return true
    end
    return result == true
end

local function handleTetherChange(
        state, guide, sourceEntityID,
        newTargetID, newTetherID, now)
    local player = getPlayer(guide)
    if type(player) ~= 'table'
            or tonumber(newTargetID) ~= tonumber(player.id)
            or tonumber(newTetherID) ~= 246
    then
        return false
    end
    local snowball = getEntity(sourceEntityID)
    local snowballPosition = validEntityPosition(snowball)
    local nereid = findEntity(
            'contentid=' .. tostring(CONTENT_ID.NereidTarget)
                    .. ',attackable', CONTENT_ID.NereidTarget)
    local nereidPosition = validEntityPosition(nereid)
    if snowballPosition == nil or nereidPosition == nil then
        diagnostic(state, 'snowball_tether_geometry_missing', now, nil)
        return false
    end
    local dx, dz = Common.normalized(
            nereidPosition.x - snowballPosition.x,
            nereidPosition.z - snowballPosition.z)
    if dx == nil then
        diagnostic(state, 'snowball_tether_heading_missing', now, nil)
        return false
    end
    local drawer = getGreenDrawer(guide)
    if not drawArrow(state, drawer, now, 6000,
            nereidPosition, math.atan2(dx, dz), 10, 1)
    then
        diagnostic(state, 'snowball_tether_drawer_unavailable', now, nil)
        return false
    end
    return true
end

local function drawFrozenObject(state, entityID, now)
    local entity = getEntity(entityID)
    local id = contentID(entity)
    if id ~= CONTENT_ID.CirclePuddle and id ~= CONTENT_ID.CrossPuddle then
        return id == nil and nil or false
    end
    if validEntityPosition(entity) == nil then
        return nil
    end
    local drawer = getDangerDrawer()
    local success
    if id == CONTENT_ID.CirclePuddle then
        success = drawCircleOnEntity(
                state, drawer, now, 4000, entityID, 20, 0)
    else
        success = drawCrossOnEntity(
                state, drawer, now, 4000, entityID, 60, 16)
    end
    if not success then
        diagnostic(state, 'frozen_object_drawer_unavailable', now, id)
        return false
    end
    return true
end

local function handleScriptFunc(state, entityID, a1, a2, a3, now)
    if a1 ~= 16 or a2 ~= 32 or a3 ~= 0 then
        return false
    end
    local result = drawFrozenObject(state, entityID, now)
    if result == nil then
        state.pendingObjects[entityID] = now + PENDING_ENTITY_MS
        return true
    end
    return result == true
end

local BLOW_HEADINGS = {
    math.rad(45), math.rad(165), math.rad(285),
}

local function hasMagitaurLance()
    if type(TensorCore) ~= 'table'
            or type(TensorCore.entityList) ~= 'function'
    then
        return false
    end
    local entities = TensorCore.entityList(
            'contentid=' .. tostring(CONTENT_ID.MagitaurLance))
    for _, entity in pairs(type(entities) == 'table' and entities or {}) do
        if contentID(entity) == CONTENT_ID.MagitaurLance
                and entity.alive ~= false
        then
            return true
        end
    end
    return false
end

local function drawMagitaurBlow(
        state, guide, entityID, spellID, now)
    local entity = getEntity(entityID)
    if contentID(entity) ~= CONTENT_ID.Magitaur then
        return false
    end
    local position = validEntityPosition(entity)
    if position == nil then
        diagnostic(state, 'magitaur_geometry_missing', now, spellID)
        return false
    end
    local danger = getDangerDrawer()
    local green = getGreenDrawer(guide)
    local success = true
    if spellID == AID.Axeblow then
        local lance = hasMagitaurLance()
        for index, heading in ipairs(BLOW_HEADINGS) do
            local delay = lance and index == 3 and 3250 or 0
            local timeout = lance and index == 3 and 2850 or 6100
            success = drawCenteredRect(state, green, now,
                    timeout, position, 20, 20, heading, delay) and success
        end
        success = drawCircle(
                state, danger, now, 6100, position, 20, 0) and success
    elseif spellID == AID.Lanceblow then
        for _, heading in ipairs(BLOW_HEADINGS) do
            success = drawCenteredRect(state, danger, now,
                    6100, position, 20, 20, heading, 0) and success
        end
        success = drawDonut(
                state, danger, now, 6100, position, 10, 32) and success
    else
        return false
    end
    if not success then
        diagnostic(state, 'magitaur_blow_drawer_rejected', now, spellID)
    end
    return success
end

local function handleEntityChannel(
        state, guide, entityID, spellID, now)
    if spellID == AID.DecisiveBattle then
        state.redPuddleCount = 0
        state.bluePuddleCount = 0
        return true
    end
    if spellID == AID.Axeblow or spellID == AID.Lanceblow then
        return drawMagitaurBlow(
                state, guide, entityID, spellID, now)
    end
    return false
end

local LANCE_SQUARE = {
    [1] = math.rad(165), [2] = math.rad(165), [3] = math.rad(165),
    [5] = math.rad(45), [6] = math.rad(45), [7] = math.rad(45),
    [9] = math.rad(285), [10] = math.rad(285), [11] = math.rad(285),
}

local function drawHolyLance(state, guide, entityID, now)
    local entity = getEntity(entityID)
    if contentID(entity) ~= CONTENT_ID.Magitaur then
        return false
    end
    local green = getGreenDrawer(guide)
    local danger = getDangerDrawer()
    local success = true
    for count = 0, 11 do
        local delay = 12125 + 2000 * count
        if count == 0 or count == 4 or count == 8 then
            for _, heading in ipairs(BLOW_HEADINGS) do
                success = drawCenteredRect(state, green, now,
                        2000, MAGITAUR_CENTER,
                        20, 20, heading, delay) and success
            end
        else
            local heading = LANCE_SQUARE[count]
            if heading ~= nil then
                success = drawCenteredRect(state, danger, now,
                        2000, MAGITAUR_CENTER,
                        20, 20, heading, delay) and success
            end
        end
    end
    if type(TensorCore) == 'table'
            and type(TensorCore.entityList) == 'function'
            and type(TensorCore.getBuff) == 'function'
    then
        local players = TensorCore.entityList(
                'chartype=4,alive,maxdistance=30')
        for _, player in pairs(type(players) == 'table' and players or {}) do
            local playerID = tonumber(player.id)
            if Common.finite(playerID) then
                for _, buffID in ipairs({ 4336, 4337, 4338 }) do
                    local buff = TensorCore.getBuff(playerID, buffID)
                    local remaining = type(buff) == 'table'
                            and tonumber(buff.duration) or nil
                    if Common.finite(remaining) and remaining > 0 then
                        local remainingMs = math.floor(remaining * 1000 + 0.5)
                        local timeout = math.min(8000, remainingMs)
                        local delay = math.max(0, remainingMs - timeout)
                        success = drawCircleOnEntity(state, danger, now,
                                timeout, playerID, 7, delay) and success
                        break
                    end
                end
            end
        end
    end
    if not success then
        diagnostic(state, 'holy_lance_drawer_rejected', now, nil)
    end
    return success
end

local function handleEntityCast(
        state, guide, entityID, spellID, now)
    if spellID ~= AID.HolyLance then
        return false
    end
    return drawHolyLance(state, guide, entityID, now)
end

local function tick(state, guide, now)
    state = ensureState(state)
    for token, expiresAt in pairs(state.active) do
        if not Common.finite(expiresAt) or now > expiresAt then
            state.active[token] = nil
        end
    end
    for key, seenAt in pairs(state.seen) do
        if not Common.finite(seenAt) or now - seenAt > 60000 then
            state.seen[key] = nil
        end
    end
    for entityID, expiresAt in pairs(state.pendingVisibility) do
        local result = drawFireball(state, guide, entityID, now)
        if result ~= nil or now > expiresAt then
            state.pendingVisibility[entityID] = nil
        end
    end
    for entityID, expiresAt in pairs(state.pendingObjects) do
        local result = drawFrozenObject(state, entityID, now)
        if result ~= nil or now > expiresAt then
            state.pendingObjects[entityID] = nil
        end
    end
end

return {
    Source = SOURCE,
    AID = AID,
    ContentID = CONTENT_ID,
    Defaults = DEFAULTS,
    NewState = newState,
    EnsureState = ensureState,
    GetConfig = getConfig,
    GetRuntimeState = getRuntimeState,
    ClearState = clearState,
    ApplyBlacklist = applyBlacklist,
    HandleMarkerAdd = handleMarkerAdd,
    HandleAOECreate = handleAOECreate,
    HandleVisibilityChange = handleVisibilityChange,
    HandleTetherChange = handleTetherChange,
    HandleScriptFunc = handleScriptFunc,
    HandleEntityChannel = handleEntityChannel,
    HandleEntityCast = handleEntityCast,
    Tick = tick,
    Test = {
        BuffStacks = buffStacks,
        HandlePuddleAOE = handlePuddleAOE,
        DrawMagitaurBlow = drawMagitaurBlow,
        DrawHolyLance = drawHolyLance,
        HandleDaggerAOE = handleDaggerAOE,
    },
}
end

rawset(_G, 'MuAiOccultCrescentSouthForkedTowerBlood', Module)
return Module
