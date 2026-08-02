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

local OCCULT_REFERENCE_SOURCE = 'MuAiCore - 南岛参考范围'
local OCCULT_REFERENCE_SEEN_TTL_MS = 30000
local OCCULT_REFERENCE_TOKEN_GRACE_MS = 1000

-- 参考布局只负责指出缺失的机制。实际判定尺寸优先采用同版本BossMod与地图1252日志；
-- 这样不会把为了场地裁切而缩短的Splatoon图形误当成真实技能范围。
local occultReferenceShapes = {
    [30872] = { kind = 'circle', radius = 24 },
    [30873] = { kind = 'circle', radius = 16 },
    [37041] = { kind = 'circle', radius = 8 },
    [37323] = { kind = 'circle', radius = 8 },
    [37804] = { kind = 'circle', radius = 13 },

    [41130] = { kind = 'circle', radius = 26 },
    [41131] = { kind = 'cross', length = 100, width = 10 },
    [41133] = { kind = 'cone', radius = 60, angle = math.rad(90) },
    [41135] = { kind = 'circle', radius = 6 },
    [41137] = { kind = 'cone', radius = 40, angle = math.rad(60) },
    [41147] = { kind = 'circle', radius = 16 },
    [41148] = { kind = 'donut', inner = 8, outer = 30 },
    [41151] = { kind = 'circle', radius = 5 },
    [41155] = { kind = 'cone', radius = 40, angle = math.rad(45) },
    [41156] = { kind = 'cone', radius = 40, angle = math.rad(45) },
    [41163] = { kind = 'rect', origin = 'backsolve', dynamic = true },
    [41164] = { kind = 'circle', radius = 8 },
    [41170] = { kind = 'cone', radius = 65, angle = math.rad(90) },
    [41184] = { kind = 'cone', radius = 70, angle = math.rad(45) },
    [41187] = { kind = 'circle', radius = 50 },

    [41256] = { kind = 'rect', length = 60, width = 10 },
    [41257] = { kind = 'rect', length = 60, width = 20 },
    [41297] = { kind = 'rect', length = 60, width = 5 },
    [41314] = { kind = 'rect', length = 60, width = 10 },
    [41315] = { kind = 'rect', length = 60, width = 7 },
    [41316] = { kind = 'rect', length = 60, width = 7 },
    [41317] = { kind = 'rect', length = 60, width = 7 },
    [41356] = { kind = 'circle', radius = 10 },
    [41357] = { kind = 'circle', radius = 22 },
    [41358] = { kind = 'rect', length = 60, width = 8 },
    [41359] = { kind = 'cone', radius = 40, angle = math.rad(60) },
    [41360] = { kind = 'cone', radius = 40, angle = math.pi },
    [41395] = { kind = 'circle', radius = 20 },
    [41406] = { kind = 'circle', radius = 12 },
    [41410] = { kind = 'circle', radius = 10 },
    [41411] = { kind = 'cone', radius = 60, angle = math.rad(90) },

    [41758] = { kind = 'circle', radius = 7 },
    [41759] = { kind = 'donut', inner = 7, outer = 13 },
    [41760] = { kind = 'donut', inner = 13, outer = 19 },
    [41761] = { kind = 'donut', inner = 19, outer = 25 },
    [41817] = { kind = 'rect', length = 60, width = 8 },
    [41818] = { kind = 'rect', length = 60, width = 8 },
    [41819] = { kind = 'circle', radius = 15 },
    [41825] = { kind = 'rect', length = 60, width = 8 },
    [41970] = { kind = 'cone', radius = 50, angle = math.rad(60) },
    [42000] = { kind = 'cone', radius = 40, angle = math.rad(45) },
    [42001] = { kind = 'cone', radius = 40, angle = math.rad(45) },
    [42012] = { kind = 'donut', inner = 10, outer = 20 },
    [42033] = { kind = 'donut', inner = 7, outer = 50 },
    [42034] = { kind = 'cross', length = 50, width = 15 },
    [42035] = { kind = 'cross', length = 50, width = 15 },
    [42691] = { kind = 'rect', length = 60, width = 60 },
    [42729] = { kind = 'donut', inner = 7, outer = 13 },
    [42730] = { kind = 'donut', inner = 13, outer = 19 },
    [42731] = { kind = 'donut', inner = 19, outer = 25 },
    [42732] = { kind = 'circle', radius = 7 },
    [42733] = { kind = 'donut', inner = 7, outer = 13 },
    [42734] = { kind = 'donut', inner = 13, outer = 19 },
    [42735] = { kind = 'donut', inner = 19, outer = 25 },
    [42766] = { kind = 'circle', radius = 22 },
    [42767] = { kind = 'donut', inner = 5, outer = 31 },
    [42768] = { kind = 'circle', radius = 22 },
    [42769] = { kind = 'donut', inner = 5, outer = 31 },
    [43046] = { kind = 'cone', radius = 30, angle = math.rad(120) },
    [43149] = { kind = 'cone', radius = 50, angle = math.rad(60) },
    [43262] = { kind = 'cone', radius = 60, angle = math.rad(120) },
    [43269] = { kind = 'circle', radius = 20 },
    [43372] = { kind = 'cone', radius = 40, angle = math.rad(60) },
}

local referenceFinite = Common.finite

local function newOccultReferenceState()
    return {
        seen = {},
        active = {},
        blacklist = {
            owned = {},
            previous = {},
            previousKnown = {},
            registered = false,
        },
        lastDiagnostic = nil,
    }
end

local function ensureOccultReferenceState(state)
    state.seen = type(state.seen) == 'table' and state.seen or {}
    state.active = type(state.active) == 'table' and state.active or {}
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

local occultReferenceFeature = Common.newFeature({
    key = 'OccultReferenceDrawings',
    defaults = { Enable = true },
    newState = newOccultReferenceState,
    ensureState = ensureOccultReferenceState,
})
local getOccultReferenceConfig = occultReferenceFeature.GetConfig
local getOccultReferenceRuntimeState = occultReferenceFeature.GetRuntimeState

local deleteOccultReferenceToken = Common.deleteTimedShape

local function clearOccultReferenceDraws(state)
    ensureOccultReferenceState(state)
    for _, entry in pairs(state.active) do
        deleteOccultReferenceToken(entry.token)
    end
    state.seen = {}
    state.active = {}
    state.lastDiagnostic = nil
end

local function getOccultReferenceBlacklist(create)
    return Common.getMoogleTable('aoeIDUserBlacklist', create)
end

local function ownsOccultReferenceBlacklist(state, aoeID, current)
    return current ~= nil
            and (current == state.blacklist.owned[aoeID]
                    or (type(current) == 'table'
                            and current.source == OCCULT_REFERENCE_SOURCE))
end

local function registerOccultReferenceBlacklist(state)
    ensureOccultReferenceState(state)
    local blacklist = getOccultReferenceBlacklist(true)
    if blacklist == nil then
        state.blacklist.registered = false
        return false
    end
    for aoeID in pairs(occultReferenceShapes) do
        local current = blacklist[aoeID]
        if current == nil then
            local owned = {
                label = '南岛参考范围',
                source = OCCULT_REFERENCE_SOURCE,
            }
            blacklist[aoeID] = owned
            state.blacklist.owned[aoeID] = owned
        elseif type(current) == 'table'
                and current.source == OCCULT_REFERENCE_SOURCE
        then
            state.blacklist.owned[aoeID] = current
        end
    end
    state.blacklist.registered = true
    return true
end

local function unregisterOccultReferenceBlacklist(state)
    ensureOccultReferenceState(state)
    local blacklist = getOccultReferenceBlacklist(false)
    if blacklist == nil then
        state.blacklist.registered = false
        return false
    end
    for aoeID in pairs(occultReferenceShapes) do
        local current = blacklist[aoeID]
        if ownsOccultReferenceBlacklist(state, aoeID, current) then
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

local function applyOccultReferenceBlacklist(state, enabled)
    if enabled == true then
        return registerOccultReferenceBlacklist(state)
    end
    return unregisterOccultReferenceBlacklist(state)
end

local function occultReferenceEventKey(aoeInfo)
    return tostring(aoeInfo.entityID)
            .. ':' .. tostring(aoeInfo.aoeID)
            .. ':' .. tostring(math.floor(aoeInfo.startTime))
end

local function occultReferenceGeometry(shape, aoeInfo)
    if not referenceFinite(aoeInfo.x)
            or not referenceFinite(aoeInfo.y)
            or aoeInfo.y == 0
            or not referenceFinite(aoeInfo.z)
    then
        return nil
    end
    local geometry = {
        x = aoeInfo.x,
        y = aoeInfo.y,
        z = aoeInfo.z,
        heading = aoeInfo.heading,
        radius = shape.radius,
        inner = shape.inner,
        outer = shape.outer,
        angle = shape.angle,
        length = shape.length,
        width = shape.width,
    }
    if shape.kind == 'cone'
            or shape.kind == 'rect'
            or shape.kind == 'cross'
    then
        if not referenceFinite(geometry.heading) then
            return nil
        end
    end
    if shape.dynamic == true then
        if not referenceFinite(aoeInfo.aoeLength)
                or aoeInfo.aoeLength <= 0
                or aoeInfo.aoeLength > 100
                or not referenceFinite(aoeInfo.aoeWidth)
                or aoeInfo.aoeWidth <= 0
                or aoeInfo.aoeWidth > 50
        then
            return nil
        end
        geometry.length = aoeInfo.aoeLength
        geometry.width = aoeInfo.aoeWidth
    end
    if shape.origin == 'backsolve' then
        geometry.x = geometry.x
                - math.sin(geometry.heading) * geometry.length
        geometry.z = geometry.z
                - math.cos(geometry.heading) * geometry.length
    end
    return geometry
end

local function getOccultReferenceDrawer()
    if type(TensorCore) ~= 'table'
            or type(TensorCore.getMoogleDrawer) ~= 'function'
    then
        return nil
    end
    local drawer = TensorCore.getMoogleDrawer()
    return type(drawer) == 'table' and drawer or nil
end

local function drawOccultReferenceShape(drawer, shape, geometry, timeout)
    if shape.kind == 'circle' and type(drawer.addTimedCircle) == 'function' then
        return drawer:addTimedCircle(
                timeout,
                geometry.x,
                geometry.y,
                geometry.z,
                geometry.radius)
    elseif shape.kind == 'donut'
            and type(drawer.addTimedDonut) == 'function'
    then
        return drawer:addTimedDonut(
                timeout,
                geometry.x,
                geometry.y,
                geometry.z,
                geometry.inner,
                geometry.outer)
    elseif shape.kind == 'cone'
            and type(drawer.addTimedCone) == 'function'
    then
        return drawer:addTimedCone(
                timeout,
                geometry.x,
                geometry.y,
                geometry.z,
                geometry.radius,
                geometry.angle,
                geometry.heading)
    elseif shape.kind == 'rect'
            and type(drawer.addTimedRect) == 'function'
    then
        return drawer:addTimedRect(
                timeout,
                geometry.x,
                geometry.y,
                geometry.z,
                geometry.length,
                geometry.width,
                geometry.heading)
    elseif shape.kind == 'cross'
            and type(drawer.addTimedCross) == 'function'
    then
        return drawer:addTimedCross(
                timeout,
                geometry.x,
                geometry.y,
                geometry.z,
                geometry.length,
                geometry.width,
                geometry.heading)
    end
    return nil
end

local function handleOccultReferenceAOECreate(state, aoeInfo, now)
    ensureOccultReferenceState(state)
    local shape = type(aoeInfo) == 'table'
            and occultReferenceShapes[aoeInfo.aoeID] or nil
    if shape == nil then
        return false
    end
    if not referenceFinite(aoeInfo.entityID)
            or not referenceFinite(aoeInfo.startTime)
            or not referenceFinite(aoeInfo.duration)
            or aoeInfo.duration <= 0
            or aoeInfo.duration > 30
    then
        state.lastDiagnostic = 'missing_event_geometry'
        return false
    end
    local key = occultReferenceEventKey(aoeInfo)
    if state.seen[key] ~= nil then
        return false
    end
    local geometry = occultReferenceGeometry(shape, aoeInfo)
    local drawer = getOccultReferenceDrawer()
    if geometry == nil or drawer == nil then
        state.lastDiagnostic = 'missing_draw_geometry'
        return false
    end
    local timeout = math.max(1, math.floor(aoeInfo.duration * 1000 + 0.5))
    local token = drawOccultReferenceShape(drawer, shape, geometry, timeout)
    if type(token) ~= 'string' then
        state.lastDiagnostic = 'drawer_rejected_shape'
        return false
    end
    local expiresAt = now + timeout + OCCULT_REFERENCE_TOKEN_GRACE_MS
    state.seen[key] = now
    state.active[key] = {
        entityID = aoeInfo.entityID,
        aoeID = aoeInfo.aoeID,
        token = token,
        expiresAt = expiresAt,
    }
    state.lastDiagnostic = nil
    return true
end

local function handleOccultReferenceEntityCast(state, entityID, spellID)
    ensureOccultReferenceState(state)
    local removed = false
    for key, entry in pairs(state.active) do
        if entry.entityID == entityID and entry.aoeID == spellID then
            deleteOccultReferenceToken(entry.token)
            state.active[key] = nil
            removed = true
        end
    end
    return removed
end

local function pruneOccultReferenceState(state, now)
    ensureOccultReferenceState(state)
    for key, entry in pairs(state.active) do
        if not referenceFinite(entry.expiresAt) or now > entry.expiresAt then
            state.active[key] = nil
        end
    end
    for key, seenAt in pairs(state.seen) do
        if not referenceFinite(seenAt)
                or now - seenAt > OCCULT_REFERENCE_SEEN_TTL_MS
        then
            state.seen[key] = nil
        end
    end
end

return {
    Source = OCCULT_REFERENCE_SOURCE,
    Shapes = occultReferenceShapes,
    NewState = newOccultReferenceState,
    EnsureState = ensureOccultReferenceState,
    GetConfig = getOccultReferenceConfig,
    GetRuntimeState = getOccultReferenceRuntimeState,
    ApplyBlacklist = applyOccultReferenceBlacklist,
    HandleAOECreate = handleOccultReferenceAOECreate,
    HandleEntityCast = handleOccultReferenceEntityCast,
    PruneState = pruneOccultReferenceState,
    ClearDraws = clearOccultReferenceDraws,
    Geometry = occultReferenceGeometry,
}
end

rawset(_G, 'MuAiOccultCrescentSouthOccultReferenceDrawings', Module)
return Module
