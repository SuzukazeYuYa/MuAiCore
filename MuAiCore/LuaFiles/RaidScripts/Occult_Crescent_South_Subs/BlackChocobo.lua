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

local BLACK_CHOCOBO_ARENA_CENTER = { x = 450, z = 357 }
local BLACK_CHOCOBO_ARENA_HALF_SIZE = 20
local BLACK_CHOCOBO_EXPLOSION_RADIUS = 5
local BLACK_CHOCOBO_STEP = 5
local BLACK_CHOCOBO_EXPLOSIONS_TOTAL = 5
local BLACK_CHOCOBO_INTERVAL_MS = 1100
local BLACK_CHOCOBO_LINE_TIMEOUT_MS = 10000
local BLACK_CHOCOBO_EVENT_DEDUPE_MS = 350
local BLACK_CHOCOBO_SEEN_TTL_MS = 30000
local BLACK_CHOCOBO_HEADING_MATCH = 0.1
local BLACK_CHOCOBO_POSITION_MATCH_SQ = 1
local BLACK_CHOCOBO_START_POSITION_MATCH_SQ = 0.01
local BLACK_CHOCOBO_START_HEADING_MATCH = 0.001
local BLACK_CHOCOBO_BOSS_MISSING_CLEAR_MS = 2000
local BLACK_CHOCOBO_VISUAL_TRACK_MS = 15000

local blackChocoboAID = {
    DeathWall = 41394,
    ChocoAero = 41165,
    ChocoAttack = 43032,
    ChocoBeak = 41163,
    ChocoMaelfeather = 41164,
    AutoAttack = 43260,
    ChocoWindstorm = 41147,
    ChocoCyclone = 41148,
    ChocoSlaughterCast = 41149,
    ChocoSlaughterFirst = 41151,
    ChocoSlaughterRest = 41152,
    ChocoBlades1 = 41155,
    ChocoBlades2 = 41156,
    ChocoDoublades = 41153,
    Unk = 41154,
    ChocoAeroII = 41162,
}

local blackChocoboBossVisualAID = {
    [blackChocoboAID.ChocoSlaughterCast] = true,
    [blackChocoboAID.ChocoDoublades] = true,
}

local blackChocoboDangerDrawer

local blackFinite = Common.finite

local deleteBlackChocoboTimedShape = Common.deleteTimedShape

local function clearBlackChocoboLineTimedCircles(line)
    if type(line) ~= 'table' then
        return
    end
    for _, token in pairs(type(line.timedCircles) == 'table'
            and line.timedCircles or {})
    do
        deleteBlackChocoboTimedShape(token)
    end
    line.timedCircles = {}
    line.timedScheduled = false
end

local function forgetBlackChocoboLineTimedCircles(line)
    if type(line) == 'table' then
        line.timedCircles = {}
        line.timedScheduled = false
    end
end

local function clearBlackChocoboTimedCircles(state)
    for _, line in ipairs(type(state.lines) == 'table' and state.lines or {}) do
        clearBlackChocoboLineTimedCircles(line)
    end
end

local function reliableBlackPosition(pos)
    return Common.copyPosition(pos, true)
end

local headingDifference = Common.headingDifference

local function newBlackChocoboState()
    return {
        lines = {},
        seenStarts = {},
        seenResolves = {},
        ambiguity = nil,
        trackedBossEntityIDs = {},
        visualExpiresAt = nil,
        bossLastSeenAt = nil,
        lastActivityAt = nil,
        lastDiagnostic = nil,
    }
end

local function ensureBlackChocoboState(state)
    state.lines = type(state.lines) == 'table' and state.lines or {}
    state.seenStarts = type(state.seenStarts) == 'table'
            and state.seenStarts or {}
    state.seenResolves = type(state.seenResolves) == 'table'
            and state.seenResolves or {}
    state.trackedBossEntityIDs = type(state.trackedBossEntityIDs) == 'table'
            and state.trackedBossEntityIDs or {}
    local ambiguity = state.ambiguity
    state.ambiguity = type(ambiguity) == 'table'
            and blackFinite(ambiguity.expiresAt)
            and ambiguity or nil
    return state
end

local function clearBlackChocoboState(state)
    ensureBlackChocoboState(state)
    clearBlackChocoboTimedCircles(state)
    state.lines = {}
    state.seenStarts = {}
    state.seenResolves = {}
    state.ambiguity = nil
    state.trackedBossEntityIDs = {}
    state.visualExpiresAt = nil
    state.bossLastSeenAt = nil
    state.lastActivityAt = nil
    state.lastDiagnostic = nil
end

local blackChocoboDiagnosticText = {
    start_missing_geometry = '黑陆行鸟连爆预测跳过：41151起点、朝向、时间或非零高度不可靠。',
    start_conflict = '黑陆行鸟连爆同一起始事件几何冲突，本轮停止自定义绘图。',
    resolve_missing_geometry = '黑陆行鸟连爆推进暂停：41151/41152缺少可靠朝向。',
    resolve_no_match = '黑陆行鸟连爆推进暂停：实际结算未匹配到预测线路。',
    resolve_multiple_matches = '黑陆行鸟连爆推进暂停：实际结算匹配到多条预测线路。',
}

local blackChocoboFeature = Common.newFeature({
    key = 'BlackChocobo',
    newState = newBlackChocoboState,
    ensureState = ensureBlackChocoboState,
    diagnosticText = blackChocoboDiagnosticText,
    dedupeMs = BLACK_CHOCOBO_EVENT_DEDUPE_MS,
    seenTtlMs = BLACK_CHOCOBO_SEEN_TTL_MS,
})
local getBlackChocoboConfig = blackChocoboFeature.GetConfig
local getBlackChocoboRuntimeState = blackChocoboFeature.GetRuntimeState
local setBlackChocoboDiagnostic = blackChocoboFeature.Diagnostic
local consumeBlackChocoboEvent = blackChocoboFeature.Consume

local function suppressBlackChocobo(state, code, now)
    if #state.lines == 0 then
        return
    end
    clearBlackChocoboTimedCircles(state)
    local expiresAt = now + BLACK_CHOCOBO_LINE_TIMEOUT_MS
    for _, line in ipairs(state.lines) do
        if blackFinite(line.expiresAt) then
            expiresAt = math.max(expiresAt, line.expiresAt)
        end
    end
    if state.ambiguity ~= nil then
        expiresAt = math.max(expiresAt, state.ambiguity.expiresAt)
    end
    state.ambiguity = {
        code = code,
        at = now,
        expiresAt = expiresAt,
    }
    state.lastActivityAt = now
end

local function blackChocoboPoint(line, index)
    if type(line) ~= 'table'
            or reliableBlackPosition(line.start) == nil
            or not blackFinite(line.heading)
            or type(index) ~= 'number'
    then
        return nil
    end
    local distance = BLACK_CHOCOBO_STEP * index
    return {
        x = line.start.x + math.sin(line.heading) * distance,
        y = line.start.y,
        z = line.start.z + math.cos(line.heading) * distance,
    }
end

local function getBlackChocoboMoogleDrawer()
    if type(TensorCore) ~= 'table'
            or type(TensorCore.getMoogleDrawer) ~= 'function'
    then
        return nil
    end
    local drawer = TensorCore.getMoogleDrawer()
    return type(drawer) == 'table' and drawer or nil
end

local function scheduleBlackChocoboTimedCircles(line, now, guide)
    if type(line) ~= 'table' or line.timedScheduled == true then
        return false
    end
    line.timedCircles = {}
    local cfg = getBlackChocoboConfig(guide)
    if type(cfg) ~= 'table' or cfg.DrawSlaughterPredictions ~= true then
        return false
    end
    local drawer = getBlackChocoboMoogleDrawer()
    if drawer == nil or type(drawer.addTimedCircle) ~= 'function' then
        return false
    end

    local added = false
    -- i=0是41151当前读条圈，继续交给Moogle原生telegraph；这里只补后续4次。
    for index = 1, line.explosionsTotal - 1 do
        local point = blackChocoboPoint(line, index)
        local activationAt =
                line.firstActivationAt + BLACK_CHOCOBO_INTERVAL_MS * index
        local timeout = activationAt - now
        if point ~= nil and timeout > 0 then
            local token = drawer:addTimedCircle(
                    timeout,
                    point.x,
                    point.y,
                    point.z,
                    BLACK_CHOCOBO_EXPLOSION_RADIUS)
            if type(token) == 'string' then
                line.timedCircles[index] = token
                added = true
            end
        end
    end
    line.timedScheduled = added
    return added
end

local function blackChocoboStartRoundKey(aoeInfo)
    if type(aoeInfo.entityID) ~= 'number'
            or not blackFinite(aoeInfo.startTime)
    then
        return nil
    end
    return tostring(aoeInfo.entityID)
            .. ':' .. tostring(math.floor(aoeInfo.startTime))
end

local function addBlackChocoboLine(state, aoeInfo, now, guide)
    if type(aoeInfo) ~= 'table'
            or aoeInfo.aoeID ~= blackChocoboAID.ChocoSlaughterFirst
    then
        return false
    end
    local start = reliableBlackPosition({
        x = aoeInfo.x,
        y = aoeInfo.y,
        z = aoeInfo.z,
    })
    local roundKey = blackChocoboStartRoundKey(aoeInfo)
    if start == nil
            or roundKey == nil
            or not blackFinite(aoeInfo.heading)
            or not blackFinite(aoeInfo.duration)
            or aoeInfo.duration <= 0
    then
        suppressBlackChocobo(state, 'start_missing_geometry', now)
        setBlackChocoboDiagnostic(
                state, guide, 'start_missing_geometry', now)
        return false
    end

    local firstActivationAt = aoeInfo.startTime + aoeInfo.duration * 1000
    local seen = state.seenStarts[roundKey]
    if seen ~= nil then
        local sameGeometry =
                distanceSquared(seen.start, start)
                        <= BLACK_CHOCOBO_START_POSITION_MATCH_SQ
                and math.abs(seen.start.y - start.y) <= 0.1
                and headingDifference(seen.heading, aoeInfo.heading)
                        <= BLACK_CHOCOBO_START_HEADING_MATCH
                and math.abs(seen.firstActivationAt - firstActivationAt) <= 1
        if not sameGeometry then
            suppressBlackChocobo(state, 'start_conflict', now)
            setBlackChocoboDiagnostic(state, guide, 'start_conflict', now, {
                entityID = aoeInfo.entityID,
            })
        end
        return false
    end

    local key = roundKey .. ':' .. string.format('%.6f', aoeInfo.heading)
    state.seenStarts[roundKey] = {
        at = now,
        key = key,
        start = start,
        heading = aoeInfo.heading,
        firstActivationAt = firstActivationAt,
    }
    local line = {
        key = key,
        entityID = aoeInfo.entityID,
        start = start,
        heading = aoeInfo.heading,
        step = BLACK_CHOCOBO_STEP,
        explosionsTotal = BLACK_CHOCOBO_EXPLOSIONS_TOTAL,
        resolvedCount = 0,
        firstActivationAt = firstActivationAt,
        nextActivationAt = firstActivationAt,
        expiresAt = firstActivationAt + BLACK_CHOCOBO_LINE_TIMEOUT_MS,
        timedCircles = {},
        timedScheduled = false,
    }
    state.lines[#state.lines + 1] = line
    scheduleBlackChocoboTimedCircles(line, now, guide)
    state.lastActivityAt = now
    return true
end

local function blackChocoboCastHeading(entityID, castPos)
    if type(castPos) == 'table' then
        local heading = castPos.h
        if not blackFinite(heading) then
            heading = castPos.heading
        end
        if blackFinite(heading) then
            return heading, 'event'
        end
    end
    if type(entityID) ~= 'number'
            or type(TensorCore) ~= 'table'
            or type(TensorCore.mGetEntity) ~= 'function'
    then
        return nil
    end
    local entity = TensorCore.mGetEntity(entityID)
    local position = type(entity) == 'table' and entity.pos or nil
    if type(position) ~= 'table' then
        return nil
    end
    local heading = position.h
    if not blackFinite(heading) then
        heading = position.heading
    end
    if not blackFinite(heading) then
        return nil
    end
    return heading, 'live'
end

local function removeBlackChocoboLine(state, target, cancelTimedShapes)
    for index, line in ipairs(state.lines) do
        if line == target then
            if cancelTimedShapes == false then
                forgetBlackChocoboLineTimedCircles(line)
            else
                clearBlackChocoboLineTimedCircles(line)
            end
            table.remove(state.lines, index)
            if #state.lines == 0 then
                state.ambiguity = nil
            end
            return true
        end
    end
    return false
end

local function resolveBlackChocoboLine(
        state,
        entityID,
        spellID,
        castPos,
        now,
        guide)
    if spellID ~= blackChocoboAID.ChocoSlaughterFirst
            and spellID ~= blackChocoboAID.ChocoSlaughterRest
    then
        return false
    end
    local resolveKey = tostring(entityID) .. ':' .. tostring(spellID)
    if not consumeBlackChocoboEvent(state.seenResolves, resolveKey, now) then
        return false
    end

    local heading = blackChocoboCastHeading(entityID, castPos)
    if heading == nil then
        suppressBlackChocobo(state, 'resolve_missing_geometry', now)
        setBlackChocoboDiagnostic(
                state, guide, 'resolve_missing_geometry', now)
        return false
    end
    local position = reliableBlackPosition(castPos)
    local pool = state.lines
    if spellID == blackChocoboAID.ChocoSlaughterFirst then
        local helperLines = {}
        for _, line in ipairs(state.lines) do
            if line.entityID == entityID then
                helperLines[#helperLines + 1] = line
            end
        end
        if #helperLines > 0 then
            pool = helperLines
        end
    end

    local matches = {}
    for _, line in ipairs(pool) do
        local expected = blackChocoboPoint(line, line.resolvedCount)
        local headingMatches =
                headingDifference(line.heading, heading)
                        <= BLACK_CHOCOBO_HEADING_MATCH
        local positionMatches = position == nil
                or distanceSquared(expected, position)
                        <= BLACK_CHOCOBO_POSITION_MATCH_SQ
        if headingMatches and positionMatches then
            matches[#matches + 1] = line
        end
    end
    if #matches ~= 1 then
        local code = #matches == 0
                and 'resolve_no_match' or 'resolve_multiple_matches'
        suppressBlackChocobo(state, code, now)
        setBlackChocoboDiagnostic(state, guide, code, now, {
            matches = #matches,
            spellID = spellID,
        })
        return false
    end

    local line = matches[1]
    local resolvedIndex = line.resolvedCount
    if type(line.timedCircles) == 'table' then
        -- 圆的timeout就是该次实际结算的预计时刻，正常路径让Moogle自行到期。
        line.timedCircles[resolvedIndex] = nil
    end
    line.resolvedCount = line.resolvedCount + 1
    line.nextActivationAt = now + BLACK_CHOCOBO_INTERVAL_MS
    line.lastResolvedAt = now
    state.lastActivityAt = now
    if line.resolvedCount >= line.explosionsTotal then
        removeBlackChocoboLine(state, line, false)
    end
    return true
end

local function blackChocoboPredictions(line, now)
    local predictions = {}
    if type(line) ~= 'table' then
        return predictions
    end
    local firstIndex = line.resolvedCount
    if firstIndex == 0 and now < line.firstActivationAt then
        firstIndex = 1
    end
    for index = firstIndex, line.explosionsTotal - 1 do
        local point = blackChocoboPoint(line, index)
        if point ~= nil then
            point.index = index
            predictions[#predictions + 1] = point
        end
    end
    return predictions
end

local function pruneBlackChocoboState(state, now)
    ensureBlackChocoboState(state)
    local timedOut = false
    for index = #state.lines, 1, -1 do
        if not blackFinite(state.lines[index].expiresAt)
                or now > state.lines[index].expiresAt
        then
            clearBlackChocoboLineTimedCircles(state.lines[index])
            table.remove(state.lines, index)
            timedOut = true
        end
    end
    for key, seen in pairs(state.seenStarts) do
        local seenAt = type(seen) == 'table' and seen.at or seen
        if not blackFinite(seenAt) or now - seenAt > BLACK_CHOCOBO_SEEN_TTL_MS then
            state.seenStarts[key] = nil
        end
    end
    blackChocoboFeature.PruneSeen(state.seenResolves, now)
    if state.ambiguity ~= nil
            and #state.lines == 0
            and now > state.ambiguity.expiresAt
    then
        state.ambiguity = nil
    end
    if state.visualExpiresAt ~= nil and now > state.visualExpiresAt then
        state.visualExpiresAt = nil
    end
    if #state.lines == 0 then
        state.ambiguity = nil
        if timedOut then
            state.seenStarts = {}
            state.seenResolves = {}
            state.lastDiagnostic = nil
            state.lastActivityAt = nil
        end
    end
end

local function hasBlackChocoboActivity(state)
    return #state.lines > 0
            or state.ambiguity ~= nil
            or state.visualExpiresAt ~= nil
end

local function hasBlackChocoboStoredState(state)
    return hasBlackChocoboActivity(state)
            or next(state.seenStarts) ~= nil
            or next(state.seenResolves) ~= nil
            or next(state.trackedBossEntityIDs) ~= nil
            or state.lastDiagnostic ~= nil
end

local function recordBlackChocoboBoss(state, entityID, now)
    if type(entityID) == 'number' then
        state.trackedBossEntityIDs[entityID] = true
        state.bossLastSeenAt = now
    end
    state.visualExpiresAt = now + BLACK_CHOCOBO_VISUAL_TRACK_MS
    state.lastActivityAt = now
end

local function hasLiveBlackChocobo(state)
    if type(TensorCore) ~= 'table' or type(TensorCore.mGetEntity) ~= 'function' then
        return nil
    end
    local checked = false
    for entityID in pairs(state.trackedBossEntityIDs) do
        checked = true
        local entity = TensorCore.mGetEntity(entityID)
        if type(entity) == 'table' and entity.alive ~= false then
            return true
        end
    end
    if checked then
        return false
    end
    -- BossMod NameID/OID 未经本机事件证明为 Minion contentid，不据此扫描实体。
    return nil
end

local function handleBlackChocoboAOECreate(state, aoeInfo, now, guide)
    if type(aoeInfo) ~= 'table' then
        return false
    end
    if aoeInfo.aoeID == blackChocoboAID.ChocoSlaughterFirst then
        return addBlackChocoboLine(state, aoeInfo, now, guide)
    end
    if blackChocoboBossVisualAID[aoeInfo.aoeID] then
        recordBlackChocoboBoss(state, aoeInfo.entityID, now)
        return true
    end
    return false
end

local function handleBlackChocoboEntityCast(
        state,
        entityID,
        spellID,
        castPos,
        now,
        guide)
    if blackChocoboBossVisualAID[spellID] then
        recordBlackChocoboBoss(state, entityID, now)
        return true
    end
    return resolveBlackChocoboLine(
            state, entityID, spellID, castPos, now, guide)
end

local function getBlackChocoboDangerDrawer(guide)
    if blackChocoboDangerDrawer == nil
            and type(guide.CreateDrawer) == 'function'
    then
        blackChocoboDangerDrawer = guide.CreateDrawer(1, 0.1, 0, 0.22, 2, 0)
    end
    return blackChocoboDangerDrawer
end

local function drawBlackChocobo(guide, cfg, state, now)
    if state.ambiguity ~= nil then
        return
    end
    for _, line in ipairs(state.lines) do
        if cfg.DrawSlaughterPredictions then
            if line.timedScheduled ~= true then
                scheduleBlackChocoboTimedCircles(line, now, guide)
            end
        elseif next(line.timedCircles or {}) ~= nil then
            clearBlackChocoboLineTimedCircles(line)
        end
        if cfg.DrawSlaughterDirection then
            local drawer = getBlackChocoboDangerDrawer(guide)
            local last = blackChocoboPoint(
                    line, line.explosionsTotal - 1)
            if drawer ~= nil and last ~= nil then
                drawer:addLine(
                        line.start.x, line.start.y, line.start.z,
                        last.x, last.y, last.z,
                        0.12, 0.25)
            end
        end
    end
end

local function updateBlackChocobo(guide, cfg, state)
    if not cfg.Enable then
        if hasBlackChocoboStoredState(state) then
            clearBlackChocoboState(state)
        end
        return
    end
    local now = getNow()
    pruneBlackChocoboState(state, now)
    if not hasBlackChocoboActivity(state) then
        state.trackedBossEntityIDs = {}
        state.bossLastSeenAt = nil
        return
    end
    local bossPresent = hasLiveBlackChocobo(state)
    if bossPresent == true then
        state.bossLastSeenAt = now
    elseif bossPresent == false
            and state.bossLastSeenAt ~= nil
            and now - state.bossLastSeenAt > BLACK_CHOCOBO_BOSS_MISSING_CLEAR_MS
    then
        clearBlackChocoboState(state)
        return
    end
    drawBlackChocobo(guide, cfg, state, now)
end

return {
    AID = blackChocoboAID,
    ArenaCenter = BLACK_CHOCOBO_ARENA_CENTER,
    ArenaHalfSize = BLACK_CHOCOBO_ARENA_HALF_SIZE,
    ExplosionRadius = BLACK_CHOCOBO_EXPLOSION_RADIUS,
    Step = BLACK_CHOCOBO_STEP,
    ExplosionsTotal = BLACK_CHOCOBO_EXPLOSIONS_TOTAL,
    IntervalMs = BLACK_CHOCOBO_INTERVAL_MS,
    LineTimeoutMs = BLACK_CHOCOBO_LINE_TIMEOUT_MS,
    HeadingMatch = BLACK_CHOCOBO_HEADING_MATCH,
    PositionMatchSq = BLACK_CHOCOBO_POSITION_MATCH_SQ,
    NewState = newBlackChocoboState,
    EnsureState = ensureBlackChocoboState,
    ClearState = clearBlackChocoboState,
    GetConfig = getBlackChocoboConfig,
    GetRuntimeState = getBlackChocoboRuntimeState,
    ReliablePosition = reliableBlackPosition,
    HeadingDifference = headingDifference,
    Point = blackChocoboPoint,
    AddLine = addBlackChocoboLine,
    CastHeading = blackChocoboCastHeading,
    ResolveLine = resolveBlackChocoboLine,
    Predictions = blackChocoboPredictions,
    ScheduleTimedCircles = scheduleBlackChocoboTimedCircles,
    ClearTimedCircles = clearBlackChocoboTimedCircles,
    PruneState = pruneBlackChocoboState,
    HandleAOECreate = handleBlackChocoboAOECreate,
    HandleEntityCast = handleBlackChocoboEntityCast,
    Draw = drawBlackChocobo,
    Update = updateBlackChocobo,
    HasActivity = hasBlackChocoboActivity,
    HasStoredState = hasBlackChocoboStoredState,
}
end

rawset(_G, 'MuAiOccultCrescentSouthBlackChocobo', Module)
return Module
