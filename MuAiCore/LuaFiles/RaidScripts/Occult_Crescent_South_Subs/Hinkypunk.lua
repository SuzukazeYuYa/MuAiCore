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

local HINKY_ARENA_CENTER = { x = -570, z = -160 }
local HINKY_ARENA_RADIUS = 20
local HINKY_KNOCKBACK_SAFE_RADIUS = 18
local HINKY_BOSS_MISSING_CLEAR_MS = 2000
local HINKY_EVENT_DEDUPE_MS = 500
local HINKY_SEEN_TTL_MS = 50000
local HINKY_ITEM_EXPIRE_AFTER_ACTIVATION_MS = 8000
local HINKY_DONUT_INNER_RADIUS = 7
local HINKY_DONUT_OUTER_RADIUS = 50
local HINKY_CROSS_LENGTH = 50
local HINKY_CROSS_HALF_WIDTH = 7.5
local HINKY_CROSS_HEADING = math.pi / 4
local HINKY_KNOCKBACK_DISTANCE = 20
local HINKY_SOURCE_MATCH_DISTANCE_SQ = 0.25
local hinkyAID = {
    Molt = 41368,
    MoltHelper = 41369,
    HuskActivate = 41371,
    DonutOmen = 41374,
    ShadesNestHuskCast = 41373,
    CrossOmen = 41377,
    ShadesCrossingHuskCast = 41376,
    BlowoutCast = 41378,
    KnockbackOmen = 41379,
    DeathWall = 41382,
    Blowout = 41397,
    ShadesNest = 42032,
    ShadesNestHusk = 42033,
    ShadesCrossing = 42034,
    ShadesCrossingHusk = 42035,
}

local hinkyCastDelays = {
    Boss = { 16.1, 18.4, 20.8, 23.1 },
    Adds = { 15.0, 15.3, 22.2, 22.4 },
}

local hinkyMechanicByOmen = {
    [41374] = 'Donut',
    [41377] = 'Cross',
    [41379] = 'KB',
}
local greenGuideColor = { r = 0, g = 1, b = 0, a = 0.5 }
local hinkyDangerDrawer
local function newHinkyState()
    return {
        mode = nil,
        modeStartedAt = nil,
        modeExpiresAt = nil,
        queue = {},
        sequence = 0,
        pendingBlowout = false,
        seenChannels = {},
        seenStarts = {},
        seenCasts = {},
        trackedMoltEntityIDs = {},
        bossLastSeenAt = nil,
        lastActivityAt = nil,
        lastDiagnostic = nil,
    }
end

local function ensureHinkyState(state)
    state.queue = type(state.queue) == 'table' and state.queue or {}
    state.sequence = type(state.sequence) == 'number' and state.sequence or 0
    state.pendingBlowout = state.pendingBlowout == true
    state.seenChannels = type(state.seenChannels) == 'table' and state.seenChannels or {}
    state.seenStarts = type(state.seenStarts) == 'table' and state.seenStarts or {}
    state.seenCasts = type(state.seenCasts) == 'table' and state.seenCasts or {}
    state.trackedMoltEntityIDs = type(state.trackedMoltEntityIDs) == 'table'
            and state.trackedMoltEntityIDs or {}
    return state
end

local function clearHinkyState(state)
    ensureHinkyState(state)
    state.mode = nil
    state.modeStartedAt = nil
    state.modeExpiresAt = nil
    state.queue = {}
    state.sequence = 0
    state.pendingBlowout = false
    state.seenChannels = {}
    state.seenStarts = {}
    state.seenCasts = {}
    state.trackedMoltEntityIDs = {}
    state.bossLastSeenAt = nil
    state.lastActivityAt = nil
    state.lastDiagnostic = nil
end

local hinkyDiagnosticText = {
    omen_unknown_mode = 'Hinkypunk预兆跳过：当前Molt模式未知。',
    omen_order_out_of_range = 'Hinkypunk预兆跳过：队列顺序超出0..3。',
    activate_missing_source = '鸟壳激活跳过：事件缺少可靠的原始位置。',
    activate_missing_target = '鸟壳激活跳过：事件缺少可靠的目标实体ID。',
    activate_missing_destination = '鸟壳激活跳过：目标实体位置不可用。',
    activate_source_unmatched = '鸟壳激活跳过：原始位置无法匹配预兆队列。',
    draw_missing_source = '下一只鸟绘图跳过：鸟源位置不可靠。',
    draw_missing_player = '下一只鸟指路跳过：玩家位置或高度不可靠。',
    draw_no_safe_point = '下一只鸟指路跳过：场内未找到可靠安全点。',
}

local hinkyFeature = Common.newFeature({
    key = 'Hinkypunk',
    newState = newHinkyState,
    ensureState = ensureHinkyState,
    diagnosticText = hinkyDiagnosticText,
})
local getHinkyConfig = hinkyFeature.GetConfig
local getHinkyRuntimeState = hinkyFeature.GetRuntimeState
local setHinkyDiagnostic = hinkyFeature.Diagnostic

local function hinkyCastDelay(mode, order)
    local delays = hinkyCastDelays[mode]
    if type(delays) ~= 'table' or type(order) ~= 'number'
            or order < 0 or order > 3
    then
        return nil
    end
    return delays[order + 1]
end

local function consumeHinkyEvent(bucket, key, now, dedupeMs)
    return Common.consumeEvent(
            bucket,
            key,
            now,
            dedupeMs or HINKY_EVENT_DEDUPE_MS)
end

local function beginHinkyMolt(state, entityID, spellID, channelTimeMax, now)
    local mode
    if spellID == hinkyAID.Molt then
        mode = 'Boss'
    elseif spellID == hinkyAID.MoltHelper then
        mode = 'Adds'
    else
        return false
    end
    if type(entityID) ~= 'number'
            or type(channelTimeMax) ~= 'number'
            or channelTimeMax <= 0
            or channelTimeMax > 30
    then
        return false
    end

    local key = 'molt-channel:' .. tostring(entityID) .. ':' .. tostring(spellID)
    if not consumeHinkyEvent(state.seenChannels, key, now) then
        return false
    end

    local startsNewStage = state.mode == nil or state.mode ~= mode
    if startsNewStage then
        state.queue = {}
        state.sequence = 0
        state.pendingBlowout = false
        state.seenStarts = {}
        state.seenCasts = {}
        state.trackedMoltEntityIDs = {}
        state.modeStartedAt = now
        state.modeExpiresAt = nil
        state.lastDiagnostic = nil
    end
    state.mode = mode
    state.modeStartedAt = state.modeStartedAt or now
    state.modeExpiresAt = math.max(
            state.modeExpiresAt or 0,
            now + channelTimeMax * 1000 + 2000)
    state.trackedMoltEntityIDs[entityID] = true
    state.bossLastSeenAt = now
    state.lastActivityAt = now
    return true
end

local function finishHinkyMolt(state, entityID, spellID, now)
    if spellID ~= hinkyAID.Molt and spellID ~= hinkyAID.MoltHelper then
        return false
    end
    local key = 'molt-finish:' .. tostring(entityID) .. ':' .. tostring(spellID)
    if not consumeHinkyEvent(state.seenCasts, key, now) then
        return false
    end
    state.mode = nil
    state.modeStartedAt = nil
    state.modeExpiresAt = nil
    state.lastActivityAt = now
    return true
end

local function hinkyStartKey(aoeInfo)
    return 'omen:' .. tostring(aoeInfo.entityID)
            .. ':' .. tostring(aoeInfo.aoeID)
            .. ':' .. tostring(math.floor(aoeInfo.startTime))
end

local function addHinkyOmen(state, aoeInfo, now, guide)
    local mechanic = hinkyMechanicByOmen[aoeInfo.aoeID]
    if mechanic == nil
            or type(aoeInfo.entityID) ~= 'number'
            or not validXYZ(aoeInfo)
            or type(aoeInfo.startTime) ~= 'number'
            or type(aoeInfo.duration) ~= 'number'
            or aoeInfo.duration < 0
            or aoeInfo.duration > 10
    then
        return false
    end

    local key = hinkyStartKey(aoeInfo)
    if state.seenStarts[key] ~= nil then
        return false
    end
    if state.mode == nil then
        setHinkyDiagnostic(state, guide, 'omen_unknown_mode', now, {
            entityID = aoeInfo.entityID,
            spellID = aoeInfo.aoeID,
        })
        return false
    end

    local order = #state.queue
    local delay = hinkyCastDelay(state.mode, order)
    if delay == nil then
        setHinkyDiagnostic(state, guide, 'omen_order_out_of_range', now, {
            mode = state.mode,
            order = order,
        })
        return false
    end

    local castEndsAt = aoeInfo.startTime + aoeInfo.duration * 1000
    state.sequence = state.sequence + 1
    state.seenStarts[key] = now
    state.queue[#state.queue + 1] = {
        key = key,
        sequence = state.sequence,
        order = order,
        mode = state.mode,
        sourceEntityID = aoeInfo.entityID,
        source = copyReliablePosition(aoeInfo),
        mechanic = mechanic,
        activationAt = castEndsAt + delay * 1000,
        ready = false,
        expiresAt = castEndsAt + delay * 1000
                + HINKY_ITEM_EXPIRE_AFTER_ACTIVATION_MS,
    }
    state.lastActivityAt = now
    return true
end

local function getNextHinkyBird(state)
    for _, item in ipairs(state.queue) do
        if item.ready then
            return item
        end
    end
    return nil
end

local function activateHinkyHusk(state, entityID, castPos, now, guide)
    local targetID = type(castPos) == 'table' and castPos.mainTargetID or nil
    local key = 'husk-activate:' .. tostring(entityID)
            .. ':' .. tostring(targetID)
    if not consumeHinkyEvent(state.seenCasts, key, now) then
        return false
    end

    local source = copyReliablePosition(castPos) or reliableEntityPosition(entityID)
    if source == nil then
        setHinkyDiagnostic(state, guide, 'activate_missing_source', now, {
            entityID = entityID,
        })
        return false
    end
    if type(targetID) ~= 'number' or targetID <= 0 then
        setHinkyDiagnostic(state, guide, 'activate_missing_target', now, {
            entityID = entityID,
        })
        return false
    end
    local destination = reliableEntityPosition(targetID)
    if destination == nil then
        setHinkyDiagnostic(state, guide, 'activate_missing_destination', now, {
            entityID = entityID,
            targetID = targetID,
        })
        return false
    end

    local matched = false
    local markReady = true
    for _, item in ipairs(state.queue) do
        if distanceSquared(item.source, source) <= HINKY_SOURCE_MATCH_DISTANCE_SQ then
            item.source = copyReliablePosition(destination)
            item.ready = markReady
            markReady = false
            matched = true
        end
    end
    if not matched then
        setHinkyDiagnostic(state, guide, 'activate_source_unmatched', now, {
            entityID = entityID,
            targetID = targetID,
            x = source.x,
            z = source.z,
        })
        return false
    end

    state.lastActivityAt = now
    state.bossLastSeenAt = now
    return true
end

local function removeHinkyQueueHead(state, now)
    if #state.queue == 0 then
        return false
    end
    table.remove(state.queue, 1)
    if #state.queue == 0 then
        state.pendingBlowout = false
    end
    state.lastActivityAt = now
    return true
end

local function handleHinkyEntityChannel(
        state, entityID, spellID, targetID, channelTimeMax, now)
    if type(state) ~= 'table' then
        return false
    end
    ensureHinkyState(state)
    now = type(now) == 'number' and now or getNow()
    return beginHinkyMolt(state, entityID, spellID, channelTimeMax, now)
end

local function handleHinkyAOECreate(state, aoeInfo, now, guide)
    if type(state) ~= 'table' or type(aoeInfo) ~= 'table'
            or type(aoeInfo.aoeID) ~= 'number'
    then
        return false
    end
    ensureHinkyState(state)
    now = type(now) == 'number' and now or getNow()
    if hinkyMechanicByOmen[aoeInfo.aoeID] ~= nil then
        return addHinkyOmen(state, aoeInfo, now, guide)
    end
    return false
end

local function handleHinkyEntityCast(
        state, entityID, spellID, castPos, now, guide)
    if type(state) ~= 'table'
            or type(entityID) ~= 'number'
            or type(spellID) ~= 'number'
    then
        return false
    end
    ensureHinkyState(state)
    now = type(now) == 'number' and now or getNow()

    if spellID == hinkyAID.Molt or spellID == hinkyAID.MoltHelper then
        return finishHinkyMolt(state, entityID, spellID, now)
    end
    if spellID == hinkyAID.HuskActivate then
        return activateHinkyHusk(state, entityID, castPos, now, guide)
    end

    local key = 'hinky-cast:' .. tostring(entityID) .. ':' .. tostring(spellID)
    if spellID == hinkyAID.BlowoutCast then
        if not consumeHinkyEvent(state.seenCasts, key, now) or #state.queue == 0 then
            return false
        end
        state.pendingBlowout = true
        state.lastActivityAt = now
        return true
    end
    if spellID == hinkyAID.Blowout then
        if not consumeHinkyEvent(state.seenCasts, key, now)
                or not state.pendingBlowout
        then
            return false
        end
        state.pendingBlowout = false
        return removeHinkyQueueHead(state, now)
    end
    if spellID == hinkyAID.ShadesNestHusk
            or spellID == hinkyAID.ShadesCrossingHusk
    then
        if not consumeHinkyEvent(state.seenCasts, key, now) then
            return false
        end
        return removeHinkyQueueHead(state, now)
    end
    return false
end

local function hasHinkyActivity(state)
    return state.mode ~= nil
            or #state.queue > 0
            or state.pendingBlowout
end

local function pruneHinkySeen(bucket, now)
    for key, seenAt in pairs(bucket) do
        if now - seenAt > HINKY_SEEN_TTL_MS then
            bucket[key] = nil
        end
    end
end

local function pruneHinkyState(state, now)
    ensureHinkyState(state)
    if state.modeExpiresAt ~= nil and now > state.modeExpiresAt then
        state.mode = nil
        state.modeStartedAt = nil
        state.modeExpiresAt = nil
    end
    for index = #state.queue, 1, -1 do
        if now > state.queue[index].expiresAt then
            table.remove(state.queue, index)
        end
    end
    if #state.queue == 0 then
        state.pendingBlowout = false
    end
    pruneHinkySeen(state.seenChannels, now)
    pruneHinkySeen(state.seenStarts, now)
    pruneHinkySeen(state.seenCasts, now)
    if not hasHinkyActivity(state) then
        state.trackedMoltEntityIDs = {}
        state.bossLastSeenAt = nil
    end
end

local function hasLiveHinkypunk(state)
    if type(TensorCore) ~= 'table' or type(TensorCore.mGetEntity) ~= 'function' then
        return nil
    end
    local checked = false
    for entityID in pairs(state.trackedMoltEntityIDs) do
        checked = true
        local entity = TensorCore.mGetEntity(entityID)
        if entity ~= nil and entity.alive ~= false then
            return true
        end
    end
    if checked then
        return false
    end
    -- BossMod 的 NameID/OID 尚未由本机日志证明为 Minion contentid，禁止按其扫描实体。
    return nil
end

local function isInsideHinkyArena(pos, radius)
    if not validXZ(pos) or type(radius) ~= 'number' then
        return false
    end
    return distanceSquared(pos, HINKY_ARENA_CENTER) <= radius * radius
end

local function isPointInHinkyCross(pos, source)
    if not validXZ(pos) or not validXZ(source) then
        return false
    end
    local dx = pos.x - source.x
    local dz = pos.z - source.z
    local forward = dx * math.sin(HINKY_CROSS_HEADING)
            + dz * math.cos(HINKY_CROSS_HEADING)
    local lateral = dx * math.cos(HINKY_CROSS_HEADING)
            - dz * math.sin(HINKY_CROSS_HEADING)
    return math.abs(forward) <= HINKY_CROSS_LENGTH
                    and math.abs(lateral) <= HINKY_CROSS_HALF_WIDTH
            or math.abs(lateral) <= HINKY_CROSS_LENGTH
                    and math.abs(forward) <= HINKY_CROSS_HALF_WIDTH
end

local function findNearestHinkyArenaPoint(playerPos, unsafe)
    if not validXYZ(playerPos) or type(unsafe) ~= 'function' then
        return nil
    end
    local best
    local bestDistanceSq
    local function consider(candidate)
        if isInsideHinkyArena(candidate, HINKY_ARENA_RADIUS - 0.5)
                and not unsafe(candidate)
        then
            local candidateDistanceSq = distanceSquared(candidate, playerPos)
            if best == nil or candidateDistanceSq < bestDistanceSq then
                best = candidate
                bestDistanceSq = candidateDistanceSq
            end
        end
    end

    consider(copyReliablePosition(playerPos))
    consider({
        x = HINKY_ARENA_CENTER.x,
        y = playerPos.y,
        z = HINKY_ARENA_CENTER.z,
    })
    for radius = 1, HINKY_ARENA_RADIUS - 0.5, 1 do
        for angleIndex = 0, 71 do
            local angle = angleIndex * math.pi / 36
            consider({
                x = HINKY_ARENA_CENTER.x + math.sin(angle) * radius,
                y = playerPos.y,
                z = HINKY_ARENA_CENTER.z + math.cos(angle) * radius,
            })
        end
    end
    return best
end

local function findHinkyDonutSafePoint(source, playerPos)
    if not validXYZ(source) or not validXYZ(playerPos) then
        return nil
    end
    local best
    local bestDistanceSq
    local function consider(candidate)
        if isInsideHinkyArena(candidate, HINKY_ARENA_RADIUS - 0.5)
                and distanceSquared(candidate, source)
                        <= HINKY_DONUT_INNER_RADIUS * HINKY_DONUT_INNER_RADIUS
        then
            local candidateDistanceSq = distanceSquared(candidate, playerPos)
            if best == nil or candidateDistanceSq < bestDistanceSq then
                best = candidate
                bestDistanceSq = candidateDistanceSq
            end
        end
    end

    consider(copyReliablePosition(playerPos))
    consider({ x = source.x, y = playerPos.y, z = source.z })
    for radius = 0.5, HINKY_DONUT_INNER_RADIUS - 0.5, 0.5 do
        for angleIndex = 0, 71 do
            local angle = angleIndex * math.pi / 36
            consider({
                x = source.x + math.sin(angle) * radius,
                y = playerPos.y,
                z = source.z + math.cos(angle) * radius,
            })
        end
    end
    return best
end

local function projectHinkyKnockback(source, startPos)
    if not validXYZ(source) or not validXYZ(startPos) then
        return nil
    end
    local dirX, dirZ = normalized(startPos.x - source.x, startPos.z - source.z)
    if dirX == nil then
        return nil
    end
    return {
        x = startPos.x + dirX * HINKY_KNOCKBACK_DISTANCE,
        y = startPos.y,
        z = startPos.z + dirZ * HINKY_KNOCKBACK_DISTANCE,
    }
end

local function findHinkyKnockbackSolution(source, playerPos)
    if not validXYZ(source) or not validXYZ(playerPos) then
        return nil
    end
    local best
    local bestDistanceSq
    local function consider(candidate)
        if not isInsideHinkyArena(candidate, HINKY_ARENA_RADIUS - 0.5) then
            return
        end
        local landing = projectHinkyKnockback(source, candidate)
        if landing == nil
                or not isInsideHinkyArena(landing, HINKY_KNOCKBACK_SAFE_RADIUS)
        then
            return
        end
        local candidateDistanceSq = distanceSquared(candidate, playerPos)
        if best == nil or candidateDistanceSq < bestDistanceSq then
            best = {
                start = candidate,
                landing = landing,
            }
            bestDistanceSq = candidateDistanceSq
        end
    end

    consider(copyReliablePosition(playerPos))
    consider({
        x = HINKY_ARENA_CENTER.x,
        y = playerPos.y,
        z = HINKY_ARENA_CENTER.z,
    })
    for radius = 1, HINKY_ARENA_RADIUS - 0.5, 0.5 do
        for angleIndex = 0, 71 do
            local angle = angleIndex * math.pi / 36
            consider({
                x = HINKY_ARENA_CENTER.x + math.sin(angle) * radius,
                y = playerPos.y,
                z = HINKY_ARENA_CENTER.z + math.cos(angle) * radius,
            })
        end
    end
    return best
end

local function getHinkyDangerDrawer(guide)
    if hinkyDangerDrawer == nil and type(guide.CreateDrawer) == 'function' then
        hinkyDangerDrawer = guide.CreateDrawer(1, 0.25, 0, 0.2, 2, 0)
    end
    return hinkyDangerDrawer
end

local function drawHinkyGuidePoint(guide, point, size)
    local drawer = getGreenDrawer(guide)
    if drawer ~= nil then
        drawer:addCircle(point.x, point.y, point.z, size or 0.8)
    end
    if type(guide.FrameDirect) == 'function' then
        guide.FrameDirect(point.x, point.z, 0.45, greenGuideColor)
    end
end

local function drawHinkypunk(guide, cfg, state, now)
    local bird = getNextHinkyBird(state)
    if bird == nil then
        return
    end
    if not validXYZ(bird.source) then
        setHinkyDiagnostic(state, guide, 'draw_missing_source', now)
        return
    end

    local dangerDrawer = getHinkyDangerDrawer(guide)
    if cfg.DrawNextBird and dangerDrawer ~= nil then
        if bird.mechanic == 'Donut' then
            dangerDrawer:addDonut(
                    bird.source.x,
                    bird.source.y,
                    bird.source.z,
                    HINKY_DONUT_INNER_RADIUS,
                    HINKY_DONUT_OUTER_RADIUS)
        elseif bird.mechanic == 'Cross' then
            dangerDrawer:addCross(
                    bird.source.x,
                    bird.source.y,
                    bird.source.z,
                    HINKY_CROSS_LENGTH,
                    HINKY_CROSS_HALF_WIDTH * 2,
                    HINKY_CROSS_HEADING)
        end
    end

    local needsGuide = bird.mechanic == 'KB' and cfg.DrawKnockbackGuide
            or (bird.mechanic == 'Donut' or bird.mechanic == 'Cross')
                    and cfg.DrawDonutCrossGuide
    if not needsGuide then
        return
    end
    local player = type(guide.GetPlayer) == 'function' and guide.GetPlayer() or nil
    if player == nil or not validXYZ(player.pos) then
        setHinkyDiagnostic(state, guide, 'draw_missing_player', now)
        return
    end

    if bird.mechanic == 'Donut' then
        local safePoint = findHinkyDonutSafePoint(bird.source, player.pos)
        if safePoint ~= nil then
            drawHinkyGuidePoint(guide, safePoint, 0.8)
        else
            setHinkyDiagnostic(state, guide, 'draw_no_safe_point', now, {
                mechanic = bird.mechanic,
            })
        end
    elseif bird.mechanic == 'Cross' then
        local safePoint = findNearestHinkyArenaPoint(player.pos, function(candidate)
            return isPointInHinkyCross(candidate, bird.source)
        end)
        if safePoint ~= nil then
            drawHinkyGuidePoint(guide, safePoint, 0.8)
        else
            setHinkyDiagnostic(state, guide, 'draw_no_safe_point', now, {
                mechanic = bird.mechanic,
            })
        end
    elseif bird.mechanic == 'KB' then
        local solution = findHinkyKnockbackSolution(bird.source, player.pos)
        if solution == nil then
            setHinkyDiagnostic(state, guide, 'draw_no_safe_point', now, {
                mechanic = bird.mechanic,
            })
            return
        end
        local drawer = getGreenDrawer(guide)
        if drawer ~= nil then
            drawer:addCircle(
                    solution.start.x,
                    solution.start.y,
                    solution.start.z,
                    0.9)
            drawer:addCircle(
                    solution.landing.x,
                    solution.landing.y,
                    solution.landing.z,
                    1.2)
            drawer:addLine(
                    solution.start.x,
                    solution.start.y,
                    solution.start.z,
                    solution.landing.x,
                    solution.landing.y,
                    solution.landing.z,
                    0.12,
                    0.25)
        end
        if type(guide.FrameDirect) == 'function' then
            guide.FrameDirect(
                    solution.start.x,
                    solution.start.z,
                    0.45,
                    greenGuideColor)
        end
    end
end

local function updateHinkypunk(guide, cfg, state)
    if not cfg.Enable then
        if hasHinkyActivity(state)
                or next(state.seenChannels) ~= nil
                or next(state.seenStarts) ~= nil
                or next(state.seenCasts) ~= nil
        then
            clearHinkyState(state)
        end
        return
    end

    local now = getNow()
    pruneHinkyState(state, now)
    if not hasHinkyActivity(state) then
        return
    end

    local bossPresent = hasLiveHinkypunk(state)
    if bossPresent == true then
        state.bossLastSeenAt = now
    elseif bossPresent == false
            and state.bossLastSeenAt ~= nil
            and now - state.bossLastSeenAt > HINKY_BOSS_MISSING_CLEAR_MS
    then
        clearHinkyState(state)
        return
    end

    drawHinkypunk(guide, cfg, state, now)
end


return {
    AID = hinkyAID,
    ArenaCenter = HINKY_ARENA_CENTER,
    ArenaRadius = HINKY_ARENA_RADIUS,
    KnockbackSafeRadius = HINKY_KNOCKBACK_SAFE_RADIUS,
    CrossHeading = HINKY_CROSS_HEADING,
    NewState = newHinkyState,
    EnsureState = ensureHinkyState,
    ClearState = clearHinkyState,
    GetConfig = getHinkyConfig,
    GetRuntimeState = getHinkyRuntimeState,
    PruneState = pruneHinkyState,
    CastDelay = hinkyCastDelay,
    HandleEntityChannel = handleHinkyEntityChannel,
    HandleAOECreate = handleHinkyAOECreate,
    HandleEntityCast = handleHinkyEntityCast,
    GetNextBird = getNextHinkyBird,
    FindDonutSafePoint = findHinkyDonutSafePoint,
    FindNearestArenaPoint = findNearestHinkyArenaPoint,
    IsPointInCross = isPointInHinkyCross,
    ProjectKnockback = projectHinkyKnockback,
    FindKnockbackSolution = findHinkyKnockbackSolution,
    Draw = drawHinkypunk,
    HasActivity = hasHinkyActivity,
    Update = updateHinkypunk,
}
end

rawset(_G, 'MuAiOccultCrescentSouthHinkypunk', Module)
return Module
