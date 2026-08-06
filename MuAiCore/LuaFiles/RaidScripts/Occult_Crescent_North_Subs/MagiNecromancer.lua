local Module = {}

function Module.Create(Context)
    assert(type(Context) == 'table' and type(Context.Common) == 'table')
    local Common = Context.Common
    local finite = Context.finite
    local nowMs = Context.nowMs
    local reliablePosition = Context.reliablePosition

local PREDICTION_TOKEN_GRACE_MS = 1000
local VISIBILITY_SEEN_TTL_MS = 60000

local FORMATION_ACTION_ID = 47179
local FORMATION_AOE_ID = 47180
local FORMATION_LENGTH = 70
local FORMATION_WIDTH = 12
local FORMATION_LIFETIME_MS = 16500
local FORMATION_ANCHOR_TOLERANCE = 0.75
local FORMATION_VALIDATION_TOLERANCE = 0.35
local FORMATION_HEADING_TOLERANCE = 0.02

local DEFAULTS = {
    Enable = true,
    DrawRevealPrediction = true,
}

-- The 2026-08-01 and 2026-08-03 map-1346 captures show each selected
-- explorer/pirate becoming visible about five seconds before its channel.
-- OnEntityAdd keeps only stable identity; visibility is the selection signal
-- and starts the bounded live-geometry resolution window.
local REVEAL_SPECS = {
    [14515] = {
        modelID = 19394,
        actionID = 47175,
        kind = 'circle',
        lifetimeMs = 7200,
        radius = 8,
    },
    [14514] = {
        modelID = 19395,
        actionID = 47176,
        kind = 'cross',
        lifetimeMs = 9250,
        length = 80,
        width = 7,
    },
}

-- All captured formations use these three fixed rectangle centers. Headings
-- vary, so the module waits until the hidden helpers actually occupy all three
-- centers, then derives the corresponding OnAOECreate edge for validation.
local FORMATION_ANCHORS = {
    { x = 215.44, z = -855.00 },
    { x = 232.44, z = -855.00 },
    { x = 224.00, z = -870.00 },
}

local function newState()
    return {
        active = {},
        seenVisibility = {},
        revealIDs = {},
        pendingReveals = {},
        helperIDs = {},
        formation = nil,
        lastDiagnostic = nil,
    }
end

local function ensureState(state)
    state = type(state) == 'table' and state or newState()
    state.active = type(state.active) == 'table' and state.active or {}
    state.seenVisibility = type(state.seenVisibility) == 'table'
            and state.seenVisibility or {}
    state.revealIDs = type(state.revealIDs) == 'table'
            and state.revealIDs or {}
    state.pendingReveals = type(state.pendingReveals) == 'table'
            and state.pendingReveals or {}
    state.helperIDs = type(state.helperIDs) == 'table'
            and state.helperIDs or {}
    state.formation = type(state.formation) == 'table'
            and state.formation or nil
    return state
end

local feature = Common.newFeature({
    key = 'MagiNecromancer',
    defaults = DEFAULTS,
    newState = newState,
    ensureState = ensureState,
    diagnosticThrottleMs = 1000,
    diagnosticText = {
        reveal_identity_missing = '魔亡灵法师显形事件缺少实体标识',
        reveal_entity_mismatch = '魔亡灵法师显形实体缓存不匹配',
        reveal_geometry_missing = '魔亡灵法师显形范围缺少可靠几何',
        formation_geometry_missing = '魔亡灵法师魔法阵缺少完整的早期几何',
        formation_geometry_mismatch = '魔亡灵法师魔法阵预测与实际几何不一致',
        danger_drawer_unavailable = '魔亡灵法师危险范围绘图器不可用',
        danger_drawer_rejected_shape = '魔亡灵法师危险范围绘制失败',
    },
})
local getConfig = feature.GetConfig

local function getState()
    return Common.getRuntimeState(
            'MagiNecromancer', newState, ensureState)
end

local function diagnostic(state, code, now, context)
    feature.Diagnostic(
            state, rawget(_G, 'MuAiGuide'), code, now, context)
end

local function deleteEntry(state, key)
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

local function clearFormation(state)
    state = ensureState(state)
    local formation = state.formation
    if type(formation) ~= 'table' then
        return false
    end
    local changed = false
    for key in pairs(type(formation.keys) == 'table'
            and formation.keys or {})
    do
        changed = deleteEntry(state, key) or changed
    end
    state.formation = nil
    return changed
end

local function clearState(state)
    state = ensureState(state)
    for key in pairs(state.active) do
        deleteEntry(state, key)
    end
    state.active = {}
    state.seenVisibility = {}
    state.revealIDs = {}
    state.pendingReveals = {}
    state.helperIDs = {}
    state.formation = nil
    state.lastDiagnostic = nil
end

local function entitiesByContent(contentID)
    local tensorCore = rawget(_G, 'TensorCore')
    if type(tensorCore) ~= 'table'
            or type(tensorCore.entityList) ~= 'function'
    then
        return nil
    end
    local entities = tensorCore.entityList(
            'contentid=' .. tostring(contentID))
    return type(entities) == 'table' and entities or nil
end

local function resolveTrackedEntity(entityID, contentID)
    local entities = entitiesByContent(contentID)
    if entities == nil then
        return nil
    end
    for _, entity in pairs(entities) do
        if type(entity) == 'table'
                and tonumber(entity.id) == entityID
                and tonumber(entity.contentid) == contentID
                and entity.alive ~= false
        then
            return entity
        end
    end
    return nil
end

local function handleEntityAdd(state, entityID, contentID, now)
    state = ensureState(state)
    contentID = tonumber(contentID)
    if not finite(entityID)
            or not finite(contentID)
            or not finite(now)
            or (REVEAL_SPECS[contentID] == nil and contentID ~= 14512)
    then
        return false
    end
    if REVEAL_SPECS[contentID] ~= nil then
        state.revealIDs[entityID] = contentID
    else
        state.helperIDs[entityID] = true
    end
    return true
end

local function entityModelID(entityID, entity)
    return Common.entityModelID(entity or entityID)
end

local function drawPrediction(drawer, spec, position, timeout)
    if spec.kind == 'circle'
            and type(drawer.addTimedCircle) == 'function'
    then
        return drawer:addTimedCircle(
                timeout,
                position.x, position.y, position.z,
                spec.radius)
    end
    if spec.kind == 'cross'
            and type(drawer.addTimedCross) == 'function'
    then
        return drawer:addTimedCross(
                timeout,
                position.x, position.y, position.z,
                spec.length, spec.width, position.h)
    end
    return nil
end

local function completeReveal(state, entityID, now)
    local pending = state.pendingReveals[entityID]
    if type(pending) ~= 'table' then
        return false
    end
    local spec = REVEAL_SPECS[pending.contentID]
    local entity = spec ~= nil
            and resolveTrackedEntity(entityID, pending.contentID) or nil
    local modelID = entityModelID(entityID, entity)
    local position = type(entity) == 'table' and spec ~= nil
            and reliablePosition(entity.pos, spec.kind == 'cross') or nil
    if type(entity) ~= 'table'
            or not finite(modelID)
            or position == nil
    then
        if now < pending.expiresAt then
            return false
        end
        state.pendingReveals[entityID] = nil
        diagnostic(state, 'reveal_geometry_missing', now, {
            entityID = entityID,
            contentID = pending.contentID,
        })
        return false
    end
    if modelID ~= spec.modelID then
        state.pendingReveals[entityID] = nil
        diagnostic(state, 'reveal_entity_mismatch', now, {
            entityID = entityID,
            contentID = pending.contentID,
            modelID = modelID,
        })
        return false
    end
    local remaining = math.floor(pending.expiresAt - now + 0.5)
    if remaining <= 0 then
        state.pendingReveals[entityID] = nil
        diagnostic(state, 'reveal_geometry_missing', now, entityID)
        return false
    end
    local drawer = Common.getMoogleDrawer()
    if drawer == nil then
        state.pendingReveals[entityID] = nil
        diagnostic(state, 'danger_drawer_unavailable', now, pending.contentID)
        return false
    end
    local token = drawPrediction(drawer, spec, position, remaining)
    state.pendingReveals[entityID] = nil
    if type(token) ~= 'string' then
        diagnostic(state, 'danger_drawer_rejected_shape', now, {
            entityID = entityID,
            contentID = pending.contentID,
            kind = spec.kind,
        })
        return false
    end
    local key = tostring(entityID) .. ':reveal'
    state.seenVisibility[key] = pending.startedAt
    state.active[key] = {
        token = token,
        kind = 'reveal',
        entityID = entityID,
        contentID = pending.contentID,
        actionID = spec.actionID,
        expiresAt = pending.expiresAt + PREDICTION_TOKEN_GRACE_MS,
    }
    state.lastDiagnostic = nil
    return true
end

local function processPendingReveals(state, now)
    local changed = false
    for entityID in pairs(state.pendingReveals) do
        changed = completeReveal(state, entityID, now) or changed
    end
    return changed
end

local function handleVisibilityChange(
        state,
        entityID,
        wasVisible,
        isVisible,
        now)
    state = ensureState(state)
    if wasVisible ~= false or isVisible ~= true then
        return false
    end
    if not finite(entityID) or entityID <= 0 or not finite(now) then
        diagnostic(state, 'reveal_identity_missing', nowMs(), entityID)
        return false
    end
    local announcedContentID = state.revealIDs[entityID]
    if REVEAL_SPECS[announcedContentID] == nil then
        return false
    end
    local key = tostring(entityID) .. ':reveal'
    local seenAt = state.seenVisibility[key]
    if finite(seenAt) and now - seenAt <= VISIBILITY_SEEN_TTL_MS then
        return false
    end
    if state.pendingReveals[entityID] ~= nil then
        return false
    end
    state.pendingReveals[entityID] = {
        contentID = announcedContentID,
        startedAt = now,
        expiresAt = now + REVEAL_SPECS[announcedContentID].lifetimeMs,
    }
    return completeReveal(state, entityID, now)
end

local function beginFormation(state, now)
    clearFormation(state)
    state.formation = {
        expiresAt = now + FORMATION_LIFETIME_MS,
        keys = {},
        predicted = {},
        drawn = false,
    }
    return true
end

local function matchFormationAnchor(position, used)
    local toleranceSquared = FORMATION_ANCHOR_TOLERANCE
            * FORMATION_ANCHOR_TOLERANCE
    for index, anchor in ipairs(FORMATION_ANCHORS) do
        if used[index] ~= true then
            local dx = position.x - anchor.x
            local dz = position.z - anchor.z
            if dx * dx + dz * dz <= toleranceSquared then
                return index
            end
        end
    end
    return nil
end

local function tableCount(values)
    local count = 0
    for _ in pairs(values) do
        count = count + 1
    end
    return count
end

local function collectFormationGeometry(state)
    local usedAnchors = {}
    local geometry = {}
    local entities = entitiesByContent(14512)
    if entities == nil then
        return nil
    end
    for _, entity in pairs(entities) do
        local entityID = type(entity) == 'table'
                and tonumber(entity.id) or nil
        if finite(entityID)
                and state.helperIDs[entityID] == true
                and tonumber(entity.contentid) == 14512
                and entityModelID(entityID, entity) == 9020
                and entity.alive ~= false
        then
            local position = reliablePosition(entity.pos, true)
            local anchorIndex = position ~= nil
                    and matchFormationAnchor(position, usedAnchors) or nil
            if anchorIndex ~= nil then
                usedAnchors[anchorIndex] = true
                local aoeX = position.x
                        - math.sin(position.h) * FORMATION_LENGTH / 2
                local aoeZ = position.z
                        - math.cos(position.h) * FORMATION_LENGTH / 2
                geometry[#geometry + 1] = {
                    entityID = entityID,
                    anchorIndex = anchorIndex,
                    x = position.x,
                    y = position.y,
                    z = position.z,
                    aoeX = aoeX,
                    aoeZ = aoeZ,
                    heading = position.h,
                }
            end
        end
    end
    if #geometry ~= #FORMATION_ANCHORS then
        return nil
    end
    table.sort(geometry, function(left, right)
        return left.anchorIndex < right.anchorIndex
    end)
    return geometry
end

local function drawFormation(state, now, reportMissing)
    local formation = state.formation
    if type(formation) ~= 'table' or formation.drawn == true then
        return false
    end
    local geometry = collectFormationGeometry(state)
    if geometry == nil then
        if reportMissing == true then
            diagnostic(state, 'formation_geometry_missing', now, {
                helperCount = tableCount(state.helperIDs),
            })
        end
        return false
    end
    local remaining = math.floor(formation.expiresAt - now + 0.5)
    if remaining <= 0 then
        return false
    end
    local drawer = Common.getMoogleDrawer()
    if drawer == nil or type(drawer.addTimedCenteredRect) ~= 'function' then
        diagnostic(state, 'danger_drawer_unavailable', now, FORMATION_AOE_ID)
        return false
    end
    local created = {}
    for _, rectangle in ipairs(geometry) do
        local token = drawer:addTimedCenteredRect(
                remaining,
                rectangle.x, rectangle.y, rectangle.z,
                FORMATION_LENGTH, FORMATION_WIDTH,
                rectangle.heading)
        if type(token) ~= 'string' then
            for _, createdToken in ipairs(created) do
                Common.deleteTimedShape(createdToken)
            end
            diagnostic(state, 'danger_drawer_rejected_shape', now, {
                actionID = FORMATION_AOE_ID,
                entityID = rectangle.entityID,
                kind = 'centeredRect',
            })
            return false
        end
        created[#created + 1] = token
        rectangle.token = token
    end
    for _, rectangle in ipairs(geometry) do
        local key = tostring(rectangle.entityID) .. ':formation'
        state.active[key] = {
            token = rectangle.token,
            kind = 'formation',
            entityID = rectangle.entityID,
            actionID = FORMATION_AOE_ID,
            expiresAt = formation.expiresAt + PREDICTION_TOKEN_GRACE_MS,
        }
        formation.keys[key] = true
        formation.predicted[rectangle.entityID] = rectangle
    end
    formation.drawn = true
    state.lastDiagnostic = nil
    return true
end

local function handleRevealActionResolve(state, entityID, actionID)
    if not finite(entityID) or not finite(actionID) then
        return false
    end
    local key = tostring(entityID) .. ':reveal'
    local pending = state.pendingReveals[entityID]
    local pendingSpec = type(pending) == 'table'
            and REVEAL_SPECS[pending.contentID] or nil
    local removedPending = false
    if pendingSpec ~= nil and pendingSpec.actionID == actionID then
        state.pendingReveals[entityID] = nil
        removedPending = true
    end
    local entry = state.active[key]
    if type(entry) ~= 'table' or entry.actionID ~= actionID then
        return removedPending
    end
    return deleteEntry(state, key)
end

local function closeEnough(actual, expected, tolerance)
    return finite(actual) and finite(expected)
            and math.abs(actual - expected) <= tolerance
end

local function headingDistance(left, right)
    if not finite(left) or not finite(right) then
        return math.huge
    end
    local difference = math.abs((left - right) % (math.pi * 2))
    return difference > math.pi
            and math.pi * 2 - difference or difference
end

local function handleFormationAOE(state, aoeInfo, now)
    if type(aoeInfo) ~= 'table'
            or tonumber(aoeInfo.aoeID) ~= FORMATION_AOE_ID
    then
        return false
    end
    local formation = state.formation
    if type(formation) ~= 'table' or formation.drawn ~= true then
        return false
    end
    local entityID = tonumber(aoeInfo.entityID)
    local predicted = type(formation.predicted) == 'table'
            and formation.predicted[entityID] or nil
    local effectInfo = aoeInfo.aoeEffectInfo
    local matches = type(predicted) == 'table'
            and tonumber(aoeInfo.contentID) == 14512
            and tonumber(aoeInfo.aoeCastType) == 12
            and tonumber(aoeInfo.aoeLength) == FORMATION_LENGTH
            and tonumber(aoeInfo.aoeWidth) == FORMATION_WIDTH
            and type(effectInfo) == 'table'
            and effectInfo.aoeEffectName == 'general02f'
            and closeEnough(aoeInfo.x, predicted.aoeX,
                    FORMATION_VALIDATION_TOLERANCE)
            and closeEnough(aoeInfo.y, predicted.y,
                    FORMATION_VALIDATION_TOLERANCE)
            and closeEnough(aoeInfo.z, predicted.aoeZ,
                    FORMATION_VALIDATION_TOLERANCE)
            and headingDistance(aoeInfo.heading, predicted.heading)
                    <= FORMATION_HEADING_TOLERANCE
    if not matches then
        diagnostic(state, 'formation_geometry_mismatch', now, {
            entityID = entityID,
            x = aoeInfo.x,
            y = aoeInfo.y,
            z = aoeInfo.z,
            heading = aoeInfo.heading,
            length = aoeInfo.aoeLength,
            width = aoeInfo.aoeWidth,
        })
        clearFormation(state)
        return false
    end
    state.lastDiagnostic = nil
    return true
end

local function pruneState(state, now)
    state = ensureState(state)
    if not finite(now) then
        return false
    end
    local changed = processPendingReveals(state, now)
    changed = drawFormation(state, now, false) or changed
    if type(state.formation) == 'table'
            and now > state.formation.expiresAt
                    + PREDICTION_TOKEN_GRACE_MS
    then
        changed = clearFormation(state) or changed
    end
    for key, entry in pairs(state.active) do
        if entry.kind ~= 'formation'
                and (not finite(entry.expiresAt) or now > entry.expiresAt)
        then
            deleteEntry(state, key)
            changed = true
        end
    end
    Common.pruneSeen(
            state.seenVisibility, now, VISIBILITY_SEEN_TTL_MS)
    return changed
end

local Feature = {}

Feature.Init = function(M)
    if type(M.MagiNecromancer) == 'table' then
        clearState(M.MagiNecromancer)
    end
    M.MagiNecromancer = newState()
    getConfig(M)
    M.SetMagiNecromancerEnabled = function(enabled)
        local cfg = getConfig(M)
        if cfg ~= nil then
            cfg.Enable = enabled == true
        end
        if enabled ~= true then
            clearState(M.MagiNecromancer)
        end
    end
    M.SetMagiNecromancerPredictionEnabled = function(enabled)
        local cfg = getConfig(M)
        if cfg ~= nil then
            cfg.DrawRevealPrediction = enabled == true
        end
        if enabled ~= true then
            clearState(M.MagiNecromancer)
        end
    end
end

Feature.Clear = function()
    local state = getState()
    if state ~= nil then
        clearState(state)
    end
end

Feature.OnEntityAdd = function(entityID, contentID, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state ~= nil
            and cfg ~= nil
            and cfg.Enable == true
            and cfg.DrawRevealPrediction == true
    then
        return handleEntityAdd(state, entityID, contentID, now)
    end
    return false
end

Feature.OnVisibilityChange = function(
        entityID, wasVisible, isVisible, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state ~= nil
            and cfg ~= nil
            and cfg.Enable == true
            and cfg.DrawRevealPrediction == true
    then
        return handleVisibilityChange(
                state, entityID, wasVisible, isVisible, now)
    end
    return false
end

Feature.OnEntityChannel = function(entityID, actionID, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = getConfig(guide)
    local state = getState()
    if state == nil
            or cfg == nil
            or cfg.Enable ~= true
            or cfg.DrawRevealPrediction ~= true
    then
        return false
    end
    if actionID == FORMATION_ACTION_ID and finite(now) then
        return beginFormation(state, now)
    end
    if actionID == FORMATION_AOE_ID and finite(now) then
        return drawFormation(state, now, true)
    end
    return false
end

Feature.OnEntityCast = function(entityID, actionID)
    local state = getState()
    if state == nil then
        return false
    end
    if actionID == FORMATION_AOE_ID then
        return clearFormation(state)
    end
    return handleRevealActionResolve(state, entityID, actionID)
end

Feature.OnAOECreate = function(aoeInfo, now)
    local state = getState()
    return state ~= nil
            and handleFormationAOE(state, aoeInfo, now) or false
end

Feature.Update = function(guide, now)
    local state = getState()
    if state == nil then
        return false
    end
    local cfg = getConfig(guide)
    if cfg ~= nil
            and cfg.Enable == true
            and cfg.DrawRevealPrediction == true
    then
        return pruneState(state, now)
    end
    clearState(state)
    return false
end

Feature.Test = {
    Defaults = DEFAULTS,
    RevealSpecs = REVEAL_SPECS,
    FormationAnchors = FORMATION_ANCHORS,
    FormationActionID = FORMATION_ACTION_ID,
    FormationAOEID = FORMATION_AOE_ID,
    FormationLength = FORMATION_LENGTH,
    FormationWidth = FORMATION_WIDTH,
    FormationLifetimeMs = FORMATION_LIFETIME_MS,
    NewState = newState,
    EnsureState = ensureState,
    GetConfig = getConfig,
    HandleEntityAdd = handleEntityAdd,
    HandleVisibilityChange = handleVisibilityChange,
    CompleteReveal = completeReveal,
    BeginFormation = beginFormation,
    CollectFormationGeometry = collectFormationGeometry,
    DrawFormation = drawFormation,
    HandleFormationAOE = handleFormationAOE,
    HandleRevealActionResolve = handleRevealActionResolve,
    PruneState = pruneState,
    ClearState = clearState,
}

return Feature
end

rawset(_G, 'MuAiOccultCrescentNorthMagiNecromancer', Module)
return Module
