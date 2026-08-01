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

local islandWatcherAID = {
    PetrifyingGaze = 43043,
}

local ISLAND_WATCHER_CONTENT_ID = 13853
local ISLAND_WATCHER_CHANNEL_MIN = 3.5
local ISLAND_WATCHER_CHANNEL_MAX = 3.9
local ISLAND_WATCHER_CHANNEL_TO_CAST_MS = 250
local ISLAND_WATCHER_AUTO_FACE_LEAD_MS = 200
local ISLAND_WATCHER_AUTO_FACE_RELEASE_MS = 150
local ISLAND_WATCHER_ACTIVATION_GRACE_MS = 1000
local ISLAND_WATCHER_EVENT_DEDUPE_MS = 1000
local ISLAND_WATCHER_SEEN_TTL_MS = 15000
local ISLAND_WATCHER_ENTITY_MISSING_CLEAR_MS = 500
local ISLAND_WATCHER_CAST_MISMATCH_CLEAR_MS = 500
local ISLAND_WATCHER_DIAGNOSTIC_TTL_MS = 5000
local ISLAND_WATCHER_SOURCE_OVERLAP_SQ = 0.25

local islandWatcherFinite = Common.finite

local function newIslandWatcherState()
    return {
        gaze = nil,
        suppression = nil,
        seenChannels = {},
        seenCasts = {},
        entityMissingSince = nil,
        castMismatchSince = nil,
        lastDiagnostic = nil,
        faceLock = Common.newFaceLock(),
    }
end

local function ensureIslandWatcherState(state)
    state.seenChannels = type(state.seenChannels) == 'table'
            and state.seenChannels or {}
    state.seenCasts = type(state.seenCasts) == 'table'
            and state.seenCasts or {}
    state.faceLock = type(state.faceLock) == 'table'
            and state.faceLock or Common.newFaceLock()
    state.faceLock.active = state.faceLock.active == true
    return state
end

local releaseIslandWatcherAutoFace = Common.releaseAutoFace

local function clearIslandWatcherState(state)
    ensureIslandWatcherState(state)
    releaseIslandWatcherAutoFace(state)
    state.gaze = nil
    state.suppression = nil
    state.seenChannels = {}
    state.seenCasts = {}
    state.entityMissingSince = nil
    state.castMismatchSince = nil
    state.lastDiagnostic = nil
end

local islandWatcherDiagnosticText = {
    channel_missing_geometry =
            '岛屿监视者石化视线跳过：施法实体或读条时间不可靠。',
    channel_conflict =
            '岛屿监视者石化视线事件冲突，本轮停止自动背对。',
    cast_conflict =
            '岛屿监视者石化视线结算不匹配，本轮停止自动背对。',
    player_missing_geometry =
            '岛屿监视者自动背对跳过：玩家位置不可靠。',
    player_source_overlap =
            '岛屿监视者自动背对跳过：玩家与施法源过近。',
    facing_api_unavailable =
            '岛屿监视者自动背对跳过：TensorACR朝向API不可用。',
}

local islandWatcherFeature = Common.newFeature({
    key = 'IslandWatcher',
    defaults = {
        Enable = true,
        AutoFacePetrifyingGaze = true,
    },
    newState = newIslandWatcherState,
    ensureState = ensureIslandWatcherState,
    diagnosticText = islandWatcherDiagnosticText,
})
local getIslandWatcherConfig = islandWatcherFeature.GetConfig
local getIslandWatcherRuntimeState = islandWatcherFeature.GetRuntimeState
local setIslandWatcherDiagnostic = islandWatcherFeature.Diagnostic

local function getLiveIslandWatcher(entityID)
    if not islandWatcherFinite(entityID)
            or entityID <= 0
            or type(TensorCore) ~= 'table'
            or type(TensorCore.mGetEntity) ~= 'function'
    then
        return nil
    end
    local entity = TensorCore.mGetEntity(entityID)
    local pos = type(entity) == 'table' and entity.pos or nil
    if type(entity) ~= 'table'
            or tonumber(entity.id) ~= entityID
            or tonumber(entity.contentid) ~= ISLAND_WATCHER_CONTENT_ID
            or entity.alive == false
            or type(pos) ~= 'table'
            or not islandWatcherFinite(pos.x)
            or not islandWatcherFinite(pos.z)
    then
        return nil
    end
    return entity
end

local function islandWatcherChannelKey(entityID, startedAt)
    return tostring(entityID)
            .. ':' .. tostring(math.floor(startedAt / 100))
end

local function islandWatcherCastKey(entityID, spellID)
    return tostring(entityID) .. ':' .. tostring(spellID)
end

local function suppressIslandWatcher(state, code, now)
    if state.gaze == nil then
        return false
    end
    releaseIslandWatcherAutoFace(state)
    local expiresAt = islandWatcherFinite(state.gaze.expiresAt)
            and state.gaze.expiresAt
            or now + ISLAND_WATCHER_ACTIVATION_GRACE_MS
    if state.suppression == nil then
        state.suppression = {
            code = code,
            at = now,
            expiresAt = expiresAt,
        }
    else
        state.suppression.expiresAt = math.max(
                state.suppression.expiresAt or expiresAt,
                expiresAt)
    end
    return true
end

local function handleIslandWatcherEntityChannel(
        state,
        entityID,
        spellID,
        channelTimeMax,
        now,
        guide)
    if spellID ~= islandWatcherAID.PetrifyingGaze then
        return false
    end
    ensureIslandWatcherState(state)
    now = islandWatcherFinite(now) and now or getNow()
    local entity = getLiveIslandWatcher(entityID)
    if entity == nil
            or not islandWatcherFinite(channelTimeMax)
            or channelTimeMax < ISLAND_WATCHER_CHANNEL_MIN
            or channelTimeMax > ISLAND_WATCHER_CHANNEL_MAX
    then
        if state.gaze ~= nil then
            suppressIslandWatcher(
                    state, 'channel_missing_geometry', now)
        end
        setIslandWatcherDiagnostic(
                state,
                guide,
                'channel_missing_geometry',
                now,
                {
                    entityID = entityID,
                    spellID = spellID,
                    channelTimeMax = channelTimeMax,
                })
        return false
    end

    local activationAt = now
            + channelTimeMax * 1000
            + ISLAND_WATCHER_CHANNEL_TO_CAST_MS
    local channelKey = islandWatcherChannelKey(entityID, now)
    local existing = state.gaze
    if existing ~= nil then
        if existing.entityID == entityID
                and math.abs(existing.activationAt - activationAt)
                        <= ISLAND_WATCHER_EVENT_DEDUPE_MS
        then
            state.seenChannels[channelKey] = now
            return false
        end
        suppressIslandWatcher(state, 'channel_conflict', now)
        setIslandWatcherDiagnostic(
                state,
                guide,
                'channel_conflict',
                now,
                {
                    expectedEntityID = existing.entityID,
                    actualEntityID = entityID,
                    expectedActivationAt = existing.activationAt,
                    actualActivationAt = activationAt,
                })
        return false
    end

    state.seenChannels[channelKey] = now
    state.entityMissingSince = nil
    state.castMismatchSince = nil
    state.gaze = {
        key = channelKey,
        entityID = entityID,
        spellID = spellID,
        startedAt = now,
        activationAt = activationAt,
        expiresAt = activationAt + ISLAND_WATCHER_ACTIVATION_GRACE_MS,
        source = { x = entity.pos.x, z = entity.pos.z },
    }
    return true
end

local function handleIslandWatcherEntityCast(
        state,
        entityID,
        spellID,
        now,
        guide)
    if spellID ~= islandWatcherAID.PetrifyingGaze then
        return false
    end
    ensureIslandWatcherState(state)
    now = islandWatcherFinite(now) and now or getNow()
    local gaze = state.gaze
    if gaze == nil then
        return false
    end
    local castKey = islandWatcherCastKey(entityID, spellID)
    local seenAt = state.seenCasts[castKey]
    if islandWatcherFinite(seenAt)
            and now - seenAt <= ISLAND_WATCHER_EVENT_DEDUPE_MS
    then
        return false
    end
    state.seenCasts[castKey] = now
    if gaze.entityID ~= entityID or gaze.spellID ~= spellID then
        suppressIslandWatcher(state, 'cast_conflict', now)
        setIslandWatcherDiagnostic(
                state,
                guide,
                'cast_conflict',
                now,
                {
                    expectedEntityID = gaze.entityID,
                    expectedSpellID = gaze.spellID,
                    actualEntityID = entityID,
                    actualSpellID = spellID,
                })
        return false
    end
    releaseIslandWatcherAutoFace(state, gaze.key)
    state.gaze = nil
    state.suppression = nil
    state.seenChannels = {}
    state.seenCasts = {}
    state.entityMissingSince = nil
    state.castMismatchSince = nil
    return true
end

local function islandWatcherFacingHeading(playerPos, sourcePos)
    if type(playerPos) ~= 'table'
            or type(sourcePos) ~= 'table'
            or not islandWatcherFinite(playerPos.x)
            or not islandWatcherFinite(playerPos.y)
            or not islandWatcherFinite(playerPos.z)
            or not islandWatcherFinite(sourcePos.x)
            or not islandWatcherFinite(sourcePos.z)
    then
        return nil, 'missing_geometry'
    end
    local dx = playerPos.x - sourcePos.x
    local dz = playerPos.z - sourcePos.z
    if dx * dx + dz * dz <= ISLAND_WATCHER_SOURCE_OVERLAP_SQ then
        return nil, 'source_overlap'
    end
    return math.atan2(dx, dz)
end

local function islandWatcherLiveCastState(gaze)
    local entity = type(gaze) == 'table'
            and getLiveIslandWatcher(gaze.entityID) or nil
    if entity == nil then
        return {
            present = false,
            stillCasting = nil,
            entity = nil,
        }
    end
    local casting = entity.castinginfo
    local channelingID = type(casting) == 'table'
            and tonumber(casting.channelingid) or nil
    if not islandWatcherFinite(channelingID) then
        return {
            present = true,
            stillCasting = nil,
            entity = entity,
        }
    end
    return {
        present = true,
        stillCasting = channelingID == islandWatcherAID.PetrifyingGaze,
        entity = entity,
        channelingID = channelingID,
    }
end

local function pruneIslandWatcherState(state, now)
    ensureIslandWatcherState(state)
    now = islandWatcherFinite(now) and now or getNow()
    local gaze = state.gaze
    if gaze ~= nil then
        if not islandWatcherFinite(gaze.expiresAt)
                or now > gaze.expiresAt
        then
            releaseIslandWatcherAutoFace(state)
            state.gaze = nil
            state.suppression = nil
            state.entityMissingSince = nil
            state.castMismatchSince = nil
        else
            local live = islandWatcherLiveCastState(gaze)
            if live.present then
                state.entityMissingSince = nil
            else
                state.entityMissingSince =
                        state.entityMissingSince or now
                if now - state.entityMissingSince
                        >= ISLAND_WATCHER_ENTITY_MISSING_CLEAR_MS
                then
                    releaseIslandWatcherAutoFace(state)
                    state.gaze = nil
                    state.suppression = nil
                    state.entityMissingSince = nil
                    state.castMismatchSince = nil
                end
            end
            if state.gaze ~= nil and live.stillCasting == false then
                state.castMismatchSince =
                        state.castMismatchSince or now
                if now - state.castMismatchSince
                        >= ISLAND_WATCHER_CAST_MISMATCH_CLEAR_MS
                then
                    releaseIslandWatcherAutoFace(state)
                    state.gaze = nil
                    state.suppression = nil
                    state.entityMissingSince = nil
                    state.castMismatchSince = nil
                end
            elseif live.stillCasting ~= false then
                state.castMismatchSince = nil
            end
        end
    end
    if state.gaze == nil then
        state.suppression = nil
    elseif state.suppression ~= nil
            and (not islandWatcherFinite(state.suppression.expiresAt)
                    or now > state.suppression.expiresAt)
    then
        releaseIslandWatcherAutoFace(state)
        state.gaze = nil
        state.suppression = nil
        state.entityMissingSince = nil
        state.castMismatchSince = nil
    end
    for key, seenAt in pairs(state.seenChannels) do
        if not islandWatcherFinite(seenAt)
                or now - seenAt > ISLAND_WATCHER_SEEN_TTL_MS
        then
            state.seenChannels[key] = nil
        end
    end
    for key, seenAt in pairs(state.seenCasts) do
        if not islandWatcherFinite(seenAt)
                or now - seenAt > ISLAND_WATCHER_SEEN_TTL_MS
        then
            state.seenCasts[key] = nil
        end
    end
    if state.lastDiagnostic ~= nil
            and (not islandWatcherFinite(state.lastDiagnostic.at)
                    or now - state.lastDiagnostic.at
                            > ISLAND_WATCHER_DIAGNOSTIC_TTL_MS)
    then
        state.lastDiagnostic = nil
    end
end

local function updateIslandWatcherAutoFace(
        guide,
        cfg,
        state,
        now)
    ensureIslandWatcherState(state)
    local gaze = state.gaze
    local lock = state.faceLock
    if lock.active
            and (cfg.AutoFacePetrifyingGaze ~= true
                    or state.suppression ~= nil
                    or gaze == nil
                    or gaze.key ~= lock.key
                    or not islandWatcherFinite(lock.releaseAt)
                    or now > lock.releaseAt)
    then
        releaseIslandWatcherAutoFace(state)
        lock = state.faceLock
    end
    if cfg.AutoFacePetrifyingGaze ~= true
            or state.suppression ~= nil
            or gaze == nil
            or not islandWatcherFinite(gaze.activationAt)
            or now < gaze.activationAt
                    - ISLAND_WATCHER_AUTO_FACE_LEAD_MS
            or now > gaze.activationAt
                    + ISLAND_WATCHER_AUTO_FACE_RELEASE_MS
    then
        return false
    end

    local live = getLiveIslandWatcher(gaze.entityID)
    local player = type(guide) == 'table'
            and type(guide.GetPlayer) == 'function'
            and guide.GetPlayer() or nil
    local heading, reason = islandWatcherFacingHeading(
            type(player) == 'table' and player.pos or nil,
            type(live) == 'table' and live.pos or nil)
    if heading == nil then
        releaseIslandWatcherAutoFace(state)
        setIslandWatcherDiagnostic(
                state,
                guide,
                reason == 'source_overlap'
                        and 'player_source_overlap'
                        or 'player_missing_geometry',
                now)
        return false
    end
    local applied = Common.applyAutoFace(
            state,
            gaze.key,
            heading,
            now,
            gaze.activationAt + ISLAND_WATCHER_AUTO_FACE_RELEASE_MS)
    if not applied then
        releaseIslandWatcherAutoFace(state)
        setIslandWatcherDiagnostic(
                state, guide, 'facing_api_unavailable', now)
        return false
    end
    return true
end

local function updateIslandWatcher(guide, cfg, state, now)
    ensureIslandWatcherState(state)
    now = islandWatcherFinite(now) and now or getNow()
    if cfg.Enable ~= true then
        clearIslandWatcherState(state)
        return
    end
    pruneIslandWatcherState(state, now)
    updateIslandWatcherAutoFace(guide, cfg, state, now)
end

local function hasStoredIslandWatcherState(state)
    ensureIslandWatcherState(state)
    return state.gaze ~= nil
            or state.suppression ~= nil
            or next(state.seenChannels) ~= nil
            or next(state.seenCasts) ~= nil
            or state.lastDiagnostic ~= nil
            or state.faceLock.active == true
end

return {
    AID = islandWatcherAID,
    ContentID = ISLAND_WATCHER_CONTENT_ID,
    ChannelMin = ISLAND_WATCHER_CHANNEL_MIN,
    ChannelMax = ISLAND_WATCHER_CHANNEL_MAX,
    ChannelToCastMs = ISLAND_WATCHER_CHANNEL_TO_CAST_MS,
    AutoFaceLeadMs = ISLAND_WATCHER_AUTO_FACE_LEAD_MS,
    AutoFaceReleaseMs = ISLAND_WATCHER_AUTO_FACE_RELEASE_MS,
    EntityMissingClearMs = ISLAND_WATCHER_ENTITY_MISSING_CLEAR_MS,
    CastMismatchClearMs = ISLAND_WATCHER_CAST_MISMATCH_CLEAR_MS,
    NewState = newIslandWatcherState,
    EnsureState = ensureIslandWatcherState,
    GetConfig = getIslandWatcherConfig,
    GetRuntimeState = getIslandWatcherRuntimeState,
    ClearState = clearIslandWatcherState,
    HandleEntityChannel = handleIslandWatcherEntityChannel,
    HandleEntityCast = handleIslandWatcherEntityCast,
    FacingHeading = islandWatcherFacingHeading,
    LiveCastState = islandWatcherLiveCastState,
    PruneState = pruneIslandWatcherState,
    UpdateAutoFace = updateIslandWatcherAutoFace,
    ReleaseAutoFace = releaseIslandWatcherAutoFace,
    Update = updateIslandWatcher,
    HasStoredState = hasStoredIslandWatcherState,
}
end

rawset(_G, 'MuAiOccultCrescentSouthIslandWatcher', Module)
return Module
