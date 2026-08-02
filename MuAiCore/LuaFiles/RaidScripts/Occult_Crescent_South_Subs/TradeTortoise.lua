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

local TRADE_ARENA_CENTER = { x = 72, z = -545 }
local TRADE_ARENA_RADIUS = 25
local TRADE_GOAL_RADIUS = 7
local TRADE_COIN_TIMEOUT_MS = 45000
local TRADE_TARGET_SNAPSHOT_MS = 5000
local TRADE_EVENT_DEDUPE_MS = 350
local TRADE_SEEN_TTL_MS = 60000
local TRADE_BOSS_MISSING_CLEAR_MS = 2000
local TRADE_VISUAL_TRACK_MS = 15000
local TRADE_GREEN_PREP_RADIUS = 11
local TRADE_GREEN_KNOCKBACK_DISTANCE = 35
local TRADE_COST_KNOCKBACK_DISTANCE = 30
local TRADE_COST_SOURCE_MATCH_SQ = 1
local TRADE_COST_ROUND_WINDOW_MS = 1200

local tradeAID = {
    WhatreYouBuying1 = 41515,
    WhatreYouBuyingHelper = 41516,
    MaterialWorld = 41517,
    CostOfLiving = 41522,
    Waterspout = 41527,
    Earthquake = 41528,
    HoardWealth = 43372,
    WhatreYouBuying2 = 43452,
}

local tradeSID = {
    BuyersRemorseGreen = 4344,
    Transporting = 4376,
}

local tradeTetherGoal = {
    [328] = 1,
    [329] = 2,
    [330] = 3,
    [331] = 4,
    [332] = 5,
    [333] = 6,
}

local tradeHeldQuantity = {
    [0] = 0,
    [1] = 1,
    [2] = 2,
    [3] = 4,
    [4] = 2,
    [5] = 3,
    [6] = 4,
    [7] = 5,
    [8] = 6,
    [9] = 8,
}

local tradeCoinContentID = {
    [1] = 2014526,
    [2] = 2014527,
    [4] = 2014528,
}

local tradeDangerDrawer

local finiteNumber = Common.finite

local function reliableTradePosition(pos)
    return Common.copyPosition(pos, true)
end

local function newTradeState()
    return {
        coin = {
            assignment = nil,
            seenTethers = {},
            seenMarkers = {},
        },
        cost = {
            active = nil,
            conflict = nil,
            seenStarts = {},
            seenResolves = {},
        },
        greenActive = false,
        trackedBossEntityIDs = {},
        visualExpiresAt = nil,
        bossLastSeenAt = nil,
        lastActivityAt = nil,
        lastDiagnostic = nil,
    }
end

local function ensureTradeState(state)
    state.coin = type(state.coin) == 'table' and state.coin or {}
    state.coin.seenTethers = type(state.coin.seenTethers) == 'table'
            and state.coin.seenTethers or {}
    state.coin.seenMarkers = type(state.coin.seenMarkers) == 'table'
            and state.coin.seenMarkers or {}
    state.cost = type(state.cost) == 'table' and state.cost or {}
    local conflict = state.cost.conflict
    state.cost.conflict = type(conflict) == 'table'
            and finiteNumber(conflict.activationAt)
            and finiteNumber(conflict.expiresAt)
            and conflict or nil
    state.cost.seenStarts = type(state.cost.seenStarts) == 'table'
            and state.cost.seenStarts or {}
    state.cost.seenResolves = type(state.cost.seenResolves) == 'table'
            and state.cost.seenResolves or {}
    state.greenActive = state.greenActive == true
    state.trackedBossEntityIDs = type(state.trackedBossEntityIDs) == 'table'
            and state.trackedBossEntityIDs or {}
    return state
end

local function clearTradeState(state)
    ensureTradeState(state)
    state.coin.assignment = nil
    state.coin.seenTethers = {}
    state.coin.seenMarkers = {}
    state.cost.active = nil
    state.cost.conflict = nil
    state.cost.seenStarts = {}
    state.cost.seenResolves = {}
    state.greenActive = false
    state.trackedBossEntityIDs = {}
    state.visualExpiresAt = nil
    state.bossLastSeenAt = nil
    state.lastActivityAt = nil
    state.lastDiagnostic = nil
end

local function clearTradeCoinGame(state)
    ensureTradeState(state)
    state.coin.assignment = nil
end

local tradeDiagnosticText = {
    tether_missing_target = '贸易龟硬币路线跳过：连线目标缺少可靠的非零地面高度。',
    transport_unknown_value = '贸易龟硬币路线跳过：Transporting状态参数无法保守解析。',
    transport_api_missing = '贸易龟硬币路线跳过：TensorCore.getBuff不可用。',
    delivery_missing_target = '贸易龟硬币路线暂停：交货点实体与短期位置快照均不可用。',
    coin_missing_objects = '贸易龟硬币路线暂停：当前最高优先面额没有可靠可见对象。',
    green_missing_geometry = '贸易龟绿龟击退跳过：玩家位置、高度或朝向不可靠。',
    cost_missing_geometry = 'Cost of Living指路跳过：击退来源位置或时间不可靠。',
    cost_conflicting_source = 'Cost of Living同轮事件来源不一致，本轮停止指路。',
    cost_no_solution = 'Cost of Living未找到可证明留在场内的安全起点。',
}

local tradeFeature = Common.newFeature({
    key = 'TradeTortoise',
    newState = newTradeState,
    ensureState = ensureTradeState,
    diagnosticText = tradeDiagnosticText,
    dedupeMs = TRADE_EVENT_DEDUPE_MS,
    seenTtlMs = TRADE_SEEN_TTL_MS,
})
local getTradeConfig = tradeFeature.GetConfig
local getTradeRuntimeState = tradeFeature.GetRuntimeState
local setTradeDiagnostic = tradeFeature.Diagnostic
local consumeTradeEvent = tradeFeature.Consume
local pruneTradeSeen = tradeFeature.PruneSeen

local function pruneTradeState(state, now)
    ensureTradeState(state)
    local assignment = state.coin.assignment
    if assignment ~= nil and now > assignment.expiresAt then
        state.coin.assignment = nil
    end
    local cost = state.cost.active
    if cost ~= nil and now > cost.expiresAt then
        state.cost.active = nil
    end
    local conflict = state.cost.conflict
    if conflict ~= nil and now > conflict.expiresAt then
        state.cost.conflict = nil
    end
    if state.visualExpiresAt ~= nil and now > state.visualExpiresAt then
        state.visualExpiresAt = nil
    end
    pruneTradeSeen(state.coin.seenTethers, now)
    pruneTradeSeen(state.coin.seenMarkers, now)
    pruneTradeSeen(state.cost.seenStarts, now)
    pruneTradeSeen(state.cost.seenResolves, now)
end

local function normalizeCarryParam(buff)
    if buff == nil then
        return 0
    end
    if type(buff) ~= 'table' then
        return nil, 'invalid_buff'
    end
    for _, field in ipairs({ 'extra', 'param', 'statusParam' }) do
        local value = buff[field]
        if value ~= nil then
            if finiteNumber(value)
                    and value == math.floor(value)
                    and value >= 0x29
                    and value <= 0x31
            then
                return value - 40
            end
            return nil, 'unknown_' .. field
        end
    end
    local stacks = buff.stacks
    if finiteNumber(stacks) and stacks == math.floor(stacks) then
        if stacks >= 1 and stacks <= 9 then
            return stacks
        end
        if stacks >= 0x29 and stacks <= 0x31 then
            return stacks - 40
        end
    end
    return nil, stacks == nil and 'missing_value' or 'unknown_stacks'
end

local function tradeCarryState(goal, buff)
    local carryParam, reason = normalizeCarryParam(buff)
    if carryParam == nil then
        return nil, reason
    end
    local held = tradeHeldQuantity[carryParam]
    if held == nil or type(goal) ~= 'number' then
        return nil, 'invalid_goal'
    end
    return {
        carryParam = carryParam,
        held = held,
        atCapacity = carryParam > 3,
        deficit = goal - held,
    }
end

local function neededCoinDenominations(deficit)
    local needed = {}
    if type(deficit) ~= 'number' or deficit <= 0 then
        return needed
    end
    for _, denomination in ipairs({ 4, 2, 1 }) do
        if math.floor(deficit / denomination) % 2 == 1 then
            table.insert(needed, denomination)
        end
    end
    return needed
end

local function selectCoinRoute(deficit, positionsByDenomination, playerPos)
    local result = {
        needed = neededCoinDenominations(deficit),
        all = {},
        target = nil,
        targetDenomination = nil,
    }
    for _, denomination in ipairs(result.needed) do
        local positions = type(positionsByDenomination) == 'table'
                and positionsByDenomination[denomination] or nil
        if type(positions) == 'table' then
            for _, position in ipairs(positions) do
                if reliableTradePosition(position) ~= nil then
                    table.insert(result.all, {
                        denomination = denomination,
                        position = position,
                    })
                end
            end
            if result.targetDenomination == nil
                    and denomination == result.needed[1]
                    and reliableTradePosition(playerPos) ~= nil
            then
                local nearestDistance
                for _, position in ipairs(positions) do
                    if reliableTradePosition(position) ~= nil then
                        local candidateDistance = distanceSquared(position, playerPos)
                        if nearestDistance == nil or candidateDistance < nearestDistance then
                            nearestDistance = candidateDistance
                            result.target = position
                            result.targetDenomination = denomination
                        end
                    end
                end
            end
        end
    end
    return result
end

local function getTradePlayer(guide)
    local player = type(guide) == 'table'
            and type(guide.GetPlayer) == 'function'
            and guide.GetPlayer() or nil
    if type(player) ~= 'table' or type(player.id) ~= 'number' then
        return nil
    end
    return player
end

local function resolveReliableTradeEntityPosition(entityID)
    return reliableTradePosition(reliableEntityPosition(entityID))
end

local function handleTradeTetherChange(
        state,
        sourceEntityID,
        newTetherID,
        newTargetID,
        now,
        guide)
    local goal = tradeTetherGoal[newTetherID]
    if goal == nil then
        -- BossMod keeps the first assignment when the tether returns to zero.
        return false
    end
    local player = getTradePlayer(guide)
    if player == nil or player.id ~= sourceEntityID then
        return false
    end
    local key = table.concat({
        tostring(sourceEntityID),
        tostring(newTetherID),
        tostring(newTargetID),
    }, ':')
    if not consumeTradeEvent(state.coin.seenTethers, key, now) then
        return false
    end
    local snapshot = resolveReliableTradeEntityPosition(newTargetID)
    if snapshot == nil then
        setTradeDiagnostic(state, guide, 'tether_missing_target', now, {
            tetherID = newTetherID,
            targetID = newTargetID,
        })
        return false
    end
    state.coin.assignment = {
        goal = goal,
        targetID = newTargetID,
        snapshot = snapshot,
        assignedAt = now,
        expiresAt = now + TRADE_COIN_TIMEOUT_MS,
    }
    state.lastActivityAt = now
    return true
end

local function handleTradeMarkerAdd(state, entityID, markerID, now, guide)
    if markerID ~= 503 and markerID ~= 504 then
        return false
    end
    local player = getTradePlayer(guide)
    if player == nil or player.id ~= entityID then
        return false
    end
    local key = tostring(entityID) .. ':' .. tostring(markerID)
    if not consumeTradeEvent(state.coin.seenMarkers, key, now) then
        return false
    end
    clearTradeCoinGame(state)
    return true
end

local function resolveTradeDeliveryTarget(assignment, now)
    if type(assignment) ~= 'table' then
        return nil
    end
    local live = resolveReliableTradeEntityPosition(assignment.targetID)
    if live ~= nil then
        return live, 'live'
    end
    if now - assignment.assignedAt <= TRADE_TARGET_SNAPSHOT_MS then
        local snapshot = reliableTradePosition(assignment.snapshot)
        if snapshot ~= nil then
            return snapshot, 'snapshot'
        end
    end
    return nil
end

local function collectTradeCoinPositions(denomination)
    local contentID = tradeCoinContentID[denomination]
    if contentID == nil
            or type(TensorCore) ~= 'table'
            or type(TensorCore.entityList) ~= 'function'
    then
        return {}
    end
    local entities = TensorCore.entityList('contentid=' .. tostring(contentID))
    if type(entities) ~= 'table' then
        return {}
    end
    local positions = {}
    for _, entity in pairs(entities) do
        if type(entity) == 'table'
                and entity.contentid == contentID
                and entity.alive ~= false
                and entity.visible ~= false
                and entity.isVisible ~= false
        then
            local position = reliableTradePosition(entity.pos)
            if position ~= nil then
                table.insert(positions, position)
            end
        end
    end
    return positions
end

local function tradeInsideArena(pos, radius)
    if not validXZ(pos) then
        return false
    end
    local limit = radius or TRADE_ARENA_RADIUS
    return distanceSquared(pos, TRADE_ARENA_CENTER) <= limit * limit
end

local function headingProjection(position, heading, distance)
    if reliableTradePosition(position) == nil
            or not finiteNumber(heading)
            or not finiteNumber(distance)
    then
        return nil
    end
    return {
        x = position.x + math.sin(heading) * distance,
        y = position.y,
        z = position.z + math.cos(heading) * distance,
    }
end

local function greenKnockbackSolution(playerPosition, heading)
    local player = reliableTradePosition(playerPosition)
    if player == nil or not finiteNumber(heading) then
        return nil
    end
    local radialX, radialZ = normalized(
            player.x - TRADE_ARENA_CENTER.x,
            player.z - TRADE_ARENA_CENTER.z)
    if radialX == nil then
        return nil
    end
    local start = {
        x = TRADE_ARENA_CENTER.x + radialX * TRADE_GREEN_PREP_RADIUS,
        y = player.y,
        z = TRADE_ARENA_CENTER.z + radialZ * TRADE_GREEN_PREP_RADIUS,
    }
    local landing = {
        x = start.x - radialX * TRADE_GREEN_KNOCKBACK_DISTANCE,
        y = player.y,
        z = start.z - radialZ * TRADE_GREEN_KNOCKBACK_DISTANCE,
    }
    local currentLanding = headingProjection(
            player, heading, TRADE_GREEN_KNOCKBACK_DISTANCE)
    if not tradeInsideArena(landing) then
        return nil
    end
    return {
        start = start,
        landing = landing,
        currentLanding = currentLanding,
        currentSafe = tradeInsideArena(currentLanding),
        recommendedForward = { x = -radialX, z = -radialZ },
    }
end

local function projectCostKnockback(sourcePosition, startPosition)
    local source = reliableTradePosition(sourcePosition)
    local start = reliableTradePosition(startPosition)
    if source == nil or start == nil then
        return nil
    end
    local awayX, awayZ = normalized(start.x - source.x, start.z - source.z)
    if awayX == nil then
        return nil
    end
    return {
        x = start.x + awayX * TRADE_COST_KNOCKBACK_DISTANCE,
        y = start.y,
        z = start.z + awayZ * TRADE_COST_KNOCKBACK_DISTANCE,
    }
end

local function findCostKnockbackSolution(sourcePosition, playerPosition)
    local source = reliableTradePosition(sourcePosition)
    local player = reliableTradePosition(playerPosition)
    if source == nil or player == nil then
        return nil
    end
    local currentLanding = projectCostKnockback(source, player)
    if currentLanding ~= nil and tradeInsideArena(currentLanding) then
        return {
            start = player,
            landing = currentLanding,
            alreadySafe = true,
        }
    end

    for searchRadius = 0.5, TRADE_ARENA_RADIUS * 2, 0.5 do
        local best
        local bestDistance
        for index = 0, 35 do
            local angle = index * 2 * math.pi / 36
            local candidate = {
                x = player.x + math.sin(angle) * searchRadius,
                y = player.y,
                z = player.z + math.cos(angle) * searchRadius,
            }
            if tradeInsideArena(candidate) then
                local landing = projectCostKnockback(source, candidate)
                if landing ~= nil and tradeInsideArena(landing) then
                    local candidateDistance = distanceSquared(candidate, player)
                    if bestDistance == nil or candidateDistance < bestDistance then
                        bestDistance = candidateDistance
                        best = { start = candidate, landing = landing, alreadySafe = false }
                    end
                end
            end
        end
        if best ~= nil then
            return best
        end
    end
    return nil
end

local function recordTradeBoss(state, entityID, now)
    if type(entityID) == 'number' then
        state.trackedBossEntityIDs[entityID] = true
        state.bossLastSeenAt = now
    end
    state.visualExpiresAt = now + TRADE_VISUAL_TRACK_MS
    state.lastActivityAt = now
end

local function recordCostSource(
        state,
        entityID,
        sourcePosition,
        activationAt,
        key,
        now,
        guide)
    local source = reliableTradePosition(sourcePosition)
    if source == nil or not finiteNumber(activationAt) then
        setTradeDiagnostic(state, guide, 'cost_missing_geometry', now)
        return false
    end
    if not consumeTradeEvent(state.cost.seenStarts, key, now) then
        return false
    end
    local conflict = state.cost.conflict
    if conflict ~= nil then
        local conflictDelta = activationAt - conflict.activationAt
        if math.abs(conflictDelta) <= TRADE_COST_ROUND_WINDOW_MS then
            conflict.expiresAt = math.max(
                    conflict.expiresAt,
                    activationAt + 5000)
            return false
        end
        if conflictDelta > TRADE_COST_ROUND_WINDOW_MS then
            state.cost.conflict = nil
        else
            return false
        end
    end
    local active = state.cost.active
    if active ~= nil
            and math.abs(active.activationAt - activationAt)
                    <= TRADE_COST_ROUND_WINDOW_MS
    then
        if distanceSquared(active.source, source) <= TRADE_COST_SOURCE_MATCH_SQ then
            active.expiresAt = math.max(active.expiresAt, activationAt + 5000)
            return true
        end
        setTradeDiagnostic(state, guide, 'cost_conflicting_source', now, {
            entityID = entityID,
        })
        state.cost.active = nil
        state.cost.conflict = {
            activationAt = active.activationAt,
            expiresAt = math.max(active.expiresAt, activationAt + 5000),
        }
        return false
    end
    state.cost.active = {
        entityID = entityID,
        source = source,
        activationAt = activationAt,
        expiresAt = activationAt + 5000,
    }
    state.lastActivityAt = now
    return true
end

local function handleTradeAOECreate(state, aoeInfo, now, guide)
    if type(aoeInfo) ~= 'table' or aoeInfo.aoeID ~= tradeAID.CostOfLiving then
        return false
    end
    if not finiteNumber(aoeInfo.startTime) or not finiteNumber(aoeInfo.duration) then
        setTradeDiagnostic(state, guide, 'cost_missing_geometry', now)
        return false
    end
    local activationAt = aoeInfo.startTime + aoeInfo.duration * 1000
    local key = table.concat({
        'aoe',
        tostring(aoeInfo.entityID),
        tostring(math.floor(aoeInfo.startTime)),
    }, ':')
    return recordCostSource(
            state,
            aoeInfo.entityID,
            { x = aoeInfo.x, y = aoeInfo.y, z = aoeInfo.z },
            activationAt,
            key,
            now,
            guide)
end

local function handleTradeEntityChannel(
        state,
        entityID,
        spellID,
        targetID,
        channelTimeMax,
        now,
        guide)
    if spellID == tradeAID.MaterialWorld
            or spellID == tradeAID.WhatreYouBuying1
            or spellID == tradeAID.WhatreYouBuying2
    then
        recordTradeBoss(state, entityID, now)
        return true
    end
    if spellID ~= tradeAID.CostOfLiving then
        return false
    end
    if not finiteNumber(channelTimeMax) then
        setTradeDiagnostic(state, guide, 'cost_missing_geometry', now)
        return false
    end
    local source = resolveReliableTradeEntityPosition(targetID)
            or resolveReliableTradeEntityPosition(entityID)
    local activationAt = now + channelTimeMax * 1000
    local key = table.concat({
        'channel',
        tostring(entityID),
        tostring(targetID),
        tostring(math.floor(activationAt)),
    }, ':')
    return recordCostSource(
            state, entityID, source, activationAt, key, now, guide)
end

local function handleTradeEntityCast(state, entityID, spellID, now)
    if spellID == tradeAID.MaterialWorld
            or spellID == tradeAID.WhatreYouBuying1
            or spellID == tradeAID.WhatreYouBuying2
    then
        recordTradeBoss(state, entityID, now)
        return true
    end
    if spellID == tradeAID.WhatreYouBuyingHelper then
        clearTradeCoinGame(state)
        return true
    end
    if spellID == tradeAID.CostOfLiving then
        local key = 'resolve:' .. tostring(entityID)
        if not consumeTradeEvent(state.cost.seenResolves, key, now) then
            return false
        end
        state.cost.active = nil
        state.cost.conflict = nil
        return true
    end
    return false
end

local function hasTradeActivity(state)
    return state.coin.assignment ~= nil
            or state.cost.active ~= nil
            or state.cost.conflict ~= nil
            or state.greenActive
            or state.visualExpiresAt ~= nil
end

local function hasTradeStoredState(state)
    return hasTradeActivity(state)
            or next(state.coin.seenTethers) ~= nil
            or next(state.coin.seenMarkers) ~= nil
            or next(state.cost.seenStarts) ~= nil
            or next(state.cost.seenResolves) ~= nil
            or next(state.trackedBossEntityIDs) ~= nil
end

local function hasLiveTradeTortoise(state)
    if type(TensorCore) ~= 'table' or type(TensorCore.mGetEntity) ~= 'function' then
        return nil
    end
    local checked = false
    for entityID in pairs(state.trackedBossEntityIDs) do
        checked = true
        local entity = TensorCore.mGetEntity(entityID)
        if entity ~= nil and entity.alive ~= false then
            return true
        end
    end
    if checked then
        return false
    end
    -- BossMod NameID/OID 未经本机事件证明为 Minion contentid，不据此扫描实体。
    return nil
end

local function getTradeDangerDrawer(guide)
    if tradeDangerDrawer == nil and type(guide.CreateDrawer) == 'function' then
        tradeDangerDrawer = guide.CreateDrawer(1, 0.1, 0, 0.24, 2, 0)
    end
    return tradeDangerDrawer
end

local function drawTradePath(drawer, start, landing)
    drawer:addCircle(start.x, start.y, start.z, 0.9)
    drawer:addCircle(landing.x, landing.y, landing.z, 1.2)
    drawer:addLine(
            start.x, start.y, start.z,
            landing.x, landing.y, landing.z,
            0.12, 0.25)
end

local function drawTradeCoinGame(guide, state, player, now)
    local assignment = state.coin.assignment
    if assignment == nil then
        return
    end
    if type(TensorCore) ~= 'table' or type(TensorCore.getBuff) ~= 'function' then
        setTradeDiagnostic(state, guide, 'transport_api_missing', now)
        return
    end
    local carry, reason = tradeCarryState(
            assignment.goal,
            TensorCore.getBuff(player.id, tradeSID.Transporting))
    if carry == nil then
        setTradeDiagnostic(state, guide, 'transport_unknown_value', now, {
            reason = reason,
        })
        return
    end
    local drawer = getGreenDrawer(guide)
    if drawer == nil then
        return
    end
    if carry.atCapacity or carry.deficit <= 0 then
        local target = resolveTradeDeliveryTarget(assignment, now)
        if target == nil then
            setTradeDiagnostic(state, guide, 'delivery_missing_target', now)
            return
        end
        drawer:addCircle(target.x, target.y, target.z, TRADE_GOAL_RADIUS)
        if type(guide.FrameDirect) == 'function' then
            guide.FrameDirect(target.x, target.z, 0.45, greenGuideColor)
        end
        return
    end

    local positions = {}
    for _, denomination in ipairs(neededCoinDenominations(carry.deficit)) do
        positions[denomination] = collectTradeCoinPositions(denomination)
    end
    local route = selectCoinRoute(carry.deficit, positions, player.pos)
    for _, coin in ipairs(route.all) do
        drawer:addCircle(
                coin.position.x,
                coin.position.y,
                coin.position.z,
                1.2)
    end
    if route.target ~= nil and type(guide.FrameDirect) == 'function' then
        guide.FrameDirect(
                route.target.x,
                route.target.z,
                0.45,
                greenGuideColor)
    elseif route.target == nil then
        setTradeDiagnostic(state, guide, 'coin_missing_objects', now, {
            deficit = carry.deficit,
        })
    end
end

local function drawTradeGreenKnockback(guide, state, player, now)
    local position = reliableTradePosition(player.pos)
    local heading = type(player.pos) == 'table'
            and (player.pos.h or player.pos.heading)
            or player.h or player.heading
    local solution = greenKnockbackSolution(position, heading)
    if solution == nil then
        setTradeDiagnostic(state, guide, 'green_missing_geometry', now)
        return
    end
    local green = getGreenDrawer(guide)
    local danger = getTradeDangerDrawer(guide)
    if green ~= nil then
        drawTradePath(green, solution.start, solution.landing)
        if solution.currentSafe then
            green:addCircle(
                    solution.currentLanding.x,
                    solution.currentLanding.y,
                    solution.currentLanding.z,
                    1)
        end
    end
    if not solution.currentSafe and danger ~= nil then
        danger:addCircle(
                solution.currentLanding.x,
                solution.currentLanding.y,
                solution.currentLanding.z,
                1)
    end
    if type(guide.FrameDirect) == 'function' then
        guide.FrameDirect(
                solution.start.x,
                solution.start.z,
                0.45,
                greenGuideColor)
    end
end

local function drawTradeCostOfLiving(guide, state, player, now)
    local active = state.cost.active
    if active == nil then
        return
    end
    local playerPosition = reliableTradePosition(player.pos)
    if playerPosition == nil then
        setTradeDiagnostic(state, guide, 'cost_missing_geometry', now)
        return
    end
    local currentLanding = projectCostKnockback(active.source, playerPosition)
    if currentLanding == nil then
        setTradeDiagnostic(state, guide, 'cost_missing_geometry', now)
        return
    end
    local currentSafe = tradeInsideArena(currentLanding)
    local green = getGreenDrawer(guide)
    local danger = getTradeDangerDrawer(guide)
    if currentSafe and green ~= nil then
        green:addCircle(
                currentLanding.x,
                currentLanding.y,
                currentLanding.z,
                1.2)
        green:addLine(
                playerPosition.x, playerPosition.y, playerPosition.z,
                currentLanding.x, currentLanding.y, currentLanding.z,
                0.12, 0.25)
        return
    end
    if danger ~= nil then
        danger:addCircle(
                currentLanding.x,
                currentLanding.y,
                currentLanding.z,
                1.2)
    end
    local solution = findCostKnockbackSolution(active.source, playerPosition)
    if solution == nil then
        setTradeDiagnostic(state, guide, 'cost_no_solution', now)
        return
    end
    if green ~= nil then
        drawTradePath(green, solution.start, solution.landing)
    end
    if type(guide.FrameDirect) == 'function' then
        guide.FrameDirect(
                solution.start.x,
                solution.start.z,
                0.45,
                greenGuideColor)
    end
end

local function updateTradeTortoise(guide, cfg, state)
    if not cfg.Enable then
        if hasTradeStoredState(state) then
            clearTradeState(state)
        end
        return
    end
    local now = getNow()
    pruneTradeState(state, now)
    local player = getTradePlayer(guide)
    if player ~= nil
            and type(TensorCore) == 'table'
            and type(TensorCore.getBuff) == 'function'
    then
        state.greenActive =
                TensorCore.getBuff(player.id, tradeSID.BuyersRemorseGreen) ~= nil
        if state.greenActive then
            state.lastActivityAt = now
        end
    else
        state.greenActive = false
    end

    if not hasTradeActivity(state) then
        state.trackedBossEntityIDs = {}
        state.bossLastSeenAt = nil
    end
    if hasTradeActivity(state) then
        local bossPresent = hasLiveTradeTortoise(state)
        if bossPresent == true then
            state.bossLastSeenAt = now
        elseif bossPresent == false
                and state.bossLastSeenAt ~= nil
                and now - state.bossLastSeenAt > TRADE_BOSS_MISSING_CLEAR_MS
        then
            clearTradeState(state)
            return
        end
    end
    if player == nil then
        return
    end
    if cfg.DrawCoinRoute then
        drawTradeCoinGame(guide, state, player, now)
    end
    if cfg.DrawGreenKnockback and state.greenActive then
        drawTradeGreenKnockback(guide, state, player, now)
    end
    if cfg.DrawCostOfLivingGuide then
        drawTradeCostOfLiving(guide, state, player, now)
    end
end

return {
    AID = tradeAID,
    SID = tradeSID,
    ArenaCenter = TRADE_ARENA_CENTER,
    ArenaRadius = TRADE_ARENA_RADIUS,
    GoalRadius = TRADE_GOAL_RADIUS,
    GreenPrepRadius = TRADE_GREEN_PREP_RADIUS,
    GreenKnockbackDistance = TRADE_GREEN_KNOCKBACK_DISTANCE,
    CostKnockbackDistance = TRADE_COST_KNOCKBACK_DISTANCE,
    CoinTimeoutMs = TRADE_COIN_TIMEOUT_MS,
    TetherGoal = tradeTetherGoal,
    HeldQuantity = tradeHeldQuantity,
    CoinContentID = tradeCoinContentID,
    NewState = newTradeState,
    EnsureState = ensureTradeState,
    ClearState = clearTradeState,
    ClearCoinGame = clearTradeCoinGame,
    GetConfig = getTradeConfig,
    GetRuntimeState = getTradeRuntimeState,
    PruneState = pruneTradeState,
    NormalizeCarryParam = normalizeCarryParam,
    CarryState = tradeCarryState,
    NeededCoinDenominations = neededCoinDenominations,
    SelectCoinRoute = selectCoinRoute,
    ReliablePosition = reliableTradePosition,
    ResolveDeliveryTarget = resolveTradeDeliveryTarget,
    CollectCoinPositions = collectTradeCoinPositions,
    InsideArena = tradeInsideArena,
    GreenKnockbackSolution = greenKnockbackSolution,
    ProjectCostKnockback = projectCostKnockback,
    FindCostKnockbackSolution = findCostKnockbackSolution,
    RecordCostSource = recordCostSource,
    HandleTetherChange = handleTradeTetherChange,
    HandleMarkerAdd = handleTradeMarkerAdd,
    HandleEntityChannel = handleTradeEntityChannel,
    HandleAOECreate = handleTradeAOECreate,
    HandleEntityCast = handleTradeEntityCast,
    DrawCoinGame = drawTradeCoinGame,
    DrawGreenKnockback = drawTradeGreenKnockback,
    DrawCostOfLiving = drawTradeCostOfLiving,
    Update = updateTradeTortoise,
    HasActivity = hasTradeActivity,
    HasStoredState = hasTradeStoredState,
}
end

rawset(_G, 'MuAiOccultCrescentSouthTradeTortoise', Module)
return Module
