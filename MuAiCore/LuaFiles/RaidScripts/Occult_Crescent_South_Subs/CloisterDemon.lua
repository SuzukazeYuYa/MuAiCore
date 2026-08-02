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

local CLOISTER_ARENA_CENTER = { x = -340, z = 800 }
local CLOISTER_ARENA_RADIUS = 29.5
local CLOISTER_SEAL_COLLECTION_RADIUS = 31
local CLOISTER_SEAL_RADIUS = 3
local CLOISTER_SEAL_CONTENT_ID = 2014460
local CLOISTER_CHANNEL_MIN_SECONDS = 20
local CLOISTER_CHANNEL_MAX_SECONDS = 60
local CLOISTER_ROUND_GRACE_MS = 3000
local CLOISTER_ENTITY_MISSING_CLEAR_MS = 500
local CLOISTER_CAST_END_CLEAR_MS = 500
local CLOISTER_EMPTY_CLEAR_MS = 500
local CLOISTER_BOSS_MISSING_CLEAR_MS = 2000
local CLOISTER_DIAGNOSTIC_TTL_MS = 5000
local CLOISTER_POSITION_MATCH_SQ = 0.01
local CLOISTER_NEAREST_TIE_SQ = 0.01

local cloisterAID = {
    AutoAttack = 41363,
    SundersealRoarCast = 41336,
    SundersealRoar = 41337,
    VoidThunderIII = 41358,
    Unk1 = 41338,
    GreatBallOfFire = 41354,
    Explosion = 41357,
    GigaflareCast = 41361,
    Gigaflare = 41362,
    TidalBreath = 41360,
    KarmicDrain = 41359,
    BlazingFlare = 41355,
    Flare = 41356,
    SealAsunder1 = 41339,
    SealAsunder2 = 41340,
    SealAsunder3 = 41341,
}

local cloisterOID = {
    Boss = 0x46C9,
    Helper = 0x233C,
    BallOfFire = 0x47F0,
    CloisterTorch = 0x46CB,
    Seal = 0x1EBCFC,
}

local sealAsunderAID = {
    [cloisterAID.SealAsunder1] = true,
    [cloisterAID.SealAsunder2] = true,
    [cloisterAID.SealAsunder3] = true,
}

local cloisterTowerDrawer
local cloisterHighlightDrawer

local cloisterFinite = Common.finite

local function reliableCloisterPosition(pos)
    return Common.copyPosition(pos, true)
end

local function isInsideCloisterCollectionArea(pos)
    if reliableCloisterPosition(pos) == nil then
        return false
    end
    local dx = pos.x - CLOISTER_ARENA_CENTER.x
    local dz = pos.z - CLOISTER_ARENA_CENTER.z
    return dx * dx + dz * dz
            <= CLOISTER_SEAL_COLLECTION_RADIUS * CLOISTER_SEAL_COLLECTION_RADIUS
end

local function newCloisterState()
    return {
        round = nil,
        lastDiagnostic = nil,
    }
end

local function ensureCloisterRound(round)
    if type(round) ~= 'table' then
        return nil
    end
    round.seals = type(round.seals) == 'table' and round.seals or {}
    round.sealByID = type(round.sealByID) == 'table' and round.sealByID or {}
    round.seenIDs = type(round.seenIDs) == 'table' and round.seenIDs or {}
    for _, seal in ipairs(round.seals) do
        if type(seal) == 'table' and type(seal.entityID) == 'number' then
            round.sealByID[seal.entityID] = seal
        end
    end
    return round
end

local function ensureCloisterState(state)
    state.round = ensureCloisterRound(state.round)
    return state
end

local function clearCloisterState(state)
    ensureCloisterState(state)
    state.round = nil
    state.lastDiagnostic = nil
end

local cloisterDiagnosticText = {
    channel_missing_data = '封印大妖塔圈跳过：Seal Asunder读条实体或时长不可靠。',
    channel_conflict = '封印大妖出现重叠Seal Asunder轮次，本轮停止自定义绘图。',
    seal_missing_entity = '封印大妖对象生成事件暂未取得可靠实体，等待受限补扫。',
    seal_missing_geometry = '封印大妖对象位置、高度或场内约束不可靠。',
    seal_position_conflict = '同一封印对象出现位置冲突，本轮停止自定义绘图。',
    cast_entity_conflict = 'Seal Asunder结算实体或技能与当前轮次不一致，本轮停止自定义绘图。',
}

local cloisterFeature = Common.newFeature({
    key = 'CloisterDemon',
    newState = newCloisterState,
    ensureState = ensureCloisterState,
    diagnosticText = cloisterDiagnosticText,
})
local getCloisterConfig = cloisterFeature.GetConfig
local getCloisterRuntimeState = cloisterFeature.GetRuntimeState

local function setCloisterDiagnostic(state, guide, code, now, context)
    if cloisterFeature.Diagnostic(state, guide, code, now, context)
            and state.round ~= nil
    then
        state.round.lastDiagnostic = state.lastDiagnostic
    end
end

local function suppressCloisterRound(state, code, now)
    local round = state.round
    if round == nil or (not round.hadSeals and #round.seals == 0) then
        return
    end
    if round.ambiguity == nil then
        round.ambiguity = {
            code = code,
            at = now,
            expiresAt = round.expiresAt,
        }
    end
end

local function sortCloisterSeals(round)
    table.sort(round.seals, function(left, right)
        if left.firstSeenAt ~= right.firstSeenAt then
            return left.firstSeenAt < right.firstSeenAt
        end
        return left.entityID < right.entityID
    end)
end

local function removeCloisterSeal(round, entityID, now)
    local seal = round.sealByID[entityID]
    if seal == nil then
        return false
    end
    round.sealByID[entityID] = nil
    for index, candidate in ipairs(round.seals) do
        if candidate == seal then
            table.remove(round.seals, index)
            break
        end
    end
    if round.hadSeals and #round.seals == 0 and round.emptySince == nil then
        round.emptySince = now
    end
    return true
end

local function sameCloisterPosition(left, right)
    return distanceSquared(left, right) <= CLOISTER_POSITION_MATCH_SQ
            and math.abs(left.y - right.y) <= 0.1
end

local function addCloisterSealEntity(
        state,
        entity,
        expectedEntityID,
        now,
        guide,
        source)
    local round = state.round
    if round == nil or type(entity) ~= 'table' then
        return false
    end
    local entityID = entity.id
    if not cloisterFinite(entityID)
            or entityID <= 0
            or (cloisterFinite(expectedEntityID) and entityID ~= expectedEntityID)
    then
        if entity.contentid == CLOISTER_SEAL_CONTENT_ID then
            suppressCloisterRound(state, 'seal_missing_geometry', now)
            setCloisterDiagnostic(state, guide, 'seal_missing_geometry', now, {
                source = source,
                entityID = entityID,
                expectedEntityID = expectedEntityID,
            })
        end
        return false
    end
    if entity.contentid ~= CLOISTER_SEAL_CONTENT_ID then
        if round.sealByID[entityID] ~= nil then
            removeCloisterSeal(round, entityID, now)
        end
        return false
    end

    local pos = reliableCloisterPosition(entity.pos)
    if pos == nil or not isInsideCloisterCollectionArea(pos) then
        suppressCloisterRound(state, 'seal_missing_geometry', now)
        setCloisterDiagnostic(state, guide, 'seal_missing_geometry', now, {
            source = source,
            entityID = entityID,
        })
        return false
    end

    local seen = round.seenIDs[entityID]
    if seen ~= nil then
        if not sameCloisterPosition(seen.pos, pos) then
            suppressCloisterRound(state, 'seal_position_conflict', now)
            setCloisterDiagnostic(state, guide, 'seal_position_conflict', now, {
                source = source,
                entityID = entityID,
            })
            return false
        end
        local active = round.sealByID[entityID]
        if active ~= nil then
            active.lastSeenAt = now
            active.missingSince = nil
        end
        return false
    end

    local seal = {
        entityID = entityID,
        pos = pos,
        firstSeenAt = now,
        lastSeenAt = now,
        missingSince = nil,
    }
    round.seenIDs[entityID] = {
        pos = pos,
        firstSeenAt = now,
    }
    round.seals[#round.seals + 1] = seal
    round.sealByID[entityID] = seal
    round.hadSeals = true
    round.emptySince = nil
    sortCloisterSeals(round)
    return true
end

local function handleCloisterEntityChannel(
        state,
        entityID,
        spellID,
        channelTimeMax,
        now,
        guide)
    if not sealAsunderAID[spellID] then
        return false
    end
    if not cloisterFinite(entityID)
            or entityID <= 0
            or not cloisterFinite(channelTimeMax)
            or channelTimeMax <= CLOISTER_CHANNEL_MIN_SECONDS
            or channelTimeMax > CLOISTER_CHANNEL_MAX_SECONDS
    then
        setCloisterDiagnostic(state, guide, 'channel_missing_data', now)
        return false
    end

    local active = state.round
    if active ~= nil then
        if active.bossEntityID == entityID and active.spellID == spellID then
            return false
        end
        if #active.seals > 0 then
            suppressCloisterRound(state, 'channel_conflict', now)
            setCloisterDiagnostic(state, guide, 'channel_conflict', now, {
                entityID = entityID,
                spellID = spellID,
            })
            return false
        end
    end

    local activationAt = now + channelTimeMax * 1000
    state.round = {
        bossEntityID = entityID,
        spellID = spellID,
        startedAt = now,
        activationAt = activationAt,
        expiresAt = activationAt + CLOISTER_ROUND_GRACE_MS,
        seals = {},
        sealByID = {},
        seenIDs = {},
        ambiguity = nil,
        lastDiagnostic = nil,
        hadSeals = false,
        emptySince = nil,
        bossMissingSince = nil,
        castEndedSince = nil,
        lastScriptEvent = nil,
    }
    state.lastDiagnostic = nil
    return true
end

local function handleCloisterEntityAdd(state, entityID, now, guide)
    if state.round == nil
            or not cloisterFinite(entityID)
            or entityID <= 0
    then
        return false
    end
    if type(TensorCore) ~= 'table'
            or type(TensorCore.mGetEntity) ~= 'function'
    then
        return false
    end
    local entity = TensorCore.mGetEntity(entityID)
    if type(entity) ~= 'table' then
        setCloisterDiagnostic(state, guide, 'seal_missing_entity', now, {
            entityID = entityID,
        })
        return false
    end
    return addCloisterSealEntity(
            state, entity, entityID, now, guide, 'entity_add')
end

local function scanCloisterSeals(state, now, guide)
    if state.round == nil
            or type(TensorCore) ~= 'table'
            or type(TensorCore.entityList) ~= 'function'
    then
        return 0
    end
    local entities = TensorCore.entityList(
            'contentid=' .. tostring(CLOISTER_SEAL_CONTENT_ID))
    if type(entities) ~= 'table' then
        return 0
    end
    local added = 0
    for _, entity in pairs(entities) do
        if type(entity) == 'table'
                and entity.contentid == CLOISTER_SEAL_CONTENT_ID
                and addCloisterSealEntity(
                        state,
                        entity,
                        entity.id,
                        now,
                        guide,
                        'scan')
        then
            added = added + 1
        end
    end
    return added
end

local function cloisterEntityVisible(entityID)
    if type(Argus) ~= 'table'
            or type(Argus.isEntityVisible) ~= 'function'
    then
        return nil
    end
    local visible = Argus.isEntityVisible(entityID)
    if type(visible) == 'boolean' then
        return visible
    end
    return nil
end

local function refreshCloisterSeals(state, now, guide)
    local round = state.round
    if round == nil
            or type(TensorCore) ~= 'table'
            or type(TensorCore.mGetEntity) ~= 'function'
    then
        return
    end
    for index = #round.seals, 1, -1 do
        local seal = round.seals[index]
        local entity = TensorCore.mGetEntity(seal.entityID)
        local removeImmediately = false
        local unavailable = false
        if type(entity) ~= 'table' then
            unavailable = true
        elseif type(entity.id) == 'number' and entity.id ~= seal.entityID then
            removeImmediately = true
        elseif type(entity.contentid) == 'number'
                and entity.contentid ~= CLOISTER_SEAL_CONTENT_ID
        then
            removeImmediately = true
        elseif entity.contentid == nil then
            unavailable = true
        elseif entity.alive == false or cloisterEntityVisible(seal.entityID) == false then
            removeImmediately = true
        else
            local pos = reliableCloisterPosition(entity.pos)
            if pos == nil then
                unavailable = true
            elseif not isInsideCloisterCollectionArea(pos) then
                removeImmediately = true
            elseif not sameCloisterPosition(seal.pos, pos) then
                suppressCloisterRound(state, 'seal_position_conflict', now)
                setCloisterDiagnostic(
                        state, guide, 'seal_position_conflict', now, {
                            source = 'refresh',
                            entityID = seal.entityID,
                        })
                seal.lastSeenAt = now
                seal.missingSince = nil
            else
                seal.lastSeenAt = now
                seal.missingSince = nil
            end
        end

        if removeImmediately then
            removeCloisterSeal(round, seal.entityID, now)
        elseif unavailable then
            seal.missingSince = seal.missingSince or now
            if now - seal.missingSince >= CLOISTER_ENTITY_MISSING_CLEAR_MS then
                removeCloisterSeal(round, seal.entityID, now)
            end
        end
    end
end

local function handleCloisterScriptFunc(state, entityID, a1, a2, a3, now)
    local round = state.round
    local seal = round ~= nil and round.sealByID[entityID] or nil
    if seal == nil then
        return false
    end
    local event = {
        entityID = entityID,
        a1 = a1,
        a2 = a2,
        a3 = a3,
        at = now,
    }
    seal.lastScriptEvent = event
    round.lastScriptEvent = event
    -- Argus参数到BossMod EAnim 0x00040008的映射尚无本机证据，不据此移除。
    return true
end

local function handleCloisterEntityCast(
        state,
        entityID,
        spellID,
        now,
        guide)
    if not sealAsunderAID[spellID] or state.round == nil then
        return false
    end
    local round = state.round
    if entityID ~= round.bossEntityID or spellID ~= round.spellID then
        suppressCloisterRound(state, 'cast_entity_conflict', now)
        setCloisterDiagnostic(state, guide, 'cast_entity_conflict', now, {
            expectedEntityID = round.bossEntityID,
            actualEntityID = entityID,
            expectedSpellID = round.spellID,
            actualSpellID = spellID,
        })
        return false
    end
    clearCloisterState(state)
    return true
end

local function cloisterBossCastState(round)
    if type(TensorCore) ~= 'table'
            or type(TensorCore.mGetEntity) ~= 'function'
    then
        return nil, nil
    end
    local entity = TensorCore.mGetEntity(round.bossEntityID)
    if type(entity) ~= 'table' or entity.alive == false then
        return false, nil
    end
    local castingInfo = entity.castinginfo
    local channelingID = type(castingInfo) == 'table'
            and castingInfo.channelingid or nil
    if not cloisterFinite(channelingID) then
        return true, nil
    end
    return true, channelingID == round.spellID
end

local function nearestCloisterSeal(round, playerPos)
    local player = reliableCloisterPosition(playerPos)
    if round == nil or player == nil or #round.seals == 0 then
        return nil
    end
    local nearest
    local nearestDistanceSq
    local tied = false
    for _, seal in ipairs(round.seals) do
        local distanceSq = distanceSquared(player, seal.pos)
        if nearest == nil or distanceSq < nearestDistanceSq - CLOISTER_NEAREST_TIE_SQ then
            nearest = seal
            nearestDistanceSq = distanceSq
            tied = false
        elseif math.abs(distanceSq - nearestDistanceSq) <= CLOISTER_NEAREST_TIE_SQ then
            tied = true
        end
    end
    if tied then
        return nil
    end
    return nearest
end

local function getCloisterTowerDrawer(guide)
    if cloisterTowerDrawer == nil and type(guide.CreateDrawer) == 'function' then
        cloisterTowerDrawer = guide.CreateDrawer(0, 1, 1, 0.25, 2, 0)
    end
    return cloisterTowerDrawer
end

local function getCloisterHighlightDrawer(guide)
    if cloisterHighlightDrawer == nil and type(guide.CreateDrawer) == 'function' then
        cloisterHighlightDrawer = guide.CreateDrawer(0, 1, 0, 0.32, 3, 0)
    end
    return cloisterHighlightDrawer
end

local function drawCloisterDemon(guide, cfg, state)
    local round = state.round
    if round == nil or round.ambiguity ~= nil or #round.seals == 0 then
        return
    end

    if cfg.DrawSealTowers then
        local drawer = getCloisterTowerDrawer(guide)
        if drawer ~= nil then
            for _, seal in ipairs(round.seals) do
                drawer:addCircle(
                        seal.pos.x,
                        seal.pos.y,
                        seal.pos.z,
                        CLOISTER_SEAL_RADIUS)
            end
        end
    end

    if not cfg.DrawNearestSealGuide then
        return
    end
    local player = type(guide.GetPlayer) == 'function'
            and guide.GetPlayer() or nil
    local playerPos = player ~= nil
            and reliableCloisterPosition(player.pos) or nil
    local nearest = nearestCloisterSeal(round, playerPos)
    if playerPos == nil or nearest == nil then
        return
    end
    local drawer = getCloisterHighlightDrawer(guide)
    if drawer ~= nil then
        drawer:addCircle(
                nearest.pos.x,
                nearest.pos.y,
                nearest.pos.z,
                CLOISTER_SEAL_RADIUS + 0.35)
        drawer:addLine(
                playerPos.x, playerPos.y, playerPos.z,
                nearest.pos.x, nearest.pos.y, nearest.pos.z,
                0.12, 0.25)
    end
    if type(guide.FrameDirect) == 'function' then
        guide.FrameDirect(
                nearest.pos.x,
                nearest.pos.z,
                0.45,
                greenGuideColor)
    end
end

local function updateCloisterDemon(guide, cfg, state)
    if not cfg.Enable then
        if state.round ~= nil or state.lastDiagnostic ~= nil then
            clearCloisterState(state)
        end
        return
    end
    local now = getNow()
    local round = state.round
    if round == nil then
        if state.lastDiagnostic ~= nil then
            local diagnosticAt = state.lastDiagnostic.at
            if not cloisterFinite(diagnosticAt)
                    or now - diagnosticAt >= CLOISTER_DIAGNOSTIC_TTL_MS
            then
                state.lastDiagnostic = nil
            end
        end
        return
    end
    if not cloisterFinite(round.expiresAt) or now > round.expiresAt then
        clearCloisterState(state)
        return
    end

    local bossPresent, stillCasting = cloisterBossCastState(round)
    if bossPresent == false then
        round.bossMissingSince = round.bossMissingSince or now
        if now - round.bossMissingSince >= CLOISTER_BOSS_MISSING_CLEAR_MS then
            clearCloisterState(state)
            return
        end
    elseif bossPresent == true then
        round.bossMissingSince = nil
        if stillCasting == true then
            round.castEndedSince = nil
        elseif stillCasting == false then
            round.castEndedSince = round.castEndedSince or now
            if now - round.castEndedSince >= CLOISTER_CAST_END_CLEAR_MS then
                clearCloisterState(state)
                return
            end
        end
    end

    scanCloisterSeals(state, now, guide)
    refreshCloisterSeals(state, now, guide)
    round = state.round
    if round == nil then
        return
    end
    if round.hadSeals and #round.seals == 0 then
        round.emptySince = round.emptySince or now
        if now - round.emptySince >= CLOISTER_EMPTY_CLEAR_MS then
            clearCloisterState(state)
            return
        end
    else
        round.emptySince = nil
    end
    drawCloisterDemon(guide, cfg, state)
end

local function hasCloisterActivity(state)
    return type(state) == 'table' and state.round ~= nil
end

local function hasCloisterStoredState(state)
    return hasCloisterActivity(state)
            or (type(state) == 'table' and state.lastDiagnostic ~= nil)
end

return {
    AID = cloisterAID,
    OID = cloisterOID,
    ArenaCenter = CLOISTER_ARENA_CENTER,
    ArenaRadius = CLOISTER_ARENA_RADIUS,
    CollectionRadius = CLOISTER_SEAL_COLLECTION_RADIUS,
    SealRadius = CLOISTER_SEAL_RADIUS,
    SealContentID = CLOISTER_SEAL_CONTENT_ID,
    EntityMissingClearMs = CLOISTER_ENTITY_MISSING_CLEAR_MS,
    CastEndClearMs = CLOISTER_CAST_END_CLEAR_MS,
    EmptyClearMs = CLOISTER_EMPTY_CLEAR_MS,
    BossMissingClearMs = CLOISTER_BOSS_MISSING_CLEAR_MS,
    DiagnosticTtlMs = CLOISTER_DIAGNOSTIC_TTL_MS,
    NewState = newCloisterState,
    EnsureState = ensureCloisterState,
    ClearState = clearCloisterState,
    GetConfig = getCloisterConfig,
    GetRuntimeState = getCloisterRuntimeState,
    ReliablePosition = reliableCloisterPosition,
    InsideCollectionArea = isInsideCloisterCollectionArea,
    HandleEntityChannel = handleCloisterEntityChannel,
    AddSealEntity = addCloisterSealEntity,
    HandleEntityAdd = handleCloisterEntityAdd,
    ScanSeals = scanCloisterSeals,
    RefreshSeals = refreshCloisterSeals,
    HandleScriptFunc = handleCloisterScriptFunc,
    HandleEntityCast = handleCloisterEntityCast,
    BossCastState = cloisterBossCastState,
    NearestSeal = nearestCloisterSeal,
    Draw = drawCloisterDemon,
    Update = updateCloisterDemon,
    HasActivity = hasCloisterActivity,
    HasStoredState = hasCloisterStoredState,
}
end

rawset(_G, 'MuAiOccultCrescentSouthCloisterDemon', Module)
return Module
