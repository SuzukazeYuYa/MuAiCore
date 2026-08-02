local Module = {}

function Module.Create(Context)
    assert(type(Context) == 'table' and type(Context.Common) == 'table')
    local Common = Context.Common
    local finite = Context.finite
    local nowMs = Context.nowMs
    local reliablePosition = Context.reliablePosition
    local resolveEntity = Context.resolveEntity

local KelpieCaptain = {
    MapID = Context.MapID,
    ContentID = 14728,
    HelperModelID = 19291,
    AID = {
        WaveburstTelegraph = 47387,
        WaveburstDamage = 47388,
    },
    InitialCastType = 12,
    InitialLength = 50,
    InitialWidth = 10,
    InitialDuration = 4.7,
    PropagationLength = 50,
    PropagationWidth = 5,
    PropagationStepDistance = 5,
    PropagationStepCount = 4,
    FirstPropagationOffsetMs = 7000,
    PropagationIntervalMs = 2000,
    LaterStepPreviewMs = 3000,
    InitialCastElapsedMinMs = 4500,
    InitialCastElapsedMaxMs = 5500,
    InitialToPropagationMs = 2000,
    TimingCorrectionThresholdMs = 100,
    ActualTimingToleranceMs = 350,
    PositionTolerance = 0.75,
    HeadingTolerance = math.rad(3),
    EventFreshPastMs = 1000,
    EventFreshFutureMs = 250,
    RoundGraceMs = 1500,
    SeenTtlMs = 30000,
    Defaults = {
        Enable = true,
        DrawWaveburstPrediction = true,
    },
}

-- The 2026-08-01 map-1346 captures at 17:18, 18:41, and 22:46 contain six
-- 47387 omens, all 50x10 for 4.7 seconds. Their 48 subsequent 47388 helper
-- casts form four two-sided waves: lateral offsets are 4.95-5.00,
-- 10.00-10.041, 15.00-15.133, and 20.00-20.082; the first wave lands
-- 6.97-7.05 seconds after the omen and later waves repeat about every two
-- seconds. 47388 has no Argus AOE-create geometry, so the module predicts it
-- only after the complete 47387 geometry and hidden-helper identity agree.

local function newState()
    return {
        rounds = {},
        seedKeys = {},
        seen = {},
        seenCasts = {},
        lastDiagnostic = nil,
    }
end

local function ensureState(state)
    state = type(state) == 'table' and state or newState()
    state.rounds = type(state.rounds) == 'table' and state.rounds or {}
    state.seedKeys = type(state.seedKeys) == 'table' and state.seedKeys or {}
    state.seen = type(state.seen) == 'table' and state.seen or {}
    state.seenCasts = type(state.seenCasts) == 'table'
            and state.seenCasts or {}
    return state
end

local feature = Common.newFeature({
    key = 'KelpieCaptain',
    defaults = KelpieCaptain.Defaults,
    newState = newState,
    ensureState = ensureState,
    diagnosticThrottleMs = 1000,
    diagnosticText = {
        initial_event_invalid = '凯尔派总领浪暴预兆字段不完整',
        initial_event_stale = '凯尔派总领浪暴预兆不是当前事件',
        initial_entity_mismatch = '凯尔派总领浪暴预兆实体不匹配',
        initial_geometry_mismatch = '凯尔派总领浪暴预兆几何与实战样本不符',
        danger_drawer_unavailable = '凯尔派总领扩散地火绘图器不可用',
        danger_drawer_rejected_shape = '凯尔派总领扩散地火绘制失败',
        initial_cast_timing_mismatch = '凯尔派总领浪暴结算时序与预测不符',
        propagation_entity_mismatch = '凯尔派总领扩散地火实体不匹配',
        propagation_prediction_mismatch = '凯尔派总领扩散地火与预测几何不符',
    },
})
local getConfig = feature.GetConfig

local function getState()
    return Common.getRuntimeState(
            'KelpieCaptain', newState, ensureState)
end

local function diagnostic(state, code, now, context)
    local at = finite(now) and now or nowMs()
    return feature.Diagnostic(
            state, rawget(_G, 'MuAiGuide'), code, at, context)
end

local function normalizeHeading(heading)
    return (heading + math.pi) % (2 * math.pi) - math.pi
end

local function getDangerDrawer()
    if type(TensorCore) ~= 'table'
            or type(TensorCore.getMoogleDrawer) ~= 'function'
    then
        return nil
    end
    local drawer = TensorCore.getMoogleDrawer()
    return type(drawer) == 'table' and drawer or nil
end

local function deleteSegment(segment)
    if type(segment) ~= 'table' then
        return false
    end
    Common.deleteTimedShape(segment.token)
    segment.token = nil
    return true
end

local function clearRound(state, key)
    state = ensureState(state)
    local round = state.rounds[key]
    if type(round) ~= 'table' then
        return false
    end
    for _, segment in ipairs(round.predictions or {}) do
        deleteSegment(segment)
    end
    local seedKey = tostring(round.seedEntityID)
    if state.seedKeys[seedKey] == key then
        state.seedKeys[seedKey] = nil
    end
    state.rounds[key] = nil
    return true
end

local function clearState(state)
    state = ensureState(state)
    local keys = {}
    for key in pairs(state.rounds) do
        keys[#keys + 1] = key
    end
    for _, key in ipairs(keys) do
        clearRound(state, key)
    end
    state.rounds = {}
    state.seedKeys = {}
    state.seen = {}
    state.seenCasts = {}
    state.lastDiagnostic = nil
end

local function suppressRound(state, key, code, now, context)
    clearRound(state, key)
    diagnostic(state, code, now, context)
    return false
end

local function resolveHelper(entityID)
    if not finite(entityID) or entityID <= 0 then
        return nil
    end
    local entity = resolveEntity(entityID)
    if type(entity) ~= 'table'
            or tonumber(entity.id) ~= entityID
            or tonumber(entity.contentid) ~= KelpieCaptain.ContentID
            or tonumber(entity.modelid) ~= KelpieCaptain.HelperModelID
            or entity.alive == false
    then
        return nil
    end
    local position = reliablePosition(entity.pos, true)
    if position == nil then
        return nil
    end
    return entity, position
end

local function readInitialAOE(aoeInfo, now)
    if type(aoeInfo) ~= 'table'
            or tonumber(aoeInfo.aoeID)
                    ~= KelpieCaptain.AID.WaveburstTelegraph
    then
        return nil, nil
    end
    local entityID = tonumber(aoeInfo.entityID)
    local startTime = tonumber(aoeInfo.startTime)
    local duration = tonumber(aoeInfo.duration)
    local heading = tonumber(aoeInfo.heading)
    local x = tonumber(aoeInfo.x)
    local y = tonumber(aoeInfo.y)
    local z = tonumber(aoeInfo.z)
    local length = tonumber(aoeInfo.aoeLength)
    local width = tonumber(aoeInfo.aoeWidth)
    if not finite(now)
            or not finite(entityID)
            or not finite(startTime)
            or not finite(duration)
            or not finite(heading)
            or not finite(x)
            or not finite(y)
            or y == 0
            or not finite(z)
            or tonumber(aoeInfo.contentID) ~= KelpieCaptain.ContentID
            or tonumber(aoeInfo.aoeCastType)
                    ~= KelpieCaptain.InitialCastType
            or not finite(length)
            or not finite(width)
    then
        return nil, 'initial_event_invalid'
    end
    local age = now - startTime
    if age > KelpieCaptain.EventFreshPastMs
            or age < -KelpieCaptain.EventFreshFutureMs
    then
        return nil, 'initial_event_stale', { age = age }
    end
    if math.abs(duration - KelpieCaptain.InitialDuration) > 0.15
            or math.abs(length - KelpieCaptain.InitialLength) > 0.25
            or math.abs(width - KelpieCaptain.InitialWidth) > 0.25
    then
        return nil, 'initial_geometry_mismatch', {
            duration = duration,
            length = length,
            width = width,
        }
    end
    local _, seed = resolveHelper(entityID)
    if seed == nil then
        return nil, 'initial_entity_mismatch', { entityID = entityID }
    end
    local headingError = Common.headingDifference(seed.h, heading)
    local dx = x - seed.x
    local dz = z - seed.z
    local forward = dx * math.sin(heading) + dz * math.cos(heading)
    local lateral = dx * math.cos(heading) - dz * math.sin(heading)
    if headingError == nil
            or headingError > KelpieCaptain.HeadingTolerance
            or math.abs(math.abs(forward)
                    - KelpieCaptain.InitialLength / 2) > 0.75
            or math.abs(lateral) > 0.75
    then
        return nil, 'initial_geometry_mismatch', {
            entityID = entityID,
            headingError = headingError,
            forward = forward,
            lateral = lateral,
        }
    end
    return {
        entityID = entityID,
        startTime = startTime,
        seed = seed,
        heading = normalizeHeading(heading),
    }
end

local function offsetRight(position, heading, distance)
    return {
        x = position.x + math.cos(heading) * distance,
        y = position.y,
        z = position.z - math.sin(heading) * distance,
    }
end

local function buildPredictions(initial)
    local predictions = {}
    for step = 1, KelpieCaptain.PropagationStepCount do
        local activationAt = initial.startTime
                + KelpieCaptain.FirstPropagationOffsetMs
                + (step - 1) * KelpieCaptain.PropagationIntervalMs
        for _, side in ipairs({ -1, 1 }) do
            local right = side * step
                    * KelpieCaptain.PropagationStepDistance
            local source = offsetRight(
                    initial.seed, initial.heading, right)
            predictions[#predictions + 1] = {
                step = step,
                side = side,
                source = source,
                heading = side < 0 and initial.heading
                        or normalizeHeading(initial.heading + math.pi),
                activationAt = activationAt,
                resolved = false,
                token = nil,
            }
        end
    end
    return predictions
end

local function scheduleSegment(drawer, segment, now)
    if type(drawer) ~= 'table'
            or type(drawer.addTimedRect) ~= 'function'
            or type(segment) ~= 'table'
            or segment.resolved == true
            or segment.token ~= nil
            or not finite(now)
            or not finite(segment.activationAt)
    then
        return false
    end
    local remaining = segment.activationAt - now
    if remaining <= 0 then
        return false
    end
    -- The first pair is shown from the initial 50x10 omen. Later pairs use a
    -- three-second preview, overlapping the previous wave for one second so
    -- the outward direction remains readable without showing all eight strips.
    local visible = segment.step == 1 and remaining
            or math.min(KelpieCaptain.LaterStepPreviewMs, remaining)
    local delay = math.max(0, remaining - visible)
    local token = drawer:addTimedRect(
            math.floor(visible + 0.5),
            segment.source.x, segment.source.y, segment.source.z,
            KelpieCaptain.PropagationLength,
            KelpieCaptain.PropagationWidth,
            segment.heading,
            math.floor(delay + 0.5))
    if type(token) ~= 'string' then
        return false
    end
    segment.token = token
    return true
end

local function scheduleRound(round, now)
    local drawer = getDangerDrawer()
    if drawer == nil or type(drawer.addTimedRect) ~= 'function' then
        return false, 'danger_drawer_unavailable'
    end
    local scheduled = {}
    for _, segment in ipairs(round.predictions) do
        if segment.resolved ~= true then
            if not scheduleSegment(drawer, segment, now) then
                for _, rollback in ipairs(scheduled) do
                    deleteSegment(rollback)
                end
                return false, 'danger_drawer_rejected_shape'
            end
            scheduled[#scheduled + 1] = segment
        end
    end
    return true
end

local function handleAOECreate(state, aoeInfo, now)
    state = ensureState(state)
    local initial, code, context = readInitialAOE(aoeInfo, now)
    if initial == nil then
        if code ~= nil then
            diagnostic(state, code, now, context)
        end
        return false
    end
    local key = tostring(initial.entityID)
            .. ':' .. tostring(math.floor(initial.startTime + 0.5))
    local seenAt = state.seen[key]
    if finite(seenAt) and now - seenAt <= KelpieCaptain.SeenTtlMs then
        return false
    end
    local previousKey = state.seedKeys[tostring(initial.entityID)]
    if previousKey ~= nil then
        clearRound(state, previousKey)
    end
    local round = {
        key = key,
        seedEntityID = initial.entityID,
        startedAt = initial.startTime,
        seed = initial.seed,
        heading = initial.heading,
        predictions = buildPredictions(initial),
        initialCastAt = nil,
        expiresAt = initial.startTime
                + KelpieCaptain.FirstPropagationOffsetMs
                + (KelpieCaptain.PropagationStepCount - 1)
                        * KelpieCaptain.PropagationIntervalMs
                + KelpieCaptain.RoundGraceMs,
    }
    local scheduled, scheduleCode = scheduleRound(round, now)
    if not scheduled then
        diagnostic(state, scheduleCode, now, {
            entityID = initial.entityID,
        })
        return false
    end
    state.rounds[key] = round
    state.seedKeys[tostring(initial.entityID)] = key
    state.seen[key] = now
    state.lastDiagnostic = nil
    return true
end

local function rescheduleRound(state, key, firstActivationAt, now)
    local round = state.rounds[key]
    if type(round) ~= 'table' then
        return false
    end
    for _, segment in ipairs(round.predictions) do
        if segment.resolved ~= true then
            deleteSegment(segment)
            segment.activationAt = firstActivationAt
                    + (segment.step - 1)
                            * KelpieCaptain.PropagationIntervalMs
        end
    end
    round.expiresAt = firstActivationAt
            + (KelpieCaptain.PropagationStepCount - 1)
                    * KelpieCaptain.PropagationIntervalMs
            + KelpieCaptain.RoundGraceMs
    local scheduled, code = scheduleRound(round, now)
    if not scheduled then
        return suppressRound(state, key, code, now, {
            entityID = round.seedEntityID,
        })
    end
    return true
end

local function handleInitialCast(state, entityID, now)
    local key = state.seedKeys[tostring(entityID)]
    local round = key ~= nil and state.rounds[key] or nil
    if type(round) ~= 'table' or round.initialCastAt ~= nil then
        return false
    end
    local elapsed = now - round.startedAt
    if elapsed < KelpieCaptain.InitialCastElapsedMinMs
            or elapsed > KelpieCaptain.InitialCastElapsedMaxMs
    then
        return suppressRound(
                state, key, 'initial_cast_timing_mismatch', now, {
                    entityID = entityID,
                    elapsed = elapsed,
                })
    end
    round.initialCastAt = now
    local correctedFirst = now + KelpieCaptain.InitialToPropagationMs
    local originalFirst = round.startedAt
            + KelpieCaptain.FirstPropagationOffsetMs
    if math.abs(correctedFirst - originalFirst)
            > KelpieCaptain.TimingCorrectionThresholdMs
    then
        return rescheduleRound(state, key, correctedFirst, now)
    end
    return true
end

local function timedRoundKeys(state, now)
    local keys = {}
    for key, round in pairs(state.rounds) do
        for _, segment in ipairs(round.predictions or {}) do
            if segment.resolved ~= true
                    and math.abs(segment.activationAt - now)
                            <= KelpieCaptain.ActualTimingToleranceMs
            then
                keys[key] = true
                break
            end
        end
    end
    return keys
end

local function suppressKeys(state, keys, code, now, context)
    for key in pairs(keys) do
        clearRound(state, key)
    end
    diagnostic(state, code, now, context)
    return false
end

local function handlePropagationCast(state, entityID, now)
    local castKey = tostring(entityID)
            .. ':' .. tostring(KelpieCaptain.AID.WaveburstDamage)
    local seenAt = state.seenCasts[castKey]
    if finite(seenAt) and now - seenAt <= KelpieCaptain.SeenTtlMs then
        return false
    end
    local timedKeys = timedRoundKeys(state, now)
    if next(timedKeys) == nil then
        return false
    end
    local _, actual = resolveHelper(entityID)
    if actual == nil then
        return suppressKeys(
                state, timedKeys, 'propagation_entity_mismatch', now, {
                    entityID = entityID,
                })
    end
    local matches = {}
    for key in pairs(timedKeys) do
        local round = state.rounds[key]
        for _, segment in ipairs(round.predictions or {}) do
            if segment.resolved ~= true
                    and math.abs(segment.activationAt - now)
                            <= KelpieCaptain.ActualTimingToleranceMs
            then
                local distance = Common.distanceSquared(
                        actual, segment.source)
                local headingError = Common.headingDifference(
                        actual.h, segment.heading)
                if distance ~= nil
                        and distance <= KelpieCaptain.PositionTolerance
                                * KelpieCaptain.PositionTolerance
                        and headingError ~= nil
                        and headingError <= KelpieCaptain.HeadingTolerance
                then
                    matches[#matches + 1] = {
                        key = key,
                        segment = segment,
                        distance = distance,
                        headingError = headingError,
                    }
                end
            end
        end
    end
    if #matches ~= 1 then
        return suppressKeys(
                state, timedKeys, 'propagation_prediction_mismatch', now, {
                    entityID = entityID,
                    matches = #matches,
                    x = actual.x,
                    z = actual.z,
                    heading = actual.h,
                })
    end
    local match = matches[1]
    deleteSegment(match.segment)
    match.segment.resolved = true
    state.seenCasts[castKey] = now
    local round = state.rounds[match.key]
    local complete = true
    for _, segment in ipairs(round.predictions) do
        if segment.resolved ~= true then
            complete = false
            break
        end
    end
    if complete then
        clearRound(state, match.key)
    end
    state.lastDiagnostic = nil
    return true
end

local function handleEntityCast(state, entityID, actionID, now)
    state = ensureState(state)
    if not finite(entityID)
            or not finite(actionID)
            or not finite(now)
    then
        return false
    end
    if actionID == KelpieCaptain.AID.WaveburstTelegraph then
        return handleInitialCast(state, entityID, now)
    end
    if actionID == KelpieCaptain.AID.WaveburstDamage then
        return handlePropagationCast(state, entityID, now)
    end
    return false
end

local function pruneState(state, now)
    state = ensureState(state)
    if not finite(now) then
        return false
    end
    local expired = {}
    for key, round in pairs(state.rounds) do
        if not finite(round.expiresAt) or now > round.expiresAt then
            expired[#expired + 1] = key
        end
    end
    for _, key in ipairs(expired) do
        clearRound(state, key)
    end
    Common.pruneSeen(state.seen, now, KelpieCaptain.SeenTtlMs)
    Common.pruneSeen(state.seenCasts, now, KelpieCaptain.SeenTtlMs)
    return #expired > 0
end

local Feature = {}

Feature.Init = function(M)
    if type(M.KelpieCaptain) == 'table' then
        clearState(M.KelpieCaptain)
    end
    M.KelpieCaptain = newState()
    getConfig(M)
    M.SetKelpieCaptainEnabled = function(enabled)
        local cfg = getConfig(M)
        if cfg ~= nil then
            cfg.Enable = enabled == true
        end
        if enabled ~= true then
            clearState(M.KelpieCaptain)
        end
    end
    M.SetKelpieCaptainPredictionEnabled = function(enabled)
        local cfg = getConfig(M)
        if cfg ~= nil then
            cfg.DrawWaveburstPrediction = enabled == true
        end
        if enabled ~= true then
            clearState(M.KelpieCaptain)
        end
    end
end

Feature.Clear = function()
    local state = getState()
    if state ~= nil then
        clearState(state)
    end
end

Feature.OnAOECreate = function(aoeInfo, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state ~= nil
            and cfg ~= nil
            and cfg.Enable == true
            and cfg.DrawWaveburstPrediction == true
    then
        return handleAOECreate(state, aoeInfo, now)
    end
    return false
end

Feature.OnEntityCast = function(entityID, actionID, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state ~= nil
            and cfg ~= nil
            and cfg.Enable == true
            and cfg.DrawWaveburstPrediction == true
    then
        return handleEntityCast(state, entityID, actionID, now)
    end
    return false
end

Feature.Update = function(guide, now)
    local state = getState()
    if state == nil then
        return false
    end
    local cfg = getConfig(guide)
    if cfg ~= nil
            and cfg.Enable == true
            and cfg.DrawWaveburstPrediction == true
    then
        return pruneState(state, now)
    end
    clearState(state)
    return false
end

Feature.Test = {
    MapID = KelpieCaptain.MapID,
    ContentID = KelpieCaptain.ContentID,
    HelperModelID = KelpieCaptain.HelperModelID,
    AID = KelpieCaptain.AID,
    InitialCastType = KelpieCaptain.InitialCastType,
    InitialLength = KelpieCaptain.InitialLength,
    InitialWidth = KelpieCaptain.InitialWidth,
    InitialDuration = KelpieCaptain.InitialDuration,
    PropagationLength = KelpieCaptain.PropagationLength,
    PropagationWidth = KelpieCaptain.PropagationWidth,
    PropagationStepDistance = KelpieCaptain.PropagationStepDistance,
    PropagationStepCount = KelpieCaptain.PropagationStepCount,
    FirstPropagationOffsetMs = KelpieCaptain.FirstPropagationOffsetMs,
    PropagationIntervalMs = KelpieCaptain.PropagationIntervalMs,
    LaterStepPreviewMs = KelpieCaptain.LaterStepPreviewMs,
    Defaults = KelpieCaptain.Defaults,
    NewState = newState,
    EnsureState = ensureState,
    ReadInitialAOE = readInitialAOE,
    BuildPredictions = buildPredictions,
    HandleAOECreate = handleAOECreate,
    HandleEntityCast = handleEntityCast,
    PruneState = pruneState,
    ClearState = clearState,
}

return Feature
end

rawset(_G, 'MuAiOccultCrescentNorthKelpieCaptain', Module)
return Module
