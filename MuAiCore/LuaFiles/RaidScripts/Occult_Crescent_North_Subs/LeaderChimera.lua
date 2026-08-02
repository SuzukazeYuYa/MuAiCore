local Module = {}

function Module.Create(Context)
    assert(type(Context) == 'table' and type(Context.Common) == 'table')
    local Common = Context.Common
    local finite = Context.finite
    local nowMs = Context.nowMs
    local reliablePosition = Context.reliablePosition
    local resolveEntity = Context.resolveEntity

local BOSS_CONTENT_ID = 14767
local ICE_ORB_CONTENT_ID = 14769
local ICE_ORB_MODEL_ID = 19584
local LIGHTNING_ORB_CONTENT_ID = 14768
local LIGHTNING_ORB_MODEL_ID = 19583

local BREATH_RADIUS = 30
local BREATH_ANGLE = math.rad(120)
local BREATH_PREVIEW_MS = 5000
local BREATH_TIMEOUT_GRACE_MS = 500
local BREATH_ACTIVATION_OFFSETS_MS = { 6000, 8700, 11400 }
local ROAR_ACTIVATION_OFFSET_MS = 18000
local ROAR_PREVIEW_MS = 6000
local ROAR_TIMEOUT_GRACE_MS = 500
local ICE_ROAR_RADIUS = 9
local LIGHTNING_ROAR_INNER = 8
local LIGHTNING_ROAR_OUTER = 30
local ICE_ORB_RADIUS = 12
local ICE_ORB_SEED_RADIUS = 9.25
local ICE_ORB_LINK_RADIUS = 12.25
local ICE_ORB_EXPECTED_COUNT = 12
local ICE_ORB_ACTIVE_COUNT = 11
local LIGHTNING_ORB_EXPECTED_COUNT = 3
local ORB_PREDICTION_TIMEOUT_MS = 12000
local ROUND_TIMEOUT_MS = 30000
local TOKEN_GRACE_MS = 1000
local BREATH_HEADING_TOLERANCE = math.rad(5)
local BLACKLIST_SOURCE = 'MuAiCore - 统领奇美拉首段吐息校正'

local BREATH_OMEN_AIDS = {
    [48631] = true,
    [48629] = true,
}

local DEFAULTS = {
    Enable = true,
    DrawBreathSequencePrediction = true,
    DrawOrbPrediction = true,
}

-- Two 2026-08-01 captures and the 2026-08-02 live capture have the same
-- arena-locked sequence. Argus publishes the first 120-degree omen at +/-135
-- degrees; the three actual hits resolve at 180, then turn by +/-120 degrees.
local BREATH_SPECS = {
    [48631] = {
        kind = 'ice',
        expectedOmenHeading = math.rad(135),
        finalHeadingOffset = math.rad(45),
        turn = math.rad(120),
        actions = { 48631, 48632, 49748 },
        roarAction = 48633,
        roarKind = 'circle',
    },
    [48629] = {
        kind = 'lightning',
        expectedOmenHeading = math.rad(-135),
        finalHeadingOffset = math.rad(-45),
        turn = math.rad(-120),
        actions = { 48629, 48630, 49747 },
        roarAction = 48634,
        roarKind = 'donut',
    },
}

local ORB_SPECS = {
    ice = {
        contentID = ICE_ORB_CONTENT_ID,
        modelID = ICE_ORB_MODEL_ID,
        actionID = 48635,
    },
    lightning = {
        contentID = LIGHTNING_ORB_CONTENT_ID,
        modelID = LIGHTNING_ORB_MODEL_ID,
        actionID = 48636,
    },
}

local function normalizeHeading(heading)
    return (heading + math.pi) % (2 * math.pi) - math.pi
end

local function newState()
    return {
        round = nil,
        orbs = { ice = {}, lightning = {} },
        active = {},
        blacklist = { owned = {}, registered = false },
        lastDiagnostic = nil,
    }
end

local function ensureState(state)
    state = type(state) == 'table' and state or newState()
    state.orbs = type(state.orbs) == 'table' and state.orbs or {}
    state.orbs.ice = type(state.orbs.ice) == 'table'
            and state.orbs.ice or {}
    state.orbs.lightning = type(state.orbs.lightning) == 'table'
            and state.orbs.lightning or {}
    state.active = type(state.active) == 'table' and state.active or {}
    state.blacklist = type(state.blacklist) == 'table'
            and state.blacklist or {}
    state.blacklist.owned = type(state.blacklist.owned) == 'table'
            and state.blacklist.owned or {}
    state.blacklist.registered = state.blacklist.registered == true
    return state
end

local feature = Common.newFeature({
    key = 'LeaderChimera',
    defaults = DEFAULTS,
    newState = newState,
    ensureState = ensureState,
    diagnosticThrottleMs = 1000,
    diagnosticText = {
        breath_geometry_invalid = '统领奇美拉吐息缺少可靠几何',
        breath_heading_unexpected = '统领奇美拉吐息预兆方向不符合已验证模式',
        danger_drawer_unavailable = '统领奇美拉危险范围绘图器不可用',
        danger_drawer_rejected_shape = '统领奇美拉危险范围绘制失败',
        roar_sequence_mismatch = '统领奇美拉咆哮与吐息序列不匹配',
        ice_orb_set_incomplete = '统领奇美拉冰球集合不完整',
        ice_orb_chain_unresolved = '统领奇美拉冰球连锁无法可靠判定',
        lightning_orb_set_incomplete = '统领奇美拉雷球集合不完整',
    },
})
local getConfig = feature.GetConfig

local function getState()
    return Common.getRuntimeState(
            'LeaderChimera', newState, ensureState)
end

local function diagnostic(state, code, now, context)
    feature.Diagnostic(
            state, rawget(_G, 'MuAiGuide'), code, now, context)
end

local function getBlacklist(create)
    return Common.getMoogleTable('aoeIDUserBlacklist', create)
end

local function ownsBlacklist(state, actionID, current)
    return current ~= nil
            and (current == state.blacklist.owned[actionID]
            or (type(current) == 'table'
                    and current.source == BLACKLIST_SOURCE))
end

local function registerBlacklist(state)
    state = ensureState(state)
    local blacklist = getBlacklist(true)
    if blacklist == nil then
        state.blacklist.registered = false
        return false
    end
    for actionID in pairs(BREATH_OMEN_AIDS) do
        local current = blacklist[actionID]
        if current == nil then
            local owned = {
                label = '统领奇美拉首段吐息校正',
                source = BLACKLIST_SOURCE,
            }
            blacklist[actionID] = owned
            state.blacklist.owned[actionID] = owned
        elseif type(current) == 'table'
                and current.source == BLACKLIST_SOURCE
        then
            state.blacklist.owned[actionID] = current
        else
            state.blacklist.owned[actionID] = nil
        end
    end
    state.blacklist.registered = true
    return true
end

local function unregisterBlacklist(state)
    state = ensureState(state)
    local blacklist = getBlacklist(false)
    if blacklist == nil then
        state.blacklist.registered = false
        return false
    end
    for actionID in pairs(BREATH_OMEN_AIDS) do
        local current = blacklist[actionID]
        if ownsBlacklist(state, actionID, current) then
            blacklist[actionID] = nil
        end
    end
    state.blacklist.owned = {}
    state.blacklist.registered = false
    return true
end

local function applyBlacklist(state, enabled)
    if enabled == true then
        return registerBlacklist(state)
    end
    return unregisterBlacklist(state)
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

local function deleteActive(state, key)
    local entry = type(state) == 'table'
            and type(state.active) == 'table'
            and state.active[key] or nil
    if type(entry) ~= 'table' then
        return false
    end
    Common.deleteTimedShape(entry.token)
    state.active[key] = nil
    return true
end

local function rememberActive(state, key, token, expiresAt, metadata)
    if type(token) ~= 'string' or not finite(expiresAt) then
        return false
    end
    deleteActive(state, key)
    metadata = type(metadata) == 'table' and metadata or {}
    metadata.token = token
    metadata.expiresAt = expiresAt
    state.active[key] = metadata
    return true
end

local function clearDraws(state)
    state = ensureState(state)
    local keys = {}
    for key in pairs(state.active) do
        keys[#keys + 1] = key
    end
    for _, key in ipairs(keys) do
        deleteActive(state, key)
    end
    state.active = {}
end

local function clearState(state)
    state = ensureState(state)
    clearDraws(state)
    state.round = nil
    state.orbs = { ice = {}, lightning = {} }
    state.lastDiagnostic = nil
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

local function drawTimedCone(
        state, drawer, key, source, heading, activationOffset, now, actionID)
    if type(drawer.addTimedCone) ~= 'function' then
        return false
    end
    local delay = math.max(0, activationOffset - BREATH_PREVIEW_MS)
    local timeout = BREATH_PREVIEW_MS + BREATH_TIMEOUT_GRACE_MS
    local token = drawer:addTimedCone(
            timeout,
            source.x, source.y, source.z,
            BREATH_RADIUS, BREATH_ANGLE, heading, delay)
    return rememberActive(
            state,
            key,
            token,
            now + delay + timeout + TOKEN_GRACE_MS,
            { kind = 'breath', actionID = actionID })
end

local function drawPredictedRoar(state, drawer, spec, source, now)
    local delay = ROAR_ACTIVATION_OFFSET_MS - ROAR_PREVIEW_MS
    local timeout = ROAR_PREVIEW_MS + ROAR_TIMEOUT_GRACE_MS
    local token = nil
    if spec.roarKind == 'circle'
            and type(drawer.addTimedCircle) == 'function'
    then
        token = drawer:addTimedCircle(
                timeout,
                source.x, source.y, source.z,
                ICE_ROAR_RADIUS, delay)
    elseif spec.roarKind == 'donut'
            and type(drawer.addTimedDonut) == 'function'
    then
        token = drawer:addTimedDonut(
                timeout,
                source.x, source.y, source.z,
                LIGHTNING_ROAR_INNER, LIGHTNING_ROAR_OUTER, delay)
    end
    return rememberActive(
            state,
            'roar',
            token,
            now + delay + timeout + TOKEN_GRACE_MS,
            { kind = 'roar', actionID = spec.roarAction })
end

local function startBreathRound(state, aoeInfo, now, drawSequence)
    state = ensureState(state)
    local actionID = type(aoeInfo) == 'table'
            and tonumber(aoeInfo.aoeID) or nil
    local spec = BREATH_SPECS[actionID]
    if spec == nil then
        return false
    end
    local entityID = tonumber(aoeInfo.entityID)
    local source = reliableAOEPosition(aoeInfo)
    local effectName = type(aoeInfo.aoeEffectInfo) == 'table'
            and aoeInfo.aoeEffectInfo.aoeEffectName or nil
    if not finite(now)
            or not finite(entityID)
            or tonumber(aoeInfo.contentID) ~= BOSS_CONTENT_ID
            or tonumber(aoeInfo.aoeCastType) ~= 13
            or not finite(aoeInfo.aoeLength)
            or math.abs(aoeInfo.aoeLength - BREATH_RADIUS) > 0.5
            or effectName ~= 'gl_fan120_1bxf'
            or not finite(aoeInfo.duration)
            or aoeInfo.duration < 5.4
            or aoeInfo.duration > 6.0
            or not finite(aoeInfo.heading)
            or source == nil
    then
        diagnostic(state, 'breath_geometry_invalid', nowMs(), {
            actionID = actionID,
            entityID = entityID,
        })
        return false
    end
    local headingDifference = Common.headingDifference(
            aoeInfo.heading, spec.expectedOmenHeading)
    if headingDifference == nil
            or headingDifference > BREATH_HEADING_TOLERANCE
    then
        diagnostic(state, 'breath_heading_unexpected', now, {
            actionID = actionID,
            heading = aoeInfo.heading,
            difference = headingDifference,
        })
        return false
    end
    local round = state.round
    if type(round) == 'table'
            and round.bossEntityID == entityID
            and round.firstActionID == actionID
            and finite(round.startedAt)
            and math.abs(round.startedAt - now) <= 500
    then
        return false
    end

    clearDraws(state)
    state.orbs = { ice = {}, lightning = {} }
    local firstHeading = normalizeHeading(
            aoeInfo.heading + spec.finalHeadingOffset)
    state.round = {
        bossEntityID = entityID,
        firstActionID = actionID,
        kind = spec.kind,
        roarAction = spec.roarAction,
        source = source,
        startedAt = now,
        expiresAt = now + ROUND_TIMEOUT_MS,
    }

    if drawSequence ~= true then
        state.lastDiagnostic = nil
        return true
    end
    local drawer = getDangerDrawer()
    if drawer == nil then
        diagnostic(state, 'danger_drawer_unavailable', now, actionID)
        return false
    end
    local created = {}
    for index, breathAction in ipairs(spec.actions) do
        local key = 'breath:' .. tostring(breathAction)
        local heading = normalizeHeading(
                firstHeading + (index - 1) * spec.turn)
        if not drawTimedCone(
                state,
                drawer,
                key,
                source,
                heading,
                BREATH_ACTIVATION_OFFSETS_MS[index],
                now,
                breathAction)
        then
            for _, createdKey in ipairs(created) do
                deleteActive(state, createdKey)
            end
            diagnostic(state, 'danger_drawer_rejected_shape', now, {
                actionID = breathAction,
                kind = 'cone',
            })
            return false
        end
        created[#created + 1] = key
    end
    if not drawPredictedRoar(state, drawer, spec, source, now) then
        for _, createdKey in ipairs(created) do
            deleteActive(state, createdKey)
        end
        diagnostic(state, 'danger_drawer_rejected_shape', now, {
            actionID = spec.roarAction,
            kind = spec.roarKind,
        })
        return false
    end
    state.lastDiagnostic = nil
    return true
end

local function handleEntityAdd(state, entityID, contentID, now)
    state = ensureState(state)
    if not finite(entityID) or not finite(now) then
        return false
    end
    local round = state.round
    local spec = type(round) == 'table' and ORB_SPECS[round.kind] or nil
    if spec == nil or now > round.expiresAt then
        return false
    end
    local callbackContentID = tonumber(contentID)
    if callbackContentID ~= nil then
        if callbackContentID ~= spec.contentID then
            return false
        end
    else
        local entity = resolveEntity(entityID)
        if type(entity) == 'table'
                and (tonumber(entity.id) ~= entityID
                or tonumber(entity.contentid) ~= spec.contentID
                or tonumber(entity.modelid) ~= spec.modelID)
        then
            return false
        end
    end
    local bucket = state.orbs[round.kind]
    if bucket[entityID] ~= nil then
        return false
    end
    bucket[entityID] = { entityID = entityID, addedAt = now }
    return true
end

local function collectOrbSnapshots(state, kind)
    local spec = ORB_SPECS[kind]
    local bucket = type(state.orbs) == 'table' and state.orbs[kind] or nil
    if spec == nil or type(bucket) ~= 'table' then
        return nil, nil
    end
    local orbs = {}
    local pending = 0
    local rejected = {}
    for entityID, candidate in pairs(bucket) do
        candidate = type(candidate) == 'table' and candidate or {
            entityID = entityID,
        }
        bucket[entityID] = candidate
        -- OnEntityAdd can precede mGetEntity by a frame. Keep only the stable
        -- ID at that boundary, then cache geometry after content/model proof.
        if candidate.position == nil then
            local entity = resolveEntity(entityID)
            if type(entity) == 'table' then
                if tonumber(entity.id) ~= entityID
                        or tonumber(entity.contentid) ~= spec.contentID
                        or tonumber(entity.modelid) ~= spec.modelID
                then
                    rejected[#rejected + 1] = entityID
                elseif entity.alive ~= false then
                    candidate.position = reliablePosition(entity.pos, false)
                end
            end
        end
        if candidate.position ~= nil then
            orbs[#orbs + 1] = {
                entityID = entityID,
                position = candidate.position,
            }
        else
            pending = pending + 1
        end
    end
    for _, entityID in ipairs(rejected) do
        bucket[entityID] = nil
        pending = pending - 1
    end
    return orbs, pending
end

local function connectedIceOrbs(orbs, bossPosition)
    if type(orbs) ~= 'table' or #orbs ~= ICE_ORB_EXPECTED_COUNT then
        return nil
    end
    local selected = {}
    local selectedCount = 0
    for index, orb in ipairs(orbs) do
        local distance = Common.distanceSquared(orb.position, bossPosition)
        if distance ~= nil
                and distance <= ICE_ORB_SEED_RADIUS * ICE_ORB_SEED_RADIUS
        then
            selected[index] = true
            selectedCount = selectedCount + 1
        end
    end
    if selectedCount ~= 2 then
        return nil
    end
    local changed = true
    while changed do
        changed = false
        for index, orb in ipairs(orbs) do
            if not selected[index] then
                for sourceIndex, source in ipairs(orbs) do
                    local distance = selected[sourceIndex]
                            and Common.distanceSquared(
                                    orb.position, source.position) or nil
                    if distance ~= nil
                            and distance
                                    <= ICE_ORB_LINK_RADIUS
                                            * ICE_ORB_LINK_RADIUS
                    then
                        selected[index] = true
                        selectedCount = selectedCount + 1
                        changed = true
                        break
                    end
                end
            end
        end
    end
    if selectedCount ~= ICE_ORB_ACTIVE_COUNT then
        return nil
    end
    local active = {}
    for index, orb in ipairs(orbs) do
        if selected[index] then
            active[#active + 1] = orb
        end
    end
    return active
end

local function drawOrbSet(state, kind, orbs, now)
    local drawer = getDangerDrawer()
    if drawer == nil then
        diagnostic(state, 'danger_drawer_unavailable', now, kind)
        return false
    end
    local created = {}
    for _, orb in ipairs(orbs) do
        local token = nil
        if kind == 'ice' and type(drawer.addTimedCircle) == 'function' then
            token = drawer:addTimedCircle(
                    ORB_PREDICTION_TIMEOUT_MS,
                    orb.position.x, orb.position.y, orb.position.z,
                    ICE_ORB_RADIUS)
        elseif kind == 'lightning'
                and type(drawer.addTimedDonut) == 'function'
        then
            token = drawer:addTimedDonut(
                    ORB_PREDICTION_TIMEOUT_MS,
                    orb.position.x, orb.position.y, orb.position.z,
                    LIGHTNING_ROAR_INNER, LIGHTNING_ROAR_OUTER)
        end
        local key = 'orb:' .. tostring(orb.entityID)
        if not rememberActive(
                state,
                key,
                token,
                now + ORB_PREDICTION_TIMEOUT_MS + TOKEN_GRACE_MS,
                {
                    kind = kind .. '_orb',
                    entityID = orb.entityID,
                    actionID = ORB_SPECS[kind].actionID,
                })
        then
            for _, createdKey in ipairs(created) do
                deleteActive(state, createdKey)
            end
            diagnostic(state, 'danger_drawer_rejected_shape', now, {
                kind = kind,
                entityID = orb.entityID,
            })
            return false
        end
        created[#created + 1] = key
    end
    state.lastDiagnostic = nil
    return #created > 0
end

local function drawOrbPredictionIfReady(state, now, diagnoseIncomplete)
    state = ensureState(state)
    local round = state.round
    if type(round) ~= 'table' or round.orbsPredicted == true then
        return round ~= nil and round.orbsPredicted == true
    end
    local bossPosition = reliablePosition(round.source, false)
    local orbs, pending = collectOrbSnapshots(state, round.kind)
    local expected = round.kind == 'ice'
            and ICE_ORB_EXPECTED_COUNT or LIGHTNING_ORB_EXPECTED_COUNT
    if bossPosition == nil
            or type(orbs) ~= 'table'
            or #orbs ~= expected
    then
        if diagnoseIncomplete == true then
            diagnostic(
                    state,
                    round.kind == 'ice'
                            and 'ice_orb_set_incomplete'
                            or 'lightning_orb_set_incomplete',
                    now,
                    {
                        observed = type(orbs) == 'table' and #orbs or nil,
                        pending = pending,
                        expected = expected,
                    })
        end
        return false
    end
    local selected = orbs
    if round.kind == 'ice' then
        selected = connectedIceOrbs(orbs, bossPosition)
        if selected == nil then
            if diagnoseIncomplete == true then
                diagnostic(state, 'ice_orb_chain_unresolved', now, {
                    observed = #orbs,
                    expectedActive = ICE_ORB_ACTIVE_COUNT,
                })
            end
            return false
        end
    end
    local drawn = drawOrbSet(state, round.kind, selected, now)
    if drawn then
        round.orbsPredicted = true
        round.orbsPredictedAt = now
    end
    return drawn
end

local function handleRoarChannel(
        state, entityID, actionID, channelTimeMax, now, drawOrbs)
    state = ensureState(state)
    if actionID ~= 48633 and actionID ~= 48634 then
        return false
    end
    local round = state.round
    local elapsed = type(round) == 'table'
            and finite(round.startedAt) and now - round.startedAt or nil
    if type(round) ~= 'table'
            or round.bossEntityID ~= entityID
            or round.roarAction ~= actionID
            or not finite(channelTimeMax)
            or channelTimeMax < 3.4
            or channelTimeMax > 4.0
            or not finite(elapsed)
            or elapsed < 13000
            or elapsed > 15500
    then
        diagnostic(state, 'roar_sequence_mismatch', now, {
            entityID = entityID,
            actionID = actionID,
            elapsed = elapsed,
        })
        return false
    end
    deleteActive(state, 'roar')
    if drawOrbs ~= true then
        return true
    end
    return drawOrbPredictionIfReady(state, now, true)
end

local function handleEntityCast(state, entityID, actionID)
    state = ensureState(state)
    local removed = deleteActive(
            state, 'breath:' .. tostring(actionID))
    if actionID == 48635 or actionID == 48636 then
        removed = deleteActive(
                state, 'orb:' .. tostring(entityID)) or removed
    end
    return removed
end

local function pruneState(state, now)
    state = ensureState(state)
    if not finite(now) then
        return false
    end
    local removed = false
    local expired = {}
    for key, entry in pairs(state.active) do
        if not finite(entry.expiresAt) or now > entry.expiresAt then
            expired[#expired + 1] = key
        end
    end
    for _, key in ipairs(expired) do
        removed = deleteActive(state, key) or removed
    end
    if type(state.round) == 'table'
            and (not finite(state.round.expiresAt)
                    or now > state.round.expiresAt)
    then
        clearState(state)
        return true
    end
    return removed
end

local Feature = {}

Feature.Init = function(M)
    if type(M.LeaderChimera) == 'table' then
        clearState(M.LeaderChimera)
        applyBlacklist(M.LeaderChimera, false)
    end
    M.LeaderChimera = newState()
    local initialConfig = getConfig(M)
    M.SetLeaderChimeraEnabled = function(enabled)
        local cfg = getConfig(M)
        if cfg ~= nil then
            cfg.Enable = enabled == true
        end
        if enabled == true then
            applyBlacklist(
                    M.LeaderChimera,
                    cfg ~= nil
                            and cfg.DrawBreathSequencePrediction == true)
        else
            clearState(M.LeaderChimera)
            applyBlacklist(M.LeaderChimera, false)
        end
    end
    M.SetLeaderChimeraBreathPredictionEnabled = function(enabled)
        local cfg = getConfig(M)
        if cfg ~= nil then
            cfg.DrawBreathSequencePrediction = enabled == true
        end
        applyBlacklist(
                M.LeaderChimera,
                enabled == true and cfg ~= nil and cfg.Enable == true)
        if enabled ~= true then
            local state = ensureState(M.LeaderChimera)
            local keys = {}
            for key, entry in pairs(state.active) do
                if entry.kind == 'breath' or entry.kind == 'roar' then
                    keys[#keys + 1] = key
                end
            end
            for _, key in ipairs(keys) do
                deleteActive(state, key)
            end
        end
    end
    M.SetLeaderChimeraOrbPredictionEnabled = function(enabled)
        local cfg = getConfig(M)
        if cfg ~= nil then
            cfg.DrawOrbPrediction = enabled == true
        end
        if enabled ~= true then
            local state = ensureState(M.LeaderChimera)
            local keys = {}
            for key, entry in pairs(state.active) do
                if entry.kind == 'ice_orb'
                        or entry.kind == 'lightning_orb'
                then
                    keys[#keys + 1] = key
                end
            end
            for _, key in ipairs(keys) do
                deleteActive(state, key)
            end
            state.orbs = { ice = {}, lightning = {} }
            if type(state.round) == 'table' then
                state.round.orbsPredicted = false
                state.round.orbsPredictedAt = nil
            end
        end
    end
    if initialConfig ~= nil and initialConfig.Enable == true
            and initialConfig.DrawBreathSequencePrediction == true
    then
        applyBlacklist(M.LeaderChimera, true)
    end
end

Feature.Clear = function(releaseOwnership)
    local state = getState()
    if state ~= nil then
        clearState(state)
        if releaseOwnership == true then
            applyBlacklist(state, false)
        end
    end
end

Feature.OnAOECreate = function(aoeInfo, now)
    local actionID = type(aoeInfo) == 'table'
            and tonumber(aoeInfo.aoeID) or nil
    if BREATH_SPECS[actionID] == nil then
        return false
    end
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state ~= nil and cfg ~= nil and cfg.Enable == true then
        return startBreathRound(
                state,
                aoeInfo,
                now,
                cfg.DrawBreathSequencePrediction == true)
    end
    return false
end

Feature.OnEntityAdd = function(entityID, contentID, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state ~= nil
            and cfg ~= nil
            and cfg.Enable == true
            and cfg.DrawOrbPrediction == true
    then
        return handleEntityAdd(state, entityID, contentID, now)
    end
    return false
end

Feature.OnEntityChannel = function(
        entityID, actionID, channelTimeMax, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state ~= nil and cfg ~= nil and cfg.Enable == true then
        return handleRoarChannel(
                state,
                entityID,
                actionID,
                channelTimeMax,
                now,
                cfg.DrawOrbPrediction == true)
    end
    return false
end

Feature.OnEntityCast = function(entityID, actionID)
    local state = getState()
    return state ~= nil
            and handleEntityCast(state, entityID, actionID) or false
end

Feature.Update = function(guide, now)
    local state = getState()
    if state == nil then
        return false
    end
    local cfg = getConfig(guide)
    if cfg ~= nil and cfg.Enable == true then
        applyBlacklist(
                state, cfg.DrawBreathSequencePrediction == true)
        local pruned = pruneState(state, now)
        local drawn = cfg.DrawOrbPrediction == true
                and drawOrbPredictionIfReady(state, now, false) or false
        return pruned or drawn
    end
    clearState(state)
    applyBlacklist(state, false)
    return false
end

Feature.Test = {
    Defaults = DEFAULTS,
    BreathSpecs = BREATH_SPECS,
    OrbSpecs = ORB_SPECS,
    BreathRadius = BREATH_RADIUS,
    BreathAngle = BREATH_ANGLE,
    BreathPreviewMs = BREATH_PREVIEW_MS,
    BreathTimeoutGraceMs = BREATH_TIMEOUT_GRACE_MS,
    BreathActivationOffsetsMs = BREATH_ACTIVATION_OFFSETS_MS,
    RoarActivationOffsetMs = ROAR_ACTIVATION_OFFSET_MS,
    RoarPreviewMs = ROAR_PREVIEW_MS,
    RoarTimeoutGraceMs = ROAR_TIMEOUT_GRACE_MS,
    IceRoarRadius = ICE_ROAR_RADIUS,
    LightningRoarInner = LIGHTNING_ROAR_INNER,
    LightningRoarOuter = LIGHTNING_ROAR_OUTER,
    IceOrbRadius = ICE_ORB_RADIUS,
    IceOrbSeedRadius = ICE_ORB_SEED_RADIUS,
    IceOrbLinkRadius = ICE_ORB_LINK_RADIUS,
    IceOrbExpectedCount = ICE_ORB_EXPECTED_COUNT,
    IceOrbActiveCount = ICE_ORB_ACTIVE_COUNT,
    LightningOrbExpectedCount = LIGHTNING_ORB_EXPECTED_COUNT,
    OrbPredictionTimeoutMs = ORB_PREDICTION_TIMEOUT_MS,
    BlacklistSource = BLACKLIST_SOURCE,
    NormalizeHeading = normalizeHeading,
    NewState = newState,
    EnsureState = ensureState,
    GetConfig = getConfig,
    StartBreathRound = startBreathRound,
    HandleEntityAdd = handleEntityAdd,
    CollectOrbSnapshots = collectOrbSnapshots,
    ConnectedIceOrbs = connectedIceOrbs,
    DrawOrbPredictionIfReady = drawOrbPredictionIfReady,
    ApplyBlacklist = applyBlacklist,
    HandleRoarChannel = handleRoarChannel,
    HandleEntityCast = handleEntityCast,
    PruneState = pruneState,
    ClearState = clearState,
}

return Feature
end

rawset(_G, 'MuAiOccultCrescentNorthLeaderChimera', Module)
return Module
