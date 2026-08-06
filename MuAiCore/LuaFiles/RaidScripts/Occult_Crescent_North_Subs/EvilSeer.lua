local Module = {}

function Module.Create(Context)
    assert(type(Context) == 'table' and type(Context.Common) == 'table')
    local Common = Context.Common
    local nowMs = Context.nowMs
    local finite = Context.finite
    local reliablePosition = Context.reliablePosition
local EVIL_SEER_CONTENT_ID = 14726
local EVIL_SEER_EYE_CONTENT_ID = 14727
local EVIL_SEER_MODEL_IDS = {
    [EVIL_SEER_CONTENT_ID] = { [19367] = true },
    [EVIL_SEER_EYE_CONTENT_ID] = { [19368] = true },
}
local EVIL_SEER_PETRIFYING_GAZE_AID = 47148
local EVIL_SEER_CURSED_GAZE_AID = 47152
local EVIL_SEER_CHANNEL_MIN = 4.4
local EVIL_SEER_CHANNEL_MAX = 5.2
local EVIL_SEER_AUTO_FACE_LEAD_MS = 200
local EVIL_SEER_AUTO_FACE_RELEASE_MS = 500
local EVIL_SEER_STATE_GRACE_MS = 1000
local EVIL_SEER_OVERLAP_SQ = 0.25
local EVIL_SEER_ACTIVATION_TIE_MS = 100

local EVIL_SEER_DEFAULTS = {
    Enable = true,
    AutoFacePetrifyingGaze = true,
}

local function getEvilSeerConfig(guide)
    return Common.getConfig(guide, 'EvilSeer', EVIL_SEER_DEFAULTS)
end

local function newEvilSeerState()
    return {
        gazes = {},
        pendingGazes = {},
        suppression = nil,
        faceLock = Common.newFaceLock(),
        seenChannels = {},
        seenCasts = {},
        lastDiagnostic = nil,
    }
end

local function ensureEvilSeerState(state)
    state = type(state) == 'table' and state or newEvilSeerState()
    state.faceLock = type(state.faceLock) == 'table'
            and state.faceLock or Common.newFaceLock()
    state.seenChannels = type(state.seenChannels) == 'table'
            and state.seenChannels or {}
    state.seenCasts = type(state.seenCasts) == 'table'
            and state.seenCasts or {}
    state.gazes = type(state.gazes) == 'table' and state.gazes or {}
    state.pendingGazes = type(state.pendingGazes) == 'table'
            and state.pendingGazes or {}
    if type(state.gaze) == 'table' and #state.gazes == 0 then
        state.gaze.spellID = state.gaze.spellID
                or EVIL_SEER_PETRIFYING_GAZE_AID
        state.gaze.expectedContentID = state.gaze.expectedContentID
                or EVIL_SEER_CONTENT_ID
        state.gazes[1] = state.gaze
    end
    state.gaze = nil
    state.suppression = type(state.suppression) == 'table'
            and state.suppression or nil
    return state
end

local function getEvilSeerState()
    local guide = rawget(_G, 'MuAiGuide')
    if type(guide) ~= 'table' then
        return nil
    end
    guide.EvilSeer = ensureEvilSeerState(guide.EvilSeer)
    return guide.EvilSeer
end

local function evilSeerDiagnostic(state, code, context, now)
    state.lastDiagnostic = {
        code = code,
        at = finite(now) and now or nowMs(),
        context = context,
    }
end

local function clearEvilSeerState(state)
    if type(state) ~= 'table' then
        return
    end
    Common.releaseAutoFace(state)
    state.gazes = {}
    state.pendingGazes = {}
    state.gaze = nil
    state.suppression = nil
    state.faceLock = Common.newFaceLock()
    state.seenChannels = {}
    state.seenCasts = {}
    state.lastDiagnostic = nil
end

local function evilSeerExpectedContentID(spellID)
    if spellID == EVIL_SEER_PETRIFYING_GAZE_AID then
        return EVIL_SEER_CONTENT_ID
    end
    if spellID == EVIL_SEER_CURSED_GAZE_AID then
        return EVIL_SEER_EYE_CONTENT_ID
    end
    return nil
end

local function resolveEvilSeer(entityID, expectedContentID, cache)
    local modelIDs = EVIL_SEER_MODEL_IDS[expectedContentID]
    local tensorCore = rawget(_G, 'TensorCore')
    if not finite(entityID)
            or entityID <= 0
            or type(modelIDs) ~= 'table'
            or type(tensorCore) ~= 'table'
            or type(tensorCore.entityList) ~= 'function'
    then
        return nil
    end
    cache = type(cache) == 'table' and cache or {}
    if cache[expectedContentID] == nil then
        cache[expectedContentID] = tensorCore.entityList(
                'contentid=' .. tostring(expectedContentID)) or false
    end
    local entities = cache[expectedContentID]
    if type(entities) ~= 'table' then
        return nil
    end
    local matches = {}
    for _, entity in pairs(entities) do
        local pos = type(entity) == 'table'
                and reliablePosition(entity.pos, false) or nil
        if type(entity) == 'table'
                and entity.id == entityID
                and entity.contentid == expectedContentID
                and modelIDs[Common.entityModelID(entity)] == true
                and entity.alive ~= false
                and pos ~= nil
        then
            matches[#matches + 1] = { entity = entity, source = pos }
        end
    end
    if #matches ~= 1 then
        return nil
    end
    return matches[1].entity, matches[1].source
end

local function sortEvilSeerGazes(gazes)
    table.sort(gazes, function(left, right)
        if left.activationAt ~= right.activationAt then
            return left.activationAt < right.activationAt
        end
        if left.entityID ~= right.entityID then
            return left.entityID < right.entityID
        end
        return left.spellID < right.spellID
    end)
end

local function latestEvilSeerExpiry(state)
    local expiresAt = nil
    for _, gaze in ipairs(state.gazes) do
        if finite(gaze.expiresAt) then
            expiresAt = expiresAt == nil
                    and gaze.expiresAt or math.max(expiresAt, gaze.expiresAt)
        end
    end
    for _, pending in ipairs(state.pendingGazes or {}) do
        if finite(pending.expiresAt) then
            expiresAt = expiresAt == nil
                    and pending.expiresAt or math.max(expiresAt, pending.expiresAt)
        end
    end
    return expiresAt
end

local function suppressEvilSeer(state, code, context, now, expiresAt)
    local batchExpiry = expiresAt or latestEvilSeerExpiry(state)
    if (#state.gazes == 0 and #state.pendingGazes == 0)
            or not finite(batchExpiry)
    then
        evilSeerDiagnostic(state, code, context, now)
        return false
    end
    Common.releaseAutoFace(state)
    state.suppression = state.suppression or {
        at = now,
        expiresAt = batchExpiry,
    }
    state.suppression.expiresAt = math.max(
            state.suppression.expiresAt or batchExpiry,
            batchExpiry)
    evilSeerDiagnostic(state, code, context, now)
    return true
end

local function resolvePendingEvilSeerGazes(state, now, cache)
    state = ensureEvilSeerState(state)
    cache = type(cache) == 'table' and cache or {}
    local resolved = false
    for index = #state.pendingGazes, 1, -1 do
        local pending = state.pendingGazes[index]
        local _, source = resolveEvilSeer(
                pending.entityID, pending.expectedContentID, cache)
        if source ~= nil then
            state.gazes[#state.gazes + 1] = {
                key = pending.key,
                entityID = pending.entityID,
                spellID = pending.spellID,
                expectedContentID = pending.expectedContentID,
                source = source,
                startedAt = pending.startedAt,
                activationAt = pending.activationAt,
                expiresAt = pending.expiresAt,
                missingSince = nil,
            }
            table.remove(state.pendingGazes, index)
            resolved = true
        elseif now >= pending.resolveBy then
            evilSeerDiagnostic(state, 'channel_invalid_entity', {
                entityID = pending.entityID,
                spellID = pending.spellID,
                expectedContentID = pending.expectedContentID,
            }, now)
            table.remove(state.pendingGazes, index)
        end
    end
    sortEvilSeerGazes(state.gazes)
    return resolved
end

local function recordEvilSeerGaze(
        state,
        entityID,
        spellID,
        channelTimeMax,
        now)
    local expectedContentID = evilSeerExpectedContentID(spellID)
    if expectedContentID == nil then
        return false
    end
    state = ensureEvilSeerState(state)
    if not finite(entityID)
            or entityID <= 0
            or not finite(channelTimeMax)
            or channelTimeMax < EVIL_SEER_CHANNEL_MIN
            or channelTimeMax > EVIL_SEER_CHANNEL_MAX
            or not finite(now)
    then
        suppressEvilSeer(state, 'channel_missing_geometry', {
            entityID = entityID,
            duration = channelTimeMax,
        }, now)
        return false
    end
    local eventKey = tostring(entityID) .. ':' .. tostring(spellID)
    if not Common.consumeEvent(state.seenChannels, eventKey, now, 350) then
        return false
    end
    local activationAt = now + channelTimeMax * 1000
    for _, existing in ipairs(state.gazes) do
        if existing.entityID == entityID
                and existing.spellID == spellID
                and math.abs(existing.activationAt - activationAt) <= 350
        then
            return false
        end
        if existing.entityID == entityID
                and existing.spellID == spellID
        then
            suppressEvilSeer(state, 'channel_identity_conflict', {
                entityID = entityID,
                spellID = spellID,
                expectedActivationAt = existing.activationAt,
                actualActivationAt = activationAt,
            }, now, math.max(existing.expiresAt,
                    activationAt + EVIL_SEER_STATE_GRACE_MS))
            return false
        end
    end
    for _, pending in ipairs(state.pendingGazes) do
        if pending.entityID == entityID and pending.spellID == spellID
                and math.abs(pending.activationAt - activationAt) <= 350
        then
            return false
        end
        if pending.entityID == entityID and pending.spellID == spellID then
            suppressEvilSeer(state, 'channel_identity_conflict', {
                entityID = entityID,
                spellID = spellID,
                expectedActivationAt = pending.activationAt,
                actualActivationAt = activationAt,
            }, now, math.max(pending.expiresAt,
                    activationAt + EVIL_SEER_STATE_GRACE_MS))
            return false
        end
    end
    state.pendingGazes[#state.pendingGazes + 1] = {
        key = eventKey .. ':' .. tostring(math.floor(activationAt / 100)),
        entityID = entityID,
        spellID = spellID,
        expectedContentID = expectedContentID,
        startedAt = now,
        activationAt = activationAt,
        expiresAt = activationAt + EVIL_SEER_STATE_GRACE_MS,
        resolveBy = activationAt - EVIL_SEER_AUTO_FACE_LEAD_MS,
    }
    local cache = {}
    resolvePendingEvilSeerGazes(state, now, cache)
    if state.suppression ~= nil then
        state.suppression.expiresAt = math.max(
                state.suppression.expiresAt or 0,
                activationAt + EVIL_SEER_STATE_GRACE_MS)
    end
    return true
end

local function evilSeerFacingHeading(playerPos, source)
    if type(playerPos) ~= 'table'
            or type(source) ~= 'table'
            or not finite(playerPos.x)
            or not finite(playerPos.y)
            or not finite(playerPos.z)
            or not finite(source.x)
            or not finite(source.z)
    then
        return nil
    end
    local dx = playerPos.x - source.x
    local dz = playerPos.z - source.z
    if dx * dx + dz * dz <= EVIL_SEER_OVERLAP_SQ then
        return nil
    end
    return math.atan2(dx, dz)
end

local function pruneEvilSeerState(state, now)
    state = ensureEvilSeerState(state)
    Common.pruneSeen(state.seenChannels, now, 10000)
    Common.pruneSeen(state.seenCasts, now, 10000)
    resolvePendingEvilSeerGazes(state, now)
    for index = #state.gazes, 1, -1 do
        local gaze = state.gazes[index]
        local remove = not finite(gaze.expiresAt) or now > gaze.expiresAt
        if not remove then
            local entity, source = resolveEvilSeer(
                    gaze.entityID, gaze.expectedContentID, cache)
            if entity ~= nil then
                gaze.missingSince = nil
                gaze.source = source
            else
                gaze.source = nil
                gaze.missingSince = gaze.missingSince or now
                Common.releaseAutoFace(state, gaze.key)
                remove = now - gaze.missingSince >= 2000
            end
        end
        if remove then
            Common.releaseAutoFace(state, gaze.key)
            table.remove(state.gazes, index)
        end
    end
    sortEvilSeerGazes(state.gazes)
    if #state.gazes == 0 and #state.pendingGazes == 0 then
        Common.releaseAutoFace(state)
        state.suppression = nil
        return
    end
    if type(state.suppression) == 'table'
            and finite(state.suppression.expiresAt)
            and now > state.suppression.expiresAt
    then
        state.suppression = nil
    end
end

local function resolveEvilSeerGaze(state, entityID, spellID, now)
    if evilSeerExpectedContentID(spellID) == nil then
        return false
    end
    state = ensureEvilSeerState(state)
    local eventKey = tostring(entityID) .. ':' .. tostring(spellID)
    if not Common.consumeEvent(state.seenCasts, eventKey, now, 350) then
        return false
    end
    local pendingIndex = nil
    for index, pending in ipairs(state.pendingGazes) do
        if pending.entityID == entityID and pending.spellID == spellID then
            if pendingIndex ~= nil then
                suppressEvilSeer(state, 'cast_identity_conflict', {
                    actualEntityID = entityID,
                    actualSpellID = spellID,
                    matches = 2,
                }, now)
                return false
            end
            pendingIndex = index
        end
    end
    if pendingIndex ~= nil then
        table.remove(state.pendingGazes, pendingIndex)
        if #state.gazes == 0 then
            state.suppression = nil
        end
        return true
    end
    if #state.gazes == 0 then
        return false
    end
    local matchIndex = nil
    local matches = 0
    for index, gaze in ipairs(state.gazes) do
        if gaze.entityID == entityID and gaze.spellID == spellID then
            matches = matches + 1
            matchIndex = index
        end
    end
    if matches ~= 1 then
        local expected = state.gazes[1]
        suppressEvilSeer(state, 'cast_identity_conflict', {
            expectedEntityID = expected.entityID,
            expectedSpellID = expected.spellID,
            actualEntityID = entityID,
            actualSpellID = spellID,
            matches = matches,
        }, now)
        return false
    end
    local gaze = state.gazes[matchIndex]
    Common.releaseAutoFace(state, gaze.key)
    table.remove(state.gazes, matchIndex)
    if #state.gazes == 0 then
        state.suppression = nil
    end
    return true
end

local function nextEvilSeerGaze(state, now)
    local first = state.gazes[1]
    local second = state.gazes[2]
    if type(first) ~= 'table' then
        return nil
    end
    if type(second) == 'table'
            and math.abs(first.activationAt - second.activationAt)
                    <= EVIL_SEER_ACTIVATION_TIE_MS
    then
        local dx = first.source.x - second.source.x
        local dz = first.source.z - second.source.z
        if first.spellID ~= second.spellID
                or dx * dx + dz * dz > EVIL_SEER_OVERLAP_SQ
        then
            suppressEvilSeer(state, 'activation_source_ambiguous', {
                firstEntityID = first.entityID,
                firstSpellID = first.spellID,
                secondEntityID = second.entityID,
                secondSpellID = second.spellID,
            }, now)
            return nil
        end
    end
    return first
end

local function updateEvilSeerAutoFace(state, guide, cfg, now)
    state = ensureEvilSeerState(state)
    pruneEvilSeerState(state, now)
    local gaze = nextEvilSeerGaze(state, now)
    if cfg.Enable ~= true
            or cfg.AutoFacePetrifyingGaze ~= true
            or type(gaze) ~= 'table'
            or state.suppression ~= nil
            or now < gaze.activationAt - EVIL_SEER_AUTO_FACE_LEAD_MS
            or now > gaze.activationAt + EVIL_SEER_AUTO_FACE_RELEASE_MS
    then
        Common.releaseAutoFace(state)
        return false
    end
    local player = type(guide) == 'table'
            and type(guide.GetPlayer) == 'function'
            and guide.GetPlayer() or nil
    local heading = evilSeerFacingHeading(
            type(player) == 'table' and player.pos or nil,
            gaze.source)
    if heading == nil then
        Common.releaseAutoFace(state)
        return false
    end
    local applied = Common.applyAutoFace(
            state,
            gaze.key,
            heading,
            now,
            gaze.activationAt + EVIL_SEER_AUTO_FACE_RELEASE_MS)
    if not applied then
        Common.releaseAutoFace(state)
    end
    return applied
end

local Feature = {}

Feature.Init = function(M)
    if type(M.EvilSeer) == 'table' then
        clearEvilSeerState(M.EvilSeer)
    end
    M.EvilSeer = newEvilSeerState()
    getEvilSeerConfig(M)
    M.SetEvilSeerEnabled = function(enabled)
        local cfg = getEvilSeerConfig(M)
        if cfg ~= nil then
            cfg.Enable = enabled == true
        end
        if enabled ~= true then
            clearEvilSeerState(M.EvilSeer)
        end
    end
    M.SetEvilSeerAutoFaceEnabled = function(enabled)
        local cfg = getEvilSeerConfig(M)
        if cfg ~= nil then
            cfg.AutoFacePetrifyingGaze = enabled == true
        end
        if enabled ~= true then
            Common.releaseAutoFace(ensureEvilSeerState(M.EvilSeer))
        end
    end
end

Feature.Clear = function()
    local state = getEvilSeerState()
    if state ~= nil then
        clearEvilSeerState(state)
    end
end

Feature.OnEntityChannel = function(entityID, spellID, channelTimeMax, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getEvilSeerConfig(guide)
    local state = getEvilSeerState()
    if state ~= nil and cfg ~= nil and cfg.Enable == true then
        recordEvilSeerGaze(state, entityID, spellID, channelTimeMax, now)
    end
end

Feature.OnEntityCast = function(entityID, spellID, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getEvilSeerConfig(guide)
    local state = getEvilSeerState()
    if state ~= nil and cfg ~= nil and cfg.Enable == true then
        resolveEvilSeerGaze(state, entityID, spellID, now)
    end
end

Feature.Update = function(guide, now)
    local state = getEvilSeerState()
    if state == nil then
        return false
    end
    local cfg = getEvilSeerConfig(guide)
    if cfg ~= nil and cfg.Enable == true then
        return updateEvilSeerAutoFace(state, guide, cfg, now)
    end
    clearEvilSeerState(state)
    return false
end

Feature.Test = {
    MapID = Context.MapID,
    ContentID = EVIL_SEER_CONTENT_ID,
    EyeContentID = EVIL_SEER_EYE_CONTENT_ID,
    PetrifyingGazeAID = EVIL_SEER_PETRIFYING_GAZE_AID,
    CursedGazeAID = EVIL_SEER_CURSED_GAZE_AID,
    ChannelMin = EVIL_SEER_CHANNEL_MIN,
    ChannelMax = EVIL_SEER_CHANNEL_MAX,
    AutoFaceLeadMs = EVIL_SEER_AUTO_FACE_LEAD_MS,
    AutoFaceReleaseMs = EVIL_SEER_AUTO_FACE_RELEASE_MS,
    ActivationTieMs = EVIL_SEER_ACTIVATION_TIE_MS,
    Defaults = EVIL_SEER_DEFAULTS,
    NewState = newEvilSeerState,
    ClearState = clearEvilSeerState,
    RecordGaze = recordEvilSeerGaze,
    ResolveGaze = resolveEvilSeerGaze,
    PruneState = pruneEvilSeerState,
    NextGaze = nextEvilSeerGaze,
    FacingHeading = evilSeerFacingHeading,
    UpdateAutoFace = updateEvilSeerAutoFace,
    ResolvePendingGazes = resolvePendingEvilSeerGazes,
}

    return Feature
end

rawset(_G, 'MuAiOccultCrescentNorthEvilSeer', Module)
return Module
