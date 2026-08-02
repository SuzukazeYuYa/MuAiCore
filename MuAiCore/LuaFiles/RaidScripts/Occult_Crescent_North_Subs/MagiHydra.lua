local Module = {}

function Module.Create(Context)
    assert(type(Context) == 'table' and type(Context.Common) == 'table')
    local Common = Context.Common
    local finite = Context.finite
    local nowMs = Context.nowMs
    local reliablePosition = Context.reliablePosition
    local resolveEntity = Context.resolveEntity

local HYDRA_CONTENT_ID = 14523
local HELPER_MODEL_ID = 9020
local FLASH_CONTENT_ID = 14524
local FLASH_MODEL_ID = 19398
local FLASH_OMEN_AID = 47189
local FLASH_OMEN_EFFECT = 'general_1bf'
local STUNNING_FLASH_AID = 47191

local FLASH_OMEN_TO_HIT_MS = 9800
local FLASH_VISIBILITY_TO_HIT_MS = 6000
local FLASH_CHANNEL_HIT_OFFSET_MS = 200
local FLASH_CHANNEL_MIN = 4.5
local FLASH_CHANNEL_MAX = 4.9
local FLASH_AUTO_FACE_LEAD_MS = 500
local FLASH_AUTO_FACE_RELEASE_MS = 800
local FLASH_STATE_GRACE_MS = 1200
local FLASH_OVERLAP_SQUARED = 0.25
local FLASH_OMEN_TO_VISIBILITY_MIN_MS = 3200
local FLASH_OMEN_TO_VISIBILITY_MAX_MS = 4500
local FLASH_OMEN_TO_CHANNEL_MIN_MS = 4200
local FLASH_OMEN_TO_CHANNEL_MAX_MS = 5500

local OMEN_AID = 47212
local OMEN_EFFECT = 'gl_fan120_red0h'
local REAL_BREATH_ACTIONS = {
    [50673] = true,
    [50674] = true,
    [50675] = true,
}
local BREATH_RADIUS = 30
local BREATH_ANGLE = math.rad(120)
local BREATH_COUNT = 6
local BREATH_HEADING_TOLERANCE = math.rad(5)
local BREATH_SOURCE_TOLERANCE_SQUARED = 0.5 * 0.5
local OMEN_GAP_MIN_MS = 800
local OMEN_GAP_MAX_MS = 1700
local OMEN_SEQUENCE_WINDOW_MS = 8000
local FIRST_ACTUAL_MIN_MS = 7000
local FIRST_ACTUAL_MAX_MS = 9500
local FIRST_ACTUAL_PREDICTED_MS = 8218
local ACTUAL_PREDICTED_GAP_MS = 2050
local ACTUAL_GAP_MIN_MS = 1500
local ACTUAL_GAP_MAX_MS = 2700
local BREATH_ROUND_TIMEOUT_MS = 24000
local PREDICTION_LEAD_MS = 3200
local PREDICTION_POST_HIT_MS = 750
local PREDICTION_TOKEN_GRACE_MS = 1000
local SEEN_TTL_MS = 30000

local DEFAULTS = {
    Enable = true,
    AutoFaceStunningFlash = true,
    DrawMultipleBreathPrediction = true,
}

local function newState()
    return {
        flash = nil,
        faceLock = Common.newFaceLock(),
        breathRound = nil,
        predictions = {},
        seenVisibility = {},
        seenChannels = {},
        seenCasts = {},
        seenAOEs = {},
        lastDiagnostic = nil,
    }
end

local function ensureState(state)
    state = type(state) == 'table' and state or newState()
    state.faceLock = type(state.faceLock) == 'table'
            and state.faceLock or Common.newFaceLock()
    state.seenVisibility = type(state.seenVisibility) == 'table'
            and state.seenVisibility or {}
    state.seenChannels = type(state.seenChannels) == 'table'
            and state.seenChannels or {}
    state.seenCasts = type(state.seenCasts) == 'table'
            and state.seenCasts or {}
    state.seenAOEs = type(state.seenAOEs) == 'table'
            and state.seenAOEs or {}
    state.flash = type(state.flash) == 'table' and state.flash or nil
    state.breathRound = type(state.breathRound) == 'table'
            and state.breathRound or nil
    state.predictions = type(state.predictions) == 'table'
            and state.predictions or {}
    return state
end

local feature = Common.newFeature({
    key = 'MagiHydra',
    defaults = DEFAULTS,
    newState = newState,
    ensureState = ensureState,
    diagnosticThrottleMs = 1000,
    diagnosticText = {
        flash_entity_invalid = '魔许德拉眩晕闪光实体不匹配',
        flash_timing_invalid = '魔许德拉眩晕闪光时序无效',
        flash_geometry_invalid = '魔许德拉眩晕闪光缺少可靠几何',
        flash_facing_unavailable = '魔许德拉眩晕闪光自动背对不可用',
        breath_omen_invalid = '魔许德拉多重吐息预兆缺少可靠几何',
        breath_omen_conflict = '魔许德拉多重吐息预兆序列冲突',
        breath_pattern_invalid = '魔许德拉多重吐息预兆方向不完整',
        breath_actual_invalid = '魔许德拉多重吐息真实判定字段无效',
        breath_actual_conflict = '魔许德拉多重吐息真实方向与预兆不符',
        danger_drawer_unavailable = '魔许德拉危险范围绘图器不可用',
        danger_drawer_rejected_shape = '魔许德拉多重吐息预测绘制失败',
    },
})
local getConfig = feature.GetConfig

local function getState()
    return Common.getRuntimeState('MagiHydra', newState, ensureState)
end

local function diagnostic(state, code, now, context)
    feature.Diagnostic(
            state, rawget(_G, 'MuAiGuide'), code, now, context)
end

local function deletePrediction(state, index)
    state = ensureState(state)
    if finite(index) then
        local prediction = state.predictions[index]
        if type(prediction) ~= 'table' then
            return false
        end
        Common.deleteTimedShape(prediction.token)
        state.predictions[index] = nil
        return true
    end
    local changed = false
    for predictionIndex, prediction in pairs(state.predictions) do
        if type(prediction) == 'table' then
            Common.deleteTimedShape(prediction.token)
            changed = true
        end
        state.predictions[predictionIndex] = nil
    end
    return changed
end

local function clearFlash(state)
    state = ensureState(state)
    Common.releaseAutoFace(state)
    state.flash = nil
end

local function clearBreath(state)
    state = ensureState(state)
    deletePrediction(state)
    state.breathRound = nil
end

local function clearState(state)
    state = ensureState(state)
    clearFlash(state)
    clearBreath(state)
    state.seenVisibility = {}
    state.seenChannels = {}
    state.seenCasts = {}
    state.seenAOEs = {}
    state.lastDiagnostic = nil
end

local function resolveExpectedEntity(entityID, contentID, modelID)
    local entity = resolveEntity(entityID)
    local position = type(entity) == 'table'
            and reliablePosition(entity.pos, false) or nil
    if type(entity) ~= 'table'
            or tonumber(entity.id) ~= entityID
            or tonumber(entity.contentid) ~= contentID
            or tonumber(entity.modelid) ~= modelID
            or entity.alive == false
            or position == nil
    then
        return nil
    end
    return entity, position
end

local function flashFacingHeading(playerPosition, source)
    if type(playerPosition) ~= 'table'
            or type(source) ~= 'table'
            or not finite(playerPosition.x)
            or not finite(playerPosition.z)
            or not finite(source.x)
            or not finite(source.z)
    then
        return nil
    end
    local dx = playerPosition.x - source.x
    local dz = playerPosition.z - source.z
    if dx * dx + dz * dz <= FLASH_OVERLAP_SQUARED then
        return nil
    end
    return math.atan2(dx, dz)
end

local function recordFlashOmenAOE(state, aoeInfo, now)
    state = ensureState(state)
    local effectInfo = type(aoeInfo) == 'table'
            and type(aoeInfo.aoeEffectInfo) == 'table'
            and aoeInfo.aoeEffectInfo or nil
    local entityID = type(aoeInfo) == 'table'
            and tonumber(aoeInfo.entityID) or nil
    local source = type(aoeInfo) == 'table' and reliablePosition({
        x = aoeInfo.x,
        y = aoeInfo.y,
        z = aoeInfo.z,
    }, false) or nil
    if type(aoeInfo) ~= 'table'
            or tonumber(aoeInfo.aoeID) ~= FLASH_OMEN_AID
            or tonumber(aoeInfo.contentID) ~= HYDRA_CONTENT_ID
            or tonumber(aoeInfo.aoeCastType) ~= 2
            or tonumber(aoeInfo.aoeType) ~= 1
            or not finite(aoeInfo.aoeLength)
            or math.abs(aoeInfo.aoeLength - 6) > 0.25
            or not finite(aoeInfo.duration)
            or math.abs(aoeInfo.duration - 2.7) > 0.15
            or not finite(aoeInfo.delay)
            or math.abs(aoeInfo.delay) > 0.15
            or not finite(aoeInfo.startTime)
            or aoeInfo.isAreaTarget ~= true
            or effectInfo == nil
            or effectInfo.aoeEffectName ~= FLASH_OMEN_EFFECT
            or not finite(entityID)
            or entityID <= 0
            or source == nil
            or not finite(now)
    then
        clearFlash(state)
        diagnostic(state, 'flash_geometry_invalid', nowMs(), {
            actionID = type(aoeInfo) == 'table' and aoeInfo.aoeID or nil,
            entityID = entityID,
        })
        return false
    end
    local eventKey = tostring(entityID)
            .. ':' .. tostring(FLASH_OMEN_AID)
            .. ':' .. string.format('%.3f', aoeInfo.startTime)
    if not Common.consumeEvent(state.seenAOEs, eventKey, now, 1000) then
        return false
    end
    clearFlash(state)
    local activationAt = now + FLASH_OMEN_TO_HIT_MS
    state.flash = {
        key = eventKey,
        source = source,
        omenEntityID = entityID,
        omenAt = now,
        activationAt = activationAt,
        expiresAt = activationAt + FLASH_STATE_GRACE_MS,
    }
    state.lastDiagnostic = nil
    return true
end

local function recordFlashVisibility(
        state, entityID, wasVisible, isVisible, now)
    state = ensureState(state)
    if wasVisible == true and isVisible == false then
        if type(state.flash) == 'table'
                and state.flash.entityID == entityID
        then
            clearFlash(state)
            return true
        end
        return false
    end
    if wasVisible ~= false or isVisible ~= true then
        return false
    end
    local flash = state.flash
    if type(flash) ~= 'table'
            or not finite(flash.omenAt)
            or type(flash.source) ~= 'table'
            or not finite(now)
    then
        return false
    end
    local elapsed = now - flash.omenAt
    if elapsed < FLASH_OMEN_TO_VISIBILITY_MIN_MS
            or elapsed > FLASH_OMEN_TO_VISIBILITY_MAX_MS
    then
        return false
    end
    if not finite(entityID) or entityID <= 0 then
        diagnostic(state, 'flash_entity_invalid', nowMs(), entityID)
        return false
    end
    if finite(flash.entityID) and flash.entityID ~= entityID
    then
        return false
    end
    local eventKey = tostring(entityID) .. ':visible'
    if not Common.consumeEvent(state.seenVisibility, eventKey, now, 1000) then
        return false
    end
    local activationAt = now + FLASH_VISIBILITY_TO_HIT_MS
    flash.entityID = entityID
    flash.visibleAt = now
    flash.activationAt = activationAt
    flash.expiresAt = activationAt + FLASH_STATE_GRACE_MS
    state.lastDiagnostic = nil
    return true
end

local function recordFlashChannel(
        state, entityID, actionID, channelTimeMax, now)
    if actionID ~= STUNNING_FLASH_AID then
        return false
    end
    state = ensureState(state)
    if not finite(entityID)
            or entityID <= 0
            or not finite(channelTimeMax)
            or channelTimeMax < FLASH_CHANNEL_MIN
            or channelTimeMax > FLASH_CHANNEL_MAX
            or not finite(now)
    then
        clearFlash(state)
        diagnostic(state, 'flash_timing_invalid', nowMs(), {
            entityID = entityID,
            channelTimeMax = channelTimeMax,
        })
        return false
    end
    local flash = state.flash
    if type(flash) ~= 'table'
            or not finite(flash.omenAt)
            or type(flash.source) ~= 'table'
    then
        return false
    end
    local elapsed = now - flash.omenAt
    if elapsed < FLASH_OMEN_TO_CHANNEL_MIN_MS
            or elapsed > FLASH_OMEN_TO_CHANNEL_MAX_MS
            or (finite(flash.entityID) and flash.entityID ~= entityID)
    then
        clearFlash(state)
        diagnostic(state, 'flash_timing_invalid', now, {
            entityID = entityID,
            elapsed = elapsed,
        })
        return false
    end
    local eventKey = tostring(entityID) .. ':' .. tostring(actionID)
    if not Common.consumeEvent(state.seenChannels, eventKey, now, 500) then
        return false
    end
    local activationAt = now + channelTimeMax * 1000
            + FLASH_CHANNEL_HIT_OFFSET_MS
    flash.key = eventKey .. ':' .. tostring(math.floor(now / 100))
    flash.entityID = entityID
    flash.channelStartedAt = now
    flash.activationAt = activationAt
    flash.expiresAt = activationAt + FLASH_STATE_GRACE_MS
    state.lastDiagnostic = nil
    return true
end

local function resolveFlashCast(state, entityID, actionID, now)
    if actionID ~= STUNNING_FLASH_AID then
        return false
    end
    state = ensureState(state)
    if not finite(entityID) or not finite(now) then
        return false
    end
    local eventKey = tostring(entityID) .. ':' .. tostring(actionID)
    if not Common.consumeEvent(state.seenCasts, eventKey, now, 500) then
        return false
    end
    if type(state.flash) ~= 'table'
            or state.flash.entityID ~= entityID
    then
        return false
    end
    clearFlash(state)
    return true
end

local function updateFlashAutoFace(state, guide, now)
    state = ensureState(state)
    local flash = state.flash
    if type(flash) ~= 'table'
            or not finite(flash.activationAt)
            or not finite(flash.expiresAt)
            or now > flash.expiresAt
    then
        clearFlash(state)
        return false
    end
    if not finite(flash.entityID)
            or not finite(flash.channelStartedAt)
            or type(flash.source) ~= 'table'
    then
        Common.releaseAutoFace(state)
        return false
    end
    if now < flash.activationAt - FLASH_AUTO_FACE_LEAD_MS
            or now > flash.activationAt + FLASH_AUTO_FACE_RELEASE_MS
    then
        Common.releaseAutoFace(state)
        return false
    end
    local _, source = resolveExpectedEntity(
            flash.entityID, FLASH_CONTENT_ID, FLASH_MODEL_ID)
    local sourceDistance = source ~= nil
            and Common.distanceSquared(flash.source, source) or nil
    local player = type(guide) == 'table'
            and type(guide.GetPlayer) == 'function'
            and guide.GetPlayer() or rawget(_G, 'Player')
    local heading = flashFacingHeading(
            type(player) == 'table' and player.pos or nil, source)
    if source == nil
            or sourceDistance == nil
            or sourceDistance > BREATH_SOURCE_TOLERANCE_SQUARED
            or heading == nil
    then
        Common.releaseAutoFace(state)
        diagnostic(state, 'flash_geometry_invalid', now, flash.entityID)
        return false
    end
    flash.source = source
    local applied, reason = Common.applyAutoFace(
            state,
            flash.key,
            heading,
            now,
            flash.activationAt + FLASH_AUTO_FACE_RELEASE_MS)
    if applied ~= true then
        Common.releaseAutoFace(state)
        diagnostic(state, 'flash_facing_unavailable', now, reason)
        return false
    end
    return true
end

local function reliableAOEPosition(aoeInfo)
    if type(aoeInfo) ~= 'table' then
        return nil
    end
    return reliablePosition({
        x = aoeInfo.x,
        y = aoeInfo.y,
        z = aoeInfo.z,
    }, false)
end

local function aoeEventKey(aoeInfo)
    return tostring(aoeInfo.entityID)
            .. ':' .. tostring(aoeInfo.aoeID)
            .. ':' .. string.format('%.3f', aoeInfo.startTime)
end

local function validateOmenAOE(state, aoeInfo, now)
    local effectInfo = type(aoeInfo) == 'table'
            and type(aoeInfo.aoeEffectInfo) == 'table'
            and aoeInfo.aoeEffectInfo or nil
    local entityID = type(aoeInfo) == 'table'
            and tonumber(aoeInfo.entityID) or nil
    local source = reliableAOEPosition(aoeInfo)
    if type(aoeInfo) ~= 'table'
            or tonumber(aoeInfo.aoeID) ~= OMEN_AID
            or tonumber(aoeInfo.contentID) ~= HYDRA_CONTENT_ID
            or tonumber(aoeInfo.aoeCastType) ~= 13
            or tonumber(aoeInfo.aoeType) ~= 736
            or not finite(aoeInfo.aoeLength)
            or math.abs(aoeInfo.aoeLength - BREATH_RADIUS) > 0.5
            or not finite(aoeInfo.heading)
            or not finite(aoeInfo.duration)
            or math.abs(aoeInfo.duration - 0.7) > 0.15
            or not finite(aoeInfo.delay)
            or math.abs(aoeInfo.delay) > 0.15
            or not finite(aoeInfo.startTime)
            or effectInfo == nil
            or effectInfo.aoeEffectName ~= OMEN_EFFECT
            or not finite(entityID)
            or source == nil
    then
        diagnostic(state, 'breath_omen_invalid', now, {
            actionID = type(aoeInfo) == 'table' and aoeInfo.aoeID or nil,
            entityID = entityID,
        })
        return nil
    end
    return {
        entityID = entityID,
        heading = aoeInfo.heading,
        source = source,
        observedAt = now,
    }
end

local function validateActualAOE(state, aoeInfo, now)
    if type(aoeInfo) ~= 'table' then
        return nil
    end
    local actionID = tonumber(aoeInfo.aoeID)
    if REAL_BREATH_ACTIONS[actionID] ~= true then
        return nil
    end
    local effectInfo = type(aoeInfo.aoeEffectInfo) == 'table'
            and aoeInfo.aoeEffectInfo or nil
    local entityID = tonumber(aoeInfo.entityID)
    local source = reliableAOEPosition(aoeInfo)
    if tonumber(aoeInfo.contentID) ~= HYDRA_CONTENT_ID
            or tonumber(aoeInfo.aoeCastType) ~= 13
            or tonumber(aoeInfo.aoeType) ~= 0
            or not finite(aoeInfo.aoeLength)
            or math.abs(aoeInfo.aoeLength - BREATH_RADIUS) > 0.5
            or not finite(aoeInfo.heading)
            or not finite(aoeInfo.duration)
            or math.abs(aoeInfo.duration - 0.5) > 0.15
            or not finite(aoeInfo.delay)
            or math.abs(aoeInfo.delay) > 0.15
            or not finite(aoeInfo.startTime)
            or effectInfo == nil
            or effectInfo.aoeEffectName ~= ''
            or not finite(entityID)
            or source == nil
    then
        diagnostic(state, 'breath_actual_invalid', now, {
            actionID = actionID,
            entityID = entityID,
        })
        return nil
    end
    return {
        actionID = actionID,
        entityID = entityID,
        heading = aoeInfo.heading,
        source = source,
        observedAt = now,
    }
end

local function omenHeadingPatternValid(entries)
    if type(entries) ~= 'table' or #entries ~= BREATH_COUNT then
        return false
    end
    local clusters = {}
    for _, entry in ipairs(entries) do
        local cluster = nil
        for _, candidate in ipairs(clusters) do
            if Common.headingDifference(candidate.heading, entry.heading)
                    <= BREATH_HEADING_TOLERANCE
            then
                cluster = candidate
                break
            end
        end
        if cluster == nil then
            cluster = { heading = entry.heading, count = 0 }
            clusters[#clusters + 1] = cluster
        end
        cluster.count = cluster.count + 1
    end
    if #clusters ~= 3 then
        return false
    end
    for _, cluster in ipairs(clusters) do
        if cluster.count ~= 2 then
            return false
        end
    end
    for left = 1, 2 do
        for right = left + 1, 3 do
            if math.abs(Common.headingDifference(
                    clusters[left].heading,
                    clusters[right].heading) - math.rad(120))
                    > BREATH_HEADING_TOLERANCE
            then
                return false
            end
        end
    end
    return true
end

local function predictedBreathHitAt(round, index)
    if type(round) ~= 'table'
            or not finite(round.startedAt)
            or not finite(index)
            or index < 1
            or index > BREATH_COUNT
    then
        return nil
    end
    return round.startedAt + FIRST_ACTUAL_PREDICTED_MS
            + (index - 1) * ACTUAL_PREDICTED_GAP_MS
end

local function drawBreathPrediction(state, round, index, now)
    if type(state.predictions[index]) == 'table' then
        return false
    end
    local entry = type(round) == 'table'
            and type(round.omens) == 'table'
            and round.omens[index] or nil
    if type(entry) ~= 'table' then
        return false
    end
    local drawer = Common.getMoogleDrawer()
    if drawer == nil or type(drawer.addTimedCone) ~= 'function' then
        diagnostic(state, 'danger_drawer_unavailable', now, index)
        return false
    end
    local hitAt = predictedBreathHitAt(round, index)
    if not finite(hitAt) then
        return false
    end
    local visibleAt = index == 1 and now
            or math.max(entry.observedAt, hitAt - PREDICTION_LEAD_MS)
    local delay = math.max(0, visibleAt - now)
    local timeout = hitAt + PREDICTION_POST_HIT_MS - visibleAt
    if timeout <= 0 then
        return false
    end
    local token = drawer:addTimedCone(
            timeout,
            round.source.x, round.source.y, round.source.z,
            BREATH_RADIUS, BREATH_ANGLE, entry.heading,
            delay, nil, true)
    if type(token) ~= 'string' then
        diagnostic(state, 'danger_drawer_rejected_shape', now, index)
        return false
    end
    state.predictions[index] = {
        token = token,
        index = index,
        visibleAt = visibleAt,
        hitAt = hitAt,
        expiresAt = visibleAt + timeout
                + PREDICTION_TOKEN_GRACE_MS,
    }
    state.lastDiagnostic = nil
    return true
end

local function startBreathRound(state, entry, now)
    clearBreath(state)
    state.breathRound = {
        startedAt = now,
        lastOmenAt = nil,
        lastActualAt = nil,
        source = entry.source,
        omens = {},
        resolved = 0,
        patternValidated = false,
        expiresAt = now + BREATH_ROUND_TIMEOUT_MS,
    }
    return state.breathRound
end

local function failBreathRound(state, code, now, context)
    clearBreath(state)
    diagnostic(state, code, now, context)
    return false
end

local function handleOmenAOE(state, aoeInfo, now)
    state = ensureState(state)
    local entry = validateOmenAOE(state, aoeInfo, now)
    if entry == nil then
        clearBreath(state)
        return false
    end
    local key = aoeEventKey(aoeInfo)
    if state.seenAOEs[key] ~= nil then
        return false
    end
    state.seenAOEs[key] = now

    local round = state.breathRound
    if type(round) ~= 'table'
            or not finite(round.startedAt)
            or now - round.startedAt > OMEN_SEQUENCE_WINDOW_MS
    then
        round = startBreathRound(state, entry, now)
    end
    if round.resolved > 0 or #round.omens >= BREATH_COUNT then
        return failBreathRound(state, 'breath_omen_conflict', now, {
            reason = 'unexpected_extra_omen',
            count = #round.omens,
            resolved = round.resolved,
        })
    end
    local sourceDistance = Common.distanceSquared(round.source, entry.source)
    if sourceDistance == nil
            or sourceDistance > BREATH_SOURCE_TOLERANCE_SQUARED
    then
        return failBreathRound(state, 'breath_omen_conflict', now, {
            reason = 'source_position',
        })
    end
    if finite(round.lastOmenAt) then
        local gap = now - round.lastOmenAt
        if gap < OMEN_GAP_MIN_MS or gap > OMEN_GAP_MAX_MS then
            return failBreathRound(state, 'breath_omen_conflict', now, {
                reason = 'omen_gap',
                gap = gap,
            })
        end
    end
    round.omens[#round.omens + 1] = entry
    round.lastOmenAt = now
    drawBreathPrediction(state, round, #round.omens, now)
    if #round.omens == BREATH_COUNT then
        if not omenHeadingPatternValid(round.omens) then
            return failBreathRound(state, 'breath_pattern_invalid', now, {
                count = #round.omens,
            })
        end
        round.patternValidated = true
    end
    return true
end

local function actualTimingValid(round, now)
    if round.resolved == 0 then
        local elapsed = now - round.startedAt
        return elapsed >= FIRST_ACTUAL_MIN_MS
                and elapsed <= FIRST_ACTUAL_MAX_MS, elapsed
    end
    if not finite(round.lastActualAt) then
        return false, nil
    end
    local gap = now - round.lastActualAt
    return gap >= ACTUAL_GAP_MIN_MS
            and gap <= ACTUAL_GAP_MAX_MS, gap
end

local function handleActualAOE(state, aoeInfo, now)
    state = ensureState(state)
    local entry = validateActualAOE(state, aoeInfo, now)
    if entry == nil then
        clearBreath(state)
        return false
    end
    local key = aoeEventKey(aoeInfo)
    if state.seenAOEs[key] ~= nil then
        return false
    end
    state.seenAOEs[key] = now
    local round = state.breathRound
    if type(round) ~= 'table'
            or round.patternValidated ~= true
            or #round.omens ~= BREATH_COUNT
            or round.resolved >= BREATH_COUNT
    then
        return failBreathRound(state, 'breath_actual_conflict', now, {
            reason = 'incomplete_omen_sequence',
            omenCount = type(round) == 'table' and #round.omens or 0,
        })
    end
    local sourceDistance = Common.distanceSquared(round.source, entry.source)
    local timingValid, timing = actualTimingValid(round, now)
    local expectedIndex = round.resolved + 1
    local expected = round.omens[expectedIndex]
    local headingDifference = type(expected) == 'table'
            and Common.headingDifference(expected.heading, entry.heading) or nil
    if sourceDistance == nil
            or sourceDistance > BREATH_SOURCE_TOLERANCE_SQUARED
            or not timingValid
            or headingDifference == nil
            or headingDifference > BREATH_HEADING_TOLERANCE
    then
        local reason = 'heading'
        if sourceDistance == nil
                or sourceDistance > BREATH_SOURCE_TOLERANCE_SQUARED
        then
            reason = 'source_position'
        elseif not timingValid then
            reason = 'actual_timing'
        end
        return failBreathRound(state, 'breath_actual_conflict', now, {
            reason = reason,
            index = expectedIndex,
            timing = timing,
            headingDifference = headingDifference,
            actionID = entry.actionID,
        })
    end
    deletePrediction(state, expectedIndex)
    round.resolved = expectedIndex
    round.lastActualAt = now
    if round.resolved >= BREATH_COUNT then
        state.breathRound = nil
        state.lastDiagnostic = nil
        return true
    end
    return true
end

local function pruneState(state, now)
    state = ensureState(state)
    local changed = false
    if type(state.flash) == 'table'
            and (not finite(state.flash.expiresAt)
                    or now > state.flash.expiresAt)
    then
        clearFlash(state)
        changed = true
    end
    for index, prediction in pairs(state.predictions) do
        if type(prediction) ~= 'table'
                or not finite(prediction.expiresAt)
                or now > prediction.expiresAt
        then
            deletePrediction(state, index)
            changed = true
        end
    end
    if type(state.breathRound) == 'table'
            and (not finite(state.breathRound.expiresAt)
                    or now > state.breathRound.expiresAt)
    then
        clearBreath(state)
        changed = true
    end
    Common.pruneSeen(state.seenVisibility, now, SEEN_TTL_MS)
    Common.pruneSeen(state.seenChannels, now, SEEN_TTL_MS)
    Common.pruneSeen(state.seenCasts, now, SEEN_TTL_MS)
    Common.pruneSeen(state.seenAOEs, now, SEEN_TTL_MS)
    return changed
end

local Feature = {}

Feature.Init = function(M)
    if type(M.MagiHydra) == 'table' then
        clearState(M.MagiHydra)
    end
    M.MagiHydra = newState()
    getConfig(M)
    M.SetMagiHydraEnabled = function(enabled)
        local cfg = getConfig(M)
        if cfg ~= nil then
            cfg.Enable = enabled == true
        end
        if enabled ~= true then
            clearState(M.MagiHydra)
        end
    end
    M.SetMagiHydraAutoFaceEnabled = function(enabled)
        local cfg = getConfig(M)
        if cfg ~= nil then
            cfg.AutoFaceStunningFlash = enabled == true
        end
        if enabled ~= true then
            clearFlash(M.MagiHydra)
        end
    end
    M.SetMagiHydraBreathPredictionEnabled = function(enabled)
        local cfg = getConfig(M)
        if cfg ~= nil then
            cfg.DrawMultipleBreathPrediction = enabled == true
        end
        if enabled ~= true then
            clearBreath(M.MagiHydra)
        end
    end
end

Feature.Clear = function()
    local state = getState()
    if state ~= nil then
        clearState(state)
    end
end

Feature.OnVisibilityChange = function(
        entityID, wasVisible, isVisible, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state ~= nil
            and cfg ~= nil
            and cfg.Enable == true
            and cfg.AutoFaceStunningFlash == true
    then
        return recordFlashVisibility(
                state, entityID, wasVisible, isVisible, now)
    end
    return false
end

Feature.OnEntityChannel = function(
        entityID, actionID, channelTimeMax, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state ~= nil
            and cfg ~= nil
            and cfg.Enable == true
            and cfg.AutoFaceStunningFlash == true
    then
        return recordFlashChannel(
                state, entityID, actionID, channelTimeMax, now)
    end
    return false
end

Feature.OnEntityCast = function(entityID, actionID, now)
    local state = getState()
    return state ~= nil
            and resolveFlashCast(state, entityID, actionID, now) or false
end

Feature.OnAOECreate = function(aoeInfo, now)
    local actionID = type(aoeInfo) == 'table'
            and tonumber(aoeInfo.aoeID) or nil
    if actionID ~= FLASH_OMEN_AID
            and actionID ~= OMEN_AID
            and REAL_BREATH_ACTIONS[actionID] ~= true
    then
        return false
    end
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state == nil
            or cfg == nil
            or cfg.Enable ~= true
    then
        return false
    end
    if actionID == FLASH_OMEN_AID then
        return cfg.AutoFaceStunningFlash == true
                and recordFlashOmenAOE(state, aoeInfo, now) or false
    end
    if cfg.DrawMultipleBreathPrediction ~= true then
        return false
    end
    if actionID == OMEN_AID then
        return handleOmenAOE(state, aoeInfo, now)
    end
    return handleActualAOE(state, aoeInfo, now)
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
    local changed = pruneState(state, now)
    if cfg.AutoFaceStunningFlash == true then
        changed = updateFlashAutoFace(state, guide, now) or changed
    else
        clearFlash(state)
    end
    if cfg.DrawMultipleBreathPrediction ~= true then
        clearBreath(state)
    end
    return changed
end

Feature.Test = {
    Defaults = DEFAULTS,
    HydraContentID = HYDRA_CONTENT_ID,
    HelperModelID = HELPER_MODEL_ID,
    FlashContentID = FLASH_CONTENT_ID,
    FlashModelID = FLASH_MODEL_ID,
    FlashOmenAID = FLASH_OMEN_AID,
    FlashOmenEffect = FLASH_OMEN_EFFECT,
    StunningFlashAID = STUNNING_FLASH_AID,
    FlashOmenToHitMs = FLASH_OMEN_TO_HIT_MS,
    FlashVisibilityToHitMs = FLASH_VISIBILITY_TO_HIT_MS,
    FlashChannelHitOffsetMs = FLASH_CHANNEL_HIT_OFFSET_MS,
    FlashAutoFaceLeadMs = FLASH_AUTO_FACE_LEAD_MS,
    FlashAutoFaceReleaseMs = FLASH_AUTO_FACE_RELEASE_MS,
    OmenAID = OMEN_AID,
    OmenEffect = OMEN_EFFECT,
    RealBreathActions = REAL_BREATH_ACTIONS,
    BreathRadius = BREATH_RADIUS,
    BreathAngle = BREATH_ANGLE,
    BreathCount = BREATH_COUNT,
    FirstActualPredictedMs = FIRST_ACTUAL_PREDICTED_MS,
    ActualPredictedGapMs = ACTUAL_PREDICTED_GAP_MS,
    PredictionLeadMs = PREDICTION_LEAD_MS,
    PredictionPostHitMs = PREDICTION_POST_HIT_MS,
    NewState = newState,
    EnsureState = ensureState,
    RecordFlashOmenAOE = recordFlashOmenAOE,
    RecordFlashVisibility = recordFlashVisibility,
    RecordFlashChannel = recordFlashChannel,
    ResolveFlashCast = resolveFlashCast,
    FlashFacingHeading = flashFacingHeading,
    UpdateFlashAutoFace = updateFlashAutoFace,
    OmenHeadingPatternValid = omenHeadingPatternValid,
    HandleOmenAOE = handleOmenAOE,
    HandleActualAOE = handleActualAOE,
    PruneState = pruneState,
    ClearState = clearState,
}

return Feature
end

rawset(_G, 'MuAiOccultCrescentNorthMagiHydra', Module)
return Module
