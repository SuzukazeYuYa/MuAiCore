local Module = {}

function Module.Create(Context)
    assert(type(Context) == 'table' and type(Context.Common) == 'table')
    local Common = Context.Common
    local nowMs = Context.nowMs
    local finite = Context.finite
    local reliablePosition = Context.reliablePosition
    local getPlayer = Context.getPlayer

local LITTLE_MAGE_CONTENT_ID = 14795
local LITTLE_MAGE_APPRENTICE_CONTENT_ID = 14796
local LITTLE_MAGE_APPRENTICE_MODEL_ID = 19566
local LITTLE_MAGE_FIRE_ORB_CONTENT_ID = 14797
local LITTLE_MAGE_WATER_ORB_CONTENT_ID = 14798
local LITTLE_MAGE_FIRE_ORB_MODEL_IDS = { [19567] = true, [19568] = true }
local LITTLE_MAGE_WATER_ORB_MODEL_IDS = { [19569] = true, [19570] = true }
local LITTLE_MAGE_ARENA_CENTER = { x = 151.995, z = 715.999 }
local LITTLE_MAGE_ARENA_RADIUS = 20
local LITTLE_MAGE_GUIDE_RADIUS = 19
local LITTLE_MAGE_KNOCKBACK_DISTANCE = 15
local LITTLE_MAGE_FUSION_TETHER = 415
local LITTLE_MAGE_FIRST_TELEGRAPH_MS = 7300
local LITTLE_MAGE_FIRST_RESOLVE_MS = 9300
local LITTLE_MAGE_FUSION_INTERVAL_MS = 3000
local LITTLE_MAGE_NEXT_DRAW_LEAD_MS = 1500
local LITTLE_MAGE_TETHER_WINDOW_MS = 500
local LITTLE_MAGE_FUSION_RESOLVE_MS = LITTLE_MAGE_FIRST_TELEGRAPH_MS
local LITTLE_MAGE_ROUND_TIMEOUT_MS = 22000
local LITTLE_MAGE_RELAY_GATHER_WINDOW_MS = 8000
local LITTLE_MAGE_RELAY_TELEGRAPH_MS = 14500
local LITTLE_MAGE_RELAY_RESOLVE_MS = 16450
local LITTLE_MAGE_RELAY_ROUND_TIMEOUT_MS = 18000
local LITTLE_MAGE_RELAY_RADIUS = 10
local LITTLE_MAGE_RELAY_RADIUS_TOLERANCE = 0.75
local LITTLE_MAGE_RELAY_REFLECTION_TOLERANCE_SQ = 0.75 * 0.75
local LITTLE_MAGE_RELAY_HEADING_TOLERANCE = math.rad(7.5)
local LITTLE_MAGE_RELAY_SUPPLY_TOLERANCE_MS = 1000
local LITTLE_MAGE_RELAY_SUPPLY_OFFSETS_MS = { 6750, 11700 }
local LITTLE_MAGE_RELAY_ENTITY_WAIT_MS = LITTLE_MAGE_RELAY_TELEGRAPH_MS
local LITTLE_MAGE_SEEN_TTL_MS = 30000

local LITTLE_MAGE_AID = {
    Gather = 48306,
    GenerateFireOrb = 48307,
    GenerateWaterOrb = 48308,
    SupplyFireOrb = 48309,
    SupplyWaterOrb = 48310,
    TinyFlare = 48311,
    TinyHoly = 48312,
}

local LITTLE_MAGE_RELAY_GENERATION = {
    [LITTLE_MAGE_AID.GenerateFireOrb] = 'fire',
    [LITTLE_MAGE_AID.GenerateWaterOrb] = 'knockback',
}

local LITTLE_MAGE_RELAY_SUPPLY = {
    [LITTLE_MAGE_AID.SupplyFireOrb] = 'fire',
    [LITTLE_MAGE_AID.SupplyWaterOrb] = 'knockback',
}

local LITTLE_MAGE_RESULT = {
    [LITTLE_MAGE_AID.TinyFlare] = 'fire',
    [LITTLE_MAGE_AID.TinyHoly] = 'knockback',
}

local LITTLE_MAGE_DEFAULTS = {
    Enable = true,
    DynamicGuide = true,
}

local LITTLE_MAGE_DIAGNOSTIC_TEXT = {
    relay_gather_window_invalid = '小小法师集合窗口无效',
    relay_apprentice_list_unavailable = '小小法师学徒实体列表不可用',
    relay_apprentice_count_mismatch = '小小法师学徒数量不匹配',
    relay_apprentice_invalid = '小小法师学徒实体几何无效',
    relay_caster_missing = '小小法师生成魔法球施法者缺失',
    relay_heading_ambiguous = '小小法师传球方向不唯一',
    relay_square_geometry_mismatch = '小小法师四学徒几何不匹配',
    relay_round_overlap = '小小法师传球轮次重叠',
    relay_supply_mismatch = '小小法师传球顺序不匹配',
    fusion_entity_mismatch = '小小法师双球实体不匹配',
    fusion_midpoint_invalid = '小小法师双球中点无效',
    fusion_pair_conflict = '小小法师双球配对冲突',
    fusion_late_tether = '小小法师双球连线超出窗口',
    fusion_result_ambiguous = '小小法师实际判定无法唯一匹配',
    fusion_guide_no_safe_point = '小小法师未找到可靠指路点',
    prediction_draw_failed = '小小法师预测圆绘制失败',
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
        seenRelayChannels = {},
        seenRelaySupplies = {},
        apprentices = {},
        gatherAt = nil,
        pendingRelay = nil,
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
    state.seenRelayChannels = type(state.seenRelayChannels) == 'table'
            and state.seenRelayChannels or {}
    state.seenRelaySupplies = type(state.seenRelaySupplies) == 'table'
            and state.seenRelaySupplies or {}
    state.apprentices = type(state.apprentices) == 'table'
            and state.apprentices or {}
    state.pendingRelay = type(state.pendingRelay) == 'table'
            and state.pendingRelay or nil
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

local function clearLittleMageRound(state)
    if type(state) ~= 'table' then return false end
    if type(state.round) == 'table' then
        for _, entry in ipairs(state.round.predictions or {}) do
            Common.deleteTimedShape(entry.token)
        end
    end
    state.round = nil
    return true
end

local function clearLittleMageState(state)
    if type(state) ~= 'table' then
        return
    end
    clearLittleMageRound(state)
    state.seenTethers = {}
    state.seenChannels = {}
    state.seenCasts = {}
    state.seenRelayChannels = {}
    state.seenRelaySupplies = {}
    state.apprentices = {}
    state.gatherAt = nil
    state.pendingRelay = nil
    state.lastDiagnostic = nil
end

local function littleMageDiagnostic(state, code, context)
    local at = nowMs()
    state.lastDiagnostic = {
        code = code,
        at = at,
        context = context,
    }
    local guide = rawget(_G, 'MuAiGuide')
    if type(guide) == 'table' and type(guide.LogOnce) == 'function' then
        guide.LogOnce(
                'LittleMage',
                code,
                LITTLE_MAGE_DIAGNOSTIC_TEXT[code] or code,
                context)
    end
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
    state.pendingRelay = nil
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

local function entityModelID(entityID, entity)
    return Common.entityModelID(entity or entityID)
end

local function scanLittleMageFusionOrbs()
    local tensorCore = rawget(_G, 'TensorCore')
    if type(tensorCore) ~= 'table'
            or type(tensorCore.entityList) ~= 'function'
    then
        return nil, 'fusion_entity_list_unavailable'
    end
    local snapshots = {}
    local function collect(contentID, modelIDs, kind)
        local entities = tensorCore.entityList(
                'contentid=' .. tostring(contentID))
        if type(entities) ~= 'table' then
            return false
        end
        for _, entity in pairs(entities) do
            local pos = type(entity) == 'table'
                    and reliablePosition(entity.pos, false) or nil
            if type(entity) == 'table'
                    and finite(entity.id)
                    and tonumber(entity.contentid) == contentID
                    and modelIDs[entityModelID(entity.id, entity)] == true
                    and entity.alive ~= false
                    and pos ~= nil
                    and Common.insideCircle(
                            pos, LITTLE_MAGE_ARENA_CENTER, 21)
            then
                local entityID = tonumber(entity.id)
                if snapshots[entityID] ~= nil then
                    snapshots[entityID] = false
                else
                    snapshots[entityID] = {
                        entity = entity,
                        kind = kind,
                        pos = pos,
                    }
                end
            end
        end
        return true
    end
    if not collect(LITTLE_MAGE_FIRE_ORB_CONTENT_ID,
            LITTLE_MAGE_FIRE_ORB_MODEL_IDS, 'fire')
            or not collect(LITTLE_MAGE_WATER_ORB_CONTENT_ID,
                    LITTLE_MAGE_WATER_ORB_MODEL_IDS, 'knockback')
    then
        return nil, 'fusion_entity_list_unavailable'
    end
    return snapshots, nil
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
    then
        return false
    end
    local drawer = Common.getMoogleDrawer()
    if drawer == nil
            or type(drawer.addTimedCircle) ~= 'function'
    then
        return false
    end
    local visibleAt = finite(entry.visibleAt) and entry.visibleAt or now
    local drawStartsAt = math.max(now, visibleAt)
    local timeout = entry.activationAt - drawStartsAt
    local delay = math.max(0, visibleAt - now)
    if timeout <= 0 then
        return false
    end
    local token = drawer:addTimedCircle(
            math.floor(timeout + 0.5),
            entry.source.x,
            entry.source.y,
            entry.source.z,
            18,
            math.floor(delay + 0.5))
    if type(token) ~= 'string' then
        return false
    end
    entry.token = token
    return true
end

local function beginLittleMageGather(state, now)
    if type(state) ~= 'table' or not finite(now) then
        return false
    end
    clearLittleMageRound(state)
    state.apprentices = {}
    state.pendingRelay = nil
    state.gatherAt = now
    return true
end

local function recordLittleMageApprentice(state, entityID, contentID, now)
    if type(state) ~= 'table'
            or not finite(entityID)
            or entityID <= 0
            or tonumber(contentID) ~= LITTLE_MAGE_APPRENTICE_CONTENT_ID
            or not finite(now)
            or not finite(state.gatherAt)
            or now < state.gatherAt
            or now - state.gatherAt > LITTLE_MAGE_RELAY_GATHER_WINDOW_MS
    then
        return false
    end
    state.apprentices[entityID] = { addedAt = now }
    return true
end

local function findRelayReflection(group, point, excluded)
    local expectedX = 2 * LITTLE_MAGE_ARENA_CENTER.x - point.pos.x
    local expectedZ = 2 * LITTLE_MAGE_ARENA_CENTER.z - point.pos.z
    local matches = {}
    for _, candidate in ipairs(group) do
        if candidate.id ~= excluded then
            local dx = candidate.pos.x - expectedX
            local dz = candidate.pos.z - expectedZ
            if dx * dx + dz * dz
                    <= LITTLE_MAGE_RELAY_REFLECTION_TOLERANCE_SQ
            then
                matches[#matches + 1] = candidate
            end
        end
    end
    return #matches == 1 and matches[1] or nil
end

local function resolveLittleMageRelayGeometry(state, casterID, now)
    if type(state) ~= 'table'
            or not finite(casterID)
            or not finite(now)
            or not finite(state.gatherAt)
            or now - state.gatherAt < 0
            or now - state.gatherAt > LITTLE_MAGE_RELAY_GATHER_WINDOW_MS
    then
        return nil, 'relay_gather_window_invalid'
    end
    local tensorCore = rawget(_G, 'TensorCore')
    if type(tensorCore) ~= 'table'
            or type(tensorCore.entityList) ~= 'function'
    then
        return nil, 'relay_apprentice_list_unavailable'
    end
    local entities = tensorCore.entityList(
            'contentid=' .. tostring(LITTLE_MAGE_APPRENTICE_CONTENT_ID))
    if type(entities) ~= 'table' then
        return nil, 'relay_apprentice_list_unavailable'
    end
    local group = {}
    for _, entity in pairs(entities) do
        local entityID = type(entity) == 'table'
                and tonumber(entity.id) or nil
        if finite(entityID) and state.apprentices[entityID] ~= nil then
            local position = reliablePosition(
                    entity.pos, entityID == casterID)
            if tonumber(entity.contentid)
                        ~= LITTLE_MAGE_APPRENTICE_CONTENT_ID
                    or entityModelID(entityID, entity)
                        ~= LITTLE_MAGE_APPRENTICE_MODEL_ID
                    or entity.alive == false
                    or position == nil
            then
                return nil, 'relay_apprentice_invalid', {
                    entityID = entityID,
                }
            end
            group[#group + 1] = { id = entityID, pos = position }
        end
    end
    if #group ~= 4 then
        return nil, 'relay_apprentice_count_mismatch', {
            count = #group,
        }
    end
    local caster = nil
    for _, apprentice in ipairs(group) do
        local dx = apprentice.pos.x - LITTLE_MAGE_ARENA_CENTER.x
        local dz = apprentice.pos.z - LITTLE_MAGE_ARENA_CENTER.z
        local radius = math.sqrt(dx * dx + dz * dz)
        if math.abs(radius - LITTLE_MAGE_RELAY_RADIUS)
                > LITTLE_MAGE_RELAY_RADIUS_TOLERANCE
        then
            return nil, 'relay_apprentice_radius_mismatch', {
                entityID = apprentice.id,
                radius = radius,
            }
        end
        if apprentice.id == casterID then
            caster = apprentice
        end
    end
    if caster == nil or not finite(caster.pos.h) then
        return nil, 'relay_caster_missing', { entityID = casterID }
    end
    local forwardX = math.sin(caster.pos.h)
    local forwardZ = math.cos(caster.pos.h)
    local nextApprentice = nil
    local nextError = math.huge
    local headingMatches = 0
    for _, candidate in ipairs(group) do
        if candidate.id ~= caster.id then
            local dx = candidate.pos.x - caster.pos.x
            local dz = candidate.pos.z - caster.pos.z
            local distance = math.sqrt(dx * dx + dz * dz)
            if distance > 0 then
                local alignment = (dx * forwardX + dz * forwardZ) / distance
                alignment = math.max(-1, math.min(1, alignment))
                local error = math.acos(alignment)
                if error <= LITTLE_MAGE_RELAY_HEADING_TOLERANCE then
                    headingMatches = headingMatches + 1
                end
                if error < nextError then
                    nextError = error
                    nextApprentice = candidate
                end
            end
        end
    end
    if nextApprentice == nil
            or headingMatches ~= 1
            or nextError > LITTLE_MAGE_RELAY_HEADING_TOLERANCE
    then
        return nil, 'relay_heading_ambiguous', {
            entityID = casterID,
            headingError = nextError,
            matches = headingMatches,
        }
    end
    local casterX = caster.pos.x - LITTLE_MAGE_ARENA_CENTER.x
    local casterZ = caster.pos.z - LITTLE_MAGE_ARENA_CENTER.z
    local nextX = nextApprentice.pos.x - LITTLE_MAGE_ARENA_CENTER.x
    local nextZ = nextApprentice.pos.z - LITTLE_MAGE_ARENA_CENTER.z
    local orthogonality = math.abs(casterX * nextX + casterZ * nextZ)
            / (LITTLE_MAGE_RELAY_RADIUS * LITTLE_MAGE_RELAY_RADIUS)
    if orthogonality > 0.15 then
        return nil, 'relay_square_geometry_mismatch', {
            orthogonality = orthogonality,
        }
    end
    local second = findRelayReflection(group, caster, caster.id)
    local final = findRelayReflection(group, nextApprentice, nextApprentice.id)
    if second == nil
            or final == nil
            or second.id == nextApprentice.id
            or final.id == caster.id
            or final.id == second.id
    then
        return nil, 'relay_square_geometry_mismatch'
    end
    return {
        caster = caster,
        next = nextApprentice,
        second = second,
        final = final,
    }
end

local function commitLittleMageRelayGeneration(state, pending, geometry, now)
    local key = 'relay:' .. pending.eventKey .. ':'
            .. tostring(math.floor(pending.observedAt + 0.5))
    local entry = {
        key = key,
        sourceEntityID = geometry.caster.id,
        kind = pending.kind,
        source = geometry.final.pos,
        order = 1,
        visibleAt = pending.observedAt,
        telegraphAt = pending.observedAt + LITTLE_MAGE_RELAY_TELEGRAPH_MS,
        activationAt = pending.observedAt + LITTLE_MAGE_RELAY_RESOLVE_MS,
        handedOff = false,
    }
    state.round = {
        mode = 'relay',
        startedAt = pending.observedAt,
        expiresAt = pending.observedAt + LITTLE_MAGE_RELAY_ROUND_TIMEOUT_MS,
        predictions = { entry },
        byKey = { [key] = entry },
        orbPartners = {},
        suppressed = false,
        relay = {
            kind = pending.kind,
            suppliesSeen = 0,
            supplies = {
                { id = geometry.next.id, source = geometry.next.pos },
                { id = geometry.second.id, source = geometry.second.pos },
            },
            finalEntityID = geometry.final.id,
        },
    }
    state.pendingRelay = nil
    if entry.kind == 'fire' and not drawLittleMagePrediction(entry, now) then
        littleMageDiagnostic(state, 'prediction_draw_failed', {
            entityID = pending.entityID,
            spellID = pending.spellID,
        })
    end
    return true
end

local function resolveLittleMagePendingRelay(state, now)
    local pending = type(state) == 'table' and state.pendingRelay or nil
    if type(pending) ~= 'table' then
        return false
    end
    local geometry, code, context = resolveLittleMageRelayGeometry(
            state, pending.entityID, pending.observedAt)
    if geometry ~= nil then
        return commitLittleMageRelayGeneration(state, pending, geometry, now)
    end
    pending.lastCode = code
    pending.lastContext = context
    if now >= pending.expiresAt then
        state.pendingRelay = nil
        suppressLittleMage(state, code, context)
    end
    return false
end

local function recordLittleMageRelayGeneration(
        state, entityID, spellID, now)
    local kind = LITTLE_MAGE_RELAY_GENERATION[spellID]
    if kind == nil or type(state) ~= 'table' or not finite(now) then
        return false
    end
    local eventKey = tostring(entityID) .. ':' .. tostring(spellID)
    local seenAt = state.seenRelayChannels[eventKey]
    if finite(seenAt) and now - seenAt <= 1000 then
        return false
    end
    if type(state.round) == 'table' or type(state.pendingRelay) == 'table' then
        suppressLittleMage(state, 'relay_round_overlap', {
            entityID = entityID,
            spellID = spellID,
        })
        return false
    end
    state.seenRelayChannels[eventKey] = now
    state.pendingRelay = {
        eventKey = eventKey,
        entityID = entityID,
        spellID = spellID,
        kind = kind,
        observedAt = now,
        expiresAt = now + LITTLE_MAGE_RELAY_ENTITY_WAIT_MS,
    }
    resolveLittleMagePendingRelay(state, now)
    return true
end

local function recordLittleMageRelaySupply(state, entityID, spellID, now)
    local kind = LITTLE_MAGE_RELAY_SUPPLY[spellID]
    local round = type(state) == 'table' and state.round or nil
    if kind == nil
            or type(round) ~= 'table'
            or round.mode ~= 'relay'
            or round.suppressed == true
            or type(round.relay) ~= 'table'
    then
        return false
    end
    local eventKey = tostring(entityID) .. ':' .. tostring(spellID)
    local seenAt = state.seenRelaySupplies[eventKey]
    if finite(seenAt) and now - seenAt <= 1000 then
        return false
    end
    local index = (tonumber(round.relay.suppliesSeen) or 0) + 1
    local expected = round.relay.supplies[index]
    local expectedOffset = LITTLE_MAGE_RELAY_SUPPLY_OFFSETS_MS[index]
    if kind ~= round.relay.kind
            or type(expected) ~= 'table'
            or not finite(expectedOffset)
            or entityID ~= expected.id
            or math.abs(now - (round.startedAt + expectedOffset))
                    > LITTLE_MAGE_RELAY_SUPPLY_TOLERANCE_MS
    then
        suppressLittleMage(state, 'relay_supply_mismatch', {
            entityID = entityID,
            spellID = spellID,
            expectedEntityID = type(expected) == 'table'
                    and expected.id or nil,
            index = index,
        })
        return false
    end
    round.relay.suppliesSeen = index
    state.seenRelaySupplies[eventKey] = now
    return true
end

local function commitLittleMageFusion(state, pending, now, snapshots)
    local round = state.round
    local source = type(snapshots) == 'table'
            and snapshots[pending.sourceID] or nil
    local target = type(snapshots) == 'table'
            and snapshots[pending.targetID] or nil
    if type(source) ~= 'table' or type(target) ~= 'table' then
        pending.lastError = 'fusion_entity_mismatch'
        return false
    end
    if source.kind ~= target.kind then
        suppressLittleMage(state, 'fusion_entity_mismatch', {
            sourceID = pending.sourceID,
            targetID = pending.targetID,
        })
        return false
    end
    local midpoint = reliablePosition({
        x = (source.pos.x + target.pos.x) / 2,
        y = (source.pos.y + target.pos.y) / 2,
        z = (source.pos.z + target.pos.z) / 2,
    }, false)
    if midpoint == nil
            or not Common.insideCircle(
                    midpoint, LITTLE_MAGE_ARENA_CENTER, 21)
    then
        suppressLittleMage(state, 'fusion_midpoint_invalid', pending.key)
        return false
    end
    local oldSourcePartner = round.orbPartners[pending.sourceID]
    local oldTargetPartner = round.orbPartners[pending.targetID]
    if (oldSourcePartner ~= nil and oldSourcePartner ~= pending.targetID)
            or (oldTargetPartner ~= nil and oldTargetPartner ~= pending.sourceID)
            or #round.predictions >= 4
    then
        suppressLittleMage(state, 'fusion_pair_conflict', {
            sourceID = pending.sourceID,
            targetID = pending.targetID,
        })
        return false
    end
    local order = #round.predictions + 1
    local telegraphAt = round.startedAt + LITTLE_MAGE_FIRST_TELEGRAPH_MS
            + (order - 1) * LITTLE_MAGE_FUSION_INTERVAL_MS
    local activationAt = round.startedAt + LITTLE_MAGE_FIRST_RESOLVE_MS
            + (order - 1) * LITTLE_MAGE_FUSION_INTERVAL_MS
    local visibleAt = order == 1 and round.startedAt
            or activationAt - LITTLE_MAGE_FUSION_INTERVAL_MS
                    - LITTLE_MAGE_NEXT_DRAW_LEAD_MS
    local entry = {
        key = pending.key,
        sourceEntityID = pending.sourceID,
        targetEntityID = pending.targetID,
        kind = source.kind,
        source = midpoint,
        order = order,
        visibleAt = visibleAt,
        telegraphAt = telegraphAt,
        activationAt = activationAt,
        handedOff = false,
    }
    round.predictions[#round.predictions + 1] = entry
    round.byKey[pending.key] = entry
    round.orbPartners[pending.sourceID] = pending.targetID
    round.orbPartners[pending.targetID] = pending.sourceID
    round.pendingFusions[pending.key] = nil
    state.seenTethers[pending.key] = pending.receivedAt
    drawLittleMagePrediction(entry, now)
    return true
end

local function resolveLittleMagePendingFusions(state, now)
    local round = type(state) == 'table' and state.round or nil
    if type(round) ~= 'table' or round.mode ~= 'fusion'
            or round.suppressed == true
            or type(round.pendingFusions) ~= 'table'
    then
        return false
    end
    if next(round.pendingFusions) == nil then
        return false
    end
    local snapshots, scanError = scanLittleMageFusionOrbs()
    local resolved = false
    local ordered = {}
    for key, pending in pairs(round.pendingFusions) do
        ordered[#ordered + 1] = { key = key, pending = pending }
    end
    table.sort(ordered, function(left, right)
        local leftOrder = type(left.pending) == 'table'
                and tonumber(left.pending.receivedOrder) or math.huge
        local rightOrder = type(right.pending) == 'table'
                and tonumber(right.pending.receivedOrder) or math.huge
        if leftOrder ~= rightOrder then
            return leftOrder < rightOrder
        end
        return tostring(left.key) < tostring(right.key)
    end)
    for _, item in ipairs(ordered) do
        local key = item.key
        local pending = item.pending
        if type(pending) ~= 'table' then
            round.pendingFusions[key] = nil
        elseif commitLittleMageFusion(state, pending, now, snapshots) then
            resolved = true
        elseif now > pending.expiresAt then
            suppressLittleMage(state,
                    scanError or (type(pending.lastError) == 'string'
                            and pending.lastError or 'fusion_entity_mismatch'), {
                        sourceID = pending.sourceID,
                        targetID = pending.targetID,
                    })
            break
        end
    end
    return resolved
end

local function recordLittleMageFusion(state, sourceID, targetID, now)
    if type(state) ~= 'table' or not finite(now) then
        return false
    end
    local key = littleMagePairKey(sourceID, targetID)
    if key == nil or state.seenTethers[key] ~= nil then
        return false
    end
    local round = state.round
    if type(round) ~= 'table' then
        round = {
            mode = 'fusion',
            startedAt = now,
            expiresAt = now + LITTLE_MAGE_ROUND_TIMEOUT_MS,
            predictions = {},
            byKey = {},
            orbPartners = {},
            pendingFusions = {},
            nextFusionOrder = 1,
            suppressed = false,
        }
        state.round = round
    elseif round.mode ~= 'fusion'
            or now - round.startedAt > LITTLE_MAGE_TETHER_WINDOW_MS
    then
        suppressLittleMage(state, 'fusion_late_tether', {
            startedAt = round.startedAt,
            actualAt = now,
        })
        return false
    end
    round.pendingFusions = type(round.pendingFusions) == 'table'
            and round.pendingFusions or {}
    if round.suppressed == true or round.pendingFusions[key] ~= nil then
        return false
    end
    local receivedOrder = tonumber(round.nextFusionOrder) or 1
    round.nextFusionOrder = receivedOrder + 1
    round.pendingFusions[key] = {
        key = key,
        sourceID = sourceID,
        targetID = targetID,
        receivedAt = now,
        receivedOrder = receivedOrder,
        expiresAt = round.startedAt + LITTLE_MAGE_FUSION_RESOLVE_MS,
    }
    resolveLittleMagePendingFusions(state, now)
    return round.suppressed ~= true
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
    local matches = {}
    local tolerance = channel and 1200 or 1600
    for index, entry in ipairs(round.predictions) do
        local expectedAt = channel and entry.telegraphAt or entry.activationAt
        if entry.kind == kind
                and math.abs(now - expectedAt) <= tolerance
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
                end
            end
            if #round.predictions == 0
                    and next(round.pendingFusions or {}) == nil
                    and round.suppressed ~= true
            then
                state.round = nil
            end
        end
    end
    Common.pruneSeen(state.seenTethers, now, LITTLE_MAGE_SEEN_TTL_MS)
    Common.pruneSeen(state.seenChannels, now, LITTLE_MAGE_SEEN_TTL_MS)
    Common.pruneSeen(state.seenCasts, now, LITTLE_MAGE_SEEN_TTL_MS)
    Common.pruneSeen(
            state.seenRelayChannels, now, LITTLE_MAGE_SEEN_TTL_MS)
    Common.pruneSeen(
            state.seenRelaySupplies, now, LITTLE_MAGE_SEEN_TTL_MS)
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

Feature.OnEntityAdd = function(entityID, contentID, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getLittleMageConfig(guide)
    local state = getLittleMageState()
    if state ~= nil and cfg ~= nil and cfg.Enable == true
            and cfg.DynamicGuide == true
    then
        return recordLittleMageApprentice(state, entityID, contentID, now)
    end
    return false
end

Feature.OnEntityChannel = function(entityID, spellID, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getLittleMageConfig(guide)
    local state = getLittleMageState()
    if state ~= nil and cfg ~= nil and cfg.Enable == true
            and cfg.DynamicGuide == true
    then
        local generated = recordLittleMageRelayGeneration(
                state, entityID, spellID, now)
        local supplied = recordLittleMageRelaySupply(
                state, entityID, spellID, now)
        local handedOff = markLittleMageTelegraph(
                state, entityID, spellID, now)
        return generated or supplied or handedOff
    end
    return false
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
        if spellID == LITTLE_MAGE_AID.Gather then
            beginLittleMageGather(state, now)
        end
        return resolveLittleMageResult(state, entityID, spellID, now)
    end
    return false
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
    resolveLittleMagePendingRelay(state, now)
    resolveLittleMagePendingFusions(state, now)
    if allowGuide == false then
        return false
    end
    return drawLittleMageDynamicGuide(state, guide, now)
end

Feature.Test = {
    MapID = Context.MapID,
    ContentID = LITTLE_MAGE_CONTENT_ID,
    ApprenticeContentID = LITTLE_MAGE_APPRENTICE_CONTENT_ID,
    ApprenticeModelID = LITTLE_MAGE_APPRENTICE_MODEL_ID,
    FireOrbContentID = LITTLE_MAGE_FIRE_ORB_CONTENT_ID,
    WaterOrbContentID = LITTLE_MAGE_WATER_ORB_CONTENT_ID,
    ArenaCenter = LITTLE_MAGE_ARENA_CENTER,
    ArenaRadius = LITTLE_MAGE_ARENA_RADIUS,
    GuideArenaRadius = LITTLE_MAGE_GUIDE_RADIUS,
    KnockbackDistance = LITTLE_MAGE_KNOCKBACK_DISTANCE,
    FusionTether = LITTLE_MAGE_FUSION_TETHER,
    FusionTetherWindowMs = LITTLE_MAGE_TETHER_WINDOW_MS,
    FusionResolveMs = LITTLE_MAGE_FUSION_RESOLVE_MS,
    FirstTelegraphMs = LITTLE_MAGE_FIRST_TELEGRAPH_MS,
    FirstResolveMs = LITTLE_MAGE_FIRST_RESOLVE_MS,
    FusionIntervalMs = LITTLE_MAGE_FUSION_INTERVAL_MS,
    NextDrawLeadMs = LITTLE_MAGE_NEXT_DRAW_LEAD_MS,
    RelayGatherWindowMs = LITTLE_MAGE_RELAY_GATHER_WINDOW_MS,
    RelayTelegraphMs = LITTLE_MAGE_RELAY_TELEGRAPH_MS,
    RelayResolveMs = LITTLE_MAGE_RELAY_RESOLVE_MS,
    RelaySupplyOffsetsMs = LITTLE_MAGE_RELAY_SUPPLY_OFFSETS_MS,
    RelayEntityWaitMs = LITTLE_MAGE_RELAY_ENTITY_WAIT_MS,
    FireRadius = 18,
    AID = LITTLE_MAGE_AID,
    Result = LITTLE_MAGE_RESULT,
    Defaults = LITTLE_MAGE_DEFAULTS,
    NewState = newLittleMageState,
    ClearState = clearLittleMageState,
    BeginGather = beginLittleMageGather,
    RecordApprentice = recordLittleMageApprentice,
    ResolveRelayGeometry = resolveLittleMageRelayGeometry,
    RecordRelayGeneration = recordLittleMageRelayGeneration,
    RecordRelaySupply = recordLittleMageRelaySupply,
    RecordFusion = recordLittleMageFusion,
    ResolvePendingFusions = resolveLittleMagePendingFusions,
    MarkTelegraph = markLittleMageTelegraph,
    ResolveResult = resolveLittleMageResult,
    PruneState = pruneLittleMageState,
    NextPrediction = littleMageNextPrediction,
    KnockbackSolution = littleMageKnockbackSolution,
    NearestKnockbackStart = nearestLittleMageKnockbackStart,
    DrawPrediction = drawLittleMagePrediction,
    DrawDynamicGuide = drawLittleMageDynamicGuide,
    ResolvePendingRelay = resolveLittleMagePendingRelay,
    PointInDanger = Common.pointInDanger,
    ProjectKnockback = Common.projectKnockback,
}

    return Feature
end

rawset(_G, 'MuAiOccultCrescentNorthLittleMage', Module)
return Module
