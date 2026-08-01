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

local NYMIAN_ARENA_CENTER = { x = -117, z = -850 }
local NYMIAN_ARENA_RADIUS = 20
local NYMIAN_OUTER_THRESHOLD = 15
local NYMIAN_OPEN_WATER_RADIUS = 4
local NYMIAN_MARKER_RADIUS = 20
local NYMIAN_EVENT_DEDUPE_MS = 250
local NYMIAN_SEEN_TTL_MS = 60000
local NYMIAN_BOSS_MISSING_CLEAR_MS = 2000
local NYMIAN_MARKER_EXPIRE_AFTER_ACTIVATION_MS = 8000
local NYMIAN_VISUAL_TRACK_MS = 15000

local nymianAID = {
    MarkerAppear = 41682,
    OpenWaterCast = 41686,
    OpenWaterFirst = 41687,
    OpenWaterRepeat2 = 41688,
    TidalGuillotineFast = 41722,
    OpenWaterRepeat1 = 43151,
}

local nymianLineConfig = {
    inner = {
        divisions = 16,
        speedMs = 1100,
        numLeft = 35,
        maxShown = 4,
    },
    outer = {
        divisions = 28,
        speedMs = 700,
        numLeft = 59,
        maxShown = 7,
    },
}

local nymianDangerDrawer
local nymianWarningDrawer
local nymianMarkerDrawer

local function newNymianState()
    return {
        openWater = {
            inner = nil,
            outer = nil,
            seenFirst = {},
            seenRepeats = {},
        },
        markers = {
            queue = {},
            sequence = 0,
            seenAppear = {},
            seenResolve = {},
        },
        seenChannels = {},
        trackedBossEntityIDs = {},
        visualExpiresAt = nil,
        bossLastSeenAt = nil,
        lastActivityAt = nil,
        lastDiagnostic = nil,
    }
end

local function ensureNymianState(state)
    state.openWater = type(state.openWater) == 'table' and state.openWater or {}
    state.openWater.seenFirst = type(state.openWater.seenFirst) == 'table'
            and state.openWater.seenFirst or {}
    state.openWater.seenRepeats = type(state.openWater.seenRepeats) == 'table'
            and state.openWater.seenRepeats or {}
    state.markers = type(state.markers) == 'table' and state.markers or {}
    state.markers.queue = type(state.markers.queue) == 'table'
            and state.markers.queue or {}
    state.markers.sequence = type(state.markers.sequence) == 'number'
            and state.markers.sequence or 0
    state.markers.seenAppear = type(state.markers.seenAppear) == 'table'
            and state.markers.seenAppear or {}
    state.markers.seenResolve = type(state.markers.seenResolve) == 'table'
            and state.markers.seenResolve or {}
    state.seenChannels = type(state.seenChannels) == 'table'
            and state.seenChannels or {}
    state.trackedBossEntityIDs = type(state.trackedBossEntityIDs) == 'table'
            and state.trackedBossEntityIDs or {}
    return state
end

local function clearNymianState(state)
    ensureNymianState(state)
    state.openWater.inner = nil
    state.openWater.outer = nil
    state.openWater.seenFirst = {}
    state.openWater.seenRepeats = {}
    state.markers.queue = {}
    state.markers.sequence = 0
    state.markers.seenAppear = {}
    state.markers.seenResolve = {}
    state.seenChannels = {}
    state.trackedBossEntityIDs = {}
    state.visualExpiresAt = nil
    state.bossLastSeenAt = nil
    state.lastActivityAt = nil
    state.lastDiagnostic = nil
end

local nymianDiagnosticText = {
    first_missing_geometry = 'Open Water预测跳过：首个水圈缺少可靠的位置、地面高度或朝向。',
    first_missing_timing = 'Open Water预测跳过：首个水圈缺少可靠的读条时间。',
    repeat_missing_position = 'Open Water未推进：实际水圈事件缺少可靠的来源位置。',
    repeat_missing_line = 'Open Water未推进：实际水圈没有可匹配的内圈或外圈预测线。',
    marker_missing_target = 'Tidal Guillotine预警跳过：事件没有可证明的地面目标位置。',
    marker_missing_height = 'Tidal Guillotine预警跳过：事件和玩家都没有可靠地面高度。',
    marker_missing_queue = 'Tidal Guillotine未推进：实际结算时没有待结算标记。',
}

local nymianFeature = Common.newFeature({
    key = 'NymianPetalodus',
    newState = newNymianState,
    ensureState = ensureNymianState,
    diagnosticText = nymianDiagnosticText,
    dedupeMs = NYMIAN_EVENT_DEDUPE_MS,
    seenTtlMs = NYMIAN_SEEN_TTL_MS,
})
local getNymianConfig = nymianFeature.GetConfig
local getNymianRuntimeState = nymianFeature.GetRuntimeState
local setNymianDiagnostic = nymianFeature.Diagnostic
local consumeNymianEvent = nymianFeature.Consume

-- BossMod Angle.FromDirection/ToDirection uses x=sin(angle), z=cos(angle).
local function nymianAngleFromDirection(dx, dz)
    if type(dx) ~= 'number' or type(dz) ~= 'number'
            or dx ~= dx or dz ~= dz
            or math.abs(dx) + math.abs(dz) < 0.0001
    then
        return nil
    end
    if dz > 0 then
        return math.atan(dx / dz)
    end
    if dz < 0 then
        local angle = math.atan(dx / dz)
        return dx >= 0 and angle + math.pi or angle - math.pi
    end
    return dx > 0 and math.pi / 2 or -math.pi / 2
end

local function nymianRotationSign(source, heading)
    if not validXZ(source) or type(heading) ~= 'number' then
        return nil
    end
    local dx = source.x - NYMIAN_ARENA_CENTER.x
    local dz = source.z - NYMIAN_ARENA_CENTER.z
    if dx * dx + dz * dz < 0.0001 then
        return nil
    end
    -- WDir.OrthoR() == (-Z, X); heading 0 follows +Z.
    local orthoRX = -dz
    local orthoRZ = dx
    local forwardX = math.sin(heading)
    local forwardZ = math.cos(heading)
    return orthoRX * forwardX + orthoRZ * forwardZ > 0 and -1 or 1
end

local function nymianLineKind(source)
    if not validXZ(source) then
        return nil
    end
    local distance = math.sqrt(distanceSquared(source, NYMIAN_ARENA_CENTER))
    return distance > NYMIAN_OUTER_THRESHOLD and 'outer' or 'inner', distance
end

local function nymianFirstKey(entityID, startTime)
    return 'first:' .. tostring(entityID) .. ':' .. tostring(math.floor(startTime))
end

local function nymianReliableHeight(y)
    return type(y) == 'number'
            and y == y
            and y ~= 0
            and y > -math.huge
            and y < math.huge
end

local function createNymianOpenWaterLine(
        state,
        entityID,
        source,
        heading,
        nextExplosion,
        key,
        now,
        guide)
    if type(entityID) ~= 'number'
            or not validXYZ(source)
            or not nymianReliableHeight(source.y)
            or type(heading) ~= 'number'
    then
        setNymianDiagnostic(state, guide, 'first_missing_geometry', now)
        return false
    end
    if type(nextExplosion) ~= 'number' then
        setNymianDiagnostic(state, guide, 'first_missing_timing', now)
        return false
    end
    if state.openWater.seenFirst[key] ~= nil then
        return false
    end

    local kind, distance = nymianLineKind(source)
    local nextAngle = nymianAngleFromDirection(
            source.x - NYMIAN_ARENA_CENTER.x,
            source.z - NYMIAN_ARENA_CENTER.z)
    local rotationSign = nymianRotationSign(source, heading)
    if kind == nil or nextAngle == nil or rotationSign == nil then
        setNymianDiagnostic(state, guide, 'first_missing_geometry', now)
        return false
    end
    local lineCfg = nymianLineConfig[kind]
    local line = {
        key = key,
        entityID = entityID,
        kind = kind,
        outside = kind == 'outer',
        distance = distance,
        y = source.y,
        next = nextAngle,
        nextExplosion = nextExplosion,
        increment = rotationSign * 2 * math.pi / lineCfg.divisions,
        speedMs = lineCfg.speedMs,
        numLeft = lineCfg.numLeft,
        maxShown = lineCfg.maxShown,
        repeatCount = 0,
        expiresAt = nextExplosion
                + lineCfg.speedMs * lineCfg.numLeft
                + NYMIAN_MARKER_EXPIRE_AFTER_ACTIVATION_MS,
    }
    state.openWater.seenFirst[key] = now
    state.openWater[kind] = line
    state.lastActivityAt = now
    return true
end

local function addNymianOpenWaterFirst(state, aoeInfo, now, guide)
    if type(aoeInfo) ~= 'table' or aoeInfo.aoeID ~= nymianAID.OpenWaterFirst then
        return false
    end
    if type(aoeInfo.startTime) ~= 'number'
            or type(aoeInfo.duration) ~= 'number'
            or aoeInfo.duration < 0
            or aoeInfo.duration > 15
    then
        setNymianDiagnostic(state, guide, 'first_missing_timing', now)
        return false
    end
    local source = copyReliablePosition(aoeInfo)
    return createNymianOpenWaterLine(
            state,
            aoeInfo.entityID,
            source,
            aoeInfo.heading,
            aoeInfo.startTime + aoeInfo.duration * 1000,
            nymianFirstKey(aoeInfo.entityID, aoeInfo.startTime),
            now,
            guide)
end

local function addNymianOpenWaterFirstFromCast(
        state,
        entityID,
        castPos,
        now,
        guide)
    local source = copyReliablePosition(castPos)
    local heading = eventHeading(castPos)
    if source == nil or heading == nil then
        setNymianDiagnostic(state, guide, 'first_missing_geometry', now)
        return false
    end
    local kind = nymianLineKind(source)
    local current = kind ~= nil and state.openWater[kind] or nil
    if current ~= nil
            and current.entityID == entityID
            and math.abs(current.nextExplosion - now) <= 1000
    then
        return false
    end
    return createNymianOpenWaterLine(
            state,
            entityID,
            source,
            heading,
            now,
            nymianFirstKey(entityID, now),
            now,
            guide)
end

local function getNymianOpenWaterPredictions(line)
    local predictions = {}
    if type(line) ~= 'table'
            or type(line.numLeft) ~= 'number'
            or line.numLeft <= 0
    then
        return predictions
    end

    -- OpenWaterFirst 的当前读条圆交给 Moogle；首个 Repeat1 后，Next 已是下一颗。
    local firstOffset = line.repeatCount > 0 and 0 or 1
    local count = math.min(line.maxShown, math.max(0, line.numLeft - firstOffset))
    for index = 0, count - 1 do
        local offset = firstOffset + index
        local angle = line.next + line.increment * offset
        predictions[#predictions + 1] = {
            x = NYMIAN_ARENA_CENTER.x + math.sin(angle) * line.distance,
            y = line.y,
            z = NYMIAN_ARENA_CENTER.z + math.cos(angle) * line.distance,
            activationAt = line.nextExplosion + line.speedMs * offset,
            nearest = index == 0,
        }
    end
    return predictions
end

local function nymianEventPositionKey(prefix, entityID, pos)
    return prefix
            .. ':' .. tostring(entityID)
            .. ':' .. tostring(math.floor(pos.x * 100 + 0.5))
            .. ':' .. tostring(math.floor(pos.z * 100 + 0.5))
end

local function advanceNymianOpenWater(state, entityID, castPos, now, guide)
    local source = validXZ(castPos) and castPos or reliableEntityPosition(entityID)
    if not validXZ(source) then
        setNymianDiagnostic(state, guide, 'repeat_missing_position', now)
        return false
    end
    local key = nymianEventPositionKey('repeat', entityID, source)
    if not consumeNymianEvent(state.openWater.seenRepeats, key, now) then
        return false
    end
    local kind = nymianLineKind(source)
    local line = kind ~= nil and state.openWater[kind] or nil
    if line == nil then
        setNymianDiagnostic(state, guide, 'repeat_missing_line', now, {
            kind = kind,
            entityID = entityID,
        })
        return false
    end

    line.numLeft = line.numLeft - 1
    line.next = line.next + line.increment
    line.nextExplosion = now + line.speedMs
    line.repeatCount = line.repeatCount + 1
    line.expiresAt = line.nextExplosion
            + line.speedMs * math.max(0, line.numLeft)
            + NYMIAN_MARKER_EXPIRE_AFTER_ACTIVATION_MS
    state.lastActivityAt = now
    if line.numLeft <= 0 then
        state.openWater[kind] = nil
    end
    return true
end

local function getNymianPlayerPosition(guide)
    local player = type(guide) == 'table'
            and type(guide.GetPlayer) == 'function'
            and guide.GetPlayer() or nil
    return player ~= nil and copyReliablePosition(player.pos) or nil
end

local function nymianMarkerTarget(castPos, playerPos)
    if type(castPos) ~= 'table' then
        return nil, 'marker_missing_target'
    end

    local target
    for _, field in ipairs({ 'targetXZ', 'targetPos', 'targetPosition' }) do
        if validXZ(castPos[field]) then
            target = {
                x = castPos[field].x,
                y = castPos[field].y,
                z = castPos[field].z,
            }
            break
        end
    end
    if target == nil
            and type(castPos.targetX) == 'number'
            and type(castPos.targetZ) == 'number'
    then
        target = {
            x = castPos.targetX,
            y = castPos.targetY,
            z = castPos.targetZ,
        }
    end
    if target == nil and castPos.isAreaTarget == true and validXZ(castPos) then
        target = {
            x = castPos.x,
            y = castPos.y,
            z = castPos.z,
        }
    end
    if target == nil then
        return nil, 'marker_missing_target'
    end

    local y = nymianReliableHeight(target.y) and target.y or nil
    if y == nil and validXYZ(playerPos) and nymianReliableHeight(playerPos.y) then
        y = playerPos.y
    end
    if y == nil then
        return nil, 'marker_missing_height'
    end
    return {
        x = target.x,
        y = y,
        z = target.z,
    }
end

local pruneNymianSeen = nymianFeature.PruneSeen

local function pruneNymianState(state, now)
    ensureNymianState(state)
    for _, kind in ipairs({ 'inner', 'outer' }) do
        local line = state.openWater[kind]
        if line ~= nil and now > line.expiresAt then
            state.openWater[kind] = nil
        end
    end
    for index = #state.markers.queue, 1, -1 do
        if now > state.markers.queue[index].expiresAt then
            table.remove(state.markers.queue, index)
        end
    end
    if state.visualExpiresAt ~= nil and now > state.visualExpiresAt then
        state.visualExpiresAt = nil
    end
    pruneNymianSeen(state.openWater.seenFirst, now)
    pruneNymianSeen(state.openWater.seenRepeats, now)
    pruneNymianSeen(state.markers.seenAppear, now)
    pruneNymianSeen(state.markers.seenResolve, now)
    pruneNymianSeen(state.seenChannels, now)
    if state.openWater.inner == nil
            and state.openWater.outer == nil
            and #state.markers.queue == 0
            and state.visualExpiresAt == nil
    then
        state.trackedBossEntityIDs = {}
        state.bossLastSeenAt = nil
    end
end

local function addNymianMarker(state, entityID, castPos, now, guide)
    pruneNymianState(state, now)
    local playerPos = getNymianPlayerPosition(guide)
    local target, reason = nymianMarkerTarget(castPos, playerPos)
    if target == nil then
        setNymianDiagnostic(state, guide, reason, now)
        return false
    end
    local key = nymianEventPositionKey('marker', entityID, target)
    if not consumeNymianEvent(state.markers.seenAppear, key, now) then
        return false
    end
    local delayMs = #state.markers.queue == 0 and 8700 or 9900
    state.markers.sequence = state.markers.sequence + 1
    state.markers.queue[#state.markers.queue + 1] = {
        entityID = entityID,
        position = target,
        activationAt = now + delayMs,
        expiresAt = now + delayMs + NYMIAN_MARKER_EXPIRE_AFTER_ACTIVATION_MS,
        sequence = state.markers.sequence,
    }
    state.lastActivityAt = now
    return true
end

local function resolveNymianMarker(state, entityID, now, guide)
    local key = 'marker-resolve:' .. tostring(entityID)
    if not consumeNymianEvent(state.markers.seenResolve, key, now) then
        return false
    end
    if #state.markers.queue == 0 then
        setNymianDiagnostic(state, guide, 'marker_missing_queue', now, {
            entityID = entityID,
        })
        return false
    end
    table.remove(state.markers.queue, 1)
    state.lastActivityAt = now
    return true
end

local function recordNymianBoss(state, entityID, now)
    if type(entityID) == 'number' then
        state.trackedBossEntityIDs[entityID] = true
    end
    state.visualExpiresAt = now + NYMIAN_VISUAL_TRACK_MS
    state.lastActivityAt = now
    state.bossLastSeenAt = now
end

local function handleNymianEntityChannel(state, entityID, spellID, now)
    if spellID ~= nymianAID.OpenWaterCast then
        return false
    end
    local key = 'visual-channel:' .. tostring(entityID)
    if not consumeNymianEvent(state.seenChannels, key, now) then
        return false
    end
    recordNymianBoss(state, entityID, now)
    return true
end

local function handleNymianAOECreate(state, aoeInfo, now, guide)
    return addNymianOpenWaterFirst(state, aoeInfo, now, guide)
end

local function handleNymianEntityCast(
        state,
        entityID,
        spellID,
        castPos,
        now,
        guide)
    if spellID == nymianAID.OpenWaterCast then
        local key = 'visual-cast:' .. tostring(entityID)
        if not consumeNymianEvent(state.seenChannels, key, now) then
            return false
        end
        recordNymianBoss(state, entityID, now)
        return true
    end
    if spellID == nymianAID.OpenWaterFirst then
        return addNymianOpenWaterFirstFromCast(
                state, entityID, castPos, now, guide)
    end
    if spellID == nymianAID.OpenWaterRepeat1 then
        return advanceNymianOpenWater(state, entityID, castPos, now, guide)
    end
    if spellID == nymianAID.MarkerAppear then
        return addNymianMarker(state, entityID, castPos, now, guide)
    end
    if spellID == nymianAID.TidalGuillotineFast then
        return resolveNymianMarker(state, entityID, now, guide)
    end
    return false
end

local function hasNymianActivity(state)
    return state.openWater.inner ~= nil
            or state.openWater.outer ~= nil
            or #state.markers.queue > 0
            or state.visualExpiresAt ~= nil
end

local function hasLiveNymian(state)
    if type(TensorCore) ~= 'table' or type(TensorCore.mGetEntity) ~= 'function' then
        return nil
    end
    local checked = false
    for entityID in pairs(state.trackedBossEntityIDs) do
        checked = true
        local entity = TensorCore.mGetEntity(entityID)
        if entity ~= nil and entity.alive ~= false then
            return true
        end
    end
    if checked then
        return false
    end
    -- BossMod NameID/OID 未经本机事件证明为 Minion contentid，不据此扫描实体。
    return nil
end

local function getNymianDangerDrawer(guide)
    if nymianDangerDrawer == nil and type(guide.CreateDrawer) == 'function' then
        nymianDangerDrawer = guide.CreateDrawer(1, 0.15, 0, 0.24, 2, 0)
    end
    return nymianDangerDrawer
end

local function getNymianWarningDrawer(guide)
    if nymianWarningDrawer == nil and type(guide.CreateDrawer) == 'function' then
        nymianWarningDrawer = guide.CreateDrawer(1, 0.65, 0, 0.16, 2, 0)
    end
    return nymianWarningDrawer
end

local function getNymianMarkerDrawer(guide)
    if nymianMarkerDrawer == nil and type(guide.CreateDrawer) == 'function' then
        nymianMarkerDrawer = guide.CreateDrawer(1, 0.25, 0, 0.16, 2, 0)
    end
    return nymianMarkerDrawer
end

local function drawNymianPetalodus(guide, cfg, state)
    if cfg.DrawOpenWaterPrediction then
        local dangerDrawer = getNymianDangerDrawer(guide)
        local warningDrawer = getNymianWarningDrawer(guide)
        if dangerDrawer ~= nil and warningDrawer ~= nil then
            for _, kind in ipairs({ 'inner', 'outer' }) do
                local line = state.openWater[kind]
                for _, prediction in ipairs(getNymianOpenWaterPredictions(line)) do
                    local drawer = prediction.nearest and dangerDrawer or warningDrawer
                    drawer:addCircle(
                            prediction.x,
                            prediction.y,
                            prediction.z,
                            NYMIAN_OPEN_WATER_RADIUS)
                end
            end
        end
    end

    if cfg.DrawTidalGuillotineMarkers then
        local drawer = getNymianMarkerDrawer(guide)
        if drawer ~= nil then
            for _, marker in ipairs(state.markers.queue) do
                drawer:addCircle(
                        marker.position.x,
                        marker.position.y,
                        marker.position.z,
                        NYMIAN_MARKER_RADIUS)
            end
        end
    end
end

local function updateNymianPetalodus(guide, cfg, state)
    if not cfg.Enable then
        if hasNymianActivity(state)
                or next(state.openWater.seenFirst) ~= nil
                or next(state.openWater.seenRepeats) ~= nil
                or next(state.markers.seenAppear) ~= nil
                or next(state.markers.seenResolve) ~= nil
                or next(state.seenChannels) ~= nil
                or next(state.trackedBossEntityIDs) ~= nil
        then
            clearNymianState(state)
        end
        return
    end

    local now = getNow()
    pruneNymianState(state, now)
    if not hasNymianActivity(state) then
        return
    end
    local bossPresent = hasLiveNymian(state)
    if bossPresent == true then
        state.bossLastSeenAt = now
    elseif bossPresent == false
            and state.bossLastSeenAt ~= nil
            and now - state.bossLastSeenAt > NYMIAN_BOSS_MISSING_CLEAR_MS
    then
        clearNymianState(state)
        return
    end
    drawNymianPetalodus(guide, cfg, state)
end

return {
    AID = nymianAID,
    ArenaCenter = NYMIAN_ARENA_CENTER,
    ArenaRadius = NYMIAN_ARENA_RADIUS,
    OuterThreshold = NYMIAN_OUTER_THRESHOLD,
    OpenWaterRadius = NYMIAN_OPEN_WATER_RADIUS,
    MarkerRadius = NYMIAN_MARKER_RADIUS,
    LineConfig = nymianLineConfig,
    NewState = newNymianState,
    EnsureState = ensureNymianState,
    ClearState = clearNymianState,
    GetConfig = getNymianConfig,
    GetRuntimeState = getNymianRuntimeState,
    PruneState = pruneNymianState,
    RotationSign = nymianRotationSign,
    AddOpenWaterFirst = addNymianOpenWaterFirst,
    GetOpenWaterPredictions = getNymianOpenWaterPredictions,
    AdvanceOpenWater = advanceNymianOpenWater,
    MarkerTarget = nymianMarkerTarget,
    AddMarker = addNymianMarker,
    ResolveMarker = resolveNymianMarker,
    HandleEntityChannel = handleNymianEntityChannel,
    HandleAOECreate = handleNymianAOECreate,
    HandleEntityCast = handleNymianEntityCast,
    Draw = drawNymianPetalodus,
    Update = updateNymianPetalodus,
    HasActivity = hasNymianActivity,
}
end

rawset(_G, 'MuAiOccultCrescentSouthNymianPetalodus', Module)
return Module
