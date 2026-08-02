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

local LION_MAP_ID = 1252
local LION_BOSS_CONTENT_ID = 13809
local LION_ORB_CONTENT_ID = 13812
local LION_BRIGHT_PULSE_AID = 41403
local LION_OLD_ACTIVE_AURA = 2428
local LION_NEW_ACTIVE_AURA = 2429
local LION_ARENA_CENTER = { x = 636, z = -54 }
local LION_INNER_THRESHOLD = 15
local LION_BRIGHT_PULSE_RADIUS = 12
local LION_BRIGHT_PULSE_DELAY_MS = 5200
local LION_INNER_ANGLE = -80 * math.pi / 180
local LION_OUTER_ANGLE = 148 * math.pi / 180
local LION_BATCH_WINDOW_MS = 750
local LION_SEEN_TTL_MS = 12000
local LION_CAST_DEDUPE_MS = 1000
local LION_RESOLVE_MATCH_DISTANCE_SQ = 4
local LION_ORB_MISSING_CLEAR_MS = 500
local LION_BOSS_MISSING_CLEAR_MS = 1000

local lionFinite = Common.finite

local function lionMapActive()
    local player = rawget(_G, 'Player')
    if player == nil then
        return false
    end
    return tonumber(player.localmapid) == LION_MAP_ID
end

local lionDistanceSquared = Common.distanceSquared

local function lionDiagnostic(guide, key, context)
    if type(guide) == 'table' and type(guide.LogOnce) == 'function' then
        guide.LogOnce(
                'OccultCrescentLionRampant',
                key,
                '跃立狮闪光预测跳过',
                context,
                false)
    end
end

local function newLionState()
    return {
        items = {},
        seenTriggers = {},
        seenCasts = {},
        batch = {
            sequence = 0,
            startedAt = nil,
        },
        bossEntityIDs = {},
        bossLastSeenAt = nil,
        bossMissingSince = nil,
        lastActivityAt = nil,
        lastDiagnostic = nil,
    }
end

local function ensureLionState(state)
    state.items = type(state.items) == 'table' and state.items or {}
    state.seenTriggers = type(state.seenTriggers) == 'table'
            and state.seenTriggers or {}
    state.seenCasts = type(state.seenCasts) == 'table'
            and state.seenCasts or {}
    state.batch = type(state.batch) == 'table' and state.batch or {}
    state.batch.sequence = tonumber(state.batch.sequence) or 0
    state.bossEntityIDs = type(state.bossEntityIDs) == 'table'
            and state.bossEntityIDs or {}
    return state
end

local lionFeature = Common.newFeature({
    key = 'LionRampant',
    newState = newLionState,
    ensureState = ensureLionState,
})
local getLionConfig = lionFeature.GetConfig
local getLionRuntimeState = lionFeature.GetRuntimeState

local function clearLionState(state)
    local replacement = newLionState()
    for key in pairs(state) do
        state[key] = nil
    end
    for key, value in pairs(replacement) do
        state[key] = value
    end
end

local function resetLionPredictionState(state)
    state.items = {}
    state.seenTriggers = {}
    state.seenCasts = {}
    state.batch = {
        sequence = 0,
        startedAt = nil,
    }
    state.bossMissingSince = nil
    state.lastActivityAt = nil
    state.lastDiagnostic = nil
end

local function lionBrightPulsePrediction(pos)
    if type(pos) ~= 'table'
            or not lionFinite(pos.x)
            or not lionFinite(pos.z)
            or not lionFinite(pos.h)
    then
        return nil
    end
    local offX = pos.x - LION_ARENA_CENTER.x
    local offZ = pos.z - LION_ARENA_CENTER.z
    local distanceSq = offX * offX + offZ * offZ
    if distanceSq <= 0 then
        return nil
    end

    local facingX = math.sin(pos.h)
    local facingZ = math.cos(pos.h)
    local rightTangentX = offZ
    local rightTangentZ = -offX
    local clockwise =
            rightTangentX * facingX + rightTangentZ * facingZ > 0
    local inner = distanceSq < LION_INNER_THRESHOLD * LION_INNER_THRESHOLD
    local angle = inner and LION_INNER_ANGLE or LION_OUTER_ANGLE
    if clockwise then
        angle = -angle
    end

    local cosine = math.cos(angle)
    local sine = math.sin(angle)
    local rotatedX = offX * cosine - offZ * sine
    local rotatedZ = offX * sine + offZ * cosine
    return {
        x = LION_ARENA_CENTER.x + rotatedX,
        y = pos.y,
        z = LION_ARENA_CENTER.z + rotatedZ,
        clockwise = clockwise,
        inner = inner,
        angle = angle,
    }
end

local function lionOrbSnapshot(entityID)
    if not lionFinite(entityID)
            or entityID <= 0
            or type(TensorCore) ~= 'table'
            or type(TensorCore.mGetEntity) ~= 'function'
    then
        return nil
    end
    local entity = TensorCore.mGetEntity(entityID)
    local pos = entity ~= nil and entity.pos or nil
    if entity == nil
            or tonumber(entity.id) ~= entityID
            or tonumber(entity.contentid) ~= LION_ORB_CONTENT_ID
            or pos == nil
            or not lionFinite(pos.x)
            or not lionFinite(pos.y)
            or pos.y == 0
            or not lionFinite(pos.z)
            or not lionFinite(pos.h)
    then
        return nil
    end
    return {
        x = pos.x,
        y = pos.y,
        z = pos.z,
        h = pos.h,
    }
end

local function lionBatchSequence(state, now)
    local batch = state.batch
    if not lionFinite(batch.startedAt)
            or now - batch.startedAt > LION_BATCH_WINDOW_MS
    then
        batch.sequence = batch.sequence + 1
        batch.startedAt = now
    end
    return batch.sequence
end

local function addLionBrightPulse(
        state,
        entityID,
        oldActiveAura1,
        newActiveAura1,
        now,
        guide)
    ensureLionState(state)
    if not lionMapActive()
            or oldActiveAura1 ~= LION_OLD_ACTIVE_AURA
            or newActiveAura1 ~= LION_NEW_ACTIVE_AURA
            or not lionFinite(now)
    then
        return false
    end

    local source = lionOrbSnapshot(entityID)
    local predicted = lionBrightPulsePrediction(source)
    if source == nil or predicted == nil or not lionFinite(predicted.y) then
        state.lastDiagnostic = {
            key = 'trigger_missing_geometry',
            at = now,
            entityID = entityID,
        }
        lionDiagnostic(guide, 'trigger_missing_geometry', {
            entityID = entityID,
        })
        return false
    end

    local batchSequence = lionBatchSequence(state, now)
    local key = tostring(batchSequence) .. ':' .. tostring(entityID)
    if state.seenTriggers[key] ~= nil then
        return false
    end
    state.seenTriggers[key] = now + LION_SEEN_TTL_MS

    local activationAt = now + LION_BRIGHT_PULSE_DELAY_MS
    state.items[#state.items + 1] = {
        key = key,
        batchSequence = batchSequence,
        entityID = entityID,
        source = source,
        predicted = predicted,
        triggeredAt = now,
        activationAt = activationAt,
        expiresAt = activationAt,
        missingSince = nil,
    }
    table.sort(state.items, function(left, right)
        if left.activationAt ~= right.activationAt then
            return left.activationAt < right.activationAt
        end
        if left.batchSequence ~= right.batchSequence then
            return left.batchSequence < right.batchSequence
        end
        return left.entityID < right.entityID
    end)
    state.bossLastSeenAt = now
    state.lastActivityAt = now
    return true
end

local function removeLionItemAt(state, index)
    table.remove(state.items, index)
end

local function clearLionBatch(state, batchSequence)
    local removed = false
    for index = #state.items, 1, -1 do
        if state.items[index].batchSequence == batchSequence then
            removeLionItemAt(state, index)
            removed = true
        end
    end
    if #state.items == 0 then
        resetLionPredictionState(state)
    end
    return removed
end

local function resolveLionBrightPulse(
        state,
        entityID,
        spellID,
        castPos,
        now)
    ensureLionState(state)
    if spellID ~= LION_BRIGHT_PULSE_AID or not lionFinite(now) then
        return false
    end
    if #state.items == 0 then
        return false
    end
    local castKey = tostring(entityID)
            .. ':' .. tostring(math.floor(now / LION_CAST_DEDUPE_MS))
    if state.seenCasts[castKey] ~= nil then
        return false
    end
    state.seenCasts[castKey] = now + LION_SEEN_TTL_MS

    if type(castPos) == 'table'
            and lionFinite(castPos.x)
            and lionFinite(castPos.z)
    then
        local matches = {}
        for index, item in ipairs(state.items) do
            if lionDistanceSquared(item.predicted, castPos)
                    <= LION_RESOLVE_MATCH_DISTANCE_SQ
            then
                matches[#matches + 1] = index
            end
        end
        if #matches == 1 then
            removeLionItemAt(state, matches[1])
            state.lastActivityAt = now
            if #state.items == 0 then
                resetLionPredictionState(state)
            end
            return true
        elseif #matches > 1 then
            local batchSequence = state.items[matches[1]].batchSequence
            state.lastActivityAt = now
            return clearLionBatch(state, batchSequence)
        end
        return false
    end

    -- 三颗球同批同时结算；缺少castPos时只清最早批次，不猜单颗配对。
    local earliestBatch = state.items[1].batchSequence
    state.lastActivityAt = now
    return clearLionBatch(state, earliestBatch)
end

local function pruneLionState(state, now)
    ensureLionState(state)
    for key, expiresAt in pairs(state.seenTriggers) do
        if not lionFinite(expiresAt) or now >= expiresAt then
            state.seenTriggers[key] = nil
        end
    end
    for key, expiresAt in pairs(state.seenCasts) do
        if not lionFinite(expiresAt) or now >= expiresAt then
            state.seenCasts[key] = nil
        end
    end
    for index = #state.items, 1, -1 do
        if not lionFinite(state.items[index].expiresAt)
                or now >= state.items[index].expiresAt
        then
            removeLionItemAt(state, index)
        end
    end
    if #state.items == 0 and state.lastActivityAt ~= nil then
        resetLionPredictionState(state)
    end
end

local function refreshLionOrbs(state, now)
    if type(TensorCore) ~= 'table'
            or type(TensorCore.mGetEntity) ~= 'function'
    then
        return
    end
    for index = #state.items, 1, -1 do
        local item = state.items[index]
        local entity = TensorCore.mGetEntity(item.entityID)
        if entity ~= nil
                and tonumber(entity.id) == item.entityID
                and tonumber(entity.contentid) == LION_ORB_CONTENT_ID
        then
            item.missingSince = nil
        elseif item.missingSince == nil then
            item.missingSince = now
        elseif now - item.missingSince >= LION_ORB_MISSING_CLEAR_MS then
            removeLionItemAt(state, index)
        end
    end
    if #state.items == 0 and state.lastActivityAt ~= nil then
        resetLionPredictionState(state)
    end
end

local function lionBossPresence(state)
    if type(TensorCore) ~= 'table' then
        return nil
    end
    if type(TensorCore.mGetEntity) == 'function' then
        for entityID in pairs(state.bossEntityIDs) do
            local entity = TensorCore.mGetEntity(entityID)
            if entity ~= nil
                    and tonumber(entity.id) == entityID
                    and tonumber(entity.contentid) == LION_BOSS_CONTENT_ID
            then
                return true
            end
        end
    end
    if type(TensorCore.entityList) ~= 'function' then
        return nil
    end
    local entities = TensorCore.entityList(
            'contentid=' .. tostring(LION_BOSS_CONTENT_ID))
    if type(entities) ~= 'table' then
        return nil
    end
    for _, entity in pairs(entities) do
        if entity ~= nil
                and lionFinite(tonumber(entity.id))
                and tonumber(entity.contentid) == LION_BOSS_CONTENT_ID
        then
            state.bossEntityIDs[tonumber(entity.id)] = true
            return true
        end
    end
    return false
end

local function handleLionEntityAdd(state, entityID, now)
    ensureLionState(state)
    if not lionMapActive()
            or not lionFinite(entityID)
            or entityID <= 0
            or type(TensorCore) ~= 'table'
            or type(TensorCore.mGetEntity) ~= 'function'
    then
        return false
    end
    local entity = TensorCore.mGetEntity(entityID)
    if entity == nil
            or tonumber(entity.id) ~= entityID
            or tonumber(entity.contentid) ~= LION_BOSS_CONTENT_ID
    then
        return false
    end
    state.bossEntityIDs[entityID] = true
    state.bossLastSeenAt = now
    state.bossMissingSince = nil
    return true
end

local function drawLionRampant(cfg, state)
    if cfg.DrawBrightPulsePrediction ~= true
            or #state.items == 0
            or type(TensorCore) ~= 'table'
            or type(TensorCore.getMoogleDrawer) ~= 'function'
    then
        return false
    end
    local drawer = TensorCore.getMoogleDrawer()
    if drawer == nil or type(drawer.addCircle) ~= 'function' then
        return false
    end
    for _, item in ipairs(state.items) do
        local predicted = item.predicted
        drawer:addCircle(
                predicted.x,
                predicted.y,
                predicted.z,
                LION_BRIGHT_PULSE_RADIUS)
    end
    return true
end

local function updateLionRampant(guide, cfg, state, now)
    ensureLionState(state)
    now = now or getNow()
    if cfg.Enable ~= true or not lionMapActive() then
        clearLionState(state)
        return
    end
    pruneLionState(state, now)
    if #state.items == 0 then
        return
    end

    refreshLionOrbs(state, now)
    if #state.items == 0 then
        return
    end
    local bossPresent = lionBossPresence(state)
    if bossPresent == true then
        state.bossLastSeenAt = now
        state.bossMissingSince = nil
    elseif bossPresent == false then
        state.bossMissingSince = state.bossMissingSince or now
        if now - state.bossMissingSince >= LION_BOSS_MISSING_CLEAR_MS then
            clearLionState(state)
            return
        end
    end
    drawLionRampant(cfg, state)
end

local function hasLionStoredState(state)
    return type(state) == 'table'
            and (#(state.items or {}) > 0
                    or next(state.seenTriggers or {}) ~= nil
                    or next(state.seenCasts or {}) ~= nil)
end

return {
    MapID = LION_MAP_ID,
    BossContentID = LION_BOSS_CONTENT_ID,
    OrbContentID = LION_ORB_CONTENT_ID,
    BrightPulseAID = LION_BRIGHT_PULSE_AID,
    OldActiveAura = LION_OLD_ACTIVE_AURA,
    NewActiveAura = LION_NEW_ACTIVE_AURA,
    ArenaCenter = LION_ARENA_CENTER,
    InnerThreshold = LION_INNER_THRESHOLD,
    BrightPulseRadius = LION_BRIGHT_PULSE_RADIUS,
    BrightPulseDelayMs = LION_BRIGHT_PULSE_DELAY_MS,
    InnerAngle = LION_INNER_ANGLE,
    OuterAngle = LION_OUTER_ANGLE,
    BatchWindowMs = LION_BATCH_WINDOW_MS,
    OrbMissingClearMs = LION_ORB_MISSING_CLEAR_MS,
    BossMissingClearMs = LION_BOSS_MISSING_CLEAR_MS,
    NewState = newLionState,
    EnsureState = ensureLionState,
    GetConfig = getLionConfig,
    GetRuntimeState = getLionRuntimeState,
    ClearState = clearLionState,
    Prediction = lionBrightPulsePrediction,
    AddBrightPulse = addLionBrightPulse,
    ResolveBrightPulse = resolveLionBrightPulse,
    PruneState = pruneLionState,
    RefreshOrbs = refreshLionOrbs,
    BossPresence = lionBossPresence,
    HandleEntityAdd = handleLionEntityAdd,
    Draw = drawLionRampant,
    Update = updateLionRampant,
    HasStoredState = hasLionStoredState,
}
end

rawset(_G, 'MuAiOccultCrescentSouthLionRampant', Module)
return Module
