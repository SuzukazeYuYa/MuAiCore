local Common = {}

function Common.finite(value)
    return type(value) == 'number'
            and value == value
            and value > -math.huge
            and value < math.huge
end

function Common.validXZ(pos)
    return type(pos) == 'table'
            and Common.finite(pos.x)
            and Common.finite(pos.z)
end

function Common.copyPosition(pos, requireNonZeroY, fallbackY)
    if not Common.validXZ(pos) then
        return nil
    end
    local y = Common.finite(pos.y) and pos.y or fallbackY
    if not Common.finite(y) or (requireNonZeroY and y == 0) then
        return nil
    end
    return { x = pos.x, y = y, z = pos.z }
end

function Common.distanceSquared(left, right)
    if not Common.validXZ(left) or not Common.validXZ(right) then
        return nil
    end
    local dx = left.x - right.x
    local dz = left.z - right.z
    return dx * dx + dz * dz
end

function Common.normalized(dx, dz)
    if not Common.finite(dx) or not Common.finite(dz) then
        return nil
    end
    local length = math.sqrt(dx * dx + dz * dz)
    if length < 0.0001 then
        return nil
    end
    return dx / length, dz / length
end

function Common.headingDifference(left, right)
    if not Common.finite(left) or not Common.finite(right) then
        return nil
    end
    local difference = (left - right + math.pi) % (2 * math.pi) - math.pi
    return math.abs(difference)
end

function Common.insideCircle(pos, center, radius)
    if not Common.finite(radius) or radius < 0 then
        return false
    end
    local distance = Common.distanceSquared(pos, center)
    return distance ~= nil and distance <= radius * radius
end

function Common.pointInDanger(point, danger, margin)
    if not Common.validXZ(point)
            or type(danger) ~= 'table'
            or not Common.validXZ(danger.source)
            or not Common.finite(danger.radius)
    then
        return true
    end
    margin = Common.finite(margin) and margin or 0
    local dx = point.x - danger.source.x
    local dz = point.z - danger.source.z
    local distanceSq = dx * dx + dz * dz
    local outer = math.max(0, danger.radius + margin)
    if danger.kind == 'circle' then
        return distanceSq <= outer * outer
    end
    if danger.kind == 'donut' then
        if not Common.finite(danger.innerRadius) then
            return true
        end
        local inner = math.max(0, danger.innerRadius - margin)
        return distanceSq >= inner * inner and distanceSq <= outer * outer
    end
    if danger.kind == 'rect' then
        if not Common.finite(danger.heading)
                or not Common.finite(danger.length)
                or danger.length < 0
        then
            return true
        end
        local forward = dx * math.sin(danger.heading)
                + dz * math.cos(danger.heading)
        local side = dx * math.cos(danger.heading)
                - dz * math.sin(danger.heading)
        return forward >= -margin
                and forward <= danger.length + margin
                and math.abs(side) <= danger.radius + margin
    end
    if danger.kind ~= 'cone'
            or not Common.finite(danger.heading)
            or not Common.finite(danger.angle)
            or distanceSq > outer * outer
    then
        return danger.kind ~= 'cone'
    end
    if Common.finite(danger.innerRadius) then
        local inner = math.max(0, danger.innerRadius - margin)
        if distanceSq < inner * inner then
            return false
        end
    end
    local length = math.sqrt(distanceSq)
    if length < 0.001 then
        return true
    end
    local dot = (dx * math.sin(danger.heading)
            + dz * math.cos(danger.heading)) / length
    dot = math.max(-1, math.min(1, dot))
    return math.acos(dot) <= danger.angle / 2 + math.rad(1)
end

function Common.safeForGroup(point, group, center, radius, margin)
    if type(group) ~= 'table'
            or not Common.insideCircle(point, center, radius)
    then
        return false
    end
    for _, danger in ipairs(group) do
        if Common.pointInDanger(point, danger, margin) then
            return false
        end
    end
    return true
end

local sampleDirectionCache = {}

local function sampleDirections(count)
    local cached = sampleDirectionCache[count]
    if cached ~= nil then
        return cached
    end
    cached = {}
    for index = 0, count - 1 do
        local angle = 2 * math.pi * index / count
        cached[index + 1] = { x = math.sin(angle), z = math.cos(angle) }
    end
    sampleDirectionCache[count] = cached
    return cached
end

function Common.nearestValidPoint(playerPos, center, radius, options, validator)
    if not Common.validXZ(playerPos)
            or not Common.validXZ(center)
            or not Common.finite(radius)
            or radius <= 0
            or type(validator) ~= 'function'
    then
        return nil
    end
    options = type(options) == 'table' and options or {}
    local step = Common.finite(options.step) and options.step or 1
    local directionCount = Common.finite(options.directionCount)
            and math.floor(options.directionCount) or 72
    if step <= 0 or directionCount < 8 then
        return nil
    end
    local y = playerPos.y
    local best = nil
    local bestDistanceSq = math.huge
    local function consider(candidate)
        if not validator(candidate) then
            return
        end
        local distanceSq = Common.distanceSquared(playerPos, candidate)
        if distanceSq < bestDistanceSq then
            best = candidate
            bestDistanceSq = distanceSq
        end
    end
    consider({ x = playerPos.x, y = y, z = playerPos.z })
    consider({ x = center.x, y = y, z = center.z })
    local directions = sampleDirections(directionCount)
    for sampleRadius = step, radius, step do
        for _, direction in ipairs(directions) do
            consider({
                x = center.x + direction.x * sampleRadius,
                y = y,
                z = center.z + direction.z * sampleRadius,
            })
        end
    end
    return best
end

function Common.nearestSafePoint(playerPos, group, center, radius, options)
    if not Common.validXZ(playerPos)
            or type(group) ~= 'table'
            or not Common.validXZ(center)
            or not Common.finite(radius)
            or radius <= 0
    then
        return nil
    end
    options = type(options) == 'table' and options or {}
    local margin = Common.finite(options.margin) and options.margin or 0.5
    return Common.nearestValidPoint(
            playerPos, center, radius, options, function(candidate)
                return Common.safeForGroup(
                        candidate, group, center, radius, margin)
            end)
end

function Common.projectKnockback(point, source, distance)
    if not Common.validXZ(point)
            or not Common.validXZ(source)
            or not Common.finite(distance)
            or distance < 0
    then
        return nil
    end
    local dx, dz = Common.normalized(
            point.x - source.x, point.z - source.z)
    if dx == nil then
        return nil
    end
    return {
        x = point.x + dx * distance,
        y = point.y,
        z = point.z + dz * distance,
    }
end

function Common.consumeEvent(bucket, key, now, windowMs)
    if type(bucket) ~= 'table'
            or key == nil
            or not Common.finite(now)
            or not Common.finite(windowMs)
    then
        return false
    end
    local previous = bucket[key]
    if Common.finite(previous) and now - previous <= windowMs then
        return false
    end
    bucket[key] = now
    return true
end

function Common.pruneSeen(bucket, now, ttlMs)
    if type(bucket) ~= 'table'
            or not Common.finite(now)
            or not Common.finite(ttlMs)
    then
        return
    end
    for key, seenAt in pairs(bucket) do
        if not Common.finite(seenAt) or now - seenAt > ttlMs then
            bucket[key] = nil
        end
    end
end

function Common.newFaceLock()
    return {
        active = false,
        key = nil,
        heading = nil,
        lockedAt = nil,
        releaseAt = nil,
    }
end

function Common.getFacingAPI()
    local api = type(TensorCore) == 'table'
            and type(TensorCore.API) == 'table'
            and type(TensorCore.API.TensorACR) == 'table'
            and TensorCore.API.TensorACR or nil
    if type(api) ~= 'table'
            or type(api.setLockFaceHeading) ~= 'function'
            or type(api.setHardLockFace) ~= 'function'
            or type(api.toggleLockFace) ~= 'function'
    then
        return nil
    end
    return api
end

function Common.releaseAutoFace(state, key)
    if type(state) ~= 'table' then
        return false
    end
    local lock = type(state.faceLock) == 'table'
            and state.faceLock or Common.newFaceLock()
    state.faceLock = lock
    if lock.active ~= true
            or (key ~= nil and lock.key ~= key)
    then
        return false
    end
    local api = Common.getFacingAPI()
    if api ~= nil then
        api.setHardLockFace(false)
        api.toggleLockFace(false)
    end
    state.faceLock = Common.newFaceLock()
    return true
end

function Common.applyAutoFace(state, key, heading, now, releaseAt)
    if type(state) ~= 'table'
            or key == nil
            or not Common.finite(heading)
            or not Common.finite(now)
            or not Common.finite(releaseAt)
    then
        return false, 'missing_geometry'
    end
    local api = Common.getFacingAPI()
    if api == nil then
        return false, 'facing_api_unavailable'
    end
    local lock = type(state.faceLock) == 'table'
            and state.faceLock or Common.newFaceLock()
    state.faceLock = lock
    if lock.active == true and lock.key ~= key then
        Common.releaseAutoFace(state)
        lock = state.faceLock
    end
    api.setLockFaceHeading(heading)
    if lock.active ~= true then
        api.setHardLockFace(true)
        api.toggleLockFace(true)
        state.faceLock = {
            active = true,
            key = key,
            heading = heading,
            lockedAt = now,
            releaseAt = releaseAt,
        }
    else
        lock.heading = heading
        lock.releaseAt = releaseAt
    end
    return true
end

function Common.getConfig(guide, key, defaults)
    guide = guide or rawget(_G, 'MuAiGuide')
    local main = type(guide) == 'table'
            and type(guide.Config) == 'table'
            and guide.Config.Main or nil
    if type(main) ~= 'table' then
        return nil
    end
    local cfg = main[key]
    if type(cfg) ~= 'table' then
        if type(defaults) ~= 'table' then
            return nil
        end
        cfg = {}
        main[key] = cfg
    end
    if type(defaults) == 'table' then
        for field, value in pairs(defaults) do
            if cfg[field] == nil then
                cfg[field] = value
            end
        end
    end
    return cfg
end

function Common.getRuntimeState(key, newState, ensureState)
    local guide = rawget(_G, 'MuAiGuide')
    if type(guide) ~= 'table' then
        return nil
    end
    if type(guide[key]) ~= 'table' then
        guide[key] = newState()
    end
    return ensureState(guide[key])
end

function Common.newFeature(spec)
    assert(type(spec) == 'table' and type(spec.key) == 'string')
    assert(type(spec.newState) == 'function')
    assert(type(spec.ensureState) == 'function')
    local feature = {}

    function feature.GetConfig(guide)
        return Common.getConfig(guide, spec.configKey or spec.key, spec.defaults)
    end

    function feature.GetRuntimeState()
        return Common.getRuntimeState(spec.key, spec.newState, spec.ensureState)
    end

    function feature.Diagnostic(state, guide, code, now, context)
        if type(state) ~= 'table' or not Common.finite(now) then
            return false
        end
        local previous = state.lastDiagnostic
        local throttleMs = spec.diagnosticThrottleMs or 1000
        if type(previous) == 'table'
                and previous.code == code
                and Common.finite(previous.at)
                and now - previous.at <= throttleMs
        then
            return false
        end
        state.lastDiagnostic = { code = code, at = now, context = context }
        if type(guide) == 'table' and type(guide.LogOnce) == 'function' then
            local text = type(spec.diagnosticText) == 'table'
                    and spec.diagnosticText[code] or nil
            guide.LogOnce(spec.logKey or spec.key, code, text or code, context)
        end
        return true
    end

    function feature.Consume(bucket, key, now)
        return Common.consumeEvent(bucket, key, now, spec.dedupeMs or 0)
    end

    function feature.PruneSeen(bucket, now)
        return Common.pruneSeen(bucket, now, spec.seenTtlMs or 0)
    end

    return feature
end

function Common.deleteTimedShape(token)
    if type(token) == 'string'
            and type(Argus) == 'table'
            and type(Argus.deleteTimedShape) == 'function'
    then
        Argus.deleteTimedShape(token)
    end
end

function Common.getMoogleTable(name, create)
    local moogle = rawget(_G, 'MoogleTelegraphs')
    if type(moogle) ~= 'table' or type(moogle.Settings) ~= 'table' then
        return nil
    end
    local target = moogle.Settings[name]
    if type(target) ~= 'table' and create == true then
        target = {}
        moogle.Settings[name] = target
    end
    return type(target) == 'table' and target or nil
end

function Common.getMoogleDrawer(allowUserdata)
    if type(TensorCore) ~= 'table'
            or type(TensorCore.getMoogleDrawer) ~= 'function'
    then
        return nil
    end
    local drawer = TensorCore.getMoogleDrawer()
    local drawerType = type(drawer)
    if drawerType == 'table'
            or (allowUserdata == true and drawerType == 'userdata')
    then
        return drawer
    end
    return nil
end

local function resetOwnership(bucket)
    bucket.registered = false
    bucket.owned = {}
    bucket.previous = {}
    bucket.previousKnown = {}
end

function Common.newMoogleDonutRegistry(spec)
    assert(type(spec) == 'table' and type(spec.entries) == 'table')
    assert(type(spec.source) == 'string')
    local registry = {}

    local function getBucket(state)
        local bucket = type(spec.getBucket) == 'function'
                and spec.getBucket(state) or state
        if type(bucket) ~= 'table' then
            return nil
        end
        bucket.registered = bucket.registered == true
        bucket.owned = type(bucket.owned) == 'table' and bucket.owned or {}
        bucket.previous = type(bucket.previous) == 'table'
                and bucket.previous or {}
        bucket.previousKnown = type(bucket.previousKnown) == 'table'
                and bucket.previousKnown or {}
        return bucket
    end

    local function owns(bucket, aoeID, current)
        return current == bucket.owned[aoeID]
                or (type(current) == 'table' and current.source == spec.source)
    end

    local function make(desired)
        return {
            name = desired.name,
            radius = desired.radius,
            source = spec.source,
        }
    end

    local function register(state)
        if type(spec.ensureState) == 'function' then
            spec.ensureState(state)
        end
        local bucket = getBucket(state)
        local donuts = Common.getMoogleTable('aoeIDUserSetDonuts', true)
        if bucket == nil or donuts == nil then
            if bucket ~= nil then
                bucket.registered = false
            end
            return false
        end
        for aoeID, desired in pairs(spec.entries) do
            local current = donuts[aoeID]
            if owns(bucket, aoeID, current) then
                if type(current) ~= 'table'
                        or current.radius ~= desired.radius
                        or current.name ~= desired.name
                then
                    local owned = make(desired)
                    donuts[aoeID] = owned
                    bucket.owned[aoeID] = owned
                end
            elseif type(current) == 'table' and current.radius == desired.radius then
                bucket.owned[aoeID] = nil
            elseif not bucket.previousKnown[aoeID] then
                bucket.previousKnown[aoeID] = true
                bucket.previous[aoeID] = current
                local owned = make(desired)
                donuts[aoeID] = owned
                bucket.owned[aoeID] = owned
            else
                bucket.owned[aoeID] = nil
            end
        end
        bucket.registered = true
        return true
    end

    local function unregister(state)
        if type(spec.ensureState) == 'function' then
            spec.ensureState(state)
        end
        local bucket = getBucket(state)
        local donuts = Common.getMoogleTable('aoeIDUserSetDonuts', false)
        if bucket == nil or donuts == nil then
            if bucket ~= nil then
                bucket.registered = false
            end
            return false
        end
        for aoeID in pairs(spec.entries) do
            local current = donuts[aoeID]
            if owns(bucket, aoeID, current) then
                if bucket.previousKnown[aoeID] then
                    donuts[aoeID] = bucket.previous[aoeID]
                else
                    donuts[aoeID] = nil
                end
            end
        end
        resetOwnership(bucket)
        return true
    end

    function registry.Apply(state, enabled)
        if enabled == true then
            return register(state)
        end
        return unregister(state)
    end

    return registry
end

rawset(_G, 'MuAiOccultCrescentCommon', Common)
return Common
