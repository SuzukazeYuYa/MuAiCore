local Module = {}

function Module.Create(Context)
    assert(type(Context) == 'table' and type(Context.Common) == 'table')
    local Common = Context.Common
    local nowMs = Context.nowMs
    local finite = Context.finite
    local reliablePosition = Context.reliablePosition
    local resolveEntity = Context.resolveEntity
    local getPlayer = Context.getPlayer

local LITTLE_MAGE_CONTENT_ID = 14795
local LITTLE_MAGE_FIRE_ORB_CONTENT_ID = 14797
local LITTLE_MAGE_WATER_ORB_CONTENT_ID = 14798
local LITTLE_MAGE_ARENA_CENTER = { x = 151.995, z = 715.999 }
local LITTLE_MAGE_ARENA_RADIUS = 20
local LITTLE_MAGE_GUIDE_RADIUS = 19
local LITTLE_MAGE_KNOCKBACK_DISTANCE = 15
local LITTLE_MAGE_FUSION_TETHER = 415
local LITTLE_MAGE_FIRST_TELEGRAPH_MS = 7300
local LITTLE_MAGE_FIRST_RESOLVE_MS = 9300
local LITTLE_MAGE_FUSION_INTERVAL_MS = 3000
local LITTLE_MAGE_TETHER_WINDOW_MS = 500
local LITTLE_MAGE_MATCH_DISTANCE_SQ = 1.44
local LITTLE_MAGE_ROUND_TIMEOUT_MS = 22000
local LITTLE_MAGE_SEEN_TTL_MS = 30000

local LITTLE_MAGE_AID = {
    Gather = 48306,
    TinyFlare = 48311,
    TinyHoly = 48312,
    DiminutiveDualcast = 48317,
}

local LITTLE_MAGE_RESULT = {
    [LITTLE_MAGE_AID.TinyFlare] = 'fire',
    [LITTLE_MAGE_AID.TinyHoly] = 'knockback',
}

local LITTLE_MAGE_DEFAULTS = {
    Enable = true,
    DynamicGuide = true,
}

local function getLittleMageConfig(guide)
    return Common.getConfig(guide, 'LittleMage', LITTLE_MAGE_DEFAULTS)
end

local function newLittleMageState()
    return {
        round = nil,
        seenTethers = {},
        seenChannels = {},
        seenCasts = {},
        bossEntityID = nil,
        bossMissingSince = nil,
        lastDiagnostic = nil,
    }
end

local function ensureLittleMageState(state)
    state = type(state) == 'table' and state or newLittleMageState()
    state.seenTethers = type(state.seenTethers) == 'table'
            and state.seenTethers or {}
    state.seenChannels = type(state.seenChannels) == 'table'
            and state.seenChannels or {}
    state.seenCasts = type(state.seenCasts) == 'table'
            and state.seenCasts or {}
    return state
end

local function getLittleMageState()
    local guide = rawget(_G, 'MuAiGuide')
    if type(guide) ~= 'table' then
        return nil
    end
    guide.LittleMage = ensureLittleMageState(guide.LittleMage)
    return guide.LittleMage
end

local function clearLittleMageState(state)
    if type(state) ~= 'table' then
        return
    end
    if type(state.round) == 'table' then
        for _, entry in ipairs(state.round.predictions or {}) do
            Common.deleteTimedShape(entry.token)
        end
    end
    state.round = nil
    state.seenTethers = {}
    state.seenChannels = {}
    state.seenCasts = {}
    state.bossEntityID = nil
    state.bossMissingSince = nil
    state.lastDiagnostic = nil
end

local function littleMageDiagnostic(state, code, context)
    state.lastDiagnostic = {
        code = code,
        at = nowMs(),
        context = context,
    }
end

local function suppressLittleMage(state, code, context)
    local round = type(state) == 'table' and state.round or nil
    if type(state) == 'table' and type(round) ~= 'table' then
        local now = nowMs()
        round = {
            startedAt = now,
            expiresAt = now + LITTLE_MAGE_ROUND_TIMEOUT_MS,
            predictions = {},
            byKey = {},
            orbPartners = {},
            suppressed = true,
        }
        state.round = round
    end
    if type(round) == 'table' then
        round.suppressed = true
        for _, entry in ipairs(round.predictions or {}) do
            Common.deleteTimedShape(entry.token)
            entry.token = nil
        end
    end
    littleMageDiagnostic(state, code, context)
end

local function littleMageOrbKind(contentID)
    if contentID == LITTLE_MAGE_FIRE_ORB_CONTENT_ID then
        return 'fire'
    end
    if contentID == LITTLE_MAGE_WATER_ORB_CONTENT_ID then
        return 'knockback'
    end
    return nil
end

local function littleMagePairKey(sourceID, targetID)
    if not finite(sourceID) or not finite(targetID) then
        return nil
    end
    local low = math.min(sourceID, targetID)
    local high = math.max(sourceID, targetID)
    return tostring(low) .. ':' .. tostring(high)
end

local function drawLittleMagePrediction(entry, now)
    if type(entry) ~= 'table'
            or entry.kind ~= 'fire'
            or entry.handedOff == true
            or type(entry.token) == 'string'
            or not finite(entry.activationAt)
            or entry.activationAt <= now
            or type(TensorCore) ~= 'table'
            or type(TensorCore.getMoogleDrawer) ~= 'function'
    then
        return false
    end
    local drawer = TensorCore.getMoogleDrawer()
    if type(drawer) ~= 'table'
            or type(drawer.addTimedCircle) ~= 'function'
    then
        return false
    end
    local token = drawer:addTimedCircle(
            entry.activationAt - now,
            entry.source.x,
            entry.source.y,
            entry.source.z,
            18)
    if type(token) ~= 'string' then
        return false
    end
    entry.token = token
    return true
end

local function recordLittleMageFusion(state, sourceID, targetID, now)
    if type(state) ~= 'table' then
        return false
    end
    local key = littleMagePairKey(sourceID, targetID)
    if key ~= nil and state.seenTethers[key] ~= nil then
        return false
    end
    local sourceEntity = resolveEntity(sourceID)
    local targetEntity = resolveEntity(targetID)
    local sourceKind = type(sourceEntity) == 'table'
            and littleMageOrbKind(sourceEntity.contentid) or nil
    local targetKind = type(targetEntity) == 'table'
            and littleMageOrbKind(targetEntity.contentid) or nil
    if sourceKind == nil and targetKind == nil then
        return false
    end
    if sourceEntity == nil
            or targetEntity == nil
            or sourceEntity.id ~= sourceID
            or targetEntity.id ~= targetID
            or sourceKind == nil
            or sourceKind ~= targetKind
    then
        suppressLittleMage(state, 'fusion_entity_mismatch', {
            sourceID = sourceID,
            targetID = targetID,
        })
        return false
    end
    local sourcePos = reliablePosition(sourceEntity.pos, false)
    local targetPos = reliablePosition(targetEntity.pos, false)
    if sourcePos == nil or targetPos == nil then
        suppressLittleMage(state, 'fusion_missing_geometry', key)
        return false
    end
    local midpoint = reliablePosition({
        x = (sourcePos.x + targetPos.x) / 2,
        y = (sourcePos.y + targetPos.y) / 2,
        z = (sourcePos.z + targetPos.z) / 2,
    }, false)
    if midpoint == nil
            or not Common.insideCircle(
                    midpoint, LITTLE_MAGE_ARENA_CENTER, 21)
    then
        suppressLittleMage(state, 'fusion_midpoint_invalid', key)
        return false
    end
    local round = state.round
    if type(round) ~= 'table' then
        round = {
            startedAt = now,
            expiresAt = now + LITTLE_MAGE_ROUND_TIMEOUT_MS,
            predictions = {},
            byKey = {},
            orbPartners = {},
            suppressed = false,
        }
        state.round = round
    elseif now - round.startedAt > LITTLE_MAGE_TETHER_WINDOW_MS then
        suppressLittleMage(state, 'fusion_late_tether', {
            startedAt = round.startedAt,
            actualAt = now,
        })
        return false
    end
    if round.suppressed == true then
        return false
    end
    local oldSourcePartner = round.orbPartners[sourceID]
    local oldTargetPartner = round.orbPartners[targetID]
    if (oldSourcePartner ~= nil and oldSourcePartner ~= targetID)
            or (oldTargetPartner ~= nil and oldTargetPartner ~= sourceID)
            or #round.predictions >= 4
    then
        suppressLittleMage(state, 'fusion_pair_conflict', {
            sourceID = sourceID,
            targetID = targetID,
        })
        return false
    end
    local order = #round.predictions + 1
    local entry = {
        key = key,
        sourceEntityID = sourceID,
        targetEntityID = targetID,
        kind = sourceKind,
        source = midpoint,
        order = order,
        telegraphAt = round.startedAt + LITTLE_MAGE_FIRST_TELEGRAPH_MS
                + (order - 1) * LITTLE_MAGE_FUSION_INTERVAL_MS,
        activationAt = round.startedAt + LITTLE_MAGE_FIRST_RESOLVE_MS
                + (order - 1) * LITTLE_MAGE_FUSION_INTERVAL_MS,
        handedOff = false,
    }
    round.predictions[#round.predictions + 1] = entry
    round.byKey[key] = entry
    round.orbPartners[sourceID] = targetID
    round.orbPartners[targetID] = sourceID
    state.seenTethers[key] = now
    drawLittleMagePrediction(entry, now)
    return true
end

local function littleMageNextPrediction(state)
    local round = type(state) == 'table' and state.round or nil
    if type(round) ~= 'table'
            or round.suppressed == true
            or type(round.predictions) ~= 'table'
            or #round.predictions == 0
    then
        return nil
    end
    table.sort(round.predictions, function(left, right)
        if left.activationAt ~= right.activationAt then
            return left.activationAt < right.activationAt
        end
        return left.order < right.order
    end)
    return round.predictions[1]
end

local function matchLittleMageResult(state, entityID, spellID, now, channel)
    local kind = LITTLE_MAGE_RESULT[spellID]
    local round = type(state) == 'table' and state.round or nil
    if kind == nil or type(round) ~= 'table' then
        return nil
    end
    local entity = resolveEntity(entityID)
    local observed = type(entity) == 'table'
            and entity.id == entityID
            and entity.contentid == LITTLE_MAGE_CONTENT_ID
            and reliablePosition(entity.pos, false) or nil
    if observed == nil then
        suppressLittleMage(state, 'fusion_result_missing_position', {
            entityID = entityID,
            spellID = spellID,
        })
        return nil
    end
    local matches = {}
    local tolerance = channel and 1200 or 1600
    for index, entry in ipairs(round.predictions) do
        local expectedAt = channel and entry.telegraphAt or entry.activationAt
        if entry.kind == kind
                and math.abs(now - expectedAt) <= tolerance
                and Common.distanceSquared(observed, entry.source)
                        <= LITTLE_MAGE_MATCH_DISTANCE_SQ
        then
            matches[#matches + 1] = index
        end
    end
    if #matches ~= 1 then
        suppressLittleMage(state, 'fusion_result_ambiguous', {
            entityID = entityID,
            spellID = spellID,
            matches = #matches,
        })
        return nil
    end
    return matches[1]
end

local function markLittleMageTelegraph(state, entityID, spellID, now)
    if LITTLE_MAGE_RESULT[spellID] == nil then
        return false
    end
    local channelKey = tostring(entityID) .. ':' .. tostring(spellID)
            .. ':' .. tostring(math.floor(now / 100))
    if not Common.consumeEvent(
            state.seenChannels, channelKey, now, 350)
    then
        return false
    end
    local index = matchLittleMageResult(
            state, entityID, spellID, now, true)
    if index == nil then
        return false
    end
    local entry = state.round.predictions[index]
    entry.handedOff = true
    Common.deleteTimedShape(entry.token)
    entry.token = nil
    return true
end

local function resolveLittleMageResult(state, entityID, spellID, now)
    if LITTLE_MAGE_RESULT[spellID] == nil then
        return false
    end
    local castKey = tostring(entityID) .. ':' .. tostring(spellID)
            .. ':' .. tostring(math.floor(now / 100))
    if not Common.consumeEvent(state.seenCasts, castKey, now, 350) then
        return false
    end
    local index = matchLittleMageResult(
            state, entityID, spellID, now, false)
    if index == nil then
        return false
    end
    local entry = state.round.predictions[index]
    Common.deleteTimedShape(entry.token)
    table.remove(state.round.predictions, index)
    if #state.round.predictions == 0 then
        state.round = nil
    end
    return true
end

local function pruneLittleMageState(state, now)
    local round = type(state) == 'table' and state.round or nil
    if type(round) == 'table' then
        if not finite(round.expiresAt) or now > round.expiresAt then
            for _, entry in ipairs(round.predictions or {}) do
                Common.deleteTimedShape(entry.token)
            end
            state.round = nil
        else
            for index = #round.predictions, 1, -1 do
                local entry = round.predictions[index]
                if not finite(entry.activationAt)
                        or now > entry.activationAt + 1500
                then
                    Common.deleteTimedShape(entry.token)
                    table.remove(round.predictions, index)
                elseif round.suppressed ~= true then
                    drawLittleMagePrediction(entry, now)
                end
            end
            if #round.predictions == 0 and round.suppressed ~= true then
                state.round = nil
            end
        end
    end
    Common.pruneSeen(state.seenTethers, now, LITTLE_MAGE_SEEN_TTL_MS)
    Common.pruneSeen(state.seenChannels, now, LITTLE_MAGE_SEEN_TTL_MS)
    Common.pruneSeen(state.seenCasts, now, LITTLE_MAGE_SEEN_TTL_MS)
end

local function recordLittleMageBoss(state, entityID, spellID)
    if spellID ~= LITTLE_MAGE_AID.Gather
            and spellID ~= LITTLE_MAGE_AID.DiminutiveDualcast
    then
        return false
    end
    local entity = resolveEntity(entityID)
    if type(entity) ~= 'table'
            or entity.id ~= entityID
            or entity.contentid ~= LITTLE_MAGE_CONTENT_ID
    then
        return false
    end
    state.bossEntityID = entityID
    state.bossMissingSince = nil
    return true
end

local function updateLittleMageBossLifetime(state, now)
    if type(state.bossEntityID) ~= 'number' then
        return
    end
    local boss = resolveEntity(state.bossEntityID)
    if type(boss) == 'table'
            and boss.id == state.bossEntityID
            and boss.alive ~= false
    then
        state.bossMissingSince = nil
        return
    end
    state.bossMissingSince = state.bossMissingSince or now
    if now - state.bossMissingSince >= BOSS_MISSING_CLEAR_MS then
        clearLittleMageState(state)
    end
end

local function littleMageKnockbackSolution(start, source, group)
    if not Common.safeForGroup(
            start, {}, LITTLE_MAGE_ARENA_CENTER,
            LITTLE_MAGE_GUIDE_RADIUS, 0.5)
    then
        return nil
    end
    local landing = Common.projectKnockback(
            start, source, LITTLE_MAGE_KNOCKBACK_DISTANCE)
    if landing == nil then
        return nil
    end
    local otherHazards = {}
    for _, hazard in ipairs(group) do
        if hazard.kind ~= 'knockback' then
            otherHazards[#otherHazards + 1] = hazard
        end
    end
    if not Common.safeForGroup(
            start, otherHazards, LITTLE_MAGE_ARENA_CENTER,
            LITTLE_MAGE_GUIDE_RADIUS, 0.5)
            or not Common.safeForGroup(
                    landing, otherHazards, LITTLE_MAGE_ARENA_CENTER,
                    LITTLE_MAGE_GUIDE_RADIUS, 0.5)
    then
        return nil
    end
    return landing
end

local function nearestLittleMageKnockbackStart(playerPos, source, group)
    local target = Common.nearestValidPoint(
            playerPos,
            LITTLE_MAGE_ARENA_CENTER,
            LITTLE_MAGE_GUIDE_RADIUS,
            { step = 1, directionCount = 72 },
            function(candidate)
                return littleMageKnockbackSolution(
                        candidate, source, group) ~= nil
            end)
    if target == nil then
        return nil
    end
    return target, littleMageKnockbackSolution(target, source, group)
end

local function drawLittleMageDynamicGuide(state, guide, now)
    local cfg = getLittleMageConfig(guide)
    if type(cfg) ~= 'table'
            or cfg.DynamicGuide ~= true
            or type(guide) ~= 'table'
            or type(guide.FrameDirect) ~= 'function'
    then
        return false
    end
    local current = littleMageNextPrediction(state)
    local player = getPlayer(guide)
    if current == nil or player == nil then
        return false
    end
    local group = {}
    if current.kind == 'fire' then
        group[#group + 1] = {
            kind = 'circle', source = current.source, radius = 18,
        }
    end
    local predictions = state.round.predictions
    for index = 2, #predictions do
        local entry = predictions[index]
        if entry.activationAt - current.activationAt
                    > LITTLE_MAGE_FUSION_INTERVAL_MS + 500
        then
            break
        end
        if entry.kind == 'fire' then
            group[#group + 1] = {
                kind = 'circle', source = entry.source, radius = 18,
            }
            break
        end
    end
    local target
    if current.kind == 'knockback' then
        target = nearestLittleMageKnockbackStart(
                player.pos, current.source, group)
        if target == nil and #group > 0 then
            target = nearestLittleMageKnockbackStart(
                    player.pos, current.source, {})
        end
    else
        target = Common.nearestSafePoint(
                player.pos,
                group,
                LITTLE_MAGE_ARENA_CENTER,
                LITTLE_MAGE_GUIDE_RADIUS,
                { margin = 0.5, step = 1, directionCount = 72 })
        if target == nil and #group > 1 then
            target = Common.nearestSafePoint(
                    player.pos,
                    { group[1] },
                    LITTLE_MAGE_ARENA_CENTER,
                    LITTLE_MAGE_GUIDE_RADIUS,
                    { margin = 0.5, step = 1, directionCount = 72 })
        end
    end
    if target == nil then
        littleMageDiagnostic(state, 'fusion_guide_no_safe_point', {
            kind = current.kind,
            order = current.order,
        })
        return true
    end
    if Common.distanceSquared(player.pos, target) <= 0.25 then
        return true
    end
    local color = type(guide.Config) == 'table'
            and type(guide.Config.Main) == 'table'
            and guide.Config.Main.GuideColor
            or { r = 0, g = 1, b = 1, a = 0.5 }
    guide.FrameDirect(target.x, target.z, 0.7, color)
    return true
end

local Feature = {}

Feature.Init = function(M)
    if type(M.LittleMage) == 'table' then
        clearLittleMageState(M.LittleMage)
    end
    M.LittleMage = newLittleMageState()
    getLittleMageConfig(M)
    M.SetLittleMageEnabled = function(enabled)
        local cfg = getLittleMageConfig(M)
        if cfg ~= nil then
            cfg.Enable = enabled == true
        end
        if enabled ~= true then
            clearLittleMageState(M.LittleMage)
        end
    end
    M.SetLittleMageDynamicGuideEnabled = function(enabled)
        local cfg = getLittleMageConfig(M)
        if cfg ~= nil then
            cfg.DynamicGuide = enabled == true
        end
        if enabled ~= true then
            clearLittleMageState(M.LittleMage)
        end
    end
end

Feature.Clear = function()
    local state = getLittleMageState()
    if state ~= nil then
        clearLittleMageState(state)
    end
end

Feature.OnEntityChannel = function(entityID, spellID, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getLittleMageConfig(guide)
    local state = getLittleMageState()
    if state ~= nil and cfg ~= nil and cfg.Enable == true
            and cfg.DynamicGuide == true
    then
        recordLittleMageBoss(state, entityID, spellID)
        markLittleMageTelegraph(state, entityID, spellID, now)
    end
end

Feature.OnTetherChange = function(sourceEntityID, newTetherID, newTargetID, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getLittleMageConfig(guide)
    local state = getLittleMageState()
    if newTetherID == LITTLE_MAGE_FUSION_TETHER
            and state ~= nil and cfg ~= nil
            and cfg.Enable == true and cfg.DynamicGuide == true
    then
        recordLittleMageFusion(state, sourceEntityID, newTargetID, now)
    end
end

Feature.OnEntityCast = function(entityID, spellID, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getLittleMageConfig(guide)
    local state = getLittleMageState()
    if state ~= nil and cfg ~= nil and cfg.Enable == true
            and cfg.DynamicGuide == true
    then
        recordLittleMageBoss(state, entityID, spellID)
        resolveLittleMageResult(state, entityID, spellID, now)
    end
end

Feature.Update = function(guide, now, allowGuide)
    local state = getLittleMageState()
    if state == nil then
        return false
    end
    local cfg = getLittleMageConfig(guide)
    if cfg == nil or cfg.Enable ~= true or cfg.DynamicGuide ~= true then
        clearLittleMageState(state)
        return false
    end
    pruneLittleMageState(state, now)
    updateLittleMageBossLifetime(state, now)
    if allowGuide == false then
        return false
    end
    return drawLittleMageDynamicGuide(state, guide, now)
end

Feature.Test = {
    MapID = Context.MapID,
    ContentID = LITTLE_MAGE_CONTENT_ID,
    FireOrbContentID = LITTLE_MAGE_FIRE_ORB_CONTENT_ID,
    WaterOrbContentID = LITTLE_MAGE_WATER_ORB_CONTENT_ID,
    ArenaCenter = LITTLE_MAGE_ARENA_CENTER,
    ArenaRadius = LITTLE_MAGE_ARENA_RADIUS,
    GuideArenaRadius = LITTLE_MAGE_GUIDE_RADIUS,
    KnockbackDistance = LITTLE_MAGE_KNOCKBACK_DISTANCE,
    FusionTether = LITTLE_MAGE_FUSION_TETHER,
    FirstTelegraphMs = LITTLE_MAGE_FIRST_TELEGRAPH_MS,
    FirstResolveMs = LITTLE_MAGE_FIRST_RESOLVE_MS,
    FusionIntervalMs = LITTLE_MAGE_FUSION_INTERVAL_MS,
    FireRadius = 18,
    AID = LITTLE_MAGE_AID,
    Result = LITTLE_MAGE_RESULT,
    Defaults = LITTLE_MAGE_DEFAULTS,
    NewState = newLittleMageState,
    ClearState = clearLittleMageState,
    RecordFusion = recordLittleMageFusion,
    MarkTelegraph = markLittleMageTelegraph,
    ResolveResult = resolveLittleMageResult,
    PruneState = pruneLittleMageState,
    NextPrediction = littleMageNextPrediction,
    KnockbackSolution = littleMageKnockbackSolution,
    NearestKnockbackStart = nearestLittleMageKnockbackStart,
    DrawPrediction = drawLittleMagePrediction,
    DrawDynamicGuide = drawLittleMageDynamicGuide,
    RecordBoss = recordLittleMageBoss,
    UpdateBossLifetime = updateLittleMageBossLifetime,
    PointInDanger = Common.pointInDanger,
    ProjectKnockback = Common.projectKnockback,
}

    return Feature
end

rawset(_G, 'MuAiOccultCrescentNorthLittleMage', Module)
return Module
