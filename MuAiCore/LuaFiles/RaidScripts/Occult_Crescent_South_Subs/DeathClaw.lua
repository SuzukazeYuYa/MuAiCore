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

local DEATH_CLAW_BOSS_CONTENT_ID = 13656
local DEATH_CLAW_CLAWMARK_CONTENT_ID = 13658
local DEATH_CLAW_SKULKING_OBJECT_CONTENT_ID = 2014448
local DEATH_CLAW_ARENA_CENTER = { x = 681, z = 534 }
local DEATH_CLAW_ARENA_HALF_SIZE = 21
local DEATH_CLAW_ARENA_EVENT_MARGIN = 2
local DEATH_CLAW_CONE_RADIUS = 50
local DEATH_CLAW_CONE_ANGLE = math.pi / 2
local DEATH_CLAW_CHANNEL_TO_CAST_MS = 400
local DEATH_CLAW_CROSS_SECOND_DELAY_MS = 2000
local DEATH_CLAW_SKULKING_FIRST_DELAY_MS = 8100
local DEATH_CLAW_SKULKING_LATER_DELAY_MS = 10600
local DEATH_CLAW_ENTRY_GRACE_MS = 750
local DEATH_CLAW_DEDUPE_MS = 500
local DEATH_CLAW_SEEN_TTL_MS = 30000
local DEATH_CLAW_MISSING_DEBOUNCE_MS = 500
local DEATH_CLAW_BOSS_MISSING_CLEAR_MS = 2000
local DEATH_CLAW_CLAWMARK_DELAY_MS = { 6900, 9100, 11100 }
local DEATH_CLAW_CLAWMARK_LENGTH = 60
local DEATH_CLAW_CLAWMARK_WIDTH = 7

local deathClawAID = {
    AutoAttack = 871,
    DeathWall = 41308,
    DirtyNails = 41332,
    Clawmarks = 41309,
    SlashVisual = 41312,
    LethalNailsFast = 41315,
    LethalNailsMid = 41316,
    LethalNailsSlow = 41317,
    VerticalCrosshatch = 41323,
    HorizontalCrosshatch = 41324,
    RakingScratch = 41325,
    SkulkingOrdersSingle = 41326,
    ClawingShadow = 41327,
    ClawingShadowVisual = 41328,
    SkulkingOrdersDouble = 41329,
    VerticalCrosshatchSlow = 41330,
    HorizontalCrosshatchSlow = 41331,
    TheGripOfPoisonCast = 41333,
    TheGripOfPoison = 41334,
    ThreefoldMarks = 41310,
    ManifoldMarks = 41311,
}

local crosshatchRotation = {
    [deathClawAID.VerticalCrosshatch] = 0,
    [deathClawAID.VerticalCrosshatchSlow] = 0,
    [deathClawAID.HorizontalCrosshatch] = math.pi / 2,
    [deathClawAID.HorizontalCrosshatchSlow] = math.pi / 2,
}

local deathClawFinite = Common.finite

local function normalizeDeathClawHeading(heading)
    if not deathClawFinite(heading) then
        return nil
    end
    return (heading + math.pi) % (2 * math.pi) - math.pi
end

local function deathClawHeadingDifference(left, right)
    left = normalizeDeathClawHeading(left)
    right = normalizeDeathClawHeading(right)
    if left == nil or right == nil then
        return nil
    end
    return math.abs((left - right + math.pi) % (2 * math.pi) - math.pi)
end

local function deathClawPosition(value)
    if type(value) ~= 'table'
            or not deathClawFinite(value.x)
            or not deathClawFinite(value.y)
            or value.y == 0
            or not deathClawFinite(value.z)
    then
        return nil
    end
    return {
        x = value.x,
        y = value.y,
        z = value.z,
    }
end

local function deathClawInArena(pos)
    return pos ~= nil
            and math.abs(pos.x - DEATH_CLAW_ARENA_CENTER.x)
                    <= DEATH_CLAW_ARENA_HALF_SIZE
                            + DEATH_CLAW_ARENA_EVENT_MARGIN
            and math.abs(pos.z - DEATH_CLAW_ARENA_CENTER.z)
                    <= DEATH_CLAW_ARENA_HALF_SIZE
                            + DEATH_CLAW_ARENA_EVENT_MARGIN
end

local deathClawDistanceSquared = Common.distanceSquared

local function newDeathClawState()
    return {
        crosshatch = nil,
        clawmarks = {},
        clawmarkModels = {},
        skulking = {},
        skulkingOrder = 0,
        ambiguity = {
            crosshatch = nil,
            skulking = nil,
        },
        seenResolves = {},
        seenVisibility = {},
        bossEntityID = nil,
        bossLastSeenAt = nil,
        bossMissingSince = nil,
        lastActivityAt = nil,
        lastDiagnostic = nil,
    }
end

local function ensureDeathClawState(state)
    state.clawmarks = type(state.clawmarks) == 'table'
            and state.clawmarks or {}
    state.clawmarkModels = type(state.clawmarkModels) == 'table'
            and state.clawmarkModels or {}
    state.skulking = type(state.skulking) == 'table'
            and state.skulking or {}
    state.skulkingOrder = tonumber(state.skulkingOrder) or 0
    state.ambiguity = type(state.ambiguity) == 'table'
            and state.ambiguity or {}
    state.seenResolves = type(state.seenResolves) == 'table'
            and state.seenResolves or {}
    state.seenVisibility = type(state.seenVisibility) == 'table'
            and state.seenVisibility or {}
    return state
end

local deleteDeathClawTimedShape = Common.deleteTimedShape

local function clearDeathClawEntry(entry)
    if type(entry) == 'table' then
        deleteDeathClawTimedShape(entry.token)
        entry.token = nil
        entry.scheduled = false
    end
end

local function clearDeathClawCrosshatch(state)
    if type(state.crosshatch) == 'table' then
        for _, entry in ipairs(state.crosshatch.entries or {}) do
            clearDeathClawEntry(entry)
        end
    end
    state.crosshatch = nil
    state.ambiguity.crosshatch = nil
end

local function clearDeathClawClawmarks(state)
    for _, entry in pairs(state.clawmarks) do
        clearDeathClawEntry(entry)
    end
    state.clawmarks = {}
    state.clawmarkModels = {}
end

local function clearDeathClawSkulking(state)
    for _, entry in ipairs(state.skulking) do
        clearDeathClawEntry(entry)
    end
    state.skulking = {}
    state.skulkingOrder = 0
    state.ambiguity.skulking = nil
end

local function clearDeathClawState(state)
    ensureDeathClawState(state)
    clearDeathClawCrosshatch(state)
    clearDeathClawClawmarks(state)
    clearDeathClawSkulking(state)
    state.seenResolves = {}
    state.seenVisibility = {}
    state.bossEntityID = nil
    state.bossLastSeenAt = nil
    state.bossMissingSince = nil
    state.lastActivityAt = nil
    state.lastDiagnostic = nil
end

local deathClawDiagnosticText = {
    clawmark_missing_geometry =
            '死亡爪抓痕预兆跳过：实体、位置、朝向或非零高度不可靠。',
    crosshatch_missing_geometry =
            '死亡爪交叉抓痕跳过：Boss位置、朝向、读条时间或非零高度不可靠。',
    crosshatch_conflict =
            '死亡爪交叉抓痕重复事件几何冲突，本轮停止预测。',
    crosshatch_resolve_mismatch =
            '死亡爪交叉抓痕实际结算无法唯一配对，本轮停止预测。',
    skulking_missing_geometry =
            '死亡爪潜行命令跳过：封印物件位置、朝向或非零高度不可靠。',
    skulking_conflict =
            '死亡爪潜行命令封印事件冲突，本轮停止预测。',
}

local deathClawFeature = Common.newFeature({
    key = 'DeathClaw',
    newState = newDeathClawState,
    ensureState = ensureDeathClawState,
    diagnosticText = deathClawDiagnosticText,
})
local getDeathClawConfig = deathClawFeature.GetConfig
local getDeathClawRuntimeState = deathClawFeature.GetRuntimeState
local setDeathClawDiagnostic = deathClawFeature.Diagnostic

local function getDeathClawMoogleDrawer()
    if type(TensorCore) ~= 'table'
            or type(TensorCore.getMoogleDrawer) ~= 'function'
    then
        return nil
    end
    local drawer = TensorCore.getMoogleDrawer()
    return type(drawer) == 'table' and drawer or nil
end

local function scheduleDeathClawEntry(entry, now)
    if type(entry) ~= 'table'
            or entry.scheduled == true
            or not deathClawFinite(entry.activationAt)
    then
        return false
    end
    local timeout = entry.activationAt - now
    if timeout <= 0 then
        return false
    end
    local drawer = getDeathClawMoogleDrawer()
    if drawer == nil or type(drawer.addTimedCone) ~= 'function' then
        return false
    end
    entry.token = drawer:addTimedCone(
            timeout,
            entry.source.x,
            entry.source.y,
            entry.source.z,
            DEATH_CLAW_CONE_RADIUS,
            DEATH_CLAW_CONE_ANGLE,
            entry.heading)
    entry.scheduled = true
    return true
end

local function firstDeathClawClawmarkOrder(state)
    local firstOrder = nil
    for _, entry in pairs(state.clawmarks) do
        if deathClawFinite(entry.order)
                and (firstOrder == nil or entry.order < firstOrder)
        then
            firstOrder = entry.order
        end
    end
    return firstOrder
end

local function scheduleDeathClawClawmark(state, entry, now)
    if type(entry) ~= 'table'
            or entry.scheduled == true
            or not deathClawFinite(entry.expiresAt)
            or entry.order ~= firstDeathClawClawmarkOrder(state)
    then
        return false
    end
    local timeout = entry.expiresAt - now
    if timeout <= 0 then
        return false
    end
    local drawer = getDeathClawMoogleDrawer()
    if drawer == nil or type(drawer.addTimedRect) ~= 'function' then
        return false
    end
    entry.token = drawer:addTimedRect(
            timeout,
            entry.source.x,
            entry.source.y,
            entry.source.z,
            DEATH_CLAW_CLAWMARK_LENGTH,
            DEATH_CLAW_CLAWMARK_WIDTH,
            entry.heading)
    entry.scheduled = true
    return true
end


local function scheduleDeathClawQueuedClawmarks(state, now)
    local firstOrder = firstDeathClawClawmarkOrder(state)
    if firstOrder == nil then
        return
    end
    for _, entry in pairs(state.clawmarks) do
        if entry.order == firstOrder then
            scheduleDeathClawClawmark(state, entry, now)
        end
    end
end

local function handleDeathClawVisibilityChange(
        state,
        entityID,
        wasVisible,
        isVisible,
        now,
        guide)
    ensureDeathClawState(state)
    if wasVisible ~= false or isVisible ~= true
            or not deathClawFinite(entityID)
    then
        return false
    end
    local key = tostring(entityID) .. ':visible'
    local seenAt = state.seenVisibility[key]
    if deathClawFinite(seenAt)
            and now - seenAt <= DEATH_CLAW_SEEN_TTL_MS
    then
        return false
    end
    if type(TensorCore) ~= 'table'
            or type(TensorCore.mGetEntity) ~= 'function'
            or type(Argus) ~= 'table'
            or type(Argus.getEntityModel) ~= 'function'
    then
        return false
    end
    local entity = TensorCore.mGetEntity(entityID)
    local model = Argus.getEntityModel(entityID)
    local source = entity ~= nil and deathClawPosition(entity.pos) or nil
    local heading = entity ~= nil
            and type(entity.pos) == 'table'
            and normalizeDeathClawHeading(entity.pos.h) or nil
    if entity == nil
            or tonumber(entity.id) ~= entityID
            or tonumber(entity.contentid) ~= DEATH_CLAW_CLAWMARK_CONTENT_ID
            or not deathClawFinite(model)
            or not deathClawInArena(source)
            or heading == nil
    then
        setDeathClawDiagnostic(
                state,
                guide,
                'clawmark_missing_geometry',
                now,
                { entityID = entityID })
        return false
    end

    state.seenVisibility[key] = now
    local order = nil
    for index, knownModel in ipairs(state.clawmarkModels) do
        if knownModel == model then
            order = index
            break
        end
    end
    if order == nil then
        order = #state.clawmarkModels + 1
        local delay = DEATH_CLAW_CLAWMARK_DELAY_MS[order]
        if delay == nil then
            setDeathClawDiagnostic(
                    state,
                    guide,
                    'clawmark_missing_geometry',
                    now,
                    { entityID = entityID, model = model })
            return false
        end
        state.clawmarkModels[order] = model
    end
    local previous = state.clawmarks[entityID]
    if type(previous) == 'table' then
        clearDeathClawEntry(previous)
    end
    local entry = {
        entityID = entityID,
        source = source,
        heading = heading,
        model = model,
        order = order,
        activationAt = now + DEATH_CLAW_CLAWMARK_DELAY_MS[order],
        expiresAt = now + DEATH_CLAW_CLAWMARK_DELAY_MS[order],
        scheduled = false,
        token = nil,
    }
    state.clawmarks[entityID] = entry
    state.lastActivityAt = now
    scheduleDeathClawQueuedClawmarks(state, now)
    return true
end

local function handleDeathClawAOECreate(state, aoeInfo, now)
    if type(aoeInfo) ~= 'table'
            or aoeInfo.aoeID ~= deathClawAID.LethalNailsFast
                    and aoeInfo.aoeID ~= deathClawAID.LethalNailsMid
                    and aoeInfo.aoeID ~= deathClawAID.LethalNailsSlow
    then
        return false
    end
    local entityID = tonumber(aoeInfo.entityID)
    local entry = entityID ~= nil and state.clawmarks[entityID] or nil
    if type(entry) ~= 'table' then
        return false
    end
    clearDeathClawEntry(entry)
    state.clawmarks[entityID] = nil
    if next(state.clawmarks) == nil then
        state.clawmarkModels = {}
    else
        scheduleDeathClawQueuedClawmarks(state, now or getNow())
    end
    return true
end

local function trackDeathClawBoss(state, entityID, now)
    if type(TensorCore) ~= 'table'
            or type(TensorCore.mGetEntity) ~= 'function'
            or not deathClawFinite(entityID)
    then
        return nil
    end
    local entity = TensorCore.mGetEntity(entityID)
    local pos = entity ~= nil and deathClawPosition(entity.pos) or nil
    if entity == nil
            or tonumber(entity.id) ~= entityID
            or tonumber(entity.contentid) ~= DEATH_CLAW_BOSS_CONTENT_ID
            or not deathClawInArena(pos)
    then
        return nil
    end
    local heading = normalizeDeathClawHeading(entity.pos.h)
    if heading == nil then
        return nil
    end
    state.bossEntityID = entityID
    state.bossLastSeenAt = now
    state.bossMissingSince = nil
    return pos, heading
end

local function suppressDeathClawCrosshatch(state, code, now)
    if type(state.crosshatch) == 'table' then
        for _, entry in ipairs(state.crosshatch.entries or {}) do
            clearDeathClawEntry(entry)
        end
    end
    local expiresAt = now + 10000
    if type(state.crosshatch) == 'table'
            and deathClawFinite(state.crosshatch.expiresAt)
    then
        expiresAt = math.max(expiresAt, state.crosshatch.expiresAt)
    end
    state.crosshatch = nil
    state.ambiguity.crosshatch = {
        code = code,
        at = now,
        expiresAt = expiresAt,
    }
    state.lastActivityAt = now
end

local function suppressDeathClawSkulking(state, code, now)
    for _, entry in ipairs(state.skulking) do
        clearDeathClawEntry(entry)
    end
    local expiresAt = now + DEATH_CLAW_SKULKING_LATER_DELAY_MS
            + DEATH_CLAW_ENTRY_GRACE_MS
    for _, entry in ipairs(state.skulking) do
        if deathClawFinite(entry.expiresAt) then
            expiresAt = math.max(expiresAt, entry.expiresAt)
        end
    end
    state.skulking = {}
    state.ambiguity.skulking = {
        code = code,
        at = now,
        expiresAt = expiresAt,
    }
    state.lastActivityAt = now
end

local function makeDeathClawCrosshatchEntries(
        source,
        heading,
        rotation,
        firstActivationAt)
    local entries = {}
    local rotations = {
        rotation,
        rotation + math.pi,
        rotation + math.pi / 2,
        rotation + math.pi * 3 / 2,
    }
    for index, offset in ipairs(rotations) do
        local activationAt = firstActivationAt
        if index > 2 then
            activationAt =
                    firstActivationAt + DEATH_CLAW_CROSS_SECOND_DELAY_MS
        end
        entries[#entries + 1] = {
            source = {
                x = source.x,
                y = source.y,
                z = source.z,
            },
            heading = normalizeDeathClawHeading(heading + offset),
            activationAt = activationAt,
            expiresAt = activationAt + DEATH_CLAW_ENTRY_GRACE_MS,
            scheduled = false,
            token = nil,
        }
    end
    return entries
end

local function sameDeathClawCrosshatch(round, spellID, source, heading, duration)
    return type(round) == 'table'
            and round.spellID == spellID
            and deathClawDistanceSquared(round.source, source) <= 0.01
            and math.abs(round.source.y - source.y) <= 0.1
            and deathClawHeadingDifference(round.heading, heading) <= 0.01
            and math.abs(round.channelTimeMax - duration) <= 0.25
end

local function handleDeathClawEntityChannel(
        state,
        entityID,
        spellID,
        channelTimeMax,
        now,
        guide)
    ensureDeathClawState(state)
    local rotation = crosshatchRotation[spellID]
    local isSkulkingVisual =
            spellID == deathClawAID.SkulkingOrdersSingle
            or spellID == deathClawAID.SkulkingOrdersDouble
    if rotation == nil and not isSkulkingVisual then
        return false
    end

    local source, heading = trackDeathClawBoss(state, entityID, now)
    if isSkulkingVisual then
        return source ~= nil
    end
    if source == nil
            or not deathClawFinite(channelTimeMax)
            or channelTimeMax < 4
            or channelTimeMax > 8
    then
        if type(state.crosshatch) == 'table' then
            suppressDeathClawCrosshatch(
                    state, 'crosshatch_missing_geometry', now)
        end
        setDeathClawDiagnostic(
                state, guide, 'crosshatch_missing_geometry', now)
        return false
    end
    if state.ambiguity.crosshatch ~= nil then
        return false
    end

    local previous = state.crosshatch
    if previous ~= nil
            and now - previous.startedAt <= DEATH_CLAW_DEDUPE_MS
    then
        if sameDeathClawCrosshatch(
                previous, spellID, source, heading, channelTimeMax)
        then
            return false
        end
        suppressDeathClawCrosshatch(state, 'crosshatch_conflict', now)
        setDeathClawDiagnostic(
                state, guide, 'crosshatch_conflict', now, {
                    expectedSpellID = previous.spellID,
                    actualSpellID = spellID,
                })
        return false
    end
    if previous ~= nil then
        clearDeathClawCrosshatch(state)
    end

    local firstActivationAt = now
            + channelTimeMax * 1000
            + DEATH_CLAW_CHANNEL_TO_CAST_MS
    local entries = makeDeathClawCrosshatchEntries(
            source, heading, rotation, firstActivationAt)
    state.crosshatch = {
        entityID = entityID,
        spellID = spellID,
        source = source,
        heading = heading,
        channelTimeMax = channelTimeMax,
        startedAt = now,
        firstActivationAt = firstActivationAt,
        expiresAt = firstActivationAt
                + DEATH_CLAW_CROSS_SECOND_DELAY_MS
                + DEATH_CLAW_ENTRY_GRACE_MS,
        entries = entries,
    }
    state.lastActivityAt = now
    local cfg = getDeathClawConfig(guide)
    if type(cfg) == 'table' and cfg.DrawCrosshatchPrediction == true then
        for _, entry in ipairs(entries) do
            scheduleDeathClawEntry(entry, now)
        end
    end
    return true
end

local function deathClawCastGeometry(entityID, castPos)
    local pos = deathClawPosition(castPos)
    local heading = type(castPos) == 'table'
            and normalizeDeathClawHeading(castPos.h or castPos.heading)
            or nil
    if (pos == nil or heading == nil)
            and type(TensorCore) == 'table'
            and type(TensorCore.mGetEntity) == 'function'
    then
        local entity = TensorCore.mGetEntity(entityID)
        if entity ~= nil and tonumber(entity.id) == entityID then
            pos = pos or deathClawPosition(entity.pos)
            heading = heading
                    or normalizeDeathClawHeading(
                            type(entity.pos) == 'table'
                                    and entity.pos.h or nil)
        end
    end
    if not deathClawInArena(pos) or heading == nil then
        return nil, nil
    end
    return pos, heading
end

local function resolveDeathClawCrosshatch(
        state,
        entityID,
        castPos,
        now,
        guide)
    local round = state.crosshatch
    if type(round) ~= 'table' then
        return false
    end
    local key = tostring(entityID) .. ':'
            .. tostring(deathClawAID.RakingScratch)
    local seenAt = state.seenResolves[key]
    if seenAt ~= nil and now - seenAt <= DEATH_CLAW_DEDUPE_MS then
        return false
    end
    state.seenResolves[key] = now

    local pos, heading = deathClawCastGeometry(entityID, castPos)
    local matches = {}
    if pos ~= nil then
        for index, entry in ipairs(round.entries) do
            if deathClawDistanceSquared(entry.source, pos) <= 2.25
                    and deathClawHeadingDifference(
                            entry.heading, heading) <= 0.1
            then
                matches[#matches + 1] = index
            end
        end
    end
    if #matches ~= 1 then
        suppressDeathClawCrosshatch(
                state, 'crosshatch_resolve_mismatch', now)
        setDeathClawDiagnostic(
                state, guide, 'crosshatch_resolve_mismatch', now, {
                    matches = #matches,
                    entityID = entityID,
                })
        return false
    end
    local index = matches[1]
    clearDeathClawEntry(round.entries[index])
    table.remove(round.entries, index)
    state.lastActivityAt = now
    if #round.entries == 0 then
        state.crosshatch = nil
        state.ambiguity.crosshatch = nil
    end
    return true
end

local function handleDeathClawEntityCast(
        state,
        entityID,
        spellID,
        castPos,
        now,
        guide)
    ensureDeathClawState(state)
    if spellID ~= deathClawAID.RakingScratch then
        return false
    end
    return resolveDeathClawCrosshatch(
            state, entityID, castPos, now, guide)
end

local function deathClawEventObject(entityID)
    if type(TensorCore) ~= 'table'
            or type(TensorCore.mGetEntity) ~= 'function'
    then
        return nil, nil
    end
    local entity = TensorCore.mGetEntity(entityID)
    local pos = entity ~= nil and deathClawPosition(entity.pos) or nil
    local heading = entity ~= nil
            and type(entity.pos) == 'table'
            and normalizeDeathClawHeading(entity.pos.h) or nil
    if entity == nil
            or tonumber(entity.id) ~= entityID
            or tonumber(entity.contentid)
                    ~= DEATH_CLAW_SKULKING_OBJECT_CONTENT_ID
            or not deathClawInArena(pos)
            or heading == nil
    then
        return nil, nil
    end
    return pos, heading
end

local function findDeathClawSkulking(state, entityID)
    for index, entry in ipairs(state.skulking) do
        if entry.entityID == entityID then
            return index, entry
        end
    end
    return nil, nil
end

local function handleDeathClawScriptFunc(
        state,
        entityID,
        a1,
        a2,
        a3,
        now,
        guide)
    ensureDeathClawState(state)
    local isStart = a1 == 16 and a2 == 32 and a3 == 0
    local isEnd = a1 == 4 and a2 == 8 and a3 == 0
    if not isStart and not isEnd then
        return false
    end

    local existingIndex, existing = findDeathClawSkulking(state, entityID)
    if isEnd then
        if existing == nil then
            return false
        end
        clearDeathClawEntry(existing)
        table.remove(state.skulking, existingIndex)
        state.lastActivityAt = now
        if #state.skulking == 0 then
            state.skulkingOrder = 0
            state.ambiguity.skulking = nil
        end
        return true
    end
    if state.ambiguity.skulking ~= nil then
        return false
    end

    local pos, heading = deathClawEventObject(entityID)
    if pos == nil then
        if #state.skulking > 0 then
            suppressDeathClawSkulking(
                    state, 'skulking_missing_geometry', now)
        end
        setDeathClawDiagnostic(
                state, guide, 'skulking_missing_geometry', now, {
                    entityID = entityID,
                })
        return false
    end
    if existing ~= nil then
        if now - existing.startedAt <= DEATH_CLAW_DEDUPE_MS
                and deathClawDistanceSquared(existing.source, pos) <= 0.01
                and math.abs(existing.source.y - pos.y) <= 0.1
                and deathClawHeadingDifference(
                        existing.heading, heading) <= 0.01
        then
            return false
        end
        suppressDeathClawSkulking(state, 'skulking_conflict', now)
        setDeathClawDiagnostic(
                state, guide, 'skulking_conflict', now, {
                    entityID = entityID,
                })
        return false
    end
    if state.skulkingOrder >= 4 then
        suppressDeathClawSkulking(state, 'skulking_conflict', now)
        setDeathClawDiagnostic(
                state, guide, 'skulking_conflict', now, {
                    count = state.skulkingOrder + 1,
                })
        return false
    end

    local delay = state.skulkingOrder < 2
            and DEATH_CLAW_SKULKING_FIRST_DELAY_MS
            or DEATH_CLAW_SKULKING_LATER_DELAY_MS
    state.skulkingOrder = state.skulkingOrder + 1
    local entry = {
        entityID = entityID,
        source = pos,
        heading = heading,
        sequence = state.skulkingOrder,
        startedAt = now,
        activationAt = now + delay,
        expiresAt = now + delay + DEATH_CLAW_ENTRY_GRACE_MS,
        missingSince = nil,
        scheduled = false,
        token = nil,
    }
    state.skulking[#state.skulking + 1] = entry
    state.lastActivityAt = now
    local cfg = getDeathClawConfig(guide)
    if type(cfg) == 'table' and cfg.DrawSkulkingPrediction == true then
        scheduleDeathClawEntry(entry, now)
    end
    return true
end

local function pruneDeathClawState(state, now)
    ensureDeathClawState(state)
    for key, seenAt in pairs(state.seenResolves) do
        if not deathClawFinite(seenAt)
                or now - seenAt > DEATH_CLAW_SEEN_TTL_MS
        then
            state.seenResolves[key] = nil
        end
    end
    for key, seenAt in pairs(state.seenVisibility) do
        if not deathClawFinite(seenAt)
                or now - seenAt > DEATH_CLAW_SEEN_TTL_MS
        then
            state.seenVisibility[key] = nil
        end
    end
    for entityID, entry in pairs(state.clawmarks) do
        if not deathClawFinite(entry.expiresAt)
                or now >= entry.expiresAt
        then
            clearDeathClawEntry(entry)
            state.clawmarks[entityID] = nil
        end
    end
    if next(state.clawmarks) == nil then
        state.clawmarkModels = {}
    end

    local round = state.crosshatch
    if type(round) == 'table' then
        for index = #round.entries, 1, -1 do
            local entry = round.entries[index]
            if not deathClawFinite(entry.expiresAt)
                    or now >= entry.expiresAt
            then
                clearDeathClawEntry(entry)
                table.remove(round.entries, index)
            end
        end
        if #round.entries == 0
                or not deathClawFinite(round.expiresAt)
                or now >= round.expiresAt
        then
            clearDeathClawCrosshatch(state)
        end
    end
    local crossAmbiguity = state.ambiguity.crosshatch
    if type(crossAmbiguity) == 'table'
            and (not deathClawFinite(crossAmbiguity.expiresAt)
                    or now >= crossAmbiguity.expiresAt)
    then
        state.ambiguity.crosshatch = nil
    end

    for index = #state.skulking, 1, -1 do
        local entry = state.skulking[index]
        if not deathClawFinite(entry.expiresAt)
                or now >= entry.expiresAt
        then
            clearDeathClawEntry(entry)
            table.remove(state.skulking, index)
        end
    end
    if #state.skulking == 0 then
        state.skulkingOrder = 0
        local skulkingAmbiguity = state.ambiguity.skulking
        if type(skulkingAmbiguity) ~= 'table'
                or not deathClawFinite(skulkingAmbiguity.expiresAt)
                or now >= skulkingAmbiguity.expiresAt
        then
            state.ambiguity.skulking = nil
        end
    end
end

local function refreshDeathClawSkulking(state, now)
    if type(TensorCore) ~= 'table'
            or type(TensorCore.mGetEntity) ~= 'function'
    then
        return
    end
    for index = #state.skulking, 1, -1 do
        local entry = state.skulking[index]
        local entity = TensorCore.mGetEntity(entry.entityID)
        if entity == nil then
            entry.missingSince = entry.missingSince or now
            if now - entry.missingSince
                    >= DEATH_CLAW_MISSING_DEBOUNCE_MS
            then
                clearDeathClawEntry(entry)
                table.remove(state.skulking, index)
            end
        else
            local pos = deathClawPosition(entity.pos)
            local heading = type(entity.pos) == 'table'
                    and normalizeDeathClawHeading(entity.pos.h) or nil
            local invalid = tonumber(entity.id) ~= entry.entityID
                    or tonumber(entity.contentid)
                            ~= DEATH_CLAW_SKULKING_OBJECT_CONTENT_ID
                    or entity.alive == false
                    or entity.visible == false
                    or not deathClawInArena(pos)
                    or heading == nil
            if invalid
                    or deathClawDistanceSquared(entry.source, pos) > 0.25
                    or deathClawHeadingDifference(
                            entry.heading, heading) > 0.1
            then
                suppressDeathClawSkulking(
                        state, 'skulking_conflict', now)
                return
            end
            entry.missingSince = nil
        end
    end
    if #state.skulking == 0 then
        state.skulkingOrder = 0
        state.ambiguity.skulking = nil
    end
end

local function deathClawHasActivity(state)
    return type(state.crosshatch) == 'table'
            or next(state.clawmarks) ~= nil
            or #state.skulking > 0
            or state.ambiguity.crosshatch ~= nil
            or state.ambiguity.skulking ~= nil
end

local function updateDeathClaw(guide, cfg, state, now)
    ensureDeathClawState(state)
    now = now or getNow()
    if cfg.Enable ~= true then
        clearDeathClawState(state)
        return
    end
    if cfg.DrawCrosshatchPrediction ~= true then
        clearDeathClawCrosshatch(state)
    end
    if cfg.DrawSkulkingPrediction ~= true then
        clearDeathClawSkulking(state)
    end

    pruneDeathClawState(state, now)
    refreshDeathClawSkulking(state, now)
    if not deathClawHasActivity(state) then
        return
    end

    if state.bossEntityID ~= nil
            and type(TensorCore) == 'table'
            and type(TensorCore.mGetEntity) == 'function'
    then
        local boss = TensorCore.mGetEntity(state.bossEntityID)
        if boss ~= nil
                and tonumber(boss.id) == state.bossEntityID
                and tonumber(boss.contentid)
                        == DEATH_CLAW_BOSS_CONTENT_ID
                and boss.alive ~= false
        then
            state.bossLastSeenAt = now
            state.bossMissingSince = nil
        else
            state.bossMissingSince = state.bossMissingSince or now
            if now - state.bossMissingSince
                    >= DEATH_CLAW_BOSS_MISSING_CLEAR_MS
            then
                clearDeathClawState(state)
                return
            end
        end
    end

    if state.ambiguity.crosshatch == nil
            and type(state.crosshatch) == 'table'
            and cfg.DrawCrosshatchPrediction == true
    then
        for _, entry in ipairs(state.crosshatch.entries) do
            scheduleDeathClawEntry(entry, now)
        end
    end
    for _, entry in pairs(state.clawmarks) do
        scheduleDeathClawClawmark(state, entry, now)
    end
    if state.ambiguity.skulking == nil
            and cfg.DrawSkulkingPrediction == true
    then
        for _, entry in ipairs(state.skulking) do
            scheduleDeathClawEntry(entry, now)
        end
    end
end

return {
    AID = deathClawAID,
    BossContentID = DEATH_CLAW_BOSS_CONTENT_ID,
    ClawmarkContentID = DEATH_CLAW_CLAWMARK_CONTENT_ID,
    SkulkingObjectContentID = DEATH_CLAW_SKULKING_OBJECT_CONTENT_ID,
    ArenaCenter = DEATH_CLAW_ARENA_CENTER,
    ArenaHalfSize = DEATH_CLAW_ARENA_HALF_SIZE,
    ConeRadius = DEATH_CLAW_CONE_RADIUS,
    ConeAngle = DEATH_CLAW_CONE_ANGLE,
    ClawmarkDelayMs = DEATH_CLAW_CLAWMARK_DELAY_MS,
    ClawmarkLength = DEATH_CLAW_CLAWMARK_LENGTH,
    ClawmarkWidth = DEATH_CLAW_CLAWMARK_WIDTH,
    ChannelToCastMs = DEATH_CLAW_CHANNEL_TO_CAST_MS,
    CrossSecondDelayMs = DEATH_CLAW_CROSS_SECOND_DELAY_MS,
    SkulkingFirstDelayMs = DEATH_CLAW_SKULKING_FIRST_DELAY_MS,
    SkulkingLaterDelayMs = DEATH_CLAW_SKULKING_LATER_DELAY_MS,
    NewState = newDeathClawState,
    EnsureState = ensureDeathClawState,
    GetConfig = getDeathClawConfig,
    GetRuntimeState = getDeathClawRuntimeState,
    ClearState = clearDeathClawState,
    HandleEntityChannel = handleDeathClawEntityChannel,
    HandleEntityCast = handleDeathClawEntityCast,
    HandleVisibilityChange = handleDeathClawVisibilityChange,
    HandleAOECreate = handleDeathClawAOECreate,
    HandleScriptFunc = handleDeathClawScriptFunc,
    PruneState = pruneDeathClawState,
    RefreshSkulking = refreshDeathClawSkulking,
    Update = updateDeathClaw,
    HasActivity = deathClawHasActivity,
}
end

rawset(_G, 'MuAiOccultCrescentSouthDeathClaw', Module)
return Module
