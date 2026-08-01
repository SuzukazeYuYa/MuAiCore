local Module = {}

function Module.Create(Context)
    assert(type(Context) == 'table' and type(Context.Common) == 'table')
    local Common = Context.Common
    local nowMs = Context.nowMs
    local finite = Context.finite
    local reliablePosition = Context.reliablePosition
    local resolveEntity = Context.resolveEntity
    local MAP_ID = Context.MapID
local WarlikeMinotaur = {
    MapID = MAP_ID,
    ContentID = 14735,
    AID = {
        EightfoldSweep = 47600,
        EightfoldSweepOmen = 47601,
        EightfoldSweepDamage1 = 47602,
        EightfoldSweepDamage2 = 47603,
        EightfoldSweepDamage3 = 47604,
        EightfoldSweepDamage4 = 47605,
    },
    ConeRange = 40,
    ConeAngle = math.pi / 2,
    PreviewMs = 3000,
    Pattern = { 0, 1, 2, 3, 1, 2, 3, 0 },
    OmenIntervalMinMs = 750,
    OmenIntervalMaxMs = 1250,
    PredictedFirstOffsetMs = 550,
    ActualFirstDelayMs = 250,
    ActualIntervalMs = 2100,
    HeadingTolerance = math.rad(6),
    ActivationToleranceMs = 350,
    SourceToleranceSq = 1,
    RoundGraceMs = 2000,
    BossMissingMs = 2000,
    Defaults = {
        Enable = true,
        DrawEightfoldSweepPrediction = true,
    },
}

function WarlikeMinotaur.GetConfig(guide)
    return Common.getConfig(
            guide, 'WarlikeMinotaur', WarlikeMinotaur.Defaults)
end

function WarlikeMinotaur.NewState()
    return {
        round = nil,
        bossMissingSince = nil,
        lastDiagnostic = nil,
    }
end

function WarlikeMinotaur.EnsureState(state)
    state = type(state) == 'table' and state or WarlikeMinotaur.NewState()
    state.bossMissingSince = finite(state.bossMissingSince)
            and state.bossMissingSince or nil
    return state
end

function WarlikeMinotaur.GetState()
    return Common.getRuntimeState(
            'WarlikeMinotaur', WarlikeMinotaur.NewState,
            WarlikeMinotaur.EnsureState)
end

function WarlikeMinotaur.ClearPrediction(entry)
    if type(entry) == 'table' then
        Common.deleteTimedShape(entry.token)
        entry.token = nil
    end
end

function WarlikeMinotaur.ClearRound(state)
    if type(state) ~= 'table' then
        return
    end
    local predictions = type(state.round) == 'table'
            and state.round.predictions or nil
    if type(predictions) == 'table' then
        for _, entry in pairs(predictions) do
            WarlikeMinotaur.ClearPrediction(entry)
        end
    end
    state.round = nil
    state.bossMissingSince = nil
end

function WarlikeMinotaur.ClearState(state)
    if type(state) ~= 'table' then
        return
    end
    WarlikeMinotaur.ClearRound(state)
    state.lastDiagnostic = nil
end

function WarlikeMinotaur.Diagnose(state, code, context, now)
    state.lastDiagnostic = {
        code = code,
        context = context,
        at = now,
    }
end

function WarlikeMinotaur.Suppress(state, code, context, now)
    local round = type(state) == 'table' and state.round or nil
    if type(round) ~= 'table' then
        return false
    end
    if round.suppressed ~= true then
        for _, entry in pairs(round.predictions or {}) do
            WarlikeMinotaur.ClearPrediction(entry)
        end
    end
    round.suppressed = true
    WarlikeMinotaur.Diagnose(state, code, context, now)
    return false
end

function WarlikeMinotaur.ResolveEntity(entityID)
    if not finite(entityID)
            or type(TensorCore) ~= 'table'
            or type(TensorCore.mGetEntity) ~= 'function'
    then
        return nil
    end
    local entity = TensorCore.mGetEntity(entityID)
    if type(entity) ~= 'table'
            or entity.id ~= entityID
            or entity.contentid ~= WarlikeMinotaur.ContentID
    then
        return nil
    end
    return entity
end

function WarlikeMinotaur.StartRound(
        state, entityID, spellID, channelTimeMax, now)
    state = WarlikeMinotaur.EnsureState(state)
    if spellID ~= WarlikeMinotaur.AID.EightfoldSweep
            or not finite(now)
            or not finite(channelTimeMax)
            or channelTimeMax < 9.2
            or channelTimeMax > 10.2
            or WarlikeMinotaur.ResolveEntity(entityID) == nil
    then
        return false
    end
    local active = state.round
    if type(active) == 'table'
            and active.bossEntityID == entityID
            and math.abs(active.startedAt - now) <= 250
    then
        return false
    end
    WarlikeMinotaur.ClearRound(state)
    state.round = {
        bossEntityID = entityID,
        startedAt = now,
        activationAt = now + channelTimeMax * 1000,
        expiresAt = now + channelTimeMax * 1000
                + WarlikeMinotaur.PredictedFirstOffsetMs
                + 7 * WarlikeMinotaur.ActualIntervalMs
                + WarlikeMinotaur.RoundGraceMs,
        observed = {},
        seenAOEs = {},
        predictions = {},
        nextIndex = 1,
        visualResolved = false,
        suppressed = false,
    }
    return true
end

function WarlikeMinotaur.NormalizeHeading(heading)
    return (heading + math.pi) % (2 * math.pi) - math.pi
end

function WarlikeMinotaur.SchedulePrediction(entry, now)
    if type(entry) ~= 'table'
            or not finite(now)
            or entry.resolved
            or entry.token ~= nil
            or type(TensorCore) ~= 'table'
            or type(TensorCore.getMoogleDrawer) ~= 'function'
    then
        return false
    end
    local remaining = entry.activationAt - now
    if remaining <= 0 then
        return false
    end
    local drawer = TensorCore.getMoogleDrawer()
    if type(drawer) ~= 'table'
            or type(drawer.addTimedCone) ~= 'function'
    then
        return false
    end
    local visible = math.min(WarlikeMinotaur.PreviewMs, remaining)
    local delay = math.max(0, remaining - visible)
    local token = drawer:addTimedCone(
            visible,
            entry.source.x,
            entry.source.y,
            entry.source.z,
            WarlikeMinotaur.ConeRange,
            WarlikeMinotaur.ConeAngle,
            entry.heading,
            delay)
    if type(token) == 'string' then
        entry.token = token
        return true
    end
    return false
end

function WarlikeMinotaur.InferRound(state, now)
    local round = state.round
    if type(round) ~= 'table'
            or round.suppressed
            or #round.observed ~= 2
    then
        return false
    end
    local first = round.observed[1]
    local second = round.observed[2]
    local omenInterval = second.activationAt - first.activationAt
    local sourceDistance = Common.distanceSquared(first.source, second.source)
    local delta = WarlikeMinotaur.NormalizeHeading(
            second.heading - first.heading)
    if omenInterval < WarlikeMinotaur.OmenIntervalMinMs
            or omenInterval > WarlikeMinotaur.OmenIntervalMaxMs
            or sourceDistance == nil
            or sourceDistance > WarlikeMinotaur.SourceToleranceSq
            or math.abs(math.abs(delta) - math.pi / 2)
                    > WarlikeMinotaur.HeadingTolerance
    then
        return WarlikeMinotaur.Suppress(state, 'sequence_not_predictable', {
            interval = omenInterval,
            sourceDistance = sourceDistance,
            headingDelta = delta,
        }, now)
    end
    local step = delta > 0 and math.pi / 2 or -math.pi / 2
    round.omenInterval = omenInterval
    round.step = step
    local firstActualAt = round.actualBaseAt
            or round.activationAt + WarlikeMinotaur.PredictedFirstOffsetMs
    for index = 1, 8 do
        local entry = {
            index = index,
            source = {
                x = first.source.x,
                y = first.source.y,
                z = first.source.z,
            },
            heading = WarlikeMinotaur.NormalizeHeading(
                    first.heading
                    + WarlikeMinotaur.Pattern[index] * step),
            omenActivationAt = first.activationAt
                    + (index - 1) * omenInterval,
            activationAt = firstActualAt
                    + (index - 1) * WarlikeMinotaur.ActualIntervalMs,
            resolved = false,
        }
        round.predictions[index] = entry
    end
    WarlikeMinotaur.SchedulePrediction(round.predictions[1], now)
    return true
end

function WarlikeMinotaur.ScheduleCurrent(state, now)
    local round = type(state) == 'table' and state.round or nil
    if type(round) ~= 'table' or round.suppressed then
        return false
    end
    return WarlikeMinotaur.SchedulePrediction(
            round.predictions[round.nextIndex], now)
end

function WarlikeMinotaur.ReadAOE(aoeInfo)
    if type(aoeInfo) ~= 'table'
            or aoeInfo.aoeID ~= WarlikeMinotaur.AID.EightfoldSweepOmen
            or aoeInfo.contentID ~= WarlikeMinotaur.ContentID
            or not finite(aoeInfo.entityID)
            or not finite(aoeInfo.startTime)
            or not finite(aoeInfo.duration)
            or aoeInfo.duration < 0.4
            or aoeInfo.duration > 1.1
            or not finite(aoeInfo.x)
            or not finite(aoeInfo.y)
            or aoeInfo.y == 0
            or not finite(aoeInfo.z)
            or not finite(aoeInfo.heading)
            or not finite(aoeInfo.aoeLength)
            or math.abs(aoeInfo.aoeLength
                    - WarlikeMinotaur.ConeRange) > 1
    then
        return nil
    end
    return {
        entityID = aoeInfo.entityID,
        startTime = aoeInfo.startTime,
        activationAt = aoeInfo.startTime + aoeInfo.duration * 1000,
        source = { x = aoeInfo.x, y = aoeInfo.y, z = aoeInfo.z },
        heading = WarlikeMinotaur.NormalizeHeading(aoeInfo.heading),
    }
end

function WarlikeMinotaur.SameAOE(left, right)
    return type(left) == 'table'
            and type(right) == 'table'
            and left.entityID == right.entityID
            and math.abs(left.startTime - right.startTime) <= 1
            and Common.distanceSquared(left.source, right.source) <= 0.01
            and Common.headingDifference(left.heading, right.heading) <= 0.01
end

function WarlikeMinotaur.AddAOE(state, aoeInfo, now)
    if type(aoeInfo) ~= 'table'
            or aoeInfo.aoeID ~= WarlikeMinotaur.AID.EightfoldSweepOmen
    then
        return false
    end
    local round = type(state) == 'table' and state.round or nil
    if type(round) ~= 'table' or round.suppressed then
        return false
    end
    local observed = WarlikeMinotaur.ReadAOE(aoeInfo)
    if observed == nil then
        return WarlikeMinotaur.Suppress(
                state, 'aoe_missing_geometry', nil, now)
    end
    local key = tostring(observed.entityID)
            .. ':' .. string.format('%.1f', observed.startTime)
    local duplicate = round.seenAOEs[key]
    if duplicate ~= nil then
        if WarlikeMinotaur.SameAOE(duplicate, observed) then
            return false
        end
        return WarlikeMinotaur.Suppress(state, 'aoe_identity_conflict', {
            key = key,
        }, now)
    end
    round.seenAOEs[key] = observed
    local index = #round.observed + 1
    if index > 8 then
        return WarlikeMinotaur.Suppress(
                state, 'too_many_sweeps', { entityID = observed.entityID }, now)
    end
    observed.index = index
    round.observed[index] = observed
    if index == 2 then
        return WarlikeMinotaur.InferRound(state, now)
    end
    if index >= 3 then
        local predicted = round.predictions[index]
        local sourceDistance = type(predicted) == 'table'
                and Common.distanceSquared(predicted.source, observed.source)
                or nil
        if type(predicted) ~= 'table'
                or sourceDistance == nil
                or sourceDistance > WarlikeMinotaur.SourceToleranceSq
                or Common.headingDifference(
                        predicted.heading, observed.heading)
                        > WarlikeMinotaur.HeadingTolerance
                or math.abs(predicted.omenActivationAt - observed.activationAt)
                        > WarlikeMinotaur.ActivationToleranceMs
        then
            return WarlikeMinotaur.Suppress(state, 'prediction_mismatch', {
                index = index,
                entityID = observed.entityID,
            }, now)
        end
    end
    return true
end

function WarlikeMinotaur.IsActualDamage(spellID)
    return spellID == WarlikeMinotaur.AID.EightfoldSweepDamage1
            or spellID == WarlikeMinotaur.AID.EightfoldSweepDamage2
            or spellID == WarlikeMinotaur.AID.EightfoldSweepDamage3
            or spellID == WarlikeMinotaur.AID.EightfoldSweepDamage4
end

function WarlikeMinotaur.ResolveCast(state, entityID, spellID, now)
    local round = type(state) == 'table' and state.round or nil
    if type(round) ~= 'table' then
        return false
    end
    if round.suppressed then
        return false
    end
    if spellID == WarlikeMinotaur.AID.EightfoldSweep then
        if entityID ~= round.bossEntityID then
            return WarlikeMinotaur.Suppress(state, 'boss_cast_conflict', {
                expected = round.bossEntityID,
                actual = entityID,
            }, now)
        end
        if round.visualResolved then
            return false
        end
        if not finite(now) then
            return WarlikeMinotaur.Suppress(
                    state, 'boss_cast_missing_time', nil, now)
        end
        round.visualResolved = true
        round.visualResolvedAt = now
        round.actualBaseAt = now + WarlikeMinotaur.ActualFirstDelayMs
        for index, prediction in ipairs(round.predictions) do
            local correctedAt = round.actualBaseAt
                    + (index - 1) * WarlikeMinotaur.ActualIntervalMs
            if prediction.token ~= nil
                    and math.abs(prediction.activationAt - correctedAt)
                            > WarlikeMinotaur.ActivationToleranceMs
            then
                WarlikeMinotaur.ClearPrediction(prediction)
            end
            prediction.activationAt = correctedAt
        end
        round.expiresAt = round.actualBaseAt
                + 7 * WarlikeMinotaur.ActualIntervalMs
                + WarlikeMinotaur.RoundGraceMs
        WarlikeMinotaur.ScheduleCurrent(state, now)
        return true
    end
    if not WarlikeMinotaur.IsActualDamage(spellID) then
        return false
    end
    if entityID ~= round.bossEntityID or not finite(now) then
        return WarlikeMinotaur.Suppress(state, 'damage_source_conflict', {
            expectedEntityID = round.bossEntityID,
            actualEntityID = entityID,
            spellID = spellID,
        }, now)
    end
    local boss = WarlikeMinotaur.ResolveEntity(entityID)
    local heading = type(boss) == 'table'
            and type(boss.pos) == 'table' and boss.pos.h or nil
    if not finite(heading) or not round.visualResolved then
        return WarlikeMinotaur.Suppress(state, 'damage_missing_geometry', {
            entityID = entityID,
            spellID = spellID,
            visualResolved = round.visualResolved,
        }, now)
    end
    heading = WarlikeMinotaur.NormalizeHeading(heading)
    local last = round.lastDamage
    if type(last) == 'table'
            and last.entityID == entityID
            and last.spellID == spellID
            and now - last.at <= 350
            and Common.headingDifference(last.heading, heading) <= 0.01
    then
        return false
    end
    local current = round.predictions[round.nextIndex]
    if type(current) ~= 'table'
            or Common.headingDifference(current.heading, heading)
                    > WarlikeMinotaur.HeadingTolerance
    then
        return WarlikeMinotaur.Suppress(state, 'damage_prediction_mismatch', {
            index = round.nextIndex,
            expectedHeading = type(current) == 'table'
                    and current.heading or nil,
            actualHeading = heading,
            spellID = spellID,
        }, now)
    end
    round.lastDamage = {
        entityID = entityID,
        spellID = spellID,
        heading = heading,
        at = now,
    }
    WarlikeMinotaur.ClearPrediction(current)
    current.resolved = true
    round.nextIndex = round.nextIndex + 1
    if round.nextIndex > 8 then
        WarlikeMinotaur.ClearRound(state)
        return true
    end
    for index = round.nextIndex, 8 do
        local prediction = round.predictions[index]
        WarlikeMinotaur.ClearPrediction(prediction)
        prediction.activationAt = now
                + (index - round.nextIndex + 1)
                        * WarlikeMinotaur.ActualIntervalMs
    end
    round.expiresAt = now
            + (9 - round.nextIndex) * WarlikeMinotaur.ActualIntervalMs
            + WarlikeMinotaur.RoundGraceMs
    WarlikeMinotaur.ScheduleCurrent(state, now)
    return true
end

function WarlikeMinotaur.PruneState(state, now)
    local round = type(state) == 'table' and state.round or nil
    if type(round) ~= 'table' then
        return false
    end
    if now > round.expiresAt then
        WarlikeMinotaur.ClearRound(state)
        return true
    end
    local boss = WarlikeMinotaur.ResolveEntity(round.bossEntityID)
    if boss ~= nil and boss.alive ~= false then
        state.bossMissingSince = nil
        WarlikeMinotaur.ScheduleCurrent(state, now)
        return false
    end
    state.bossMissingSince = state.bossMissingSince or now
    if now - state.bossMissingSince >= WarlikeMinotaur.BossMissingMs then
        WarlikeMinotaur.ClearRound(state)
        return true
    end
    return false
end

local Feature = {}

Feature.Init = function(M)
    if type(M.WarlikeMinotaur) == 'table' then
        WarlikeMinotaur.ClearState(M.WarlikeMinotaur)
    end
    M.WarlikeMinotaur = WarlikeMinotaur.NewState()
    WarlikeMinotaur.GetConfig(M)
    M.SetWarlikeMinotaurEnabled = function(enabled)
        local cfg = WarlikeMinotaur.GetConfig(M)
        if cfg ~= nil then
            cfg.Enable = enabled == true
        end
        if enabled ~= true then
            WarlikeMinotaur.ClearState(M.WarlikeMinotaur)
        end
    end
    M.SetWarlikeMinotaurPredictionEnabled = function(enabled)
        local cfg = WarlikeMinotaur.GetConfig(M)
        if cfg ~= nil then
            cfg.DrawEightfoldSweepPrediction = enabled == true
        end
        if enabled ~= true then
            WarlikeMinotaur.ClearRound(
                    WarlikeMinotaur.EnsureState(M.WarlikeMinotaur))
        end
    end
end

Feature.Clear = function()
    local state = WarlikeMinotaur.GetState()
    if state ~= nil then
        WarlikeMinotaur.ClearState(state)
    end
end

Feature.OnEntityChannel = function(entityID, spellID, channelTimeMax, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = WarlikeMinotaur.GetConfig(guide)
    local state = WarlikeMinotaur.GetState()
    if state ~= nil and cfg ~= nil and cfg.Enable == true
            and cfg.DrawEightfoldSweepPrediction == true
    then
        WarlikeMinotaur.StartRound(
                state, entityID, spellID, channelTimeMax, now)
    end
end

Feature.OnEntityCast = function(entityID, spellID, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = WarlikeMinotaur.GetConfig(guide)
    local state = WarlikeMinotaur.GetState()
    if state ~= nil and cfg ~= nil and cfg.Enable == true
            and cfg.DrawEightfoldSweepPrediction == true
    then
        WarlikeMinotaur.ResolveCast(state, entityID, spellID, now)
    end
end

Feature.OnAOECreate = function(aoeInfo, now)
    local guide = rawget(_G, 'MuAiGuide')
    local cfg = WarlikeMinotaur.GetConfig(guide)
    local state = WarlikeMinotaur.GetState()
    if state ~= nil and cfg ~= nil and cfg.Enable == true
            and cfg.DrawEightfoldSweepPrediction == true
    then
        WarlikeMinotaur.AddAOE(state, aoeInfo, now)
    end
end

Feature.Update = function(guide, now)
    local state = WarlikeMinotaur.GetState()
    if state == nil then
        return false
    end
    local cfg = WarlikeMinotaur.GetConfig(guide)
    if cfg ~= nil and cfg.Enable == true then
        return WarlikeMinotaur.PruneState(state, now)
    end
    WarlikeMinotaur.ClearState(state)
    return false
end

Feature.Test = WarlikeMinotaur

    return Feature
end

rawset(_G, 'MuAiOccultCrescentNorthWarlikeMinotaur', Module)
return Module
