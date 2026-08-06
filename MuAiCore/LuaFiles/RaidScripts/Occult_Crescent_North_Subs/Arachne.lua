local Module = {}

function Module.Create(Context)
    assert(type(Context) == 'table' and type(Context.Common) == 'table')
    local Common = Context.Common
    local nowMs = Context.nowMs
    local finite = Context.finite
    local reliablePosition = Context.reliablePosition
    local getPlayer = Context.getPlayer

local ARACHNE_BOSS_CONTENT_ID = 14840
local ARACHNE_DAUGHTER_CONTENT_ID = 14841
local ARACHNE_BOSS_MODEL_ID = 19962
local ARACHNE_DAUGHTER_MODEL_ID = 19963
local ARACHNE_ARENA_CENTER = { x = 169.970, z = -136.004 }
local ARACHNE_ARENA_RADIUS = 30
local ARACHNE_GUIDE_RADIUS = 29
local ARACHNE_CHARGE_WIDTH = 20
local ARACHNE_CONE_RANGE = 50
local ARACHNE_CONE_ANGLE = math.rad(45)
local ARACHNE_CONE_AURA = 1900
local ARACHNE_CONE_READY_RADIUS = 23
local ARACHNE_STATE_TIMEOUT_MS = 30000

local ARACHNE_AID = {
    Summon = 50368,
    WebStart = 50369,
    WebLink = 50370,
    ChargeStart = 50371,
    ChargeStep = 50372,
    VenomEruption = 50375,
    ConformityVisual = 50376,
    ConformityCone = 50377,
}

local ARACHNE_DEFAULTS = {
    Enable = true,
    DrawChargePrediction = true,
    DrawConformityPrediction = true,
    DynamicGuide = true,
}

local function getArachneConfig(guide)
    return Common.getConfig(guide, 'Arachne', ARACHNE_DEFAULTS)
end

local function newArachneState()
    return {
        charge = nil,
        marked = {},
        markedOrder = {},
        seenCasts = {},
        seenAuras = {},
        bossEntityID = nil,
        entityScan = { at = nil, byContentID = {} },
        lastDiagnostic = nil,
    }
end

local function ensureArachneState(state)
    state = type(state) == 'table' and state or newArachneState()
    state.marked = type(state.marked) == 'table' and state.marked or {}
    state.markedOrder = type(state.markedOrder) == 'table'
            and state.markedOrder or {}
    state.seenCasts = type(state.seenCasts) == 'table'
            and state.seenCasts or {}
    state.seenAuras = type(state.seenAuras) == 'table'
            and state.seenAuras or {}
    state.entityScan = type(state.entityScan) == 'table'
            and state.entityScan or {}
    state.entityScan.byContentID = type(state.entityScan.byContentID) == 'table'
            and state.entityScan.byContentID or {}
    return state
end

local function getArachneState()
    return Common.getRuntimeState(
            'Arachne', newArachneState, ensureArachneState)
end

local function arachneDiagnostic(state, code, context)
    state.lastDiagnostic = {
        code = code,
        at = nowMs(),
        context = context,
    }
end

local function clearArachneMechanics(state)
    state.charge = nil
    state.marked = {}
    state.markedOrder = {}
end

local function clearArachneState(state)
    if type(state) ~= 'table' then
        return
    end
    clearArachneMechanics(state)
    state.seenCasts = {}
    state.seenAuras = {}
    state.bossEntityID = nil
    state.entityScan = { at = nil, byContentID = {} }
    state.lastDiagnostic = nil
end

local function scanArachneContent(state, contentID, modelID, now)
    state = ensureArachneState(state)
    local scan = state.entityScan
    if scan.at ~= now then
        scan.at = now
        scan.byContentID = {}
    end
    local cached = scan.byContentID[contentID]
    if type(cached) == 'table' then
        return cached
    end
    cached = { byID = {} }
    scan.byContentID[contentID] = cached
    local tensorCore = rawget(_G, 'TensorCore')
    if type(tensorCore) ~= 'table'
            or type(tensorCore.entityList) ~= 'function'
    then
        return cached
    end
    local entities = tensorCore.entityList(
            'contentid=' .. tostring(contentID))
    if type(entities) ~= 'table' then
        return cached
    end
    for _, entity in pairs(entities) do
        if type(entity) == 'table' then
            local entityID = tonumber(entity.id)
            if finite(entityID) then
                local entry = { status = 'invalid' }
                local pos = reliablePosition(entity.pos, false)
                if tonumber(entity.contentid) == contentID
                        and Common.entityModelID(entity) == modelID
                        and entity.alive ~= false
                        and pos ~= nil
                        and Common.insideCircle(
                                pos,
                                ARACHNE_ARENA_CENTER,
                                ARACHNE_ARENA_RADIUS + 3)
                then
                    entry = {
                        status = 'ready',
                        entity = entity,
                        pos = pos,
                    }
                end
                if cached.byID[entityID] ~= nil then
                    cached.byID[entityID] = { status = 'invalid' }
                else
                    cached.byID[entityID] = entry
                end
            end
        end
    end
    return cached
end

local function resolveArachneEntity(
        state, entityID, contentID, modelID, heading, now)
    if not finite(entityID) or not finite(now) then
        return nil, nil, 'invalid'
    end
    local snapshot = scanArachneContent(
            state, contentID, modelID, now)
    local entry = snapshot.byID[entityID]
    if type(entry) ~= 'table' then
        return nil, nil, 'missing'
    end
    if entry.status ~= 'ready' then
        return nil, nil, 'invalid'
    end
    local pos = heading == true
            and reliablePosition(entry.entity.pos, true) or entry.pos
    if pos == nil then
        return nil, nil, 'invalid'
    end
    return entry.entity, pos, 'ready'
end

local function arachneHeading(from, to)
    if not Common.validXZ(from) or not Common.validXZ(to) then
        return nil
    end
    local dx, dz = Common.normalized(to.x - from.x, to.z - from.z)
    return dx ~= nil and math.atan2(dx, dz) or nil
end

local function beginArachneSummon(state, entityID, spellID)
    if spellID ~= ARACHNE_AID.Summon
            and spellID ~= ARACHNE_AID.ConformityVisual
    then
        return false
    end
    if not finite(entityID) then
        return false
    end
    clearArachneMechanics(state)
    state.bossEntityID = entityID
    return true
end

local function startArachneWeb(
        state, entityID, targetID, duration, now)
    if not finite(duration) or duration < 2 or duration > 3.5 then
        arachneDiagnostic(state, 'web_invalid_duration', duration)
        return false
    end
    if not finite(entityID)
            or not finite(targetID)
            or entityID == targetID
            or not finite(now)
    then
        arachneDiagnostic(state, 'web_invalid_entities', {
            entityID = entityID, targetID = targetID,
        })
        return false
    end
    state.charge = {
        bossEntityID = entityID,
        order = { targetID },
        byID = { [targetID] = true },
        links = {},
        resolvedCount = 0,
        phase = 'web',
        startedAt = now,
        expiresAt = now + ARACHNE_STATE_TIMEOUT_MS,
        suppressed = false,
    }
    state.bossEntityID = entityID
    return true
end

local function suppressArachneCharge(state, code, context)
    if type(state.charge) == 'table' then
        state.charge.suppressed = true
    end
    arachneDiagnostic(state, code, context)
end

local function collectArachneWebLink(
        state, sourceID, targetID, now)
    local charge = state.charge
    if type(charge) ~= 'table'
            or charge.phase ~= 'web'
            or type(targetID) ~= 'number'
    then
        return false
    end
    local existing = charge.links[sourceID]
    if existing ~= nil then
        if existing ~= targetID then
            suppressArachneCharge(state, 'web_link_conflict', {
                sourceID = sourceID,
                expectedTargetID = existing,
                actualTargetID = targetID,
            })
        end
        return false
    end
    if charge.order[#charge.order] ~= sourceID
            or charge.byID[targetID]
            or not finite(sourceID)
            or not finite(targetID)
            or sourceID == targetID
            or not finite(now)
    then
        suppressArachneCharge(state, 'web_link_invalid', {
            sourceID = sourceID, targetID = targetID,
        })
        return false
    end
    charge.links[sourceID] = targetID
    charge.byID[targetID] = true
    charge.order[#charge.order + 1] = targetID
    charge.expiresAt = now + ARACHNE_STATE_TIMEOUT_MS
    return true
end

local function startArachneCharge(
        state, entityID, targetID, duration, now)
    if not finite(duration) or duration < 4 or duration > 5.5 then
        suppressArachneCharge(state, 'charge_invalid_duration', duration)
        return false
    end
    local charge = state.charge
    if type(charge) ~= 'table'
            or charge.suppressed
            or charge.bossEntityID ~= entityID
            or charge.order[1] ~= targetID
            or #charge.order < 2
            or not finite(now)
    then
        suppressArachneCharge(state, 'charge_chain_invalid', {
            entityID = entityID, targetID = targetID,
        })
        return false
    end
    charge.phase = 'charging'
    charge.activationAt = now + duration * 1000
    charge.expiresAt = now + ARACHNE_STATE_TIMEOUT_MS
    return true
end

local function advanceArachneCharge(state, entityID, spellID, now)
    if spellID ~= ARACHNE_AID.ChargeStart
            and spellID ~= ARACHNE_AID.ChargeStep
    then
        return false
    end
    local charge = state.charge
    if type(charge) ~= 'table' or charge.phase ~= 'charging' then
        return false
    end
    if charge.bossEntityID ~= entityID then
        suppressArachneCharge(state, 'charge_caster_conflict', {
            expectedEntityID = charge.bossEntityID,
            actualEntityID = entityID,
        })
        return false
    end
    local key = tostring(entityID) .. ':' .. tostring(spellID)
    if not Common.consumeEvent(state.seenCasts, key, now, 350) then
        return false
    end
    charge.resolvedCount = charge.resolvedCount + 1
    charge.expiresAt = now + 5000
    if charge.resolvedCount >= #charge.order then
        state.charge = nil
    end
    return true
end

local function markArachneCone(
        state, entityID, oldAura, newAura, now)
    if oldAura == ARACHNE_CONE_AURA or newAura ~= ARACHNE_CONE_AURA then
        return false
    end
    if not finite(entityID) or not finite(now) then
        arachneDiagnostic(state, 'cone_aura_invalid_entity', entityID)
        return false
    end
    local key = tostring(entityID) .. ':' .. tostring(ARACHNE_CONE_AURA)
    if not Common.consumeEvent(state.seenAuras, key, now, 1000) then
        return false
    end
    local marker = {
        entityID = entityID,
        markedAt = now,
        expiresAt = now + 14000,
        ready = false,
    }
    state.marked[entityID] = marker
    state.markedOrder[#state.markedOrder + 1] = entityID
    return true
end

local function updateArachneMarker(state, marker, now)
    local _, pos, status = resolveArachneEntity(
            state,
            marker.entityID,
            ARACHNE_DAUGHTER_CONTENT_ID,
            ARACHNE_DAUGHTER_MODEL_ID,
            marker.channelStarted == true,
            now)
    if status == 'invalid' then
        arachneDiagnostic(
                state, 'cone_invalid_entity', marker.entityID)
        return false
    end
    if status ~= 'ready' then
        return now <= marker.expiresAt
    end
    if marker.channelStarted == true then
        local expected = arachneHeading(pos, ARACHNE_ARENA_CENTER)
        if expected == nil
                or Common.headingDifference(pos.h, expected) > math.rad(12)
        then
            arachneDiagnostic(
                    state, 'cone_heading_conflict', marker.entityID)
            return false
        end
        marker.source = pos
        marker.heading = pos.h
        marker.ready = true
        return now <= marker.expiresAt
    end
    local distanceSq = Common.distanceSquared(pos, ARACHNE_ARENA_CENTER)
    if distanceSq ~= nil
            and distanceSq >= ARACHNE_CONE_READY_RADIUS
                    * ARACHNE_CONE_READY_RADIUS
    then
        local heading = arachneHeading(pos, ARACHNE_ARENA_CENTER)
        if heading ~= nil then
            marker.source = pos
            marker.heading = heading
            marker.ready = true
        end
    end
    return now <= marker.expiresAt
end

local function startArachneCone(
        state, entityID, duration, now)
    if not finite(duration) or duration < 2 or duration > 3.5 then
        arachneDiagnostic(state, 'cone_invalid_duration', duration)
        return false
    end
    if not finite(entityID) or not finite(now) then
        arachneDiagnostic(state, 'cone_invalid_entity', entityID)
        return false
    end
    local marker = state.marked[entityID]
    if marker == nil then
        marker = { entityID = entityID, markedAt = now }
        state.marked[entityID] = marker
        state.markedOrder[#state.markedOrder + 1] = entityID
    end
    marker.source = nil
    marker.heading = nil
    marker.ready = false
    marker.channelStarted = true
    marker.activationAt = now + duration * 1000
    marker.expiresAt = marker.activationAt + 1000
    return true
end

local function resolveArachneCone(state, entityID, now)
    local key = tostring(entityID) .. ':'
            .. tostring(ARACHNE_AID.ConformityCone)
    if not Common.consumeEvent(state.seenCasts, key, now, 350) then
        return false
    end
    if state.marked[entityID] == nil then
        return false
    end
    state.marked[entityID] = nil
    return true
end

local function pruneArachneState(state, now)
    local charge = state.charge
    if type(charge) == 'table' and now > charge.expiresAt then
        state.charge = nil
    end
    for index = #state.markedOrder, 1, -1 do
        local entityID = state.markedOrder[index]
        local marker = state.marked[entityID]
        if marker == nil or not updateArachneMarker(state, marker, now) then
            state.marked[entityID] = nil
            table.remove(state.markedOrder, index)
        end
    end
    Common.pruneSeen(state.seenCasts, now, ARACHNE_STATE_TIMEOUT_MS)
    Common.pruneSeen(state.seenAuras, now, ARACHNE_STATE_TIMEOUT_MS)
end

local function arachneChargeDangers(state, now)
    now = finite(now) and now or nowMs()
    local charge = state.charge
    if type(charge) ~= 'table'
            or charge.phase ~= 'charging'
            or charge.suppressed
    then
        return {}
    end
    local result = {}
    local first = charge.resolvedCount + 1
    for index = first, math.min(#charge.order, first + 1) do
        local source, sourceStatus = nil, nil
        if index == 1 then
            local _, pos, status = resolveArachneEntity(
                    state,
                    charge.bossEntityID,
                    ARACHNE_BOSS_CONTENT_ID,
                    ARACHNE_BOSS_MODEL_ID,
                    false,
                    now)
            source = pos
            sourceStatus = status
        else
            local _, pos, status = resolveArachneEntity(
                    state,
                    charge.order[index - 1],
                    ARACHNE_DAUGHTER_CONTENT_ID,
                    ARACHNE_DAUGHTER_MODEL_ID,
                    false,
                    now)
            source = pos
            sourceStatus = status
        end
        local _, target, targetStatus = resolveArachneEntity(
                state,
                charge.order[index],
                ARACHNE_DAUGHTER_CONTENT_ID,
                ARACHNE_DAUGHTER_MODEL_ID,
                false,
                now)
        if sourceStatus == 'invalid' or targetStatus == 'invalid' then
            suppressArachneCharge(state, 'charge_entity_invalid', {
                sourceID = index == 1
                        and charge.bossEntityID or charge.order[index - 1],
                targetID = charge.order[index],
            })
            return {}
        end
        if sourceStatus ~= 'ready' or targetStatus ~= 'ready' then
            break
        end
        local distanceSq = Common.distanceSquared(source, target)
        local heading = arachneHeading(source, target)
        if distanceSq == nil or distanceSq < 1 or distanceSq > 3600
                or heading == nil
        then
            suppressArachneCharge(state, 'charge_geometry_invalid', index)
            return {}
        end
        result[#result + 1] = {
            kind = 'rect',
            source = source,
            radius = ARACHNE_CHARGE_WIDTH / 2,
            length = math.sqrt(distanceSq),
            heading = heading,
        }
    end
    return result
end

local function arachneConeDangers(state)
    local result = {}
    for _, entityID in ipairs(state.markedOrder) do
        local marker = state.marked[entityID]
        if type(marker) == 'table'
                and marker.ready
                and Common.validXZ(marker.source)
                and finite(marker.heading)
        then
            result[#result + 1] = {
                kind = 'cone',
                source = marker.source,
                radius = ARACHNE_CONE_RANGE,
                angle = ARACHNE_CONE_ANGLE,
                heading = marker.heading,
            }
        end
    end
    return result
end

local function drawArachneDangers(state, guide, cfg, now)
    now = finite(now) and now or nowMs()
    local drawer = Common.getMoogleDrawer()
    if drawer == nil then
        return false
    end
    local charge = cfg.DrawChargePrediction == true
            and arachneChargeDangers(state, now) or {}
    local cones = cfg.DrawConformityPrediction == true
            and arachneConeDangers(state) or {}
    for _, danger in ipairs(charge) do
        if type(drawer.addRect) == 'function' then
            drawer:addRect(
                    danger.source.x, danger.source.y, danger.source.z,
                    danger.length, ARACHNE_CHARGE_WIDTH, danger.heading)
        end
    end
    for _, danger in ipairs(cones) do
        if type(drawer.addCone) == 'function' then
            drawer:addCone(
                    danger.source.x, danger.source.y, danger.source.z,
                    danger.radius, danger.angle, danger.heading)
        end
    end
    if cfg.DynamicGuide ~= true
            or type(guide) ~= 'table'
            or type(guide.FrameDirect) ~= 'function'
    then
        return false
    end
    local group = {}
    for _, danger in ipairs(charge) do
        group[#group + 1] = danger
    end
    for _, danger in ipairs(cones) do
        group[#group + 1] = danger
    end
    if #group == 0 then
        return false
    end
    local player = getPlayer(guide)
    if player == nil then
        return false
    end
    local target = Common.nearestSafePoint(
            player.pos, group, ARACHNE_ARENA_CENTER,
            ARACHNE_GUIDE_RADIUS,
            { margin = 0.5, step = 1, directionCount = 72 })
    if target == nil or Common.distanceSquared(player.pos, target) <= 0.25 then
        return target ~= nil
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
    if type(M.Arachne) == 'table' then
        clearArachneState(M.Arachne)
    end
    M.Arachne = newArachneState()
    getArachneConfig(M)
    M.SetArachneEnabled = function(enabled)
        local cfg = getArachneConfig(M)
        if cfg ~= nil then
            cfg.Enable = enabled == true
        end
        if enabled ~= true then
            clearArachneState(M.Arachne)
        end
    end
    M.SetArachneChargePredictionEnabled = function(enabled)
        local cfg = getArachneConfig(M)
        if cfg ~= nil then
            cfg.DrawChargePrediction = enabled == true
        end
    end
    M.SetArachneConformityPredictionEnabled = function(enabled)
        local cfg = getArachneConfig(M)
        if cfg ~= nil then
            cfg.DrawConformityPrediction = enabled == true
        end
    end
    M.SetArachneDynamicGuideEnabled = function(enabled)
        local cfg = getArachneConfig(M)
        if cfg ~= nil then
            cfg.DynamicGuide = enabled == true
        end
    end
end

Feature.Clear = function()
    local state = getArachneState()
    if state ~= nil then
        clearArachneState(state)
    end
end

Feature.OnEntityChannel = function(entityID, spellID, targetID, channelTimeMax, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getArachneConfig(guide)
    local state = getArachneState()
    if state == nil or cfg == nil or cfg.Enable ~= true then
        return
    end
    if spellID == ARACHNE_AID.Summon
            or spellID == ARACHNE_AID.ConformityVisual
    then
        beginArachneSummon(state, entityID, spellID)
    elseif spellID == ARACHNE_AID.WebStart then
        startArachneWeb(state, entityID, targetID, channelTimeMax, now)
    elseif spellID == ARACHNE_AID.ChargeStart then
        startArachneCharge(state, entityID, targetID, channelTimeMax, now)
    elseif spellID == ARACHNE_AID.ConformityCone then
        startArachneCone(state, entityID, channelTimeMax, now)
    end
end

Feature.OnEntityCast = function(entityID, spellID, castPos, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getArachneConfig(guide)
    local state = getArachneState()
    if state == nil or cfg == nil or cfg.Enable ~= true then
        return
    end
    if spellID == ARACHNE_AID.WebLink then
        collectArachneWebLink(
                state, entityID,
                type(castPos) == 'table' and castPos.mainTargetID or nil,
                now)
    elseif spellID == ARACHNE_AID.ChargeStart
            or spellID == ARACHNE_AID.ChargeStep
    then
        advanceArachneCharge(state, entityID, spellID, now)
    elseif spellID == ARACHNE_AID.ConformityCone then
        resolveArachneCone(state, entityID, now)
    end
end

Feature.OnAuraChange = function(entityID, oldAura, newAura, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getArachneConfig(guide)
    local state = getArachneState()
    if state ~= nil and cfg ~= nil and cfg.Enable == true then
        markArachneCone(state, entityID, oldAura, newAura, now)
    end
end

Feature.Update = function(guide, now)
    local state = getArachneState()
    if state == nil then
        return false
    end
    local cfg = getArachneConfig(guide)
    if cfg == nil or cfg.Enable ~= true then
        clearArachneState(state)
        return false
    end
    pruneArachneState(state, now)
    return drawArachneDangers(state, guide, cfg, now)
end

Feature.Test = {
    MapID = Context.MapID,
    BossContentID = ARACHNE_BOSS_CONTENT_ID,
    DaughterContentID = ARACHNE_DAUGHTER_CONTENT_ID,
    BossModelID = ARACHNE_BOSS_MODEL_ID,
    DaughterModelID = ARACHNE_DAUGHTER_MODEL_ID,
    ArenaCenter = ARACHNE_ARENA_CENTER,
    ArenaRadius = ARACHNE_ARENA_RADIUS,
    GuideRadius = ARACHNE_GUIDE_RADIUS,
    ChargeWidth = ARACHNE_CHARGE_WIDTH,
    ConeRange = ARACHNE_CONE_RANGE,
    ConeAngle = ARACHNE_CONE_ANGLE,
    ConeAura = ARACHNE_CONE_AURA,
    ConeReadyRadius = ARACHNE_CONE_READY_RADIUS,
    AID = ARACHNE_AID,
    Defaults = ARACHNE_DEFAULTS,
    NewState = newArachneState,
    ClearState = clearArachneState,
    BeginSummon = beginArachneSummon,
    StartWeb = startArachneWeb,
    CollectWebLink = collectArachneWebLink,
    StartCharge = startArachneCharge,
    AdvanceCharge = advanceArachneCharge,
    MarkCone = markArachneCone,
    StartCone = startArachneCone,
    ResolveCone = resolveArachneCone,
    PruneState = pruneArachneState,
    ChargeDangers = arachneChargeDangers,
    ConeDangers = arachneConeDangers,
    DrawDangers = drawArachneDangers,
    Heading = arachneHeading,
}

    return Feature
end

rawset(_G, 'MuAiOccultCrescentNorthArachne', Module)
return Module
