local Module = {}

function Module.Create(Context)
    assert(type(Context) == 'table' and type(Context.Common) == 'table')
    local Common = Context.Common
    local nowMs = Context.nowMs
    local finite = Context.finite
    local reliablePosition = Context.reliablePosition
    local resolveEntity = Context.resolveEntity
local MAP_ID = 1346
local BOSS_CONTENT_ID = 14714
local CLONE_CONTENT_ID = 14715
local BOSS_MODEL_ID = 19855
local CLONE_MODEL_ID = 19856
local INSTRUCTION_EVENT_OBJECT_ID = 2015274
local INSTRUCTION_EVENT_OBJECT_MODEL_ID = 2015274
local ARENA_CENTER = { x = 807, z = -562 }
local ARENA_RADIUS = 20
local GUIDE_ARENA_RADIUS = 19
local CLONE_MAX_RADIUS = 21

local AID = {
    DeathRouletteCast = 49787,
    DeathRouletteCenter = 49788,
    DeathRouletteInner = 49789,
    DeathRouletteOuter = 49790,
    Instruction = 49773,
    InstructionReverse = 49774,
    ReversePolarity = 49775,
    BadBreath = 49777,
    Plaincracker = 49779,
    DemoBadBreath = 50491,
    DemoPlaincracker = 50493,
    LilliputianLyric = 49792,
    MagicHammer = 49794,
    OccultMissile = 49797,
}

local INSTRUCTION_TETHER = 14
local REVERSE_TETHER = 207
local INSTRUCTION_OBJECT_MATCH_DISTANCE_SQ = 0.25
local BAD_BREATH_RANGE = 50
local BAD_BREATH_ANGLE = math.rad(100)
local PLAINCRACKER_RADIUS = 30
local DIRECT_DELAYS = { 6125, 10687, 15156, 19656 }
local REVERSE_DELAYS = { 12750, 17250, 21750, 26250 }
local ROUND_TIMEOUT_MS = 32000
local LIVE_AOE_GRACE_MS = 1500
local GUIDE_GROUP_WINDOW_MS = 300
local GUIDE_LOOKAHEAD_GROUPS = 2
local BOSS_MISSING_CLEAR_MS = 2000
local MATCH_DISTANCE_SQ = 2.25
local SEEN_TTL_MS = 45000
local ROULETTE_CENTER_RADIUS = 5
local ROULETTE_INNER_RADIUS = 12
local ROULETTE_OUTER_RADIUS = 20
local ROULETTE_SECTOR_ANGLE = 2 * math.pi / 3
local ROULETTE_SAFE_RADIUS =
        (ROULETTE_CENTER_RADIUS + ROULETTE_INNER_RADIUS) / 2
local ROULETTE_ACTIVATION_DELAY_MS = 18400
local ROULETTE_TIMEOUT_MS = 21500
local ROULETTE_CENTER_TOLERANCE_SQ = 0.25
local ROULETTE_GROUND_INNER_ID = 2015275
local ROULETTE_GROUND_OUTER_ID = 2015276
local ROULETTE_GROUND_HEADING_EPSILON = math.rad(1)
local ROULETTE_INNER_OFFSET_BY_STATE = {
    [16] = 0,
    [32] = -2 * math.pi / 3,
}
local ROULETTE_OUTER_OFFSET_BY_STATE = {
    [16] = -math.pi / 4,
    [32] = math.pi / 2,
}

local LIVE_AOE = {
    [AID.DemoBadBreath] = {
        kind = 'cone', radius = 50, angle = math.rad(100),
    },
    [AID.DemoPlaincracker] = { kind = 'circle', radius = 15 },
    [AID.BadBreath] = {
        kind = 'cone', radius = 50, angle = math.rad(100),
    },
    [AID.Plaincracker] = { kind = 'circle', radius = 30 },
    [AID.LilliputianLyric] = {
        kind = 'cone', radius = 40, angle = math.pi,
    },
    [AID.MagicHammer] = { kind = 'circle', radius = 8 },
    [AID.OccultMissile] = { kind = 'circle', radius = 6 },
}

local DEFAULTS = {
    Enable = true,
    DrawInstructionPrediction = true,
    DynamicGuide = true,
    RouletteGuide = true,
}

local function strictEntity(
        entityID, contentID, modelID, requireHeading, cache)
    local tensorCore = rawget(_G, 'TensorCore')
    if not finite(entityID)
            or type(tensorCore) ~= 'table'
            or type(tensorCore.entityList) ~= 'function'
    then
        return nil
    end
    cache = type(cache) == 'table' and cache or {}
    if cache[contentID] == nil then
        cache[contentID] = tensorCore.entityList(
                'contentid=' .. tostring(contentID)) or false
    end
    local entities = cache[contentID]
    if type(entities) ~= 'table' then
        return nil
    end
    local entity = nil
    for _, candidate in pairs(entities) do
        if type(candidate) == 'table'
                and candidate.id == entityID
                and candidate.contentid == contentID
                and candidate.modelid == modelID
                and candidate.alive ~= false
        then
            if entity ~= nil then
                return nil
            end
            entity = candidate
        end
    end
    if entity == nil then
        return nil
    end
    local pos = reliablePosition(entity.pos, requireHeading)
    if pos == nil or not Common.insideCircle(
            pos, ARENA_CENTER, CLONE_MAX_RADIUS)
    then
        return nil
    end
    return pos
end

local function getConfig(guide)
    return Common.getConfig(guide, 'Pallmagia', DEFAULTS)
end

local function newState()
    return {
        round = nil,
        liveAOEs = {},
        seenAOEs = {},
        seenCasts = {},
        bossEntityID = nil,
        bossMissingSince = nil,
        guideSuppressedUntil = nil,
        guideTarget = nil,
        roulette = nil,
        lastDiagnostic = nil,
    }
end

local function ensureState(state)
    state = type(state) == 'table' and state or newState()
    state.liveAOEs = type(state.liveAOEs) == 'table'
            and state.liveAOEs or {}
    state.seenAOEs = type(state.seenAOEs) == 'table'
            and state.seenAOEs or {}
    state.seenCasts = type(state.seenCasts) == 'table'
            and state.seenCasts or {}
    return state
end

local function getState()
    local guide = rawget(_G, 'MuAiGuide')
    if type(guide) ~= 'table' then
        return nil
    end
    guide.Pallmagia = ensureState(guide.Pallmagia)
    return guide.Pallmagia
end

local function diagnostic(state, code, context)
    state.lastDiagnostic = {
        code = code,
        at = nowMs(),
        context = context,
    }
end

local function clearToken(entry)
    if type(entry) == 'table' then
        Common.deleteTimedShape(entry.token)
        entry.token = nil
    end
end

local function clearRound(state)
    if type(state.round) == 'table'
            and type(state.round.predictions) == 'table'
    then
        for _, entry in ipairs(state.round.predictions) do
            clearToken(entry)
        end
    end
    state.round = nil
    state.guideTarget = nil
end

local function clearState(state)
    if type(state) ~= 'table' then
        return
    end
    clearRound(state)
    state.liveAOEs = {}
    state.seenAOEs = {}
    state.seenCasts = {}
    state.bossEntityID = nil
    state.bossMissingSince = nil
    state.guideSuppressedUntil = nil
    state.guideTarget = nil
    state.roulette = nil
    state.lastDiagnostic = nil
end

local function setRoundAmbiguity(state, code, context)
    local round = state.round
    if type(round) == 'table' then
        round.ambiguity = true
        state.guideTarget = nil
        if type(round.predictions) == 'table' then
            for _, entry in ipairs(round.predictions) do
                clearToken(entry)
            end
        end
    end
    diagnostic(state, code, context)
end

local function startInstructionRound(state, entityID, spellID, duration, now)
    if spellID ~= AID.Instruction
            and spellID ~= AID.InstructionReverse
    then
        return false
    end
    if not finite(duration) or duration < 10 or duration > 15 then
        diagnostic(state, 'instruction_invalid_duration', duration)
        return false
    end
    if not finite(entityID) or entityID <= 0 then
        diagnostic(state, 'instruction_invalid_boss', entityID)
        return false
    end
    clearRound(state)
    state.bossEntityID = entityID
    state.bossMissingSince = nil
    state.round = {
        bossEntityID = entityID,
        spellID = spellID,
        reverse = spellID == AID.InstructionReverse,
        startedAt = now,
        expectedFinishAt = now + duration * 1000,
        expiresAt = now + ROUND_TIMEOUT_MS,
        clones = {},
        clonesByID = {},
        eventObjects = {},
        pendingCloneIDs = {},
        pendingCloneOrder = {},
        pendingCloneCount = 0,
        pendingInstructionKinds = {},
        pendingSwaps = {},
        swaps = {},
        predictions = {},
        ambiguity = false,
    }
    return true
end

local function sameClone(left, right)
    return Common.distanceSquared(left, right) <= 0.04
            and Common.headingDifference(left.h, right.h) <= 0.02
end

local resolveInstructionRound

local function collectInstructionClone(state, sourceID, targetID)
    local round = state.round
    if type(round) ~= 'table' or targetID ~= round.bossEntityID
            or not finite(sourceID) or sourceID <= 0
    then
        return false
    end
    local previous = round.clonesByID[sourceID]
    if previous ~= nil then
        local pos = strictEntity(
                sourceID, CLONE_CONTENT_ID, CLONE_MODEL_ID, true)
        if pos ~= nil and not sameClone(previous.pos, pos) then
            setRoundAmbiguity(state, 'instruction_clone_conflict', sourceID)
        end
        return false
    end
    if round.pendingCloneIDs[sourceID] ~= nil then
        return false
    end
    if #round.clones + round.pendingCloneCount >= 4 then
        setRoundAmbiguity(state, 'instruction_too_many_clones', sourceID)
        return false
    end
    round.pendingCloneIDs[sourceID] = true
    round.pendingCloneOrder[#round.pendingCloneOrder + 1] = sourceID
    round.pendingCloneCount = round.pendingCloneCount + 1
    resolveInstructionRound(state)
    return true
end

local function collectReversePair(state, sourceID, targetID)
    local round = state.round
    if type(round) ~= 'table' or not round.reverse then
        return false
    end
    if not finite(sourceID) or not finite(targetID) or sourceID == targetID then
        setRoundAmbiguity(state, 'reverse_unknown_pair', {
            sourceID = sourceID, targetID = targetID,
        })
        return false
    end
    if round.pendingSwaps[sourceID] ~= nil
            and round.pendingSwaps[sourceID] ~= targetID
    then
        setRoundAmbiguity(state, 'reverse_pair_conflict', {
            sourceID = sourceID, targetID = targetID,
        })
        return false
    end
    round.pendingSwaps[sourceID] = targetID
    round.pendingSwaps[targetID] = sourceID
    resolveInstructionRound(state)
    return true
end

local function instructionKindFromScript(a1, a2, a3)
    a1, a2, a3 = tonumber(a1), tonumber(a2), tonumber(a3)
    if a3 ~= 0 then
        return nil
    end
    if (a1 == 1 and a2 == 2) or (a1 == 4 and a2 == 8) then
        return 'cone'
    end
    if (a1 == 16 and a2 == 32) or (a1 == 4 and a2 == 64) then
        return 'circle'
    end
    return nil
end

local function instructionEventObjectPosition(entityID)
    local entity = resolveEntity(entityID)
    if type(entity) ~= 'table'
            or entity.id ~= entityID
            or entity.contentid ~= INSTRUCTION_EVENT_OBJECT_ID
            or entity.modelid ~= INSTRUCTION_EVENT_OBJECT_MODEL_ID
            or entity.alive == false
    then
        return nil
    end
    return reliablePosition(entity.pos, true)
end

local function recordInstructionKind(state, entityID, a1, a2, a3)
    local round = state.round
    local kind = instructionKindFromScript(a1, a2, a3)
    if type(round) ~= 'table' or kind == nil then
        return false
    end
    local clone = round.eventObjects[entityID]
    if clone == nil then
        if #round.clones < 4 then
            round.pendingInstructionKinds[entityID] = {
                a1 = a1, a2 = a2, a3 = a3,
            }
            return false
        end
        local eventObjectPos = instructionEventObjectPosition(entityID)
        if eventObjectPos == nil then
            round.pendingInstructionKinds[entityID] = {
                a1 = a1, a2 = a2, a3 = a3,
            }
            return false
        end
        if not Common.insideCircle(
                eventObjectPos, ARENA_CENTER, CLONE_MAX_RADIUS)
        then
            setRoundAmbiguity(
                    state, 'instruction_event_object_invalid', entityID)
            return false
        end
        local matches = {}
        for _, candidate in ipairs(round.clones) do
            if Common.distanceSquared(eventObjectPos, candidate.pos)
                    <= INSTRUCTION_OBJECT_MATCH_DISTANCE_SQ
            then
                matches[#matches + 1] = candidate
            end
        end
        if #matches ~= 1 then
            setRoundAmbiguity(state, 'instruction_event_object_ambiguous', {
                entityID = entityID,
                matches = #matches,
            })
            return false
        end
        clone = matches[1]
        if clone.eventObjectID ~= nil and clone.eventObjectID ~= entityID then
            setRoundAmbiguity(state, 'instruction_event_object_conflict', {
                cloneID = clone.entityID,
                previous = clone.eventObjectID,
                incoming = entityID,
            })
            return false
        end
        clone.eventObjectID = entityID
        round.eventObjects[entityID] = clone
    end
    if clone.kind ~= nil then
        if clone.kind ~= kind then
            setRoundAmbiguity(state, 'instruction_kind_conflict', {
                cloneID = clone.entityID,
                previous = clone.kind,
                incoming = kind,
            })
        end
        return false
    end
    clone.kind = kind
    return true
end

resolveInstructionRound = function(state, cache)
    local round = state.round
    if type(round) ~= 'table' or round.ambiguity then
        return false
    end
    cache = type(cache) == 'table' and cache or {}
    if strictEntity(
            round.bossEntityID,
            BOSS_CONTENT_ID,
            BOSS_MODEL_ID,
            false,
            cache)
            == nil
    then
        return false
    end
    for _, entityID in ipairs(round.pendingCloneOrder) do
        if round.pendingCloneIDs[entityID] then
            local pos = strictEntity(
                    entityID,
                    CLONE_CONTENT_ID,
                    CLONE_MODEL_ID,
                    true,
                    cache)
            if pos ~= nil then
                if #round.clones >= 4 then
                    setRoundAmbiguity(state, 'instruction_too_many_clones', entityID)
                    return false
                end
                local clone = {
                    entityID = entityID,
                    pos = pos,
                    order = #round.clones + 1,
                }
                round.clones[#round.clones + 1] = clone
                round.clonesByID[entityID] = clone
                round.pendingCloneIDs[entityID] = nil
                round.pendingCloneCount = round.pendingCloneCount - 1
            end
        end
    end
    for sourceID, targetID in pairs(round.pendingSwaps) do
        if round.clonesByID[sourceID] ~= nil
                and round.clonesByID[targetID] ~= nil
        then
            local old = round.swaps[sourceID]
            if old ~= nil and old ~= targetID then
                setRoundAmbiguity(state, 'reverse_pair_conflict', {
                    sourceID = sourceID, targetID = targetID,
                })
                return false
            end
            round.swaps[sourceID] = targetID
        end
    end
    if #round.clones == 4 then
        local pending = {}
        for entityID, args in pairs(round.pendingInstructionKinds) do
            pending[#pending + 1] = {
                entityID = entityID, a1 = args.a1, a2 = args.a2, a3 = args.a3,
            }
        end
        for _, args in ipairs(pending) do
            if recordInstructionKind(
                    state,
                    args.entityID,
                    args.a1, args.a2, args.a3)
            then
                round.pendingInstructionKinds[args.entityID] = nil
            end
        end
    end
    return true
end

local function drawPrediction(entry, now)
    local drawer = Common.getMoogleDrawer()
    local timeout = entry.activationAt - now
    if drawer == nil or timeout <= 0 then
        return false
    end
    local token = nil
    if entry.kind == 'cone' and type(drawer.addTimedCone) == 'function' then
        token = drawer:addTimedCone(
                timeout,
                entry.source.x,
                entry.source.y,
                entry.source.z,
                entry.radius,
                entry.angle,
                entry.heading)
    elseif entry.kind == 'circle'
            and type(drawer.addTimedCircle) == 'function'
    then
        token = drawer:addTimedCircle(
                timeout,
                entry.source.x,
                entry.source.y,
                entry.source.z,
                entry.radius)
    end
    if type(token) == 'string' then
        entry.token = token
        return true
    end
    return false
end

local function nextPendingPrediction(round)
    for _, entry in ipairs(round.predictions or {}) do
        if not entry.resolved then
            return entry
        end
    end
    return nil
end

local function scheduleNextPrediction(state, now, guide)
    local round = state.round
    local cfg = getConfig(guide)
    if type(round) ~= 'table'
            or not round.finalized
            or round.ambiguity
            or type(cfg) ~= 'table'
            or cfg.DrawInstructionPrediction ~= true
    then
        return false
    end
    local entry = nextPendingPrediction(round)
    if entry == nil or entry.handedOff or entry.token ~= nil then
        return false
    end
    return drawPrediction(entry, now)
end

local function finalizeRound(state, now, guide)
    local round = state.round
    if type(round) ~= 'table'
            or round.finalized
            or round.ambiguity
            or not finite(round.learnFinishedAt)
            or #round.clones ~= 4
    then
        return false
    end
    if round.reverse then
        for _, clone in ipairs(round.clones) do
            if round.swaps[clone.entityID] == nil then
                return false
            end
        end
    end

    local delays = round.reverse and REVERSE_DELAYS or DIRECT_DELAYS
    for index, clone in ipairs(round.clones) do
        local destination = clone
        if round.reverse then
            destination = round.clonesByID[round.swaps[clone.entityID]]
        end
        if type(destination) ~= 'table'
                or reliablePosition(destination.pos, true) == nil
        then
            setRoundAmbiguity(state, 'prediction_missing_destination', index)
            return false
        end
        if clone.kind ~= 'cone' and clone.kind ~= 'circle' then
            return false
        end
        local isCone = clone.kind == 'cone'
        round.predictions[index] = {
            order = index,
            cloneID = clone.entityID,
            destinationID = destination.entityID,
            kind = isCone and 'cone' or 'circle',
            source = {
                x = destination.pos.x,
                y = destination.pos.y,
                z = destination.pos.z,
            },
            heading = destination.pos.h,
            radius = isCone and BAD_BREATH_RANGE or PLAINCRACKER_RADIUS,
            angle = isCone and BAD_BREATH_ANGLE or nil,
            activationAt = round.learnFinishedAt + delays[index],
        }
    end
    round.finalized = true
    round.expiresAt = round.predictions[4].activationAt + LIVE_AOE_GRACE_MS
    scheduleNextPrediction(state, now, guide)
    return true
end

local function finishInstruction(state, entityID, spellID, now, guide)
    local round = state.round
    if type(round) ~= 'table'
            or (spellID ~= AID.Instruction
                    and spellID ~= AID.InstructionReverse)
    then
        return false
    end
    if entityID ~= round.bossEntityID or spellID ~= round.spellID then
        setRoundAmbiguity(state, 'instruction_finish_conflict', {
            expectedEntityID = round.bossEntityID,
            actualEntityID = entityID,
            expectedSpellID = round.spellID,
            actualSpellID = spellID,
        })
        return false
    end
    round.learnFinishedAt = now
    resolveInstructionRound(state)
    return finalizeRound(state, now, guide)
end

local function predictionForEvent(round, entityID, kind, pos)
    local matches = {}
    for _, entry in ipairs(round.predictions or {}) do
        if not entry.resolved and entry.kind == kind then
            local exactEntity = entityID == entry.cloneID
            local near = pos ~= nil
                    and Common.distanceSquared(pos, entry.source)
                            <= MATCH_DISTANCE_SQ
            if exactEntity or near then
                matches[#matches + 1] = entry
            end
        end
    end
    if #matches == 1 then
        return matches[1]
    end
    return nil, #matches
end

local function eventPosition(entityID, castPos)
    return reliablePosition(castPos, false)
end

local function removeLiveAOE(state, key)
    if type(key) ~= 'string' then
        return false
    end
    for index = #state.liveAOEs, 1, -1 do
        local aoe = state.liveAOEs[index]
        if aoe.key == key then
            state.seenAOEs[key] = nil
            table.remove(state.liveAOEs, index)
            return true
        end
    end
    state.seenAOEs[key] = nil
    return false
end

local function resolvePrediction(state, entityID, spellID, castPos, now, guide)
    local round = state.round
    if type(round) ~= 'table' or not round.finalized or round.ambiguity then
        return false
    end
    local kind = spellID == AID.BadBreath and 'cone'
            or (spellID == AID.Plaincracker and 'circle' or nil)
    if kind == nil then
        return false
    end
    local key = tostring(entityID) .. ':' .. tostring(spellID)
            .. ':' .. tostring(math.floor(now / 100))
    if not Common.consumeEvent(state.seenCasts, key, now, 350) then
        return false
    end
    local entry, count = predictionForEvent(
            round, entityID, kind, eventPosition(entityID, castPos))
    if entry == nil then
        setRoundAmbiguity(state, 'prediction_resolution_ambiguous', {
            entityID = entityID, spellID = spellID, matches = count,
        })
        return false
    end
    clearToken(entry)
    removeLiveAOE(state, entry.liveAOEKey)
    entry.liveAOEKey = nil
    entry.resolved = true
    local remaining = false
    for _, candidate in ipairs(round.predictions) do
        if not candidate.resolved then
            remaining = true
            break
        end
    end
    if not remaining then
        clearRound(state)
    else
        scheduleNextPrediction(state, now, guide)
    end
    return true
end

local function aoeKey(aoeInfo)
    if type(aoeInfo.entityID) ~= 'number'
            or not finite(aoeInfo.startTime)
    then
        return nil
    end
    return tostring(aoeInfo.entityID) .. ':' .. tostring(aoeInfo.aoeID)
            .. ':' .. tostring(math.floor(aoeInfo.startTime / 20))
end

local function handoffPrediction(state, aoe)
    local round = state.round
    if type(round) ~= 'table' or not round.finalized or round.ambiguity then
        return
    end
    local entry = predictionForEvent(round, aoe.entityID, aoe.kind, aoe.source)
    if entry ~= nil then
        if entry.liveAOEKey ~= nil and entry.liveAOEKey ~= aoe.key then
            setRoundAmbiguity(state, 'prediction_handoff_conflict', {
                previous = entry.liveAOEKey,
                incoming = aoe.key,
            })
            return
        end
        clearToken(entry)
        entry.handedOff = true
        entry.liveAOEKey = aoe.key
        aoe.activationAt = entry.activationAt
        aoe.expiresAt = entry.activationAt + LIVE_AOE_GRACE_MS
    end
end

local function addLiveAOE(state, aoeInfo, now)
    local spec = type(aoeInfo) == 'table' and LIVE_AOE[aoeInfo.aoeID] or nil
    if spec == nil then
        return false
    end
    local key = aoeKey(aoeInfo)
    local source = reliablePosition({
        x = aoeInfo.x, y = aoeInfo.y, z = aoeInfo.z,
    }, false)
    if key == nil
            or source == nil
            or not finite(aoeInfo.duration)
            or aoeInfo.duration <= 0
            or aoeInfo.duration > 10
            or (spec.kind == 'cone' and not finite(aoeInfo.heading))
    then
        state.guideSuppressedUntil = now + 10000
        diagnostic(state, 'live_aoe_missing_geometry', aoeInfo.aoeID)
        return false
    end
    local existing = state.seenAOEs[key]
    if existing ~= nil then
        local conflict = existing.kind ~= spec.kind
                or Common.distanceSquared(existing.source, source) > 0.04
                or (spec.kind == 'cone'
                        and Common.headingDifference(
                                existing.heading, aoeInfo.heading) > 0.02)
        if conflict then
            state.guideSuppressedUntil = math.max(
                    state.guideSuppressedUntil or 0,
                    now + 10000)
            diagnostic(state, 'live_aoe_conflict', key)
        end
        return false
    end
    local activationAt = aoeInfo.startTime + aoeInfo.duration * 1000
    local aoe = {
        key = key,
        entityID = aoeInfo.entityID,
        spellID = aoeInfo.aoeID,
        kind = spec.kind,
        source = source,
        heading = aoeInfo.heading,
        radius = spec.radius,
        angle = spec.angle,
        activationAt = activationAt,
        expiresAt = activationAt + LIVE_AOE_GRACE_MS,
    }
    state.seenAOEs[key] = aoe
    state.liveAOEs[#state.liveAOEs + 1] = aoe
    handoffPrediction(state, aoe)
    return true
end

local function startRoulette(state, entityID, channelTimeMax, now)
    if not finite(entityID)
            or not finite(channelTimeMax)
            or channelTimeMax < 3
            or channelTimeMax > 5
    then
        diagnostic(state, 'roulette_invalid_start', {
            entityID = entityID, channelTimeMax = channelTimeMax,
        })
        return false
    end
    local key = 'roulette:' .. tostring(entityID)
            .. ':' .. tostring(math.floor(now / 500))
    if not Common.consumeEvent(state.seenCasts, key, now, 1000) then
        return false
    end
    state.bossEntityID = nil
    state.bossMissingSince = nil
    state.roulette = {
        bossEntityID = entityID,
        startedAt = now,
        visualEndsAt = now + channelTimeMax * 1000,
        activationAt = now + ROULETTE_ACTIVATION_DELAY_MS,
        expiresAt = now + ROULETTE_TIMEOUT_MS,
        effects = {},
        ready = false,
    }
    state.guideTarget = nil
    return true
end

local function recordRouletteGroundEffect(
        state,
        entityID,
        effectType,
        flags,
        keyID,
        radius,
        heading,
        stateValue,
        x,
        y,
        z,
        now)
    local roulette = state.roulette
    keyID = tonumber(keyID)
    if type(roulette) ~= 'table'
            or (keyID ~= ROULETTE_GROUND_INNER_ID
                    and keyID ~= ROULETTE_GROUND_OUTER_ID)
    then
        return false
    end
    local pos = reliablePosition({ x = x, y = y, z = z }, false)
    if not finite(tonumber(entityID))
            or tonumber(effectType) ~= 7
            or tonumber(flags) ~= 5
            or tonumber(stateValue) ~= 4
            or not finite(radius)
            or radius < 0.5
            or radius > 1.5
            or not finite(heading)
            or pos == nil
            or Common.distanceSquared(pos, ARENA_CENTER)
                    > ROULETTE_CENTER_TOLERANCE_SQ
    then
        roulette.suppressed = true
        roulette.ready = false
        diagnostic(state, 'roulette_ground_effect_invalid', keyID)
        return false
    end
    local incoming = {
        entityID = tonumber(entityID),
        pos = pos,
        heading = heading,
    }
    local existing = roulette.effects[keyID]
    if existing ~= nil then
        local conflict = existing.entityID ~= incoming.entityID
                or Common.distanceSquared(existing.pos, incoming.pos) > 0.04
                or Common.headingDifference(
                        existing.heading, incoming.heading)
                        > ROULETTE_GROUND_HEADING_EPSILON
        if conflict then
            roulette.suppressed = true
            roulette.ready = false
            diagnostic(state, 'roulette_ground_effect_conflict', keyID)
        end
        return false
    end
    roulette.effects[keyID] = incoming
    local inner = roulette.effects[ROULETTE_GROUND_INNER_ID]
    local outer = roulette.effects[ROULETTE_GROUND_OUTER_ID]
    if inner ~= nil and outer ~= nil then
        if Common.headingDifference(inner.heading, outer.heading)
                > ROULETTE_GROUND_HEADING_EPSILON
        then
            roulette.suppressed = true
            roulette.ready = false
            diagnostic(state, 'roulette_ground_heading_conflict')
            return false
        end
        roulette.ready = inner.dangerHeading ~= nil
                and outer.dangerHeading ~= nil
                and not roulette.suppressed
    end
    return true
end

local function recordRouletteScript(state, entityID, a1, a2, a3)
    local roulette = state.roulette
    if type(roulette) ~= 'table' then
        return false
    end
    local keyID, effect
    for candidateKey, candidate in pairs(roulette.effects) do
        if candidate.entityID == entityID then
            keyID, effect = candidateKey, candidate
            break
        end
    end
    if effect == nil then
        return false
    end
    a1, a2, a3 = tonumber(a1), tonumber(a2), tonumber(a3)
    if a1 ~= 4 then
        return false
    end
    local offsets = keyID == ROULETTE_GROUND_INNER_ID
            and ROULETTE_INNER_OFFSET_BY_STATE
            or ROULETTE_OUTER_OFFSET_BY_STATE
    local offset = a3 == 0 and offsets[a2] or nil
    if offset == nil then
        roulette.suppressed = true
        roulette.ready = false
        diagnostic(state, 'roulette_script_invalid', {
            entityID = entityID, a1 = a1, a2 = a2, a3 = a3,
        })
        return false
    end
    if effect.stateCode ~= nil then
        if effect.stateCode ~= a2 then
            roulette.suppressed = true
            roulette.ready = false
            diagnostic(state, 'roulette_script_conflict', {
                entityID = entityID,
                previous = effect.stateCode,
                incoming = a2,
            })
        end
        return false
    end
    effect.stateCode = a2
    effect.dangerHeading = effect.heading + offset
    local inner = roulette.effects[ROULETTE_GROUND_INNER_ID]
    local outer = roulette.effects[ROULETTE_GROUND_OUTER_ID]
    roulette.ready = inner ~= nil and inner.dangerHeading ~= nil
            and outer ~= nil and outer.dangerHeading ~= nil
            and not roulette.suppressed
    return true
end

local function resolveRouletteEvent(state, entityID, spellID, now)
    local roulette = state.roulette
    if type(roulette) ~= 'table'
            or (spellID ~= AID.DeathRouletteCenter
                    and spellID ~= AID.DeathRouletteInner
                    and spellID ~= AID.DeathRouletteOuter)
    then
        return false
    end
    local key = 'roulette-resolve:' .. tostring(entityID)
            .. ':' .. tostring(spellID) .. ':' .. tostring(math.floor(now / 100))
    if not Common.consumeEvent(state.seenCasts, key, now, 300) then
        return false
    end
    state.roulette = nil
    state.guideTarget = nil
    return true
end

local function updateRoulette(state, now)
    local roulette = state.roulette
    if type(roulette) ~= 'table' then
        return false
    end
    if now > roulette.expiresAt then
        state.roulette = nil
        state.guideTarget = nil
        return false
    end
    return roulette.ready and not roulette.suppressed
end

local function rouletteDangerGroup(state)
    local roulette = state.roulette
    if type(roulette) ~= 'table'
            or not roulette.ready
            or roulette.suppressed
    then
        return nil
    end
    local inner = roulette.effects[ROULETTE_GROUND_INNER_ID]
    local outer = roulette.effects[ROULETTE_GROUND_OUTER_ID]
    if inner == nil or outer == nil
            or not finite(inner.dangerHeading)
            or not finite(outer.dangerHeading)
    then
        return nil
    end
    local group = {
        {
            kind = 'circle',
            source = ARENA_CENTER,
            radius = ROULETTE_CENTER_RADIUS,
        },
    }
    group.guideKey = 'roulette:' .. tostring(roulette.startedAt)
    for _, heading in ipairs({
            inner.dangerHeading,
            inner.dangerHeading + math.pi,
    }) do
        group[#group + 1] = {
            kind = 'cone',
            source = ARENA_CENTER,
            innerRadius = ROULETTE_CENTER_RADIUS,
            radius = ROULETTE_INNER_RADIUS,
            angle = ROULETTE_SECTOR_ANGLE,
            heading = heading,
        }
    end
    for _, heading in ipairs({
            outer.dangerHeading,
            outer.dangerHeading + math.pi,
    }) do
        group[#group + 1] = {
            kind = 'cone',
            source = ARENA_CENTER,
            innerRadius = ROULETTE_INNER_RADIUS,
            radius = ROULETTE_OUTER_RADIUS,
            angle = ROULETTE_SECTOR_ANGLE,
            heading = heading,
        }
    end
    return group
end

local function pointInDanger(point, danger)
    return Common.pointInDanger(point, danger, 0.5)
end

local function safeForGroup(point, group)
    return Common.safeForGroup(
            point, group, ARENA_CENTER, GUIDE_ARENA_RADIUS, 0.5)
end

local function nextDangerGroup(state, now)
    local candidates = {}
    for _, aoe in ipairs(state.liveAOEs) do
        if now <= aoe.expiresAt then
            candidates[#candidates + 1] = aoe
        end
    end
    local round = state.round
    if type(round) == 'table' and round.finalized and not round.ambiguity then
        for _, entry in ipairs(round.predictions) do
            if not entry.resolved and now <= entry.activationAt + LIVE_AOE_GRACE_MS then
                candidates[#candidates + 1] = entry
            end
        end
    end
    table.sort(candidates, function(left, right)
        return left.activationAt < right.activationAt
    end)
    if #candidates == 0 then
        return nil
    end

    local activationGroups = {}
    for _, candidate in ipairs(candidates) do
        local activationGroup = activationGroups[#activationGroups]
        if activationGroup == nil
                or math.abs(candidate.activationAt - activationGroup.activationAt)
                        > GUIDE_GROUP_WINDOW_MS
        then
            if #activationGroups >= GUIDE_LOOKAHEAD_GROUPS then
                break
            end
            activationGroup = {
                activationAt = candidate.activationAt,
                dangers = {},
            }
            activationGroups[#activationGroups + 1] = activationGroup
        end
        activationGroup.dangers[#activationGroup.dangers + 1] = candidate
    end

    local group = {
        activationGroupCount = #activationGroups,
        primaryCount = #activationGroups[1].dangers,
    }
    local guideKey = { 'danger' }
    for _, activationGroup in ipairs(activationGroups) do
        guideKey[#guideKey + 1] = tostring(activationGroup.activationAt)
        for _, danger in ipairs(activationGroup.dangers) do
            group[#group + 1] = danger
        end
    end
    group.guideKey = table.concat(guideKey, ':')
    return group
end

local function visibleSafeAnchor(playerPos, group, fallback)
    if Common.distanceSquared(playerPos, fallback) > 0.25 then
        return fallback
    end
    local best, bestCenterDistance
    for index = 0, 71 do
        local angle = 2 * math.pi * index / 72
        local candidate = {
            x = playerPos.x + math.sin(angle) * 2,
            y = playerPos.y,
            z = playerPos.z + math.cos(angle) * 2,
        }
        if safeForGroup(candidate, group) then
            local centerDistance = Common.distanceSquared(
                    candidate, ARENA_CENTER)
            if best == nil or centerDistance < bestCenterDistance then
                best = candidate
                bestCenterDistance = centerDistance
            end
        end
    end
    return best or fallback
end

local function nearestSafePoint(playerPos, group)
    if reliablePosition(playerPos, false) == nil then
        return nil
    end
    return Common.nearestSafePoint(
            playerPos,
            group,
            ARENA_CENTER,
            GUIDE_ARENA_RADIUS,
            { margin = 0.5, step = 1, directionCount = 72 })
end

local function primaryDangerGroup(group)
    local primaryCount = type(group) == 'table'
            and tonumber(group.primaryCount) or nil
    if not finite(primaryCount)
            or primaryCount < 1
            or primaryCount >= #group
    then
        return nil
    end
    local primary = {
        guideKey = tostring(group.guideKey) .. ':primary',
    }
    for index = 1, primaryCount do
        primary[index] = group[index]
    end
    return primary
end

local function rouletteSafePoint(state, playerPos, group)
    local roulette = state.roulette
    local inner = type(roulette) == 'table'
            and roulette.effects[ROULETTE_GROUND_INNER_ID] or nil
    if reliablePosition(playerPos, false) == nil
            or type(group) ~= 'table'
            or type(inner) ~= 'table'
            or not finite(inner.dangerHeading)
    then
        return nil
    end
    local best = nil
    local bestDistanceSq = math.huge
    for _, heading in ipairs({
            inner.dangerHeading + math.pi / 2,
            inner.dangerHeading - math.pi / 2,
    }) do
        local candidate = {
            x = ARENA_CENTER.x + math.sin(heading) * ROULETTE_SAFE_RADIUS,
            y = playerPos.y,
            z = ARENA_CENTER.z + math.cos(heading) * ROULETTE_SAFE_RADIUS,
        }
        if safeForGroup(candidate, group) then
            local distanceSq = Common.distanceSquared(playerPos, candidate)
            if distanceSq < bestDistanceSq then
                best = candidate
                bestDistanceSq = distanceSq
            end
        end
    end
    return best
end

local function getPlayer(guide)
    local player = type(guide) == 'table'
            and type(guide.GetPlayer) == 'function'
            and guide.GetPlayer() or Player
    if type(player) ~= 'table' or reliablePosition(player.pos, false) == nil then
        return nil
    end
    return player
end

local function directSafeGuide(
        state, guide, group, missingCode, targetResolver)
    local player = getPlayer(guide)
    if group == nil then
        state.guideTarget = nil
        return false
    end
    if player == nil then
        return false
    end
    local planKey = group.guideKey or tostring(group[1])
    local activeGroup = group
    local target = state.guideTarget
    if type(target) == 'table'
            and target.planKey == planKey
            and target.primaryOnly
    then
        activeGroup = primaryDangerGroup(group) or group
    end
    if type(target) ~= 'table'
            or target.planKey ~= planKey
            or not safeForGroup(target, activeGroup)
    then
        activeGroup = group
        if type(targetResolver) == 'function' then
            target = targetResolver(player.pos, activeGroup)
        else
            target = nearestSafePoint(player.pos, activeGroup)
        end
        local primaryOnly = false
        if target == nil and type(targetResolver) ~= 'function' then
            local primary = primaryDangerGroup(group)
            if primary ~= nil then
                target = nearestSafePoint(player.pos, primary)
                if target ~= nil then
                    activeGroup = primary
                    primaryOnly = true
                    diagnostic(state, 'guide_no_shared_lookahead_safe_point',
                            planKey)
                end
            end
        end
        if target ~= nil then
            if type(targetResolver) ~= 'function' then
                target = visibleSafeAnchor(
                        player.pos, activeGroup, target)
            end
            target.planKey = planKey
            target.primaryOnly = primaryOnly
            state.guideTarget = target
        end
    end
    if target == nil then
        diagnostic(state, missingCode)
        return true
    end
    local color = type(guide.Config) == 'table'
            and type(guide.Config.Main) == 'table'
            and guide.Config.Main.GuideColor
            or { r = 0, g = 1, b = 1, a = 0.5 }
    guide.FrameDirect(target.x, target.z, 0.7, color)
    return true
end

local function drawDynamicGuide(state, guide, now)
    local cfg = getConfig(guide)
    if type(cfg) ~= 'table'
            or cfg.DynamicGuide ~= true
            or (finite(state.guideSuppressedUntil)
                    and now <= state.guideSuppressedUntil)
            or (type(state.round) == 'table' and state.round.ambiguity)
            or type(guide) ~= 'table'
            or type(guide.FrameDirect) ~= 'function'
    then
        return false
    end
    return directSafeGuide(
            state, guide, nextDangerGroup(state, now), 'guide_no_safe_point')
end

local function drawRouletteGuide(state, guide)
    local cfg = getConfig(guide)
    if type(cfg) ~= 'table'
            or cfg.RouletteGuide ~= true
            or type(guide) ~= 'table'
            or type(guide.FrameDirect) ~= 'function'
    then
        return false
    end
    local group = rouletteDangerGroup(state)
    return directSafeGuide(
            state, guide, group, 'roulette_no_safe_point',
            function(playerPos, dangerGroup)
                return rouletteSafePoint(state, playerPos, dangerGroup)
            end)
end

local function pruneState(state, now)
    for index = #state.liveAOEs, 1, -1 do
        if not finite(state.liveAOEs[index].expiresAt)
                or now > state.liveAOEs[index].expiresAt
        then
            state.seenAOEs[state.liveAOEs[index].key] = nil
            table.remove(state.liveAOEs, index)
        end
    end
    Common.pruneSeen(state.seenCasts, now, SEEN_TTL_MS)
    if finite(state.guideSuppressedUntil) and now > state.guideSuppressedUntil then
        state.guideSuppressedUntil = nil
    end
    if type(state.round) == 'table'
            and finite(state.round.expiresAt)
            and now > state.round.expiresAt
    then
        clearRound(state)
    end
end

local function updateBossLifetime(state, now, cache)
    if type(state.bossEntityID) ~= 'number' then
        return
    end
    local boss = strictEntity(
            state.bossEntityID,
            BOSS_CONTENT_ID,
            BOSS_MODEL_ID,
            false,
            cache)
    if boss ~= nil then
        state.bossMissingSince = nil
        return
    end
    state.bossMissingSince = state.bossMissingSince or now
    if now - state.bossMissingSince >= BOSS_MISSING_CLEAR_MS then
        clearState(state)
    end
end

local Feature = {}

Feature.Init = function(M)
    if type(M.Pallmagia) == 'table' then
        clearState(M.Pallmagia)
    end
    M.Pallmagia = newState()
    getConfig(M)
    M.SetPallmagiaEnabled = function(enabled)
        local cfg = getConfig(M)
        if cfg ~= nil then
            cfg.Enable = enabled == true
        end
        if enabled ~= true then
            clearState(M.Pallmagia)
        end
    end
    M.SetPallmagiaPredictionEnabled = function(enabled)
        local cfg = getConfig(M)
        if cfg ~= nil then
            cfg.DrawInstructionPrediction = enabled == true
        end
        local state = ensureState(M.Pallmagia)
        if enabled ~= true and type(state.round) == 'table' then
            for _, entry in ipairs(state.round.predictions or {}) do
                clearToken(entry)
            end
        elseif enabled == true and type(state.round) == 'table'
                and state.round.finalized and not state.round.ambiguity
        then
            scheduleNextPrediction(state, nowMs(), M)
        end
    end
    M.SetPallmagiaRouletteGuideEnabled = function(enabled)
        local cfg = getConfig(M)
        if cfg ~= nil then
            cfg.RouletteGuide = enabled == true
        end
        if enabled ~= true then
            local state = ensureState(M.Pallmagia)
            state.roulette = nil
            state.guideTarget = nil
        end
    end
end

Feature.Clear = function()
    local state = getState()
    if state ~= nil then
        clearState(state)
    end
end

Feature.OnEntityChannel = function(entityID, spellID, targetID, channelTimeMax, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state == nil or cfg == nil or cfg.Enable ~= true then
        return
    end
    if spellID == AID.DeathRouletteCast then
        startRoulette(state, entityID, channelTimeMax, now)
    else
        startInstructionRound(state, entityID, spellID, channelTimeMax, now)
    end
end

Feature.OnTetherChange = function(sourceEntityID, newTetherID, newTargetID, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state == nil or cfg == nil or cfg.Enable ~= true then
        return
    end
    if newTetherID == INSTRUCTION_TETHER then
        collectInstructionClone(state, sourceEntityID, newTargetID)
    elseif newTetherID == REVERSE_TETHER then
        collectReversePair(state, sourceEntityID, newTargetID)
        finalizeRound(state, now, guide)
    end
end

Feature.OnEntityCast = function(entityID, spellID, castPos, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state == nil or cfg == nil or cfg.Enable ~= true then
        return
    end
    if spellID == AID.DeathRouletteCenter
            or spellID == AID.DeathRouletteInner
            or spellID == AID.DeathRouletteOuter
    then
        resolveRouletteEvent(state, entityID, spellID, now)
    elseif spellID == AID.Instruction
            or spellID == AID.InstructionReverse
    then
        finishInstruction(state, entityID, spellID, now, guide)
    elseif spellID == AID.BadBreath or spellID == AID.Plaincracker then
        resolvePrediction(state, entityID, spellID, castPos, now, guide)
    end
end

Feature.OnAddGroundEffect = function(...)
    local args = { ... }
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state == nil or cfg == nil or cfg.Enable ~= true then
        return
    end
    recordRouletteGroundEffect(
            state,
            args[1], args[2], args[3], args[5], args[11], args[12],
            args[15], args[17], args[18], args[19], nowMs())
end

Feature.OnEventObjectScriptFunc = function(entityID, a1, a2, a3, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state == nil or cfg == nil or cfg.Enable ~= true then
        return
    end
    local cache = {}
    local recorded = recordInstructionKind(state, entityID, a1, a2, a3)
    resolveInstructionRound(state, cache)
    if recorded then
        finalizeRound(state, now, guide)
    end
    recordRouletteScript(state, entityID, a1, a2, a3)
end

Feature.OnAOECreate = function(aoeInfo, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state ~= nil and cfg ~= nil and cfg.Enable == true then
        addLiveAOE(state, aoeInfo, now)
    end
end

Feature.Update = function(guide, now)
    local state = getState()
    if state == nil then
        return false
    end
    local cfg = getConfig(guide)
    if cfg == nil or cfg.Enable ~= true then
        clearState(state)
        return false
    end
    pruneState(state, now)
    local cache = {}
    resolveInstructionRound(state, cache)
    updateRoulette(state, now)
    updateBossLifetime(state, now, cache)
    scheduleNextPrediction(state, now, guide)
    return drawRouletteGuide(state, guide)
            or drawDynamicGuide(state, guide, now)
end

Feature.Test = {
    MapID = MAP_ID,
    BossContentID = BOSS_CONTENT_ID,
    CloneContentID = CLONE_CONTENT_ID,
    InstructionEventObjectID = INSTRUCTION_EVENT_OBJECT_ID,
    ArenaCenter = ARENA_CENTER,
    ArenaRadius = ARENA_RADIUS,
    GuideArenaRadius = GUIDE_ARENA_RADIUS,
    AID = AID,
    InstructionTether = INSTRUCTION_TETHER,
    ReverseTether = REVERSE_TETHER,
    BadBreathRange = BAD_BREATH_RANGE,
    BadBreathAngle = BAD_BREATH_ANGLE,
    PlaincrackerRadius = PLAINCRACKER_RADIUS,
    RouletteCenterRadius = ROULETTE_CENTER_RADIUS,
    RouletteInnerRadius = ROULETTE_INNER_RADIUS,
    RouletteOuterRadius = ROULETTE_OUTER_RADIUS,
    RouletteSectorAngle = ROULETTE_SECTOR_ANGLE,
    RouletteSafeRadius = ROULETTE_SAFE_RADIUS,
    RouletteActivationDelay = ROULETTE_ACTIVATION_DELAY_MS,
    RouletteGroundInnerID = ROULETTE_GROUND_INNER_ID,
    RouletteGroundOuterID = ROULETTE_GROUND_OUTER_ID,
    DirectDelays = DIRECT_DELAYS,
    ReverseDelays = REVERSE_DELAYS,
    GuideLookaheadGroups = GUIDE_LOOKAHEAD_GROUPS,
    Defaults = DEFAULTS,
    NewState = newState,
    ClearState = clearState,
    StartRound = startInstructionRound,
    CollectClone = collectInstructionClone,
    CollectReversePair = collectReversePair,
    RecordInstructionKind = recordInstructionKind,
    FinishInstruction = finishInstruction,
    FinalizeRound = finalizeRound,
    AddLiveAOE = addLiveAOE,
    ResolvePrediction = resolvePrediction,
    PointInDanger = pointInDanger,
    NearestSafePoint = nearestSafePoint,
    NextDangerGroup = nextDangerGroup,
    DrawDynamicGuide = drawDynamicGuide,
    StartRoulette = startRoulette,
    RecordRouletteGroundEffect = recordRouletteGroundEffect,
    RecordRouletteScript = recordRouletteScript,
    ResolveRouletteEvent = resolveRouletteEvent,
    UpdateRoulette = updateRoulette,
    RouletteDangerGroup = rouletteDangerGroup,
    RouletteSafePoint = rouletteSafePoint,
    DrawRouletteGuide = drawRouletteGuide,
    PruneState = pruneState,
}

    return Feature
end

rawset(_G, 'MuAiOccultCrescentNorthPallmagia', Module)
return Module
