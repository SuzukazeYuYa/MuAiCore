local Module = {}

function Module.Create(Context)
    assert(type(Context) == 'table' and type(Context.Common) == 'table')
    local Common = Context.Common
    local finite = Context.finite
    local nowMs = Context.nowMs
    local reliablePosition = Context.reliablePosition
    local resolveEntity = Context.resolveEntity
    local getPlayer = Context.getPlayer

local REFERENCE_SOURCE = 'MuAiCore - 北岛参考范围'
local REFERENCE_COMMIT = 'fda083a9e2b0b183937727ab7010f3bc0ddfa5bc'
local REFERENCE_SEEN_TTL_MS = 30000
local REFERENCE_TOKEN_GRACE_MS = 1000

local OWNER_DEFAULTS = {
    Enable = true,
}

local function one(contentID, shape)
    return {
        contentIDs = { [contentID] = true },
        shapes = { shape },
    }
end

local function oneWithShapes(contentID, shapes)
    return {
        contentIDs = { [contentID] = true },
        shapes = shapes,
    }
end

local elementBlasters = one(14523, { kind = 'circle', radius = 8 })

-- Source: ToolerofLight north-island Splatoon layouts at REFERENCE_COMMIT.
-- Splatoon donuts use radius as the inner radius and Donut as annulus width;
-- line radius is half-width. Delayed/overcast windows are retained explicitly.
local REFERENCE_SHAPES = {
    -- Live map-1346 AOE headings already point at each combo's first hit;
    -- only the delayed follow-up is rotated to the opposite half.
    [48294] = oneWithShapes(14791, {
        { kind = 'cone', radius = 45, angle = math.pi },
        {
            kind = 'cone', radius = 45, angle = math.pi,
            headingOffset = math.pi,
            minElapsedMs = 6000, maxElapsedMs = 10000,
            keepAfterCast = true,
        },
    }),
    [48295] = oneWithShapes(14791, {
        {
            kind = 'cone', radius = 40, angle = math.pi,
        },
        {
            kind = 'cone', radius = 40, angle = math.pi,
            headingOffset = math.pi,
            minElapsedMs = 6000, maxElapsedMs = 10000,
            keepAfterCast = true,
        },
    }),
    [47543] = one(14508, {
        kind = 'circle', radius = 25,
    }),
    [47199] = elementBlasters,
    [47200] = elementBlasters,
    [47201] = elementBlasters,
    [47202] = elementBlasters,
    [47203] = elementBlasters,
    [48354] = one(14801, { kind = 'donut', inner = 10, outer = 30 }),
    [48341] = one(14801, { kind = 'circle', radius = 15 }),
    [47306] = one(14520, {
        kind = 'rect', length = 100, width = 6, back = 50,
    }),
    [48111] = one(14790, {
        kind = 'rect', length = 100, width = 6, back = 50,
    }),
    [48112] = one(14790, {
        kind = 'cone', radius = 30, angle = math.rad(30),
        headingOffset = math.rad(60),
    }),
    [47170] = one(14509, {
        kind = 'rect', length = 50, width = 10, back = 25,
    }),
    [50379] = one(14840, { kind = 'circle', radius = 10 }),
    [50380] = one(14840, {
        kind = 'donut', inner = 10, outer = 20,
        minElapsedMs = 5000, maxElapsedMs = 10000,
    }),
    [50381] = one(14840, {
        kind = 'donut', inner = 20, outer = 30,
        minElapsedMs = 7000, maxElapsedMs = 12000,
    }),

    [47640] = one(14490, { kind = 'donut', inner = 15, outer = 45 }),
    [47639] = one(14491, {
        kind = 'circle', radius = 18.29,
        forward = 20, right = -0.3,
    }),
    [47641] = one(14491, { kind = 'circle', radius = 20 }),
    [47686] = {
        contentIDs = { [14490] = true, [14491] = true },
        shapes = { { kind = 'donut', inner = 5, outer = 45 } },
    },
    [47685] = {
        contentIDs = { [14490] = true, [14491] = true },
        shapes = { { kind = 'cross', length = 100, width = 10 } },
    },
    [47697] = {
        contentIDs = { [14490] = true, [14491] = true },
        shapes = {
            { kind = 'rect', length = 40.5, width = 11, back = 0.5 },
        },
    },
    [47702] = {
        contentIDs = { [14490] = true, [14491] = true },
        shapes = {
            { kind = 'rect', length = 40.5, width = 20, back = 0.5 },
        },
    },
    [50726] = one(14489, {
        kind = 'circle', radius = 20,
        minElapsedMs = 6500, maxElapsedMs = 15000,
    }),
    [47629] = one(14490, {
        kind = 'donut', inner = 18, outer = 48,
        minElapsedMs = 6500, maxElapsedMs = 15000,
    }),
    [50725] = one(14489, {
        kind = 'donut', inner = 17, outer = 47,
        minElapsedMs = 6500, maxElapsedMs = 15000,
    }),
    [47620] = one(14491, {
        kind = 'circle', radius = 20, right = 4.5,
        minElapsedMs = 6500, maxElapsedMs = 15000,
    }),
    [49628] = one(14821, {
        kind = 'donutCone', inner = 19, outer = 24,
        angle = math.rad(90), headingOffset = math.rad(-45),
        forward = -21.5,
    }),
    [49634] = one(14821, {
        kind = 'donutCone', inner = 19, outer = 24,
        angle = math.rad(78), headingOffset = math.rad(-39),
        forward = -21.5,
    }),
    [49623] = one(14821, {
        kind = 'donutCone', inner = 9, outer = 14,
        angle = math.rad(90), headingOffset = math.rad(45),
        forward = -11.5,
    }),
    [49624] = one(14821, {
        kind = 'donutCone', inner = 14, outer = 19,
        angle = math.rad(90), headingOffset = math.rad(45),
        forward = -16.5,
    }),
    [49630] = one(14821, {
        kind = 'donutCone', inner = 14, outer = 19,
        angle = math.rad(74), headingOffset = math.rad(37),
        forward = -16.5,
    }),
    [49627] = one(14821, {
        kind = 'donutCone', inner = 14, outer = 19,
        angle = math.rad(90), headingOffset = math.rad(-45),
        forward = -16.5,
    }),
    [49622] = one(14821, {
        kind = 'rect', length = 100, width = 7, back = 50,
    }),
    [49674] = one(14824, {
        kind = 'rect', length = 50, width = 6,
    }),
    [49641] = one(14820, {
        kind = 'cone', radius = 50, angle = math.pi,
        maxElapsedMs = 6000, keepAfterCast = true,
    }),
    [49642] = one(14820, {
        kind = 'cone', radius = 50, angle = math.pi,
        headingOffset = math.pi,
        maxElapsedMs = 6000, keepAfterCast = true,
    }),
    [49643] = one(14820, {
        kind = 'cone', radius = 50, angle = math.pi,
        headingOffset = math.rad(90),
        maxElapsedMs = 6000, keepAfterCast = true,
    }),
    [49644] = one(14820, {
        kind = 'cone', radius = 50, angle = math.pi,
        headingOffset = math.rad(-90),
        maxElapsedMs = 6000, keepAfterCast = true,
    }),
    [49672] = one(14820, {
        kind = 'rect', length = 60, width = 20, back = 30,
    }),
    [48848] = one(14815, { kind = 'circle', radius = 20 }),
    [50358] = one(14503, {
        kind = 'cone', radius = 50, angle = math.rad(45),
        headingOffset = math.rad(0.5),
    }),
    [47497] = one(14504, {
        kind = 'cone', radius = 50, angle = math.rad(45),
        headingOffset = math.rad(0.5),
    }),
    [47490] = one(14503, { kind = 'circle', radius = 13 }),
    [47494] = one(14504, { kind = 'circle', radius = 16.6 }),
    [47491] = one(14503, {
        kind = 'cross', length = 60, width = 5,
    }),
    [47495] = one(14504, {
        kind = 'rect', length = 100, width = 12, back = 50,
        headingOffset = math.rad(90),
    }),
    [47504] = one(14504, {
        kind = 'rect', length = 50, width = 6,
    }),
    [47499] = one(14503, {
        kind = 'rect', length = 100, width = 10, back = 50,
    }),
    [47500] = one(14503, {
        kind = 'rect', length = 100, width = 10, back = 50,
    }),
    [47501] = one(14503, {
        kind = 'rect', length = 100, width = 10, back = 50,
        headingOffset = math.rad(90),
    }),
    [47502] = one(14503, {
        kind = 'cone', radius = 50, angle = math.pi,
    }),
    [47522] = one(14503, {
        kind = 'cross', length = 100, width = 15,
    }),
    [47493] = one(14503, {
        kind = 'cone', radius = 50, angle = math.rad(45),
        headingOffset = math.rad(0.5),
    }),
    [47521] = one(14503, { kind = 'circle', radius = 18 }),
}

-- The renderer is shared, but every action is governed by its actual boss
-- switch. This keeps one rendering path without exposing a second "generic"
-- owner in the UI.
local OWNER_AIDS = {
    GemstoneBeast = { 48294, 48295 },
    SacredTreeGiant = { 47543 },
    MagiHydra = { 47199, 47200, 47201, 47202, 47203 },
    ShapeshiftingMage = {
        48354, 48341,
        -- Dedicated prediction owns these three shapes; only their native
        -- late telegraphs remain suppressed here.
        48662, 48663, 50677,
    },
    OccultGrimoire = { 47306 },
    Argol = { 48111, 48112 },
    AlabasterBlade = { 47170 },
    Arachne = { 50379, 50380, 50381 },
    TwoHeadedAevis = {
        47640, 47639, 47641, 47686, 47685, 47697, 47702,
        50726, 47629, 50725, 47620,
    },
    SwordDancer = {
        49628, 49634, 49623, 49624, 49630, 49627, 49622,
        49674, 49641, 49642, 49643, 49644, 49672, 48848,
    },
    Necrophobia = {
        50358, 47497, 47490, 47494, 47491, 47495, 47504,
        47499, 47500, 47501, 47502, 47522, 47493, 47521,
    },
    MagiNecromancer = {
        -- Dedicated prediction owns these shapes; only their native late
        -- telegraphs remain suppressed here.
        47175, 47176, 47180,
    },
}

local ACTION_OWNER = {}
for owner, actionIDs in pairs(OWNER_AIDS) do
    for _, actionID in ipairs(actionIDs) do
        assert(ACTION_OWNER[actionID] == nil,
                'duplicate North reference owner: ' .. tostring(actionID))
        ACTION_OWNER[actionID] = owner
    end
end
for actionID in pairs(REFERENCE_SHAPES) do
    assert(type(ACTION_OWNER[actionID]) == 'string',
            'missing North reference owner: ' .. tostring(actionID))
end

-- 50377 remains owned by the dedicated Arachne predictor. 47191 and
-- 50706/50707/50708 depend on conditional warning/status chains that are not
-- available as reliable MuAi event geometry, so they intentionally fail closed.
-- MTE4's four summoned-weapon layouts depend on VFX-to-entity association that
-- has not appeared in the available MuAi diagnostics, so those layouts also
-- remain fail closed. Localized-name/model-only helpers without a stable action
-- signal are likewise not mirrored here.
local CHANNEL_GUIDES = {
    [47638] = {
        owner = 'TwoHeadedAevis',
        contentIDs = { [14490] = true }, distance = 15,
    },
    [49660] = {
        owner = 'SwordDancer',
        contentIDs = { [14821] = true, [14822] = true },
        distance = 25,
    },
    [48405] = {
        owner = 'Index',
        contentIDs = { [14721] = true },
        distance = 10,
        maxDistance = 12,
    },
}

local function newState()
    return {
        seen = {},
        active = {},
        blacklist = { owned = {}, registered = false },
        lastDiagnostic = nil,
    }
end

local function ensureState(state)
    state = type(state) == 'table' and state or newState()
    state.seen = type(state.seen) == 'table' and state.seen or {}
    state.active = type(state.active) == 'table' and state.active or {}
    state.blacklist = type(state.blacklist) == 'table'
            and state.blacklist or {}
    state.blacklist.owned = type(state.blacklist.owned) == 'table'
            and state.blacklist.owned or {}
    state.blacklist.registered = state.blacklist.registered == true
    return state
end

local referenceFeature = Common.newFeature({
    key = 'NorthReferenceDrawings',
    newState = newState,
    ensureState = ensureState,
    diagnosticThrottleMs = 1000,
})

local function getOwnerConfig(guide, owner)
    return type(owner) == 'string'
            and Common.getConfig(guide, owner, OWNER_DEFAULTS) or nil
end

local function ownerEnabled(guide, owner)
    local cfg = getOwnerConfig(guide, owner)
    return cfg ~= nil and cfg.Enable == true
end

local function diagnostic(state, code, now, context)
    referenceFeature.Diagnostic(
            state, rawget(_G, 'MuAiGuide'), code, now, context)
end

local function getState()
    return Common.getRuntimeState(
            'NorthReferenceDrawings', newState, ensureState)
end

local function deleteActiveToken(token)
    Common.deleteTimedShape(token)
end

local function clearDraws(state)
    state = ensureState(state)
    for _, entry in pairs(state.active) do
        for _, activeShape in ipairs(entry.shapes or {}) do
            deleteActiveToken(activeShape.token)
        end
    end
    state.seen = {}
    state.active = {}
    state.lastDiagnostic = nil
end

local function clearOwnerDraws(state, owner)
    state = ensureState(state)
    local removed = false
    for key, entry in pairs(state.active) do
        if entry.owner == owner then
            for _, activeShape in ipairs(entry.shapes or {}) do
                deleteActiveToken(activeShape.token)
            end
            state.active[key] = nil
            removed = true
        end
    end
    return removed
end

local function getBlacklist(create)
    return Common.getMoogleTable('aoeIDUserBlacklist', create)
end

local function ownsBlacklist(state, aoeID, current)
    return current ~= nil
            and (current == state.blacklist.owned[aoeID]
            or (type(current) == 'table'
                    and current.source == REFERENCE_SOURCE))
end

local function syncBlacklist(state, guide)
    state = ensureState(state)
    local blacklist = getBlacklist(true)
    if blacklist == nil then
        state.blacklist.registered = false
        return false
    end
    for actionID, owner in pairs(ACTION_OWNER) do
        local current = blacklist[actionID]
        if ownerEnabled(guide, owner) then
            if current == nil then
                local owned = {
                    label = '北岛 Boss 归属范围',
                    source = REFERENCE_SOURCE,
                    owner = owner,
                }
                blacklist[actionID] = owned
                state.blacklist.owned[actionID] = owned
            elseif type(current) == 'table'
                    and current.source == REFERENCE_SOURCE
            then
                current.owner = owner
                state.blacklist.owned[actionID] = current
            else
                state.blacklist.owned[actionID] = nil
            end
        else
            if ownsBlacklist(state, actionID, current) then
                blacklist[actionID] = nil
            end
            state.blacklist.owned[actionID] = nil
        end
    end
    state.blacklist.registered = true
    return true
end

local function releaseBlacklist(state)
    state = ensureState(state)
    local blacklist = getBlacklist(false)
    if blacklist == nil then
        state.blacklist.registered = false
        return false
    end
    for actionID in pairs(ACTION_OWNER) do
        local current = blacklist[actionID]
        if ownsBlacklist(state, actionID, current) then
            blacklist[actionID] = nil
        end
    end
    state.blacklist.owned = {}
    state.blacklist.registered = false
    return true
end

local function eventKey(aoeInfo)
    return tostring(aoeInfo.entityID)
            .. ':' .. tostring(aoeInfo.aoeID)
            .. ':' .. tostring(math.floor(aoeInfo.startTime))
end

local function contentMatches(entry, contentID)
    return type(entry) == 'table'
            and type(entry.contentIDs) == 'table'
            and entry.contentIDs[contentID] == true
end

local function offsetPosition(x, z, heading, forward, right)
    forward = forward or 0
    right = right or 0
    return x + math.sin(heading) * forward + math.cos(heading) * right,
            z + math.cos(heading) * forward - math.sin(heading) * right
end

local function geometry(shape, aoeInfo)
    if not finite(aoeInfo.x)
            or not finite(aoeInfo.y)
            or aoeInfo.y == 0
            or not finite(aoeInfo.z)
    then
        return nil, 'missing_position'
    end
    local directional = shape.kind == 'cone'
            or shape.kind == 'donutCone'
            or shape.kind == 'rect'
            or shape.kind == 'cross'
            or shape.forward ~= nil
            or shape.right ~= nil
    if directional and not finite(aoeInfo.heading) then
        return nil, 'missing_heading'
    end
    local baseHeading = aoeInfo.heading or 0
    local heading = baseHeading + (shape.headingOffset or 0)
    local x, z = offsetPosition(
            aoeInfo.x, aoeInfo.z, baseHeading,
            shape.forward, shape.right)
    if shape.kind == 'rect' and finite(shape.back) and shape.back > 0 then
        x, z = offsetPosition(x, z, heading, -shape.back, 0)
    end
    return {
        x = x,
        y = aoeInfo.y,
        z = z,
        heading = heading,
        radius = shape.radius,
        inner = shape.inner,
        outer = shape.outer,
        angle = shape.angle,
        length = shape.length,
        width = shape.width,
    }
end

local function timing(shape, aoeInfo)
    local eventDurationMs = math.floor(aoeInfo.duration * 1000 + 0.5)
    local startAt = shape.minElapsedMs or 0
    local endAt = eventDurationMs
    if finite(shape.maxElapsedMs) then
        if shape.keepAfterCast == true then
            endAt = shape.maxElapsedMs
        else
            endAt = math.min(endAt, shape.maxElapsedMs)
        end
    end
    if startAt < 0 or endAt <= startAt then
        return nil
    end
    return {
        delay = startAt,
        timeout = endAt - startAt,
        keepAfterCast = shape.keepAfterCast == true,
    }
end

local guideDrawer
local function getGuideDrawer(guide)
    if guideDrawer == nil
            and type(guide) == 'table'
            and type(guide.CreateDrawer) == 'function'
    then
        guideDrawer = guide.CreateDrawer(0, 1, 0, 0.28, 2, 0)
    end
    return type(guideDrawer) == 'table' and guideDrawer or nil
end

local function drawShape(drawer, shape, drawGeometry, drawTiming)
    local timeout = drawTiming.timeout
    local delay = drawTiming.delay
    if shape.kind == 'circle'
            and type(drawer.addTimedCircle) == 'function'
    then
        return drawer:addTimedCircle(
                timeout,
                drawGeometry.x, drawGeometry.y, drawGeometry.z,
                drawGeometry.radius,
                delay)
    elseif shape.kind == 'donut'
            and type(drawer.addTimedDonut) == 'function'
    then
        return drawer:addTimedDonut(
                timeout,
                drawGeometry.x, drawGeometry.y, drawGeometry.z,
                drawGeometry.inner, drawGeometry.outer,
                delay)
    elseif shape.kind == 'cone'
            and type(drawer.addTimedCone) == 'function'
    then
        return drawer:addTimedCone(
                timeout,
                drawGeometry.x, drawGeometry.y, drawGeometry.z,
                drawGeometry.radius, drawGeometry.angle,
                drawGeometry.heading,
                delay)
    elseif shape.kind == 'donutCone'
            and type(drawer.addTimedDonutCone) == 'function'
    then
        return drawer:addTimedDonutCone(
                timeout,
                drawGeometry.x, drawGeometry.y, drawGeometry.z,
                drawGeometry.inner, drawGeometry.outer,
                drawGeometry.angle, drawGeometry.heading,
                delay)
    elseif shape.kind == 'rect'
            and type(drawer.addTimedRect) == 'function'
    then
        return drawer:addTimedRect(
                timeout,
                drawGeometry.x, drawGeometry.y, drawGeometry.z,
                drawGeometry.length, drawGeometry.width,
                drawGeometry.heading,
                delay)
    elseif shape.kind == 'cross'
            and type(drawer.addTimedCross) == 'function'
    then
        return drawer:addTimedCross(
                timeout,
                drawGeometry.x, drawGeometry.y, drawGeometry.z,
                drawGeometry.length, drawGeometry.width,
                drawGeometry.heading,
                delay)
    end
    return nil
end

local function rollbackShapes(activeShapes)
    for _, activeShape in ipairs(activeShapes) do
        deleteActiveToken(activeShape.token)
    end
end

local function handleAOECreate(state, guide, aoeInfo, now)
    state = ensureState(state)
    local entry = type(aoeInfo) == 'table'
            and REFERENCE_SHAPES[aoeInfo.aoeID] or nil
    if entry == nil then
        return false
    end
    local owner = ACTION_OWNER[aoeInfo.aoeID]
    if not ownerEnabled(guide, owner) then
        return false
    end
    if not finite(now)
            or not finite(aoeInfo.entityID)
            or not finite(aoeInfo.contentID)
            or not finite(aoeInfo.startTime)
            or not finite(aoeInfo.duration)
            or aoeInfo.duration <= 0
            or aoeInfo.duration > 30
    then
        diagnostic(state, 'missing_event_identity', nowMs(), aoeInfo.aoeID)
        return false
    end
    if not contentMatches(entry, aoeInfo.contentID) then
        diagnostic(state, 'content_id_mismatch', now, {
            aoeID = aoeInfo.aoeID,
            contentID = aoeInfo.contentID,
        })
        return false
    end
    local key = eventKey(aoeInfo)
    if state.seen[key] ~= nil then
        return false
    end
    local drawer = Common.getMoogleDrawer()
    if drawer == nil then
        diagnostic(state, 'danger_drawer_unavailable', now, aoeInfo.aoeID)
        return false
    end
    local activeShapes = {}
    for index, shape in ipairs(entry.shapes) do
        local drawGeometry, geometryError = geometry(shape, aoeInfo)
        local drawTiming = timing(shape, aoeInfo)
        if drawGeometry == nil or drawTiming == nil then
            rollbackShapes(activeShapes)
            diagnostic(state,
                    drawGeometry == nil and geometryError
                            or 'timing_window_unreachable',
                    now,
                    { aoeID = aoeInfo.aoeID, shapeIndex = index })
            return false
        end
        local token = drawShape(drawer, shape, drawGeometry, drawTiming)
        if type(token) ~= 'string' then
            rollbackShapes(activeShapes)
            diagnostic(state, 'drawer_rejected_shape', now, {
                aoeID = aoeInfo.aoeID,
                shapeIndex = index,
                kind = shape.kind,
            })
            return false
        end
        activeShapes[#activeShapes + 1] = {
            token = token,
            keepAfterCast = drawTiming.keepAfterCast,
            expiresAt = now + drawTiming.delay + drawTiming.timeout
                    + REFERENCE_TOKEN_GRACE_MS,
        }
    end
    state.seen[key] = now
    state.active[key] = {
        entityID = aoeInfo.entityID,
        aoeID = aoeInfo.aoeID,
        owner = owner,
        shapes = activeShapes,
    }
    state.lastDiagnostic = nil
    return true
end

local function handleChannelGuide(state, guide, entityID, spellID,
        channelTimeMax, now)
    state = ensureState(state)
    local spec = CHANNEL_GUIDES[spellID]
    if spec == nil then
        return false
    end
    if not ownerEnabled(guide, spec.owner) then
        return false
    end
    if not finite(now)
            or not finite(entityID)
            or not finite(channelTimeMax)
            or channelTimeMax <= 0
            or channelTimeMax > 30
    then
        diagnostic(state, 'channel_identity_missing', nowMs(), spellID)
        return false
    end
    local key = 'channel:' .. tostring(entityID)
            .. ':' .. tostring(spellID)
    if state.active[key] ~= nil then
        return false
    end
    local entity = resolveEntity(entityID)
    local entityPos = type(entity) == 'table'
            and reliablePosition(entity.pos, false) or nil
    local player = getPlayer(guide)
    local playerPos = type(player) == 'table'
            and reliablePosition(player.pos, false) or nil
    if entity == nil
            or entity.id ~= entityID
            or not contentMatches(spec, entity.contentid)
            or entityPos == nil
            or playerPos == nil
    then
        diagnostic(state, 'channel_geometry_missing', now, spellID)
        return false
    end
    local distanceSq = Common.distanceSquared(playerPos, entityPos)
    if finite(spec.maxDistance)
            and (not finite(distanceSq)
                    or distanceSq > spec.maxDistance * spec.maxDistance)
    then
        diagnostic(state, 'channel_out_of_reference_range', now, spellID)
        return false
    end
    local dx, dz = Common.normalized(
            playerPos.x - entityPos.x, playerPos.z - entityPos.z)
    if dx == nil then
        diagnostic(state, 'knockback_direction_missing', now, spellID)
        return false
    end
    local drawer = getGuideDrawer(guide)
    if drawer == nil or type(drawer.addTimedArrow) ~= 'function' then
        diagnostic(state, 'guide_drawer_unavailable', now, spellID)
        return false
    end
    local timeout = math.max(1, math.floor(channelTimeMax * 1000 + 0.5))
    local tipLength = 3
    local token = drawer:addTimedArrow(
            timeout,
            playerPos.x, playerPos.y, playerPos.z,
            math.atan2(dx, dz),
            math.max(0.1, spec.distance - tipLength),
            1, tipLength, 4)
    if type(token) ~= 'string' then
        diagnostic(state, 'guide_drawer_rejected_arrow', now, spellID)
        return false
    end
    state.active[key] = {
        entityID = entityID,
        aoeID = spellID,
        owner = spec.owner,
        shapes = {
            {
                token = token,
                keepAfterCast = false,
                expiresAt = now + timeout + REFERENCE_TOKEN_GRACE_MS,
            },
        },
    }
    state.lastDiagnostic = nil
    return true
end

local function handleEntityCast(state, entityID, spellID)
    state = ensureState(state)
    local removed = false
    for key, entry in pairs(state.active) do
        if entry.entityID == entityID and entry.aoeID == spellID then
            local retained = {}
            for _, activeShape in ipairs(entry.shapes or {}) do
                if activeShape.keepAfterCast == true then
                    retained[#retained + 1] = activeShape
                else
                    deleteActiveToken(activeShape.token)
                    removed = true
                end
            end
            entry.shapes = retained
            if #retained == 0 then
                state.active[key] = nil
            end
        end
    end
    return removed
end

local function pruneState(state, guide, now)
    state = ensureState(state)
    for key, entry in pairs(state.active) do
        local retained = {}
        for _, activeShape in ipairs(entry.shapes or {}) do
            if ownerEnabled(guide, entry.owner)
                    and finite(activeShape.expiresAt)
                    and now <= activeShape.expiresAt
            then
                retained[#retained + 1] = activeShape
            else
                deleteActiveToken(activeShape.token)
            end
        end
        entry.shapes = retained
        if #retained == 0 then
            state.active[key] = nil
        end
    end
    Common.pruneSeen(state.seen, now, REFERENCE_SEEN_TTL_MS)
end

local Feature = {}

Feature.Init = function(M)
    if type(M.NorthReferenceDrawings) == 'table' then
        clearDraws(M.NorthReferenceDrawings)
        releaseBlacklist(M.NorthReferenceDrawings)
    end
    M.NorthReferenceDrawings = newState()
    M.SetArgolEnabled = function(enabled)
        local current = getOwnerConfig(M, 'Argol')
        if current ~= nil then
            current.Enable = enabled == true
        end
        if enabled ~= true then
            clearOwnerDraws(M.NorthReferenceDrawings, 'Argol')
        end
        syncBlacklist(M.NorthReferenceDrawings, M)
    end
    syncBlacklist(M.NorthReferenceDrawings, M)
end

Feature.Clear = function(releaseOwnership)
    local state = getState()
    if state ~= nil then
        clearDraws(state)
        if releaseOwnership == true then
            releaseBlacklist(state)
        end
    end
end

Feature.OnEntityChannel = function(
        entityID, spellID, targetID, channelTimeMax, now)
    local guide = rawget(_G, 'MuAiGuide')
    local state = getState()
    if state ~= nil then
        return handleChannelGuide(
                state, guide, entityID, spellID, channelTimeMax, now)
    end
    return false
end

Feature.OnAOECreate = function(aoeInfo, now)
    local guide = rawget(_G, 'MuAiGuide')
    local state = getState()
    if state ~= nil then
        return handleAOECreate(state, guide, aoeInfo, now)
    end
    return false
end

Feature.OnEntityCast = function(entityID, spellID)
    local state = getState()
    if state ~= nil then
        return handleEntityCast(state, entityID, spellID)
    end
    return false
end

Feature.Update = function(guide, now)
    local state = getState()
    if state == nil then
        return false
    end
    syncBlacklist(state, guide)
    pruneState(state, guide, now)
    return false
end

Feature.Test = {
    Source = REFERENCE_SOURCE,
    ReferenceCommit = REFERENCE_COMMIT,
    OwnerDefaults = OWNER_DEFAULTS,
    ActionOwner = ACTION_OWNER,
    OwnerAIDs = OWNER_AIDS,
    Shapes = REFERENCE_SHAPES,
    ChannelGuides = CHANNEL_GUIDES,
    NewState = newState,
    EnsureState = ensureState,
    GetOwnerConfig = getOwnerConfig,
    OwnerEnabled = ownerEnabled,
    SyncBlacklist = syncBlacklist,
    ReleaseBlacklist = releaseBlacklist,
    Geometry = geometry,
    Timing = timing,
    HandleAOECreate = handleAOECreate,
    HandleChannelGuide = handleChannelGuide,
    HandleEntityCast = handleEntityCast,
    PruneState = pruneState,
    ClearDraws = clearDraws,
    ClearOwnerDraws = clearOwnerDraws,
}

return Feature
end

rawset(_G, 'MuAiOccultCrescentNorthNorthReferenceDrawings', Module)
return Module
