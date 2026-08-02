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
    local getGreenDrawer = assert(Context.GetGreenDrawer)
    local distanceSquared = Common.distanceSquared
    local normalized = Common.normalized
    local greenGuideColor = Context.GreenGuideColor

local gildedAID = {
    AutoAttack = 41788,
    Unk1 = 41789,
    Epigraph = 41790,
    ErosiveEyeCast = 41791,
    ErosiveEye = 41792,
    ErosiveEyeSlow = 41793,
    ErosiveEyeInverse = 41794,
    ErosiveEyeInverseSlow = 41795,
    WideningTwinflame = 41796,
    TongueOfFlameFast = 41797,
    TongueOfFlameSlow = 41798,
    NarrowingTwinflame = 41799,
    LickOfFlameFast = 41800,
    LickOfFlameSlow = 41801,
    FlamingEpigraphCast = 41802,
    FlamingEpigraph = 41803,
    FlamingEpigraphHelper = 41803,
    EpigraphicFireIICast = 41804,
    EpigraphicFireII = 41805,
    EpigraphicFireIIHelper = 41805,
    FlaringEpigraphCast = 41808,
    FlaringEpigraph = 41809,
    FlaringEpigraphHelper = 41809,
}

local gildedOID = {
    Boss = 0x471A,
    Helper = 0x471B,
}

local GILDED_GROUP_ID = 1018
local GILDED_NAME_ID = 13702
local GILDED_ARENA_CENTER = { x = 373.2, z = 486 }
local GILDED_ARENA_RADIUS = 40
local GILDED_SOURCE_COLLECTION_RADIUS = 45
local GILDED_FAST_DURATION_MIN = 4.5
local GILDED_FAST_DURATION_MAX = 5.5
local GILDED_SLOW_DURATION_MIN = 7.5
local GILDED_SLOW_DURATION_MAX = 8.5
local GILDED_ACTIVATION_GRACE_MS = 1500
local GILDED_SIMULTANEOUS_TOLERANCE_MS = 150
local GILDED_SOURCE_MATCH_DISTANCE_SQ = 0.25
local GILDED_EVENT_DEDUPE_MS = 1500
local GILDED_SEEN_TTL_MS = 30000
local GILDED_BOSS_MISSING_CLEAR_MS = 2000
local GILDED_VISUAL_TRACK_MS = 15000
local GILDED_DIAGNOSTIC_TTL_MS = 5000
local GILDED_ARROW_LENGTH = 5.5
local GILDED_ARROW_HEAD_LENGTH = 1.2
local GILDED_ARROW_HEAD_HALF_WIDTH = 0.7
local GILDED_PLAYER_SOURCE_MIN_DISTANCE_SQ = 0.25
local GILDED_AUTO_FACE_LEAD_MS = 300
local GILDED_AUTO_FACE_RELEASE_MS = 250
local GILDED_MOOGLE_SOURCE = 'MuAiCore - Gilded Headstone'

local gazeDefinitionByAID = {
    [41792] = {
        inverted = false,
        durationMin = GILDED_FAST_DURATION_MIN,
        durationMax = GILDED_FAST_DURATION_MAX,
    },
    [41793] = {
        inverted = false,
        durationMin = GILDED_SLOW_DURATION_MIN,
        durationMax = GILDED_SLOW_DURATION_MAX,
    },
    [41794] = {
        inverted = true,
        durationMin = GILDED_FAST_DURATION_MIN,
        durationMax = GILDED_FAST_DURATION_MAX,
    },
    [41795] = {
        inverted = true,
        durationMin = GILDED_SLOW_DURATION_MIN,
        durationMax = GILDED_SLOW_DURATION_MAX,
    },
}

local gildedMoogleDonuts = {
    [41800] = {
        name = 'Lick of Flame',
        radius = 10,
        source = GILDED_MOOGLE_SOURCE,
    },
    [41801] = {
        name = 'Lick of Flame',
        radius = 10,
        source = GILDED_MOOGLE_SOURCE,
    },
}

local gildedFinite = Common.finite

local gildedDistanceSquared = Common.distanceSquared

local function gildedSourceInsideArena(x, z)
    if not gildedFinite(x) or not gildedFinite(z) then
        return false
    end
    local dx = x - GILDED_ARENA_CENTER.x
    local dz = z - GILDED_ARENA_CENTER.z
    return dx * dx + dz * dz
            <= GILDED_SOURCE_COLLECTION_RADIUS * GILDED_SOURCE_COLLECTION_RADIUS
end

local function gildedPlayerPosition(pos)
    if type(pos) ~= 'table'
            or not gildedFinite(pos.x)
            or not gildedFinite(pos.y)
            or not gildedFinite(pos.z)
    then
        return nil
    end
    return { x = pos.x, y = pos.y, z = pos.z }
end

local function newGildedState()
    return {
        eyes = {},
        sequence = 0,
        seenStarts = {},
        seenCasts = {},
        suppression = nil,
        bossEntityID = nil,
        bossLastSeenAt = nil,
        bossMissingSince = nil,
        visualExpiresAt = nil,
        lastDiagnostic = nil,
        faceLock = Common.newFaceLock(),
        moogle = {
            registered = false,
            owned = {},
            previous = {},
            previousKnown = {},
        },
    }
end

local function ensureGildedState(state)
    state.eyes = type(state.eyes) == 'table' and state.eyes or {}
    state.sequence = type(state.sequence) == 'number' and state.sequence or 0
    state.seenStarts = type(state.seenStarts) == 'table'
            and state.seenStarts or {}
    state.seenCasts = type(state.seenCasts) == 'table'
            and state.seenCasts or {}
    state.faceLock = type(state.faceLock) == 'table'
            and state.faceLock or Common.newFaceLock()
    state.faceLock.active = state.faceLock.active == true
    state.moogle = type(state.moogle) == 'table' and state.moogle or {}
    state.moogle.registered = state.moogle.registered == true
    state.moogle.owned = type(state.moogle.owned) == 'table'
            and state.moogle.owned or {}
    state.moogle.previous = type(state.moogle.previous) == 'table'
            and state.moogle.previous or {}
    state.moogle.previousKnown = type(state.moogle.previousKnown) == 'table'
            and state.moogle.previousKnown or {}
    return state
end

local releaseGildedAutoFace = Common.releaseAutoFace

local gildedDiagnosticText = {
    gaze_missing_geometry = '金色石面魔眼跳过：AOE实体、时间或场内LocXZ不可靠。',
    gaze_start_conflict = '金色石面魔眼起始事件冲突，本批次停止朝向处理。',
    gaze_earliest_conflict = '金色石面同时出现无法唯一判断的最早魔眼，本批次停止朝向处理。',
    gaze_resolve_conflict = '金色石面魔眼结算与当前最早项不匹配，本批次停止朝向处理。',
    boss_visual_conflict = '金色石面Boss visual实体冲突，本批次停止朝向处理。',
    player_missing_geometry = '金色石面朝向处理跳过：玩家位置或高度不可靠。',
    player_source_overlap = '金色石面朝向处理跳过：玩家与魔眼源过近。',
    facing_api_unavailable = '金色石面自动面向跳过：TensorACR朝向API不可用。',
}

local gildedFeature = Common.newFeature({
    key = 'GildedHeadstone',
    newState = newGildedState,
    ensureState = ensureGildedState,
    diagnosticText = gildedDiagnosticText,
})
local getGildedConfig = gildedFeature.GetConfig
local getGildedRuntimeState = gildedFeature.GetRuntimeState
local setGildedDiagnostic = gildedFeature.Diagnostic

local gildedDonutRegistry = Common.newMoogleDonutRegistry({
    entries = gildedMoogleDonuts,
    source = GILDED_MOOGLE_SOURCE,
    ensureState = ensureGildedState,
    getBucket = function(state)
        return state.moogle
    end,
})
local applyGildedMoogleDonuts = gildedDonutRegistry.Apply

local function clearGildedGazeState(state)
    ensureGildedState(state)
    releaseGildedAutoFace(state)
    state.eyes = {}
    state.sequence = 0
    state.seenStarts = {}
    state.seenCasts = {}
    state.suppression = nil
    state.bossEntityID = nil
    state.bossLastSeenAt = nil
    state.bossMissingSince = nil
    state.visualExpiresAt = nil
    state.lastDiagnostic = nil
end

local function clearGildedState(state)
    ensureGildedState(state)
    applyGildedMoogleDonuts(state, false)
    clearGildedGazeState(state)
end

local function gildedIdentityKey(entityID, spellID)
    return tostring(entityID) .. ':' .. tostring(spellID)
end

local function gildedStartKey(entityID, spellID, startTime)
    return gildedIdentityKey(entityID, spellID)
            .. ':' .. tostring(math.floor(startTime))
end

local function sameGildedSource(left, right)
    return gildedDistanceSquared(left, right)
            <= GILDED_SOURCE_MATCH_DISTANCE_SQ
end

local function sortGildedEyes(state)
    table.sort(state.eyes, function(left, right)
        if left.activationAt ~= right.activationAt then
            return left.activationAt < right.activationAt
        end
        if left.entityID ~= right.entityID then
            return left.entityID < right.entityID
        end
        if left.spellID ~= right.spellID then
            return left.spellID < right.spellID
        end
        return left.sequence < right.sequence
    end)
end

local function gildedSuppressionExpiry(state, fallback)
    local expiresAt = fallback
    for _, eye in ipairs(state.eyes) do
        if gildedFinite(eye.expiresAt) then
            expiresAt = math.max(expiresAt, eye.expiresAt)
        end
    end
    return expiresAt
end

local function suppressGildedBatch(state, code, now)
    if #state.eyes == 0 then
        return
    end
    releaseGildedAutoFace(state)
    if state.suppression == nil then
        state.suppression = {
            code = code,
            at = now,
            expiresAt = gildedSuppressionExpiry(
                    state, now + GILDED_ACTIVATION_GRACE_MS),
        }
    else
        state.suppression.expiresAt = gildedSuppressionExpiry(
                state, state.suppression.expiresAt)
    end
end

local function gildedEyeHasIdentity(eye, entityID, spellID)
    return type(eye.identities) == 'table'
            and eye.identities[gildedIdentityKey(entityID, spellID)] == true
end

local function addGildedIdentity(eye, entityID, spellID, startKey)
    eye.identities[gildedIdentityKey(entityID, spellID)] = true
    eye.startKeys[startKey] = true
end

local function findGildedIdentityNear(state, entityID, activationAt)
    for _, eye in ipairs(state.eyes) do
        local entityMatches = eye.entityID == entityID
        if not entityMatches and type(eye.identityEntities) == 'table' then
            entityMatches = eye.identityEntities[entityID] == true
        end
        if entityMatches
                and math.abs(eye.activationAt - activationAt)
                        <= GILDED_SIMULTANEOUS_TOLERANCE_MS
        then
            return eye
        end
    end
    return nil
end

local function findGildedMergeCandidate(state, activationAt, source, inverted)
    for _, eye in ipairs(state.eyes) do
        if math.abs(eye.activationAt - activationAt)
                        <= GILDED_SIMULTANEOUS_TOLERANCE_MS
                and eye.inverted == inverted
                and sameGildedSource(eye.source, source)
        then
            return eye
        end
    end
    return nil
end

local function evaluateGildedEarliestConflict(state, now, guide)
    sortGildedEyes(state)
    local first = state.eyes[1]
    local second = state.eyes[2]
    if first == nil or second == nil
            or math.abs(first.activationAt - second.activationAt)
                    > GILDED_SIMULTANEOUS_TOLERANCE_MS
    then
        return false
    end
    if first.inverted == second.inverted
            and sameGildedSource(first.source, second.source)
    then
        return false
    end
    suppressGildedBatch(state, 'gaze_earliest_conflict', now)
    setGildedDiagnostic(
            state,
            guide,
            'gaze_earliest_conflict',
            now,
            {
                firstEntityID = first.entityID,
                firstSpellID = first.spellID,
                secondEntityID = second.entityID,
                secondSpellID = second.spellID,
            })
    return true
end

local function addGildedGaze(state, aoeInfo, now, guide)
    ensureGildedState(state)
    local definition = type(aoeInfo) == 'table'
            and gazeDefinitionByAID[aoeInfo.aoeID] or nil
    if definition == nil then
        return false
    end
    if not gildedFinite(aoeInfo.entityID)
            or aoeInfo.entityID <= 0
            or not gildedFinite(aoeInfo.startTime)
            or not gildedFinite(aoeInfo.duration)
            or aoeInfo.duration < definition.durationMin
            or aoeInfo.duration > definition.durationMax
            or not gildedSourceInsideArena(aoeInfo.x, aoeInfo.z)
    then
        if #state.eyes > 0 then
            suppressGildedBatch(state, 'gaze_missing_geometry', now)
        end
        setGildedDiagnostic(
                state,
                guide,
                'gaze_missing_geometry',
                now,
                { entityID = aoeInfo.entityID, spellID = aoeInfo.aoeID })
        return false
    end

    local activationAt = aoeInfo.startTime + aoeInfo.duration * 1000
    local startKey = gildedStartKey(
            aoeInfo.entityID, aoeInfo.aoeID, aoeInfo.startTime)
    local source = { x = aoeInfo.x, z = aoeInfo.z }
    if state.seenStarts[startKey] ~= nil then
        local existing = findGildedIdentityNear(
                state, aoeInfo.entityID, activationAt)
        if existing ~= nil
                and (existing.inverted ~= definition.inverted
                        or not sameGildedSource(existing.source, source))
        then
            suppressGildedBatch(state, 'gaze_start_conflict', now)
            setGildedDiagnostic(
                    state,
                    guide,
                    'gaze_start_conflict',
                    now,
                    { key = startKey })
        end
        return false
    end

    local identityNear = findGildedIdentityNear(
            state, aoeInfo.entityID, activationAt)
    if identityNear ~= nil then
        if identityNear.inverted ~= definition.inverted
                or not sameGildedSource(identityNear.source, source)
        then
            state.seenStarts[startKey] = now
            suppressGildedBatch(state, 'gaze_start_conflict', now)
            setGildedDiagnostic(
                    state,
                    guide,
                    'gaze_start_conflict',
                    now,
                    {
                        entityID = aoeInfo.entityID,
                        spellID = aoeInfo.aoeID,
                    })
            return false
        end
        state.seenStarts[startKey] = now
        identityNear.identityEntities[aoeInfo.entityID] = true
        addGildedIdentity(
                identityNear, aoeInfo.entityID, aoeInfo.aoeID, startKey)
        return false
    end

    local merge = findGildedMergeCandidate(
            state, activationAt, source, definition.inverted)
    if merge ~= nil then
        state.seenStarts[startKey] = now
        merge.identityEntities[aoeInfo.entityID] = true
        addGildedIdentity(merge, aoeInfo.entityID, aoeInfo.aoeID, startKey)
        merge.activationAt = math.min(merge.activationAt, activationAt)
        merge.expiresAt = math.max(
                merge.expiresAt,
                activationAt + GILDED_ACTIVATION_GRACE_MS)
        sortGildedEyes(state)
        return false
    end

    state.sequence = state.sequence + 1
    state.seenStarts[startKey] = now
    local eye = {
        key = startKey,
        sequence = state.sequence,
        entityID = aoeInfo.entityID,
        spellID = aoeInfo.aoeID,
        source = source,
        inverted = definition.inverted,
        startedAt = aoeInfo.startTime,
        activationAt = activationAt,
        expiresAt = activationAt + GILDED_ACTIVATION_GRACE_MS,
        identities = {},
        identityEntities = { [aoeInfo.entityID] = true },
        startKeys = {},
    }
    addGildedIdentity(eye, aoeInfo.entityID, aoeInfo.aoeID, startKey)
    state.eyes[#state.eyes + 1] = eye
    evaluateGildedEarliestConflict(state, now, guide)
    if state.suppression ~= nil then
        state.suppression.expiresAt = gildedSuppressionExpiry(
                state, state.suppression.expiresAt)
    end
    return true
end

local function handleGildedAOECreate(state, aoeInfo, now, guide)
    if type(aoeInfo) ~= 'table'
            or gazeDefinitionByAID[aoeInfo.aoeID] == nil
    then
        return false
    end
    return addGildedGaze(
            state,
            aoeInfo,
            gildedFinite(now) and now or getNow(),
            guide)
end

local function removeGildedEye(state, eye)
    for index, candidate in ipairs(state.eyes) do
        if candidate == eye then
            table.remove(state.eyes, index)
            return true
        end
    end
    return false
end

local function resolveGildedGaze(
        state,
        entityID,
        spellID,
        now,
        guide)
    ensureGildedState(state)
    if gazeDefinitionByAID[spellID] == nil then
        return false
    end
    now = gildedFinite(now) and now or getNow()
    if not gildedFinite(entityID) or entityID <= 0 then
        local earliest = state.eyes[1]
        if earliest ~= nil then
            suppressGildedBatch(state, 'gaze_resolve_conflict', now)
            setGildedDiagnostic(
                    state,
                    guide,
                    'gaze_resolve_conflict',
                    now,
                    {
                        expectedEntityID = earliest.entityID,
                        expectedSpellID = earliest.spellID,
                        actualEntityID = entityID,
                        actualSpellID = spellID,
                    })
        end
        return false
    end
    local identity = gildedIdentityKey(entityID, spellID)
    local seenAt = state.seenCasts[identity]
    if gildedFinite(seenAt) and now - seenAt <= GILDED_EVENT_DEDUPE_MS then
        return false
    end
    local earliest = state.eyes[1]
    if earliest == nil then
        state.seenCasts[identity] = now
        return false
    end
    if not gildedEyeHasIdentity(earliest, entityID, spellID) then
        state.seenCasts[identity] = now
        suppressGildedBatch(state, 'gaze_resolve_conflict', now)
        setGildedDiagnostic(
                state,
                guide,
                'gaze_resolve_conflict',
                now,
                {
                    expectedEntityID = earliest.entityID,
                    expectedSpellID = earliest.spellID,
                    actualEntityID = entityID,
                    actualSpellID = spellID,
                })
        return false
    end

    for alias in pairs(earliest.identities) do
        state.seenCasts[alias] = now
    end
    releaseGildedAutoFace(state, earliest.key)
    removeGildedEye(state, earliest)
    if #state.eyes == 0 then
        state.suppression = nil
    else
        evaluateGildedEarliestConflict(state, now, guide)
    end
    return true
end

local function handleGildedEntityCast(
        state,
        entityID,
        spellID,
        now,
        guide)
    if gazeDefinitionByAID[spellID] == nil then
        return false
    end
    return resolveGildedGaze(
            state, entityID, spellID, now, guide)
end

local function recordGildedBossVisual(
        state,
        entityID,
        spellID,
        channelTimeMax,
        now,
        guide)
    ensureGildedState(state)
    if spellID ~= gildedAID.ErosiveEyeCast then
        return false
    end
    if not gildedFinite(entityID)
            or entityID <= 0
            or not gildedFinite(channelTimeMax)
            or channelTimeMax < 3.5
            or channelTimeMax > 4.5
    then
        return false
    end
    if gildedFinite(state.bossEntityID)
            and state.bossEntityID ~= entityID
            and #state.eyes > 0
    then
        suppressGildedBatch(state, 'boss_visual_conflict', now)
        setGildedDiagnostic(
                state,
                guide,
                'boss_visual_conflict',
                now,
                {
                    expectedEntityID = state.bossEntityID,
                    actualEntityID = entityID,
                })
        return false
    end
    state.bossEntityID = entityID
    state.bossLastSeenAt = now
    state.bossMissingSince = nil
    state.visualExpiresAt = now + GILDED_VISUAL_TRACK_MS
    return true
end

local function handleGildedEntityChannel(
        state,
        entityID,
        spellID,
        channelTimeMax,
        now,
        guide)
    return recordGildedBossVisual(
            state,
            entityID,
            spellID,
            channelTimeMax,
            gildedFinite(now) and now or getNow(),
            guide)
end

local function hasLiveGildedBoss(state)
    if not gildedFinite(state.bossEntityID) then
        return nil
    end
    if type(TensorCore) ~= 'table'
            or type(TensorCore.mGetEntity) ~= 'function'
    then
        return nil
    end
    local entity = TensorCore.mGetEntity(state.bossEntityID)
    return type(entity) == 'table' and entity.alive ~= false
end

local function pruneGildedState(state, now, guide)
    ensureGildedState(state)
    for index = #state.eyes, 1, -1 do
        local eye = state.eyes[index]
        if not gildedFinite(eye.expiresAt) or now > eye.expiresAt then
            table.remove(state.eyes, index)
        end
    end
    for key, seenAt in pairs(state.seenStarts) do
        if not gildedFinite(seenAt) or now - seenAt > GILDED_SEEN_TTL_MS then
            state.seenStarts[key] = nil
        end
    end
    for key, seenAt in pairs(state.seenCasts) do
        if not gildedFinite(seenAt) or now - seenAt > GILDED_SEEN_TTL_MS then
            state.seenCasts[key] = nil
        end
    end
    if #state.eyes == 0 then
        state.suppression = nil
    else
        evaluateGildedEarliestConflict(state, now, guide)
    end
    if gildedFinite(state.visualExpiresAt)
            and now > state.visualExpiresAt
            and #state.eyes == 0
    then
        state.bossEntityID = nil
        state.bossLastSeenAt = nil
        state.bossMissingSince = nil
        state.visualExpiresAt = nil
    end
    if state.lastDiagnostic ~= nil
            and (not gildedFinite(state.lastDiagnostic.at)
                    or now - state.lastDiagnostic.at
                            > GILDED_DIAGNOSTIC_TTL_MS)
    then
        state.lastDiagnostic = nil
    end
end

local function selectGildedEye(state)
    if state.suppression ~= nil then
        return nil
    end
    return state.eyes[1]
end

local function gildedFacingGeometry(playerPos, eye)
    local player = gildedPlayerPosition(playerPos)
    if player == nil
            or type(eye) ~= 'table'
            or type(eye.source) ~= 'table'
            or not gildedFinite(eye.source.x)
            or not gildedFinite(eye.source.z)
    then
        return nil, 'missing_geometry'
    end
    local dx
    local dz
    if eye.inverted then
        dx = eye.source.x - player.x
        dz = eye.source.z - player.z
    else
        dx = player.x - eye.source.x
        dz = player.z - eye.source.z
    end
    local distanceSquared = dx * dx + dz * dz
    if distanceSquared <= GILDED_PLAYER_SOURCE_MIN_DISTANCE_SQ then
        return nil, 'source_overlap'
    end
    local scale = 1 / math.sqrt(distanceSquared)
    local dirX = dx * scale
    local dirZ = dz * scale
    local tip = {
        x = player.x + dirX * GILDED_ARROW_LENGTH,
        y = player.y,
        z = player.z + dirZ * GILDED_ARROW_LENGTH,
    }
    local perpendicularX = -dirZ
    local perpendicularZ = dirX
    local headBaseX = tip.x - dirX * GILDED_ARROW_HEAD_LENGTH
    local headBaseZ = tip.z - dirZ * GILDED_ARROW_HEAD_LENGTH
    return {
        start = player,
        tip = tip,
        left = {
            x = headBaseX + perpendicularX * GILDED_ARROW_HEAD_HALF_WIDTH,
            y = player.y,
            z = headBaseZ + perpendicularZ * GILDED_ARROW_HEAD_HALF_WIDTH,
        },
        right = {
            x = headBaseX - perpendicularX * GILDED_ARROW_HEAD_HALF_WIDTH,
            y = player.y,
            z = headBaseZ - perpendicularZ * GILDED_ARROW_HEAD_HALF_WIDTH,
        },
        direction = { x = dirX, z = dirZ },
    }
end

local function gildedFacingHeading(geometry)
    if type(geometry) ~= 'table'
            or type(geometry.direction) ~= 'table'
            or not gildedFinite(geometry.direction.x)
            or not gildedFinite(geometry.direction.z)
    then
        return nil
    end
    return math.atan2(geometry.direction.x, geometry.direction.z)
end

local function updateGildedAutoFace(guide, cfg, state, now)
    ensureGildedState(state)
    local lock = state.faceLock
    local eye = selectGildedEye(state)
    if lock.active
            and (cfg.AutoFace ~= true
                    or eye == nil
                    or eye.key ~= lock.key
                    or not gildedFinite(lock.releaseAt)
                    or now > lock.releaseAt)
    then
        releaseGildedAutoFace(state)
        lock = state.faceLock
    end
    if cfg.AutoFace ~= true
            or lock.active
            or eye == nil
            or not gildedFinite(eye.activationAt)
            or now < eye.activationAt - GILDED_AUTO_FACE_LEAD_MS
            or now > eye.activationAt + GILDED_AUTO_FACE_RELEASE_MS
    then
        return false
    end
    local player = type(guide.GetPlayer) == 'function'
            and guide.GetPlayer() or nil
    local geometry, reason = gildedFacingGeometry(
            type(player) == 'table' and player.pos or nil,
            eye)
    if geometry == nil then
        local code = reason == 'source_overlap'
                and 'player_source_overlap' or 'player_missing_geometry'
        setGildedDiagnostic(state, guide, code, now)
        return false
    end
    local heading = gildedFacingHeading(geometry)
    if heading == nil then
        setGildedDiagnostic(
                state, guide, 'facing_api_unavailable', now)
        return false
    end
    local applied = Common.applyAutoFace(
            state,
            eye.key,
            heading,
            now,
            eye.activationAt + GILDED_AUTO_FACE_RELEASE_MS)
    if not applied then
        setGildedDiagnostic(
                state, guide, 'facing_api_unavailable', now)
    end
    return applied
end

local function drawGildedHeadstone(guide, cfg, state, now)
    if not cfg.DrawFacingArrow then
        return false
    end
    local eye = selectGildedEye(state)
    if eye == nil then
        return false
    end
    local player = type(guide.GetPlayer) == 'function'
            and guide.GetPlayer() or nil
    local geometry, reason = gildedFacingGeometry(
            type(player) == 'table' and player.pos or nil,
            eye)
    if geometry == nil then
        local code = reason == 'source_overlap'
                and 'player_source_overlap' or 'player_missing_geometry'
        setGildedDiagnostic(state, guide, code, now)
        return false
    end
    local drawer = getGreenDrawer(guide)
    if drawer == nil then
        return false
    end
    drawer:addLine(
            geometry.start.x, geometry.start.y, geometry.start.z,
            geometry.tip.x, geometry.tip.y, geometry.tip.z,
            0.12, 0.25)
    drawer:addLine(
            geometry.tip.x, geometry.tip.y, geometry.tip.z,
            geometry.left.x, geometry.left.y, geometry.left.z,
            0.12, 0.25)
    drawer:addLine(
            geometry.tip.x, geometry.tip.y, geometry.tip.z,
            geometry.right.x, geometry.right.y, geometry.right.z,
            0.12, 0.25)
    return true
end

local function hasGildedActivity(state)
    return #state.eyes > 0 or state.suppression ~= nil
end

local function hasGildedStoredState(state)
    return hasGildedActivity(state)
            or (type(state.faceLock) == 'table'
                    and state.faceLock.active == true)
            or next(state.seenStarts) ~= nil
            or next(state.seenCasts) ~= nil
            or state.bossEntityID ~= nil
            or state.visualExpiresAt ~= nil
            or state.lastDiagnostic ~= nil
end

local function updateGildedHeadstone(guide, cfg, state)
    local enabled = cfg.Enable == true
    applyGildedMoogleDonuts(state, enabled)
    if not enabled then
        if hasGildedStoredState(state) then
            clearGildedGazeState(state)
        end
        return
    end

    local now = getNow()
    pruneGildedState(state, now, guide)
    if #state.eyes > 0 and state.bossEntityID ~= nil then
        local bossPresent = hasLiveGildedBoss(state)
        if bossPresent == true then
            state.bossLastSeenAt = now
            state.bossMissingSince = nil
        elseif bossPresent == false then
            state.bossMissingSince = state.bossMissingSince or now
            if now - state.bossMissingSince
                    >= GILDED_BOSS_MISSING_CLEAR_MS
            then
                clearGildedGazeState(state)
                return
            end
        end
    end
    updateGildedAutoFace(guide, cfg, state, now)
    drawGildedHeadstone(guide, cfg, state, now)
end

return {
    AID = gildedAID,
    OID = gildedOID,
    GroupID = GILDED_GROUP_ID,
    NameID = GILDED_NAME_ID,
    ArenaCenter = GILDED_ARENA_CENTER,
    ArenaRadius = GILDED_ARENA_RADIUS,
    SourceCollectionRadius = GILDED_SOURCE_COLLECTION_RADIUS,
    FastDurationMin = GILDED_FAST_DURATION_MIN,
    FastDurationMax = GILDED_FAST_DURATION_MAX,
    SlowDurationMin = GILDED_SLOW_DURATION_MIN,
    SlowDurationMax = GILDED_SLOW_DURATION_MAX,
    ActivationGraceMs = GILDED_ACTIVATION_GRACE_MS,
    SimultaneousToleranceMs = GILDED_SIMULTANEOUS_TOLERANCE_MS,
    SourceMatchDistanceSq = GILDED_SOURCE_MATCH_DISTANCE_SQ,
    BossMissingClearMs = GILDED_BOSS_MISSING_CLEAR_MS,
    VisualTrackMs = GILDED_VISUAL_TRACK_MS,
    DiagnosticTtlMs = GILDED_DIAGNOSTIC_TTL_MS,
    ArrowLength = GILDED_ARROW_LENGTH,
    AutoFaceLeadMs = GILDED_AUTO_FACE_LEAD_MS,
    AutoFaceReleaseMs = GILDED_AUTO_FACE_RELEASE_MS,
    MoogleSource = GILDED_MOOGLE_SOURCE,
    MoogleDonuts = gildedMoogleDonuts,
    NewState = newGildedState,
    EnsureState = ensureGildedState,
    ClearGazeState = clearGildedGazeState,
    ClearState = clearGildedState,
    GetConfig = getGildedConfig,
    GetRuntimeState = getGildedRuntimeState,
    SourceInsideArena = gildedSourceInsideArena,
    AddGaze = addGildedGaze,
    HandleAOECreate = handleGildedAOECreate,
    ResolveGaze = resolveGildedGaze,
    HandleEntityCast = handleGildedEntityCast,
    HandleEntityChannel = handleGildedEntityChannel,
    PruneState = pruneGildedState,
    SelectEye = selectGildedEye,
    FacingGeometry = gildedFacingGeometry,
    FacingHeading = gildedFacingHeading,
    UpdateAutoFace = updateGildedAutoFace,
    ReleaseAutoFace = releaseGildedAutoFace,
    Draw = drawGildedHeadstone,
    Update = updateGildedHeadstone,
    ApplyMoogleDonuts = applyGildedMoogleDonuts,
    HasActivity = hasGildedActivity,
    HasStoredState = hasGildedStoredState,
}
end

rawset(_G, 'MuAiOccultCrescentSouthGildedHeadstone', Module)
return Module
