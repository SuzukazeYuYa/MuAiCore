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

local MINDFLAYER_ARENA_CENTER = { x = 300, z = 730 }
local MINDFLAYER_ARENA_RADIUS = 30
local MINDFLAYER_FORCED_MARCH_DISTANCE = 26
local MINDFLAYER_TRAP_RADIUS = 8
local MINDFLAYER_SAFE_START_DISTANCE = 34.5
local MINDFLAYER_SOURCE_MATCH_DISTANCE_SQ = 1
local MINDFLAYER_NEAREST_TIE_SQ = 0.01
local MINDFLAYER_EVENT_DEDUPE_MS = 350
local MINDFLAYER_SEEN_TTL_MS = 70000
local MINDFLAYER_IMP_TIMEOUT_MS = 60000
local MINDFLAYER_VISUAL_TRACK_MS = 15000
local MINDFLAYER_BOSS_MISSING_CLEAR_MS = 2000

local mindflayerAID = {
    DarkII = 41170,
    Summon = 41168,
    MindBlastCast = 41167,
    MindBlast = 41166,
    FireTrap = 41250,
    BlizzardTrap = 41251,
    Expand = 41255,
    Recharge = 41169,
    WallopFastSmall = 41314,
    WallowSlowSmall = 41256,
    WallopSlowBig = 41257,
    VoidThunderIII = 41172,
    SurpriseAttackCast = 41252,
    SurpriseAttackInstant = 41253,
    SurpriseAttack = 41254,
    ArcaneBlastCast = 41171,
    ArcaneBlast = 41174,
}

local mindflayerSID = {
    ElementSelect = 2193,
    Seduced = 991,
    PlayingWithFire = 4211,
    PlayingWithIce = 4212,
    Pyromania = 4213,
    Cryomania = 4214,
    Expand = 4215,
}

local mindflayerElementByParam = {
    [0x344] = 'Fire',
    [0x345] = 'Ice',
}

local mindflayerImpEventAID = {
    [mindflayerAID.SurpriseAttackCast] = true,
    [mindflayerAID.SurpriseAttackInstant] = true,
    [mindflayerAID.FireTrap] = true,
    [mindflayerAID.BlizzardTrap] = true,
}

local mindflayerBossVisualAID = {
    [mindflayerAID.Summon] = true,
    [mindflayerAID.Recharge] = true,
    [mindflayerAID.MindBlastCast] = true,
    [mindflayerAID.ArcaneBlastCast] = true,
}

local mindflayerDangerDrawer

local mindFinite = Common.finite

local function reliableMindPosition(pos)
    return Common.copyPosition(pos, true)
end

local function newMindflayerState()
    return {
        imps = {},
        seenImpEvents = {},
        seenPredictions = {},
        ambiguity = nil,
        trackedBossEntityIDs = {},
        visualExpiresAt = nil,
        bossLastSeenAt = nil,
        lastActivityAt = nil,
        lastDiagnostic = nil,
    }
end

local function ensureMindflayerState(state)
    state.imps = type(state.imps) == 'table' and state.imps or {}
    state.seenImpEvents = type(state.seenImpEvents) == 'table'
            and state.seenImpEvents or {}
    state.seenPredictions = type(state.seenPredictions) == 'table'
            and state.seenPredictions or {}
    state.trackedBossEntityIDs = type(state.trackedBossEntityIDs) == 'table'
            and state.trackedBossEntityIDs or {}
    local ambiguity = state.ambiguity
    state.ambiguity = type(ambiguity) == 'table'
            and mindFinite(ambiguity.expiresAt)
            and ambiguity or nil
    return state
end

local function clearMindflayerState(state)
    ensureMindflayerState(state)
    state.imps = {}
    state.seenImpEvents = {}
    state.seenPredictions = {}
    state.ambiguity = nil
    state.trackedBossEntityIDs = {}
    state.visualExpiresAt = nil
    state.bossLastSeenAt = nil
    state.lastActivityAt = nil
    state.lastDiagnostic = nil
end

local mindflayerDiagnosticText = {
    imp_missing_geometry = '夺心魔预测跳过：小恶魔位置或非零地面高度不可靠。',
    element_unknown = '夺心魔预测跳过：ElementSelect状态参数无法保守解析。',
    element_api_missing = '夺心魔预测跳过：TensorCore.getBuff不可用。',
    prediction_missing_geometry = '夺心魔预测跳过：Surprise Attack位置、朝向、长度或时间不可靠。',
    prediction_no_match = '夺心魔预测暂停：Surprise Attack来源未能唯一匹配小恶魔。',
    prediction_multiple_matches = '夺心魔预测暂停：Surprise Attack来源匹配到多个小恶魔。',
    player_element_ambiguous = '夺心魔个人指路暂停：火/冰个人状态不唯一。',
    nearest_source_ambiguous = '夺心魔个人指路暂停：最近的同元素小恶魔来源并列。',
    guide_no_solution = '夺心魔个人指路暂停：未找到可证明安全的强制行进起点。',
    player_missing_geometry = '夺心魔个人指路暂停：玩家位置或非零地面高度不可靠。',
}

local mindflayerFeature = Common.newFeature({
    key = 'MysteriousMindflayer',
    newState = newMindflayerState,
    ensureState = ensureMindflayerState,
    diagnosticText = mindflayerDiagnosticText,
    dedupeMs = MINDFLAYER_EVENT_DEDUPE_MS,
    seenTtlMs = MINDFLAYER_SEEN_TTL_MS,
})
local getMindflayerConfig = mindflayerFeature.GetConfig
local getMindflayerRuntimeState = mindflayerFeature.GetRuntimeState
local setMindflayerDiagnostic = mindflayerFeature.Diagnostic
local consumeMindflayerEvent = mindflayerFeature.Consume

local function normalizeMindflayerElement(buff)
    if type(buff) ~= 'table' then
        return nil, 'missing'
    end
    local resolved
    local foundExplicit = false
    for _, field in ipairs({ 'extra', 'param', 'statusParam' }) do
        local value = buff[field]
        if value ~= nil then
            foundExplicit = true
            local element = mindflayerElementByParam[value]
            if element == nil then
                return nil, 'unknown_' .. field
            end
            if resolved ~= nil and resolved ~= element then
                return nil, 'conflict'
            end
            resolved = element
        end
    end
    if foundExplicit then
        return resolved
    end
    if buff.stacks == nil then
        return nil, 'missing'
    end
    local fallback = mindflayerElementByParam[buff.stacks]
    if fallback == nil then
        return nil, 'unknown_stacks'
    end
    return fallback
end

local function resolveMindEntityPosition(entityID)
    if type(entityID) ~= 'number'
            or type(TensorCore) ~= 'table'
            or type(TensorCore.mGetEntity) ~= 'function'
    then
        return nil
    end
    local entity = TensorCore.mGetEntity(entityID)
    if type(entity) ~= 'table' or entity.alive == false then
        return nil
    end
    return reliableMindPosition(entity.pos)
end

local function recordMindflayerBoss(state, entityID, now)
    if type(entityID) == 'number' then
        state.trackedBossEntityIDs[entityID] = true
        state.bossLastSeenAt = now
    end
    state.visualExpiresAt = now + MINDFLAYER_VISUAL_TRACK_MS
    state.lastActivityAt = now
end

local function recordMindflayerImp(state, entityID, position, now, guide, key)
    if type(entityID) ~= 'number' then
        return false
    end
    if key ~= nil and not consumeMindflayerEvent(state.seenImpEvents, key, now) then
        return false
    end
    local source = resolveMindEntityPosition(entityID) or reliableMindPosition(position)
    if source == nil then
        setMindflayerDiagnostic(state, guide, 'imp_missing_geometry', now, {
            entityID = entityID,
        })
        return false
    end
    local imp = state.imps[entityID]
    if imp == nil then
        imp = {
            entityID = entityID,
            source = source,
            predicted = 0,
            element = nil,
            firstSeenAt = now,
        }
        state.imps[entityID] = imp
    elseif imp.predicted == 0 then
        imp.source = source
    end
    imp.lastSeenAt = now
    imp.missingSince = nil
    imp.expiresAt = now + MINDFLAYER_IMP_TIMEOUT_MS
    state.lastActivityAt = now
    return true
end

local function removeMindflayerImp(state, entityID)
    if type(entityID) ~= 'number' or state.imps[entityID] == nil then
        return false
    end
    state.imps[entityID] = nil
    if next(state.imps) == nil then
        state.ambiguity = nil
    end
    return true
end

local function refreshMindflayerImps(state, now, guide)
    local canResolve = type(TensorCore) == 'table'
            and type(TensorCore.mGetEntity) == 'function'
    local canReadBuff = type(TensorCore) == 'table'
            and type(TensorCore.getBuff) == 'function'
    for entityID, imp in pairs(state.imps) do
        local live
        if canResolve then
            live = resolveMindEntityPosition(entityID)
            if live ~= nil then
                imp.lastSeenAt = now
                imp.missingSince = nil
                if imp.predicted == 0 then
                    imp.source = live
                end
            else
                imp.missingSince = imp.missingSince or now
            end
        end
        if canReadBuff then
            local element, reason = normalizeMindflayerElement(
                    TensorCore.getBuff(entityID, mindflayerSID.ElementSelect))
            imp.element = element
            if element == nil then
                setMindflayerDiagnostic(state, guide, 'element_unknown', now, {
                    entityID = entityID,
                    reason = reason,
                })
            end
        else
            imp.element = nil
            setMindflayerDiagnostic(state, guide, 'element_api_missing', now)
        end
        if now > imp.expiresAt
                or (imp.missingSince ~= nil
                    and now - imp.missingSince > MINDFLAYER_BOSS_MISSING_CLEAR_MS)
        then
            state.imps[entityID] = nil
        end
    end
    if next(state.imps) == nil then
        state.ambiguity = nil
    end
end

local function mindflayerTargetXZ(aoeInfo, source)
    local target = aoeInfo.targetXZ
            or aoeInfo.targetPos
            or aoeInfo.targetPosition
    local x = type(target) == 'table' and target.x or aoeInfo.targetX
    local z = type(target) == 'table' and target.z or aoeInfo.targetZ
    if not mindFinite(x) or not mindFinite(z) then
        return nil
    end
    local y = type(target) == 'table' and target.y or aoeInfo.targetY
    if not mindFinite(y) or y == 0 then
        y = source.y
    end
    return reliableMindPosition({ x = x, y = y, z = z })
end

local function mindflayerSurpriseEndpoint(aoeInfo)
    if type(aoeInfo) ~= 'table'
            or aoeInfo.aoeID ~= mindflayerAID.SurpriseAttack
            or not mindFinite(aoeInfo.x)
            or not mindFinite(aoeInfo.y)
            or aoeInfo.y == 0
            or not mindFinite(aoeInfo.z)
            or not mindFinite(aoeInfo.heading)
            or not mindFinite(aoeInfo.aoeLength)
            or aoeInfo.aoeLength <= 0
            or not mindFinite(aoeInfo.startTime)
            or not mindFinite(aoeInfo.duration)
    then
        return nil
    end
    local source = { x = aoeInfo.x, y = aoeInfo.y, z = aoeInfo.z }
    local endpoint = mindflayerTargetXZ(aoeInfo, source)
    if endpoint == nil then
        endpoint = {
            x = source.x + math.sin(aoeInfo.heading) * aoeInfo.aoeLength,
            y = source.y,
            z = source.z + math.cos(aoeInfo.heading) * aoeInfo.aoeLength,
        }
    end
    return source, endpoint
end

local function applyMindflayerPrediction(state, aoeInfo, now, guide)
    local source, endpoint = mindflayerSurpriseEndpoint(aoeInfo)
    if source == nil then
        if type(aoeInfo) == 'table'
                and aoeInfo.aoeID == mindflayerAID.SurpriseAttack
        then
            state.ambiguity = {
                code = 'prediction_missing_geometry',
                at = now,
                expiresAt = now + MINDFLAYER_IMP_TIMEOUT_MS,
            }
            state.lastActivityAt = now
        end
        setMindflayerDiagnostic(state, guide, 'prediction_missing_geometry', now)
        return false
    end
    local key = table.concat({
        tostring(aoeInfo.entityID),
        tostring(math.floor(aoeInfo.startTime)),
        tostring(math.floor(aoeInfo.duration * 1000)),
    }, ':')
    if not consumeMindflayerEvent(state.seenPredictions, key, now) then
        return false
    end

    local matches = {}
    for _, imp in pairs(state.imps) do
        if imp.predicted == 0 then
            local live = resolveMindEntityPosition(imp.entityID)
            if live ~= nil then
                imp.source = live
                imp.lastSeenAt = now
                imp.missingSince = nil
            end
        end
        if reliableMindPosition(imp.source) ~= nil
                and distanceSquared(imp.source, source)
                        <= MINDFLAYER_SOURCE_MATCH_DISTANCE_SQ
        then
            matches[#matches + 1] = imp
        end
    end
    if #matches ~= 1 then
        local code = #matches == 0
                and 'prediction_no_match' or 'prediction_multiple_matches'
        state.ambiguity = {
            code = code,
            at = now,
            expiresAt = now + MINDFLAYER_IMP_TIMEOUT_MS,
        }
        setMindflayerDiagnostic(state, guide, code, now, {
            matches = #matches,
        })
        return false
    end

    local imp = matches[1]
    imp.source = endpoint
    imp.predicted = imp.predicted + 1
    imp.lastSeenAt = now
    imp.expiresAt = now + MINDFLAYER_IMP_TIMEOUT_MS
    state.lastActivityAt = now
    return true
end

local function activeMindflayerImps(state)
    local all = {}
    for _, imp in pairs(state.imps) do
        if reliableMindPosition(imp.source) ~= nil then
            all[#all + 1] = imp
        end
    end
    local selected = {}
    if #all > 2 then
        for _, imp in ipairs(all) do
            if imp.predicted == 2 then
                selected[#selected + 1] = imp
            end
        end
    else
        for _, imp in ipairs(all) do
            selected[#selected + 1] = imp
        end
    end
    return selected
end

local function mindflayerPlayerElement(playerID)
    if type(playerID) ~= 'number'
            or type(TensorCore) ~= 'table'
            or type(TensorCore.getBuff) ~= 'function'
    then
        return nil, 'api_missing'
    end
    local fire = TensorCore.getBuff(playerID, mindflayerSID.PlayingWithFire) ~= nil
    local ice = TensorCore.getBuff(playerID, mindflayerSID.PlayingWithIce) ~= nil
    if fire == ice then
        return nil, 'not_unique'
    end
    return fire and 'Fire' or 'Ice'
end

local function sameElementMindflayerImps(state, element)
    local selected = {}
    for _, imp in ipairs(activeMindflayerImps(state)) do
        if imp.element == element and reliableMindPosition(imp.source) ~= nil then
            selected[#selected + 1] = imp
        end
    end
    return selected
end

local function nearestMindflayerImp(imps, playerPosition)
    local player = reliableMindPosition(playerPosition)
    if player == nil then
        return nil, 'missing_player'
    end
    local nearest
    local nearestDistance
    local tied = false
    for _, imp in ipairs(imps or {}) do
        local currentDistance = distanceSquared(imp.source, player)
        if nearestDistance == nil
                or currentDistance < nearestDistance - MINDFLAYER_NEAREST_TIE_SQ
        then
            nearest = imp
            nearestDistance = currentDistance
            tied = false
        elseif math.abs(currentDistance - nearestDistance) <= MINDFLAYER_NEAREST_TIE_SQ then
            tied = true
        end
    end
    if tied then
        return nil, 'tie'
    end
    return nearest
end

local function mindflayerInsideArena(position)
    return reliableMindPosition(position) ~= nil
            and distanceSquared(position, MINDFLAYER_ARENA_CENTER)
                    <= MINDFLAYER_ARENA_RADIUS * MINDFLAYER_ARENA_RADIUS
end

local function projectMindflayerMarch(sourcePosition, startPosition)
    local source = reliableMindPosition(sourcePosition)
    local start = reliableMindPosition(startPosition)
    if source == nil or start == nil then
        return nil
    end
    local directionX, directionZ = normalized(
            source.x - start.x,
            source.z - start.z)
    if directionX == nil then
        return nil
    end
    return {
        x = start.x + directionX * MINDFLAYER_FORCED_MARCH_DISTANCE,
        y = start.y,
        z = start.z + directionZ * MINDFLAYER_FORCED_MARCH_DISTANCE,
    }
end

local function isMindflayerLandingSafe(source, landing)
    return reliableMindPosition(source) ~= nil
            and reliableMindPosition(landing) ~= nil
            and mindflayerInsideArena(landing)
            and distanceSquared(source, landing)
                    >= MINDFLAYER_TRAP_RADIUS * MINDFLAYER_TRAP_RADIUS
end

local function isMindflayerSafeStart(source, start)
    if reliableMindPosition(source) == nil or reliableMindPosition(start) == nil then
        return false, nil
    end
    if not mindflayerInsideArena(start)
            or distanceSquared(source, start)
                    < MINDFLAYER_SAFE_START_DISTANCE
                            * MINDFLAYER_SAFE_START_DISTANCE
    then
        return false, nil
    end
    local landing = projectMindflayerMarch(source, start)
    return isMindflayerLandingSafe(source, landing), landing
end

local function findMindflayerSafeStart(sourcePosition, playerPosition)
    local source = reliableMindPosition(sourcePosition)
    local player = reliableMindPosition(playerPosition)
    if source == nil or player == nil then
        return nil
    end
    local currentSafe, currentLanding = isMindflayerSafeStart(source, player)
    if currentSafe then
        return {
            start = player,
            landing = currentLanding,
            alreadySafe = true,
        }
    end
    for searchRadius = 0.5, MINDFLAYER_ARENA_RADIUS * 2, 0.5 do
        local best
        local bestDistance
        for index = 0, 71 do
            local angle = index * 2 * math.pi / 72
            local candidate = {
                x = player.x + math.sin(angle) * searchRadius,
                y = player.y,
                z = player.z + math.cos(angle) * searchRadius,
            }
            local safe, landing = isMindflayerSafeStart(source, candidate)
            if safe then
                local candidateDistance = distanceSquared(candidate, player)
                if bestDistance == nil or candidateDistance < bestDistance then
                    bestDistance = candidateDistance
                    best = {
                        start = candidate,
                        landing = landing,
                        alreadySafe = false,
                    }
                end
            end
        end
        if best ~= nil then
            return best
        end
    end
    return nil
end

local function pruneMindflayerState(state, now)
    ensureMindflayerState(state)
    mindflayerFeature.PruneSeen(state.seenImpEvents, now)
    mindflayerFeature.PruneSeen(state.seenPredictions, now)
    for entityID, imp in pairs(state.imps) do
        if not mindFinite(imp.expiresAt) or now > imp.expiresAt then
            state.imps[entityID] = nil
        end
    end
    if state.ambiguity ~= nil and now > state.ambiguity.expiresAt then
        state.ambiguity = nil
    end
    if state.visualExpiresAt ~= nil and now > state.visualExpiresAt then
        state.visualExpiresAt = nil
    end
    if next(state.imps) == nil then
        state.ambiguity = nil
    end
end

local function hasMindflayerActivity(state)
    return next(state.imps) ~= nil
            or state.ambiguity ~= nil
            or state.visualExpiresAt ~= nil
end

local function hasMindflayerStoredState(state)
    return hasMindflayerActivity(state)
            or next(state.seenImpEvents) ~= nil
            or next(state.seenPredictions) ~= nil
            or next(state.trackedBossEntityIDs) ~= nil
            or state.lastDiagnostic ~= nil
end

local function hasLiveMindflayer(state)
    if type(TensorCore) ~= 'table' or type(TensorCore.mGetEntity) ~= 'function' then
        return nil
    end
    local checked = false
    for entityID in pairs(state.trackedBossEntityIDs) do
        checked = true
        local entity = TensorCore.mGetEntity(entityID)
        if type(entity) == 'table' and entity.alive ~= false then
            return true
        end
    end
    if checked then
        return false
    end
    -- BossMod NameID/OID 未经本机事件证明为 Minion contentid，不据此扫描实体。
    return nil
end

local function handleMindflayerEntityChannel(
        state,
        entityID,
        spellID,
        targetID,
        channelTimeMax,
        now,
        guide)
    if mindflayerBossVisualAID[spellID] then
        recordMindflayerBoss(state, entityID, now)
        return true
    end
    if spellID == mindflayerAID.FireTrap
            or spellID == mindflayerAID.BlizzardTrap
    then
        return removeMindflayerImp(state, entityID)
    end
    if spellID ~= mindflayerAID.SurpriseAttackCast
            and spellID ~= mindflayerAID.SurpriseAttackInstant
    then
        return false
    end
    local key = table.concat({
        'channel',
        tostring(entityID),
        tostring(spellID),
        tostring(mindFinite(channelTimeMax)
                and math.floor(now + channelTimeMax * 1000) or now),
    }, ':')
    return recordMindflayerImp(
            state,
            entityID,
            resolveMindEntityPosition(entityID),
            now,
            guide,
            key)
end

local function handleMindflayerAOECreate(state, aoeInfo, now, guide)
    if type(aoeInfo) ~= 'table' then
        return false
    end
    local spellID = aoeInfo.aoeID
    if mindflayerBossVisualAID[spellID] then
        recordMindflayerBoss(state, aoeInfo.entityID, now)
        return true
    end
    if spellID == mindflayerAID.SurpriseAttack then
        return applyMindflayerPrediction(state, aoeInfo, now, guide)
    end
    if spellID == mindflayerAID.FireTrap
            or spellID == mindflayerAID.BlizzardTrap
    then
        return removeMindflayerImp(state, aoeInfo.entityID)
    end
    if spellID == mindflayerAID.SurpriseAttackCast
            or spellID == mindflayerAID.SurpriseAttackInstant
    then
        local startTime = mindFinite(aoeInfo.startTime) and aoeInfo.startTime or now
        local key = table.concat({
            'aoe',
            tostring(aoeInfo.entityID),
            tostring(spellID),
            tostring(math.floor(startTime)),
        }, ':')
        return recordMindflayerImp(
                state,
                aoeInfo.entityID,
                { x = aoeInfo.x, y = aoeInfo.y, z = aoeInfo.z },
                now,
                guide,
                key)
    end
    return false
end

local function handleMindflayerEntityCast(
        state,
        entityID,
        spellID,
        castPos,
        now,
        guide)
    if mindflayerBossVisualAID[spellID] then
        recordMindflayerBoss(state, entityID, now)
        return true
    end
    if spellID == mindflayerAID.FireTrap
            or spellID == mindflayerAID.BlizzardTrap
    then
        return removeMindflayerImp(state, entityID)
    end
    if not mindflayerImpEventAID[spellID] then
        return false
    end
    local key = table.concat({
        'cast',
        tostring(entityID),
        tostring(spellID),
        tostring(math.floor(now)),
    }, ':')
    return recordMindflayerImp(
            state,
            entityID,
            castPos,
            now,
            guide,
            key)
end

local function getMindflayerDangerDrawer(guide)
    if mindflayerDangerDrawer == nil and type(guide.CreateDrawer) == 'function' then
        mindflayerDangerDrawer = guide.CreateDrawer(1, 0.1, 0, 0.22, 2, 0)
    end
    return mindflayerDangerDrawer
end

local function drawMindflayerPath(drawer, start, landing)
    drawer:addCircle(start.x, start.y, start.z, 0.9)
    drawer:addCircle(landing.x, landing.y, landing.z, 1.2)
    drawer:addLine(
            start.x, start.y, start.z,
            landing.x, landing.y, landing.z,
            0.12, 0.25)
end

local function drawMindflayerSeduction(guide, cfg, state, player, now)
    local playerPosition = reliableMindPosition(player.pos)
    if playerPosition == nil then
        setMindflayerDiagnostic(state, guide, 'player_missing_geometry', now)
        return
    end
    local element, reason = mindflayerPlayerElement(player.id)
    if element == nil then
        if reason ~= 'not_unique'
                or TensorCore.getBuff(player.id, mindflayerSID.PlayingWithFire) ~= nil
                or TensorCore.getBuff(player.id, mindflayerSID.PlayingWithIce) ~= nil
        then
            setMindflayerDiagnostic(state, guide, 'player_element_ambiguous', now, {
                reason = reason,
            })
        end
        return
    end
    if state.ambiguity ~= nil then
        return
    end

    local imps = sameElementMindflayerImps(state, element)
    if cfg.DrawMatchingImpDanger then
        local danger = getMindflayerDangerDrawer(guide)
        if danger ~= nil then
            for _, imp in ipairs(imps) do
                danger:addCircle(
                        imp.source.x,
                        imp.source.y,
                        imp.source.z,
                        MINDFLAYER_TRAP_RADIUS)
            end
        end
    end
    if not cfg.DrawSeductionGuide or #imps == 0 then
        return
    end

    local selected, nearestReason = nearestMindflayerImp(imps, playerPosition)
    if selected == nil then
        if nearestReason == 'tie' then
            setMindflayerDiagnostic(state, guide, 'nearest_source_ambiguous', now)
        end
        return
    end
    local currentLanding = projectMindflayerMarch(selected.source, playerPosition)
    if currentLanding == nil then
        setMindflayerDiagnostic(state, guide, 'player_missing_geometry', now)
        return
    end
    local currentLandingSafe = isMindflayerLandingSafe(selected.source, currentLanding)
    local green = getGreenDrawer(guide)
    local danger = getMindflayerDangerDrawer(guide)
    local currentDrawer = currentLandingSafe and green or danger
    if currentDrawer ~= nil then
        currentDrawer:addCircle(
                currentLanding.x,
                currentLanding.y,
                currentLanding.z,
                1.2)
        currentDrawer:addLine(
                playerPosition.x, playerPosition.y, playerPosition.z,
                currentLanding.x, currentLanding.y, currentLanding.z,
                0.12, 0.25)
    end

    local solution = findMindflayerSafeStart(selected.source, playerPosition)
    if solution == nil then
        setMindflayerDiagnostic(state, guide, 'guide_no_solution', now)
        return
    end
    if solution.alreadySafe then
        return
    end
    if green ~= nil then
        drawMindflayerPath(green, solution.start, solution.landing)
    end
    if type(guide.FrameDirect) == 'function' then
        guide.FrameDirect(
                solution.start.x,
                solution.start.z,
                0.45,
                greenGuideColor)
    end
end

local function updateMindflayer(guide, cfg, state)
    if not cfg.Enable then
        if hasMindflayerStoredState(state) then
            clearMindflayerState(state)
        end
        return
    end
    local now = getNow()
    pruneMindflayerState(state, now)
    refreshMindflayerImps(state, now, guide)
    if not hasMindflayerActivity(state) then
        state.trackedBossEntityIDs = {}
        state.bossLastSeenAt = nil
        return
    end
    local bossPresent = hasLiveMindflayer(state)
    if bossPresent == true then
        state.bossLastSeenAt = now
    elseif bossPresent == false
            and state.bossLastSeenAt ~= nil
            and now - state.bossLastSeenAt > MINDFLAYER_BOSS_MISSING_CLEAR_MS
    then
        clearMindflayerState(state)
        return
    end
    local player = type(guide.GetPlayer) == 'function' and guide.GetPlayer() or nil
    if type(player) ~= 'table' or type(player.id) ~= 'number' then
        return
    end
    drawMindflayerSeduction(guide, cfg, state, player, now)
end

return {
    AID = mindflayerAID,
    SID = mindflayerSID,
    ElementByParam = mindflayerElementByParam,
    ArenaCenter = MINDFLAYER_ARENA_CENTER,
    ArenaRadius = MINDFLAYER_ARENA_RADIUS,
    ForcedMarchDistance = MINDFLAYER_FORCED_MARCH_DISTANCE,
    TrapRadius = MINDFLAYER_TRAP_RADIUS,
    SafeStartDistance = MINDFLAYER_SAFE_START_DISTANCE,
    ImpTimeoutMs = MINDFLAYER_IMP_TIMEOUT_MS,
    NewState = newMindflayerState,
    EnsureState = ensureMindflayerState,
    ClearState = clearMindflayerState,
    GetConfig = getMindflayerConfig,
    GetRuntimeState = getMindflayerRuntimeState,
    NormalizeElement = normalizeMindflayerElement,
    ReliablePosition = reliableMindPosition,
    RecordImp = recordMindflayerImp,
    RemoveImp = removeMindflayerImp,
    RefreshImps = refreshMindflayerImps,
    SurpriseEndpoint = mindflayerSurpriseEndpoint,
    ApplyPrediction = applyMindflayerPrediction,
    ActiveImps = activeMindflayerImps,
    PlayerElement = mindflayerPlayerElement,
    SameElementImps = sameElementMindflayerImps,
    NearestImp = nearestMindflayerImp,
    InsideArena = mindflayerInsideArena,
    ProjectMarch = projectMindflayerMarch,
    IsLandingSafe = isMindflayerLandingSafe,
    IsSafeStart = isMindflayerSafeStart,
    FindSafeStart = findMindflayerSafeStart,
    PruneState = pruneMindflayerState,
    HandleEntityChannel = handleMindflayerEntityChannel,
    HandleAOECreate = handleMindflayerAOECreate,
    HandleEntityCast = handleMindflayerEntityCast,
    Draw = drawMindflayerSeduction,
    Update = updateMindflayer,
    HasActivity = hasMindflayerActivity,
    HasStoredState = hasMindflayerStoredState,
}
end

rawset(_G, 'MuAiOccultCrescentSouthMysteriousMindflayer', Module)
return Module
