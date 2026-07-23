local Dmu_P5 = {}
Dmu_P5.StateName = "P5"
---@type DancingMad
local DM
---@type MuAiGuide
local MG

-- OnEntityChannel 到实际结算存在帧级抖动，按实战日志上界保留余量。
local chaosVortexDrawDuration = 5200

local Cfg = function()
    return MG.Config.DmuCfg.P5
end

local Data = function()
    if MG.DancingMad == nil then
        return nil
    end
    return MG.DancingMad.P5
end

local groundFireGuideEnabled = function()
    if Data().DisChannel ~= 0 then
        return Cfg().guide and Cfg().groundFireGuide
                and TimeSince(Data().DisChannel) < chaosVortexDrawDuration - 2000
    end
    return Cfg().guide and Cfg().groundFireGuide
end

local floodPos = {
    { x = 100, y = 0, z = 98 }, --A
    { x = 102, y = 0, z = 100 }, --B
    { x = 100, y = 0, z = 102 }, --C
    { x = 98, y = 0, z = 100 }, --D
}

local invincibleIds = {
    82,
    1836,
    409,
    811,
    3255,
}

local blueBuffId = 5351 -- 顺手加一个神圣
local redBuffId = 5350 -- 顺手加一个核爆
local fireBuffId = 2902
local iceBuffId = 2903
local thunderBuffId = 2998

-- 究极站位
local ultimaRepeater = {
    MT = { x = 100, y = 0, z = 92 },
    ST = { x = 100, y = 0, z = 92 },
    H1 = { x = 94.34, y = 0, z = 105.66 },
    H2 = { x = 94.34, y = 0, z = 105.66 },
    D1 = { x = 105.66, y = 0, z = 105.66 },
    D2 = { x = 105.66, y = 0, z = 105.66 },
    D3 = { x = 105.66, y = 0, z = 105.66 },
    D4 = { x = 105.66, y = 0, z = 105.66 },
}

local getBoss = function()
    if Data().Kefka ~= nil then
        return
    end
    for _, ent in pairs(TensorCore.entityList("contentid=7131")) do
        local model = Argus.getEntityModel(ent.id)
        if model == 19511 and Argus.isEntityVisible(ent) then
            Data().Kefka = ent
            break
        end
    end
end

-- 判断某点是否在AOE范围内
local inBlood = function(aoe, point)
    local halfWidth = 5
    local dx = point.x - aoe.x
    local dz = point.z - aoe.z
    -- 垂直长条中心线的单位向量
    local perpX = math.sin(aoe.heading)
    local perpZ = -math.cos(aoe.heading)
    -- 点到中心线垂直距离
    local dist = dx * perpX + dz * perpZ
    return math.abs(dist) <= halfWidth
end

local drawCurBlood = function(index1, index2)
    DM.redDrawer:addRect(Data().Blood.Aoe[index1].x, MG.drawerY, Data().Blood.Aoe[index1].z, 40, 10, Data().Blood.Aoe[index1].heading)
    DM.redDrawer:addRect(Data().Blood.AoeOut[index1].x, MG.drawerY, Data().Blood.AoeOut[index1].z, 40, 10, Data().Blood.AoeOut[index1].heading)
    if index2 ~= nil then
        DM.yellowDrawer:addRect(Data().Blood.Aoe[index2].x, MG.drawerY, Data().Blood.Aoe[index2].z, 40, 10, Data().Blood.Aoe[index2].heading)
        DM.yellowDrawer:addRect(Data().Blood.AoeOut[index2].x, MG.drawerY, Data().Blood.AoeOut[index2].z, 40, 10, Data().Blood.AoeOut[index2].heading)
    end
end

local setDataAndGuide = function(index, pos)
    if Data().Blood.GuideData[index] == nil then
        Data().Blood.GuideData[index] = {}
        for job, _ in pairs(MG.Party) do
            Data().Blood.GuideData[index][job] = pos
        end
    else
        MG.FrameMultiD(Data().Blood.GuideData[index])
    end
end

local sortTableByClock = function(tbl)
    if table.size(tbl) == 3 then
        table.sort(tbl, function(a, b)
            return MG.GetClock(a.pos, b.pos)
        end)
    end
end

-- 踩塔指路
local loadGuidePosAndNextStart = function()
    if not Cfg().guide then
        return
    end
    local wave = Data().Celestriad.wave
    if Data().Celestriad.GuideData[wave] == nil or table.size(Data().Celestriad.GuideData[wave]) < 8 then
        Data().Celestriad.GuideData[wave] = {}
        local casting = Data().Celestriad.CastingTowers[wave]
        if table.size(casting) < 4 then
            return
        end
        local buffGroupPos = Data().Celestriad.groupBuffPos[wave]
        --记录哪些塔已经有人了
        if Data().Celestriad.Guiding[wave] == nil then
            Data().Celestriad.Guiding[wave] = {}
        end
        if wave < 3 and Data().Celestriad.groupBuffPos[wave + 1] == nil then
            Data().Celestriad.groupBuffPos[wave + 1] = {}
        end
        for job, pos in pairs(buffGroupPos) do
            local curDir = TensorCore.getHeadingToTarget(DM.Center, pos)
            local guideTower, nextStart
            if guideTower == nil then
                -- 先找到自己踩塔去哪
                local cnt = 0
                for i = 1, 9 do
                    local breakFlag
                    --顺时针开始找下一个激活的塔
                    local newHeading = curDir - math.pi * 2 / 9 * i
                    for towerId, towerInfo in pairs(casting) do
                        local castingDir = TensorCore.getHeadingToTarget(DM.Center, towerInfo.Obj.pos)
                        if MG.IsSameDirection(newHeading, castingDir, 0.1) then
                            guideTower = towerInfo
                            cnt = cnt + 1
                            Data().Celestriad.GuideData[wave][job] = towerInfo.Obj.pos
                            if not table.contains(Data().Celestriad.Guiding[wave], towerId) then
                                table.insert(Data().Celestriad.Guiding[wave], towerId)
                            end
                            breakFlag = true
                            break
                        end
                    end
                    if breakFlag then
                        break
                    end
                end
            end
            if guideTower ~= nil and wave < 3 then
                -- 缓存下一波查找起始点
                if guideTower.Obj.contentid == 2015294 then
                    nextStart = Data().Celestriad.TowerFire[3]
                elseif guideTower.Obj.contentid == 2015295 then
                    nextStart = Data().Celestriad.TowerIce[3]
                elseif guideTower.Obj.contentid == 2015296 then
                    nextStart = Data().Celestriad.TowerThunder[3]
                end
                Data().Celestriad.groupBuffPos[wave + 1][job] = nextStart.pos
            end
        end
        for towerId, towerInfo in pairs(casting) do
            if not table.contains(Data().Celestriad.Guiding[wave], towerId) then
                for _, job in pairs(Data().Celestriad.groupNoBuff) do
                    Data().Celestriad.GuideData[wave][job] = towerInfo.Obj.pos
                end
                break
            end
        end
    end
    if Data().Celestriad.GuideData[wave] ~= nil and table.size(Data().Celestriad.GuideData[wave]) > 0 then
        if Data().Celestriad.CatastrophicChoiceId == 0 then
            MG.FrameMultiD(Data().Celestriad.GuideData[wave])
        elseif Data().Celestriad.CatastrophicChoiceId == 49742 then
            if Data().Celestriad.GuideDataOut[wave] == nil then
                Data().Celestriad.GuideDataOut[wave] = {}
                for job, pos in pairs(Data().Celestriad.GuideData[wave]) do
                    Data().Celestriad.GuideDataOut[wave][job] = MG.GetPointAtDistance(DM.Center, pos, 11)
                end
            else
                MG.FrameMultiD(Data().Celestriad.GuideDataOut[wave])
            end
        elseif Data().Celestriad.CatastrophicChoiceId == 49743 then
            if Data().Celestriad.GuideDataIn[wave] == nil then
                Data().Celestriad.GuideDataIn[wave] = {}
                for job, pos in pairs(Data().Celestriad.GuideData[wave]) do
                    Data().Celestriad.GuideDataIn[wave][job] = MG.GetPointAtDistance(DM.Center, pos, 8)
                end
            else
                MG.FrameMultiD(Data().Celestriad.GuideDataIn[wave])
            end
        end
    end
end

local groundFireStep = math.sqrt(50)
local groundFireGroupWindow = 200
local groundFireCastMatchDistanceSq = 0.25 * 0.25

-- 地火状态分两层：Lines 记录日志还原出的真实七连爆炸，Guides 为八个职能分别保存两步法路线。
-- 攻略两步法以每名玩家所在的 3x3 小格为基准；左右列表示该小格会被哪一列地火扫过。
local groundFireGuidePos = {
    MT = { left = 3, right = 3, x = 100, z = 100 },
    ST = { left = 3, right = 3, x = 100, z = 100 },
    D1 = { left = 3, right = 3, x = 100, z = 100 },
    D2 = { left = 3, right = 3, x = 100, z = 100 },
    D3 = { left = 4, right = 2, x = 100, z = 90 },
    D4 = { left = 2, right = 4, x = 100, z = 110 },
    H1 = { left = 2, right = 2, x = 90, z = 100 },
    H2 = { left = 4, right = 4, x = 110, z = 100 },
}

local groundFireGuideRoles = { 'MT', 'ST', 'H1', 'H2', 'D1', 'D2', 'D3', 'D4' }

local newGroundFireGuide = function(job)
    local pos = groundFireGuidePos[job]
    return {
        left = pos.left,
        right = pos.right,
        x = pos.x,
        z = pos.z,
        Seen = {},
        Rels = {},
        Points = {},
        Hits = {},
        PointTriggers = {},
        CurrentPointIndex = nil,
    }
end

local newGroundFireGuides = function()
    local guides = {}
    for _, job in ipairs(groundFireGuideRoles) do
        guides[job] = newGroundFireGuide(job)
    end
    return guides
end

local resetGroundFire = function()
    Data().GroundFire = {
        Info = {},
        Lines = {},
        PendingByEntity = {},
        SeenStarts = {},
        LineCount = 0,
        GroupCount = 0,
        LastGroupAt = nil,
        Guides = newGroundFireGuides(),
        GuideEnabled = nil,
    }
end

local groundFireState = function()
    local state = Data().GroundFire
    if state == nil or state.Lines == nil then
        resetGroundFire()
        state = Data().GroundFire
    end
    state.Info = state.Info or {}
    state.Lines = state.Lines or {}
    state.PendingByEntity = state.PendingByEntity or {}
    state.SeenStarts = state.SeenStarts or {}
    state.LineCount = state.LineCount or 0
    state.GroupCount = state.GroupCount or 0
    state.Guides = state.Guides or newGroundFireGuides()
    return state
end

local groundFireGuideActive = function()
    local state = groundFireState()
    local enabled = groundFireGuideEnabled()
    if state.GuideEnabled ~= enabled then
        state.GuideEnabled = enabled
        state.Guides = newGroundFireGuides()
    end
    return enabled
end

local groundFireGuideState = function(job)
    return groundFireState().Guides[job]
end

local groundFireDirFromPair = function(a, b)
    if a == 1 and b == 1 then
        return 3
    end
    if a == 1 and b == 2 then
        return 0
    end
    if a == 2 and b == 1 then
        return 2
    end
    if a == 2 and b == 2 then
        return 1
    end
end

local groundFireCardinalPoints = function(x, z, dir4, clockwise)
    if dir4 == 0 then
        return { { x = x, y = 0, z = z - 5 }, clockwise and { x = x + 5, y = 0, z = z } or { x = x - 5, y = 0, z = z }, { x = x, y = 0, z = z + 5 } }
    elseif dir4 == 1 then
        return { { x = x - 5, y = 0, z = z }, clockwise and { x = x, y = 0, z = z - 5 } or { x = x, y = 0, z = z + 5 }, { x = x + 5, y = 0, z = z } }
    elseif dir4 == 2 then
        return { { x = x, y = 0, z = z + 5 }, clockwise and { x = x - 5, y = 0, z = z } or { x = x + 5, y = 0, z = z }, { x = x, y = 0, z = z - 5 } }
    end
    return { { x = x + 5, y = 0, z = z }, clockwise and { x = x, y = 0, z = z + 5 } or { x = x, y = 0, z = z - 5 }, { x = x - 5, y = 0, z = z } }
end

local groundFireDiagonalPoint = function(x, z, dirN4)
    local dx = (dirN4 == 0 or dirN4 == 1) and -2.5 or 2.5
    local dz = (dirN4 == 0 or dirN4 == 3) and -2.5 or 2.5
    return { x = x + dx, y = 0, z = z + dz }
end

local groundFirePointInHit = function(point, hit)
    local dx = point.x - hit.x
    local dz = point.z - hit.z
    return dx * dx + dz * dz < hit.radius * hit.radius
end

local updateGroundFirePointTriggers = function(state)
    -- 路线点只有在覆盖它的最后一枚地火结算后才前移，避免仅按固定时间提前换点。
    local nextOrder
    state.PointTriggers = {}
    for i = #state.Points, 1, -1 do
        local triggerOrder
        for _, hit in ipairs(state.Hits) do
            if (nextOrder == nil or hit.order < nextOrder)
                    and groundFirePointInHit(state.Points[i], hit)
                    and (triggerOrder == nil or hit.order > triggerOrder)
            then
                triggerOrder = hit.order
            end
        end
        state.PointTriggers[i] = triggerOrder or 0
        nextOrder = state.PointTriggers[i]
    end
end

local groundFireTriggerResolved = function(state, pointIndex)
    local triggerOrder = state.PointTriggers[pointIndex]
    if triggerOrder == nil then
        return false
    elseif triggerOrder == 0 then
        return true
    end
    local found = false
    for _, hit in ipairs(state.Hits) do
        if hit.order == triggerOrder and groundFirePointInHit(state.Points[pointIndex], hit) then
            found = true
            if not hit.resolved then
                return false
            end
        end
    end
    return found
end

local updateGroundFireCurrentPoint = function(state)
    local pointIndex
    for i = 1, #state.Points do
        if not groundFireTriggerResolved(state, i) then
            break
        end
        pointIndex = i
    end
    state.CurrentPointIndex = pointIndex
end

local setGroundFireGuideRoute = function(state, points)
    state.Points = points
    updateGroundFirePointTriggers(state)
    updateGroundFireCurrentPoint(state)
end

local appendGroundFireGuideRoute = function(state, points)
    for _, point in ipairs(points) do
        table.insert(state.Points, point)
    end
    updateGroundFirePointTriggers(state)
    updateGroundFireCurrentPoint(state)
end

local tryBuildGroundFireRoute = function(state)
    local r = state.Rels
    local relCount = #r
    local isRel = function(rel)
        return rel == 1 or rel == 2
    end
    local buildFull = function(dir4, clockwise)
        if dir4 == nil or state.Done then
            return
        end
        state.Done = true
        setGroundFireGuideRoute(state, groundFireCardinalPoints(state.x, state.z, dir4, clockwise))
    end

    -- 信息未收齐时先给第一步斜角；收齐 14/25/36 的相对列关系后再补完整路线。
    if relCount <= 3 and isRel(r[relCount]) and not state.InitialDone then
        local dirN4 = relCount == 2 and (r[relCount] == 1 and 2 or 0) or (r[relCount] == 1 and 3 or 1)
        state.InitialDone = true
        setGroundFireGuideRoute(state, { groundFireDiagonalPoint(state.x, state.z, dirN4) })
    end

    if relCount == 2 then
        if isRel(r[1]) and isRel(r[2]) then
            buildFull(groundFireDirFromPair(r[1], r[2]), r[1] == r[2])
        elseif isRel(r[1]) and r[2] == 0 and not state.HalfDone then
            local dirN4 = r[1] == 1 and 3 or 1
            state.HalfDone = true
            setGroundFireGuideRoute(state, {
                groundFireDiagonalPoint(state.x, state.z, dirN4),
                groundFireDiagonalPoint(state.x, state.z, (dirN4 + 2) % 4),
            })
        end
    elseif relCount == 3 and r[1] == 0 and isRel(r[2]) and isRel(r[3]) then
        buildFull(groundFireDirFromPair(r[3], r[2]), r[2] ~= r[3])
    elseif relCount == 4 then
        if r[1] == 0 and r[2] == 0 and isRel(r[3]) and isRel(r[4]) then
            buildFull(groundFireDirFromPair(r[3], r[4]), r[3] == r[4])
        elseif isRel(r[1]) and r[2] == 0 and isRel(r[4]) and not state.Done then
            local points = groundFireCardinalPoints(state.x, state.z,
                    groundFireDirFromPair(r[1], r[4]), r[1] == r[4])
            state.Done = true
            appendGroundFireGuideRoute(state, { points[2], points[3] })
        end
    end
end

local recordGroundFireGuideLineForState = function(state, line)
    if state.Seen[line.id] then
        return
    end
    state.Seen[line.id] = true
    for step = 0, 6 do
        local pos = line.pos[step + 1]
        table.insert(state.Hits, {
            lineID = line.id,
            step = step,
            order = line.group * 10 + step,
            x = pos.x,
            z = pos.z,
            radius = line.radius,
            resolved = false,
        })
    end
    updateGroundFirePointTriggers(state)
    updateGroundFireCurrentPoint(state)

    -- 每组两条平行线只取靠 3x3 小格一侧的一条做 14/25/36 判定；另一条仍参与真实范围计算。
    local col = (math.floor(((line.pos[1].x - 70) / 5) + 0.5) % 7) + 1
    if col > 3 then
        return
    end
    local candidateCol = line.pos[1].x < 100 and state.left or state.right
    table.insert(state.Rels, (col + 1 - candidateCol) % 3)
    tryBuildGroundFireRoute(state)
end

local recordGroundFireGuideLine = function(line)
    if not groundFireGuideActive() then
        return
    end
    for _, job in ipairs(groundFireGuideRoles) do
        recordGroundFireGuideLineForState(groundFireGuideState(job), line)
    end
end

---@param aoeInfo DirectionalAOE
local startGroundFire = function(aoeInfo)
    if not Cfg().draw and not groundFireGuideActive() then
        return
    end
    local state = groundFireState()
    local startKey = tostring(aoeInfo.entityID)
            .. ':' .. tostring(math.floor(aoeInfo.x * 100 + 0.5))
            .. ':' .. tostring(math.floor(aoeInfo.z * 100 + 0.5))
            .. ':' .. tostring(math.floor(aoeInfo.heading * 10000 + 0.5))
    if state.SeenStarts[startKey] then
        return
    end
    state.SeenStarts[startKey] = true
    -- 同一批两条平行线在日志中几乎同时出现，按 200ms 窗口归为同一组。
    local now = Now()
    if state.LastGroupAt == nil or now - state.LastGroupAt > groundFireGroupWindow then
        state.GroupCount = state.GroupCount + 1
        state.LastGroupAt = now
    end
    state.LineCount = state.LineCount + 1
    local line = {
        id = state.LineCount,
        entityID = aoeInfo.entityID,
        group = state.GroupCount,
        radius = tonumber(aoeInfo.aoeLength) or 6,
        pos = {},
        resolvedStep = 0,
        active = false,
    }
    for step = 0, 6 do
        line.pos[step + 1] = {
            x = aoeInfo.x + math.sin(aoeInfo.heading) * groundFireStep * step,
            y = 0,
            z = aoeInfo.z + math.cos(aoeInfo.heading) * groundFireStep * step,
        }
    end
    table.insert(state.Lines, line)
    state.PendingByEntity[line.entityID] = line
    recordGroundFireGuideLine(line)
end

local groundFireCastPosition = function(entityID, castPos)
    if type(castPos) == 'table' and castPos.x ~= nil and castPos.z ~= nil then
        return castPos
    end
    local entity = TensorCore.mGetEntity(entityID)
    if entity ~= nil and entity.pos ~= nil and entity.pos.x ~= nil and entity.pos.z ~= nil then
        return entity.pos
    end
end

local findGroundFireLineForStep = function(pos)
    if pos == nil then
        return nil, nil
    end
    -- 后续爆炸按实测施法坐标匹配预计算轨迹，并优先较早组，防止并行线路串线。
    local bestLine, bestIndex, bestDistanceSq
    for _, line in ipairs(groundFireState().Lines) do
        local index = line.resolvedStep + 1
        local target = line.pos[index]
        if line.active and target ~= nil then
            local dx = target.x - pos.x
            local dz = target.z - pos.z
            local distanceSq = dx * dx + dz * dz
            if distanceSq <= groundFireCastMatchDistanceSq
                    and (bestDistanceSq == nil
                    or line.group < bestLine.group
                    or line.group == bestLine.group and distanceSq < bestDistanceSq
                    or line.group == bestLine.group and distanceSq == bestDistanceSq and line.id < bestLine.id)
            then
                bestLine = line
                bestIndex = index
                bestDistanceSq = distanceSq
            end
        end
    end
    return bestLine, bestIndex
end

local markGroundFireGuideResolvedForState = function(state, line, resolvedIndex)
    for _, hit in ipairs(state.Hits) do
        if hit.lineID == line.id and hit.step <= resolvedIndex - 1 then
            hit.resolved = true
        end
    end
    updateGroundFirePointTriggers(state)
    updateGroundFireCurrentPoint(state)
end

local markGroundFireGuideResolved = function(line, resolvedIndex)
    if not groundFireGuideActive() then
        return
    end
    for _, job in ipairs(groundFireGuideRoles) do
        markGroundFireGuideResolvedForState(groundFireGuideState(job), line, resolvedIndex)
    end
end

local castGroundFire = function(entityID, spellID, castPos)
    local state = groundFireState()
    local line, resolvedIndex
    if spellID == 47932 then
        line = state.PendingByEntity[entityID]
        resolvedIndex = 1
    else
        line, resolvedIndex = findGroundFireLineForStep(groundFireCastPosition(entityID, castPos))
    end
    if line == nil or resolvedIndex == nil or resolvedIndex <= line.resolvedStep then
        return
    end
    line.resolvedStep = resolvedIndex
    if not line.active then
        line.active = true
        state.PendingByEntity[entityID] = nil
        table.insert(state.Info, line)
    end
    markGroundFireGuideResolved(line, resolvedIndex)
end

local drawingGroundFireGuide = function()
    if not groundFireGuideActive() then
        return
    end
    -- FrameMultiD 按当前玩家职能取点，因此指导者模式与本人模式使用同一份机制状态。
    local guideData = {}
    for _, job in ipairs(groundFireGuideRoles) do
        local state = groundFireGuideState(job)
        local pointIndex = state.CurrentPointIndex
        local point = pointIndex ~= nil and state.Points[pointIndex] or nil
        if point ~= nil then
            guideData[job] = point
        end
    end
    if next(guideData) ~= nil then
        MG.FrameMultiD(guideData, 0.45)
    end
end

local drawingGroudFire = function()
    if not Cfg().draw or Cfg().groundCnt <= 0 then
        return
    end
    local drawers = { DM.redDrawer, DM.orangeDrawer, DM.yellowDrawer, DM.cyanDrawer, DM.greenDrawer }
    for _, line in ipairs(groundFireState().Info) do
        for offset = 0, Cfg().groundCnt - 1 do
            local pos = line.pos[line.resolvedStep + offset + 1]
            if pos ~= nil then
                local drawer = drawers[math.min(offset + 1, #drawers)]
                drawer:addCircle(pos.x, MG.drawerY, pos.z, line.radius)
            end
        end
    end
end

local drawBloodArrow = function(wave)
    if not Cfg().draw
            or DM.OverState('P5Blood3End')
            or DM.BeLowState('P5BloodStart') then
        return
    end
    local data = Data().Blood.drawData
    if data.first == nil
            and Data().Blood.Cross34 ~= nil
            and Data().Blood.Cross14 ~= nil
    then
        local dir = TensorCore.getHeadingToTarget(Data().Blood.Cross34, Data().Blood.Cross14)
        local length = TensorCore.getDistance2d(Data().Blood.Cross34, Data().Blood.Cross14)
        local startPoint = TensorCore.getPosInDirection(Data().Blood.Cross34, dir, 0.55)
        data.first = {
            h = dir,
            l = length,
            p = startPoint
        }
    end
    if data.second == nil
            and Data().Blood.Cross14 ~= nil
            and Data().Blood.Cross12 ~= nil
    then
        local dir = TensorCore.getHeadingToTarget(Data().Blood.Cross14, Data().Blood.Cross12)
        local length = TensorCore.getDistance2d(Data().Blood.Cross14, Data().Blood.Cross12)
        local startPoint = TensorCore.getPosInDirection(Data().Blood.Cross14, dir, 0.55)
        data.second = {
            h = dir,
            l = length,
            p = startPoint
        }
    end
    if data.first ~= nil and data.second then
        if wave < 3 then
            MG.CreateDrawer(0, 1, 0, 1, 1):addArrow(data.first.p.x, 0, data.first.p.z, data.first.h, data.first.l - 1.3, 0.1, 0.3, 0.2, true)
            MG.CreateDrawer(0, 1, 0, 1, 1):addArrow(data.second.p.x, 0, data.second.p.z, data.second.h, data.second.l - 1.3, 0.1, 0.3, 0.2, true)
        else
            MG.CreateDrawer(0, 1, 0, 1, 1):addArrow(data.second.p.x, 0, data.second.p.z, data.second.h, data.second.l - 1.3, 0.1, 0.3, 0.2, true)
        end
    end
end

--------------------------------------------- event function ---------------------------------------------
--- 初始化
--- @param dm DancingMad
--- @param m MuAiGuide
Dmu_P5.Init = function(dm, m)
    DM = dm
    MG = m
end

Dmu_P5.OnEntityChannel = function(entityID, spellID, _)
    if spellID == 47936 then
        if Data().Kefka == nil then
            local boss = TensorCore.mGetEntity(entityID)
            Data().Kefka = boss
        end
        if DM.InState('P5CelestriadEnd') then
            DM.ChangeState('P5UltimaRepeater3')
        end
    elseif spellID == 49471 then
        -- 洪水
        if DM.BeLowState('P5BloodStart') then
            DM.ChangeState('P5BloodStart')
        end
    elseif spellID == 47952 then
        --癫狂交响曲
        if DM.BeLowState('P5MaddeningOrchestra') then
            DM.ChangeState('P5MaddeningOrchestra')
        end
        if DM.InState('P5GroundFire') then
            Data().MaddeningOrchestra = {
                FirstHitTimer = 0,
                FirstHits = {},
                Guide1 = nil,
                Guide2 = nil,
                Guide3 = nil,
                GuideOut = nil,
                RedBuff = nil,
                BlueBuff = nil,
            }
            DM.ChangeState('P5MaddeningOrchestra2')
        end
    elseif spellID == 47938 then
        -- 三星
        if DM.BeLowState('P5CelestriadPre') then
            DM.ChangeState('P5CelestriadPre')
            --终止对3平A站位指路
        end
    elseif spellID == 49742 or spellID == 49743 then
        Data().Celestriad.CatastrophicChoiceId = spellID
    elseif spellID == 47931 then
        if DM.BeLowState('P5GroundFire') then
            DM.ChangeState('P5GroundFire')
        end
    elseif spellID == 47934 or spellID == 47935 then
        for _, member in pairs(MG.Party) do
            if ArgusDrawsPlus ~= nil and ArgusDrawsPlus.getEnabled() then
                MG.CreateDrawer(0.3, 0, 0.3, 0.1, 2, -1):addTimedCircleOnEnt(chaosVortexDrawDuration, member.id, 5)
            else
                MG.CreateDrawer(1, 0, 1, 0.1, 2, -1):addTimedCircleOnEnt(chaosVortexDrawDuration, member.id, 5)
            end
        end
        Data().DisChannel = Now()
    elseif spellID == 47925 then
        DM.ChangeState('P5Forsaken')
    elseif spellID == 47930 then
        --遗弃末点（狂暴）
        DM.ChangeState('P5BeforeEnd')
    end
end

Dmu_P5.OnEntityCast = function(entityID, spellID, castPos)
    if spellID == 47951 then
        if DM.OverState('P5BloodStart', true)
                and DM.BeLowState('P5Blood3End', true) then
            DM.GoNextSate()
        end
    elseif spellID == 47938 then
        if DM.BeLowState('P5Celestriad') then
            DM.ChangeState('P5Celestriad')
        end
    elseif spellID == 49742 or spellID == 49743 then
        Data().Celestriad.CatastrophicChoiceId = 0
    elseif spellID == 47932 or spellID == 47933 then
        castGroundFire(entityID, spellID, castPos)
    elseif spellID == 47934 or spellID == 47935 then
        resetGroundFire()
    elseif spellID == 47927 then
        table.insert(Data().Forsaken.hasCast, entityID)
    end
end

Dmu_P5.OnAOECreate = function(aoeInfo)
    -- 洪水
    if aoeInfo.aoeID == 49539 then
        -- 锁定场中的4条
        if aoeInfo.x > 105 and aoeInfo.x < 120 or aoeInfo.x < 95 and aoeInfo.x > 80 then
            table.insert(Data().Blood.Aoe, aoeInfo)
        else
            -- 外部，画图用
            table.insert(Data().Blood.AoeOut, aoeInfo)
        end
    elseif aoeInfo.aoeID == 47932 then
        startGroundFire(aoeInfo)
    elseif aoeInfo.aoeID == 47927 then
        table.insert(Data().Forsaken.AoeInfos, aoeInfo)
    elseif aoeInfo.aoeID == 47928 then
        --软狂暴脚下出现黄圈
        Data().Forsaken.wave = Data().Forsaken.wave + 1
    end
end

local tryCommitCelestriadWave = function()
    local cache = Data().Celestriad.castingCache
    for entityID, entry in pairs(cache) do
        if entry.dir == nil then
            local obj = TensorCore.mGetEntity(entityID)
            if obj ~= nil and obj.pos ~= nil then
                if obj.contentid == nil or obj.contentid < 2015294 or obj.contentid > 2015296 then
                    cache[entityID] = nil
                else
                    entry.Obj = obj
                    entry.dir = TensorCore.getHeadingToTarget(DM.Center, obj.pos)
                end
            end
        end
    end
    if table.size(cache) ~= 4 then
        return
    end
    for _, entry in pairs(cache) do
        if entry.dir == nil or entry.Obj == nil or entry.Obj.pos == nil then
            return
        end
    end
    Data().Celestriad.wave = Data().Celestriad.wave + 1
    MG.Info('第' .. Data().Celestriad.wave .. '波踩塔。', false, true)
    Data().Celestriad.CastingTowers[Data().Celestriad.wave] = cache
    Data().Celestriad.castingCache = {}
end

Dmu_P5.OnEventObjectScriptFunc = function(entityID, a1, a2, a3)
    if a1 == 16 and a2 == 32 then
        local obj = TensorCore.mGetEntity(entityID)
        if obj == nil or obj.pos == nil
                or (obj.contentid ~= nil
                and 2015294 <= obj.contentid and obj.contentid <= 2015296)
        then
            Data().Celestriad.castingCache[entityID] = {
                dir = obj ~= nil and obj.pos ~= nil
                        and TensorCore.getHeadingToTarget(DM.Center, obj.pos) or nil,
                Obj = obj or { id = entityID },
            }
            tryCommitCelestriadWave()
        end
    elseif a1 == 1 and a2 == 64
            and Data().Celestriad.wave == 3
            and Data().Celestriad.CastingTowers[3] ~= nil
            and Data().Celestriad.CastingTowers[3][entityID] ~= nil
    then
        if DM.BeLowState('P5CelestriadEnd') then
            DM.ChangeState('P5CelestriadEnd')
        end
    end
end
Dmu_P5.Update = function()
    getBoss()
    drawingGroudFire()
    drawingGroundFireGuide()
    tryCommitCelestriadWave()
    if DM.InState('P5Start') --P5UltimaRepeater1
            or DM.InState('P5UltimaRepeater2')
            or DM.InState('P5UltimaRepeater3')
            or DM.InState('P5UltimaRepeater4')
    then
        if Cfg().guide then
            local idx = MG.DancingMad.CurrentState
            if Data().UltimaRepeater[idx] == nil or Data().UltimaRepeater[idx].StIn == nil then
                Data().UltimaRepeater[idx] = {}
                Data().UltimaRepeater[idx].StIn = ultimaRepeater
                Data().UltimaRepeater[idx].curMt = TensorCore.getEntityByGroup("Main Tank", "Nearest")
                if Data().UltimaRepeater[idx].curMt ~= nil then
                    local st, stJob
                    if Data().UltimaRepeater[idx].curMt.id == MG.Party.MT.id then
                        st = MG.Party.ST
                        stJob = 'ST'
                    else
                        st = MG.Party.MT
                        stJob = 'MT'
                    end
                    if st ~= nil then
                        local curGuideData = table.deepcopy(ultimaRepeater)
                        curGuideData[stJob] = { x = 106, y = 0, z = 94 }
                        Data().UltimaRepeater[idx].StOut = curGuideData
                    end
                end
            else
                if Data().UltimaRepeater[idx].curMt ~= nil
                        and Data().UltimaRepeater[idx].StIn ~= nil
                        and Data().UltimaRepeater[idx].StOut ~= nil
                then
                    local mt = Data().UltimaRepeater[idx].curMt
                    local invincible = false
                    for _, id in pairs(invincibleIds) do
                        local buff = TensorCore.getBuff(mt.id, id)
                        if buff ~= nil and buff.duration > 1.5 then
                            invincible = true
                            break
                        end
                    end
                    if invincible then
                        MG.FrameMultiD(Data().UltimaRepeater[idx].StOut)
                    else
                        MG.FrameMultiD(Data().UltimaRepeater[idx].StIn)
                    end
                else
                    MG.FrameMultiD(ultimaRepeater)
                end
            end
        end
    end
    -- 洪水阶段，根据当前获得AOE数据来计算4个交叉点
    -- 移动顺序一定是 34=>14=>12
    if DM.OverState('P5BloodStart', true)
            and DM.BeLowState('P5Blood3End', true)
            and (Data().Blood.Cross12 == nil or Data().Blood.Cross23 == nil)
    then
        if Data().Blood.Cross12 == nil and table.size(Data().Blood.Aoe) >= 2 then
            for _, pos in pairs(floodPos) do
                if inBlood(Data().Blood.Aoe[1], pos)
                        and inBlood(Data().Blood.Aoe[2], pos)
                then
                    Data().Blood.Cross12 = pos
                    break
                end
            end
            if Data().Blood.Cross12 ~= nil then
                local dis = TensorCore.getDistance2d(DM.Center, Data().Blood.Cross12)
                local dir = TensorCore.getHeadingToTarget(DM.Center, Data().Blood.Cross12)
                Data().Blood.Cross34 = TensorCore.getPosInDirection(DM.Center, dir + math.pi, dis)
            end
        end
        if Data().Blood.Cross23 == nil and table.size(Data().Blood.Aoe) >= 3 then
            for _, pos in pairs(floodPos) do
                if inBlood(Data().Blood.Aoe[2], pos)
                        and inBlood(Data().Blood.Aoe[3], pos)
                then
                    Data().Blood.Cross23 = pos
                    break
                end
            end
            if Data().Blood.Cross23 ~= nil then
                local dis = TensorCore.getDistance2d(DM.Center, Data().Blood.Cross23)
                local dir = TensorCore.getHeadingToTarget(DM.Center, Data().Blood.Cross23)
                Data().Blood.Cross14 = TensorCore.getPosInDirection(DM.Center, dir + math.pi, dis)
            end
        end
    end

    if DM.InState('P5BloodStart') then
        drawBloodArrow(1)
        if Cfg().draw and table.size(Data().Blood.Aoe) >= 2 and table.size(Data().Blood.AoeOut) >= 2 then
            drawCurBlood(1, 2)
        end
        if Data().Blood.Cross34 ~= nil and Cfg().guide then
            setDataAndGuide(1, Data().Blood.Cross34)
        end
    end

    if DM.InState('P5Blood1End') then
        drawBloodArrow(2)
        if Cfg().draw and table.size(Data().Blood.Aoe) >= 3
                and table.size(Data().Blood.AoeOut) >= 3 then
            drawCurBlood(2, 3)
        end
        if Data().Blood.Cross14 ~= nil and Cfg().guide then
            setDataAndGuide(2, Data().Blood.Cross14)
        end
    end

    if DM.InState('P5Blood2End') then
        drawBloodArrow(3)
        if Cfg().draw and table.size(Data().Blood.Aoe) >= 4
                and table.size(Data().Blood.AoeOut) >= 4 then
            drawCurBlood(3, 4)
        end
        if Data().Blood.Cross12 ~= nil and Cfg().guide then
            setDataAndGuide(3, Data().Blood.Cross12)
        end
    end

    if DM.InState('P5Blood3End') then
        drawBloodArrow(4)
        if Cfg().draw and table.size(Data().Blood.Aoe) >= 4
                and table.size(Data().Blood.AoeOut) >= 4 then
            drawCurBlood(4)
        end
        if Data().Blood.Cross12 ~= nil and Cfg().guide then
            setDataAndGuide(3, Data().Blood.Cross12)
        end
    end
    if DM.InState('P5MaddeningOrchestra')
            or DM.InState('P5MaddeningOrchestra2')
    then
        if MG.IsAnyMemberHasBuff(2941) then
            if DM.InState('P5MaddeningOrchestra') then
                DM.ChangeState('P5MaddeningOrchestra1End')
            else
                DM.ChangeState('P5MaddeningOrchestra2_1End')
            end
            Data().MaddeningOrchestra.FirstHitTimer = Now()
        end
        if Cfg().draw then
            MG.OnCurrentPartyDo(function(job, member)
                local drawer
                if MG.IsTank(member.job) then
                    drawer = MG.CreateDrawer(1, 0.5, 0, 0.2, 2)
                else
                    drawer = MG.CreateDrawer(0, 0.5, 1, 0.2, 2)
                end
                drawer:addCircle(member.pos.x, MG.drawerY, member.pos.z, 5)
            end)
        end
        if Data().MaddeningOrchestra.Guide1 == nil or table.size(Data().MaddeningOrchestra.Guide1) < 8 then
            Data().MaddeningOrchestra.Guide1 = {}
            Data().MaddeningOrchestra.GuideOut = {}
            local pos = Cfg().jobOrder
            for i = 1, 8 do
                local dir
                if Cfg().isLeaning then
                    dir = (i - 1) * math.pi / 4 + math.pi / 8
                else
                    dir = (i - 1) * math.pi / 4
                end
                if pos[i] == 'MT' or pos[i] == 'ST' then
                    Data().MaddeningOrchestra.Guide1[pos[i]] = TensorCore.getPosInDirection(DM.Center, dir, 10)
                else
                    Data().MaddeningOrchestra.Guide1[pos[i]] = TensorCore.getPosInDirection(DM.Center, dir, 7.5)
                end
                local dis = 11
                if pos[i] == 'MT' then
                    dis = 9
                elseif table.contains({ 'H1', 'H2', 'D3', 'D4' }, pos[i]) then
                    dis = 14
                end
                Data().MaddeningOrchestra.GuideOut[pos[i]] = TensorCore.getPosInDirection(DM.Center, dir, dis)
            end
        else
            if Cfg().guide then
                MG.FrameMultiD(Data().MaddeningOrchestra.Guide1)
            end
        end
    end

    if DM.InState('P5MaddeningOrchestra1End')
            or DM.InState('P5MaddeningOrchestra2_1End')
    then
        if Cfg().draw then
            local curParty = MG.GetPartyPlayers()
            table.sort(curParty, function(a, b)
                return TensorCore.getDistance2d(DM.Center, a.pos)
                        < TensorCore.getDistance2d(DM.Center, b.pos)
            end)
            for i = 1, #curParty do
                local member = curParty[i]
                if i < 4 then
                    MG.CreateDrawer(0, 0.5, 1, 0.2, 2):addCircle(member.pos.x, MG.drawerY, member.pos.z, 5)
                end
            end
            local mt = TensorCore.mGetEntity(MG.Party.MT.id)
            if mt ~= nil and mt.pos ~= nil then
                MG.CreateDrawer(1, 0.5, 0, 0.2, 2):addCircle(mt.pos.x, MG.drawerY, mt.pos.z, 5)
            end
        end
        -- 获取DebuffHD
        if Data().MaddeningOrchestra.Guide2 == nil or table.size(Data().MaddeningOrchestra.Guide2) < 8 then
            if TimeSince(Data().MaddeningOrchestra.FirstHitTimer) > 500 then
                Data().MaddeningOrchestra.Guide2 = {}
                for job, member in pairs(MG.Party) do
                    if TensorCore.hasBuff(member.id, 2941) and job ~= 'MT' and job ~= 'ST' then
                        if not table.contains(Data().MaddeningOrchestra.FirstHits, job) then
                            table.insert(Data().MaddeningOrchestra.FirstHits, job)
                        end
                        Data().MaddeningOrchestra.Guide2[job] = Data().MaddeningOrchestra.GuideOut[job]
                    else
                        Data().MaddeningOrchestra.Guide2[job] = Data().MaddeningOrchestra.Guide1[job]
                    end
                end
                Data().MaddeningOrchestra.Guide2.ST = { x = 100, y = 0, z = 90 }
                Data().MaddeningOrchestra.Guide2.MT = { x = 100, y = 0, z = 90 }
            end
        else
            if Cfg().guide then
                MG.FrameMultiD(Data().MaddeningOrchestra.Guide2)
            end
        end
        if TimeSince(Data().MaddeningOrchestra.FirstHitTimer) > 4200 then
            local secondHitFound = false
            for job, member in pairs(MG.Party) do
                if job ~= 'MT' and job ~= 'ST'
                        and TensorCore.hasBuff(member.id, 2941)
                        and (not table.contains(Data().MaddeningOrchestra.FirstHits, job)) then
                    secondHitFound = true
                    break
                end
            end
            if secondHitFound then
                if DM.InState('P5MaddeningOrchestra1End') then
                    DM.ChangeState('P5MaddeningOrchestra2End')
                else
                    DM.ChangeState('P5MaddeningOrchestra2_2End')
                end
            end
        end
    end

    if DM.InState('P5MaddeningOrchestra2End')
            or DM.InState('P5MaddeningOrchestra2_2End')
    then
        if Data().MaddeningOrchestra.Guide3 == nil or table.size(Data().MaddeningOrchestra.Guide3) < 8 then
            Data().MaddeningOrchestra.Guide3 = {}
            Data().MaddeningOrchestra.RedBuff = nil
            Data().MaddeningOrchestra.BlueBuff = nil
            for job, member in pairs(MG.Party) do
                if job == 'MT' or job == 'ST' then
                    if TensorCore.hasBuff(member.id, redBuffId) then
                        Data().MaddeningOrchestra.Guide3[job] = { x = 100, y = 0, z = 80.5 }
                        Data().MaddeningOrchestra.RedBuff = member
                    elseif TensorCore.hasBuff(member.id, blueBuffId) then
                        Data().MaddeningOrchestra.Guide3[job] = { x = 100, y = 0, z = 92.5 }
                        Data().MaddeningOrchestra.BlueBuff = member
                    end
                else
                    Data().MaddeningOrchestra.Guide3[job] = { x = 100, y = 0, z = 111 }
                end
            end
        end
        local orchestraReady = table.size(Data().MaddeningOrchestra.Guide3) >= 8
                and Data().MaddeningOrchestra.RedBuff ~= nil
                and Data().MaddeningOrchestra.BlueBuff ~= nil
        if orchestraReady then
            if Cfg().draw then
                local curPlayer = TensorCore.mGetEntity(Data().MaddeningOrchestra.RedBuff.id)
                if curPlayer ~= nil and curPlayer.pos ~= nil then
                    MG.CreateDrawer(1, 0.5, 0, 0.2, 2):addCircle(curPlayer.pos.x, MG.drawerY, curPlayer.pos.z, 26)
                end
                curPlayer = TensorCore.mGetEntity(Data().MaddeningOrchestra.BlueBuff.id)
                if curPlayer ~= nil and curPlayer.pos ~= nil then
                    MG.CreateDrawer(0, 0.5, 1, 0.2, 2):addCircle(curPlayer.pos.x, MG.drawerY, curPlayer.pos.z, 6)
                end
            end
            if Cfg().guide then
                MG.FrameMultiD(Data().MaddeningOrchestra.Guide3)
            end
            if not TensorCore.hasBuff(Data().MaddeningOrchestra.RedBuff.id, redBuffId)
                    and not TensorCore.hasBuff(Data().MaddeningOrchestra.BlueBuff.id, blueBuffId)
            then
                if DM.InState('P5MaddeningOrchestra2End') then
                    DM.ChangeState('P5UltimaRepeater2')
                else
                    DM.ChangeState('P5UltimaRepeater4')
                end
            end
        end
    end
    if DM.InState('P5Celestriad') then
        local towersReady = Data().Celestriad.AllTowers ~= nil
                and table.size(Data().Celestriad.AllTowers) >= 9
                and table.size(Data().Celestriad.TowerFire or {}) >= 3
                and table.size(Data().Celestriad.TowerIce or {}) >= 3
                and table.size(Data().Celestriad.TowerThunder or {}) >= 3
        if not towersReady then
            Data().Celestriad.AllTowers = {}
            Data().Celestriad.TowerFire = {}
            Data().Celestriad.TowerIce = {}
            Data().Celestriad.TowerThunder = {}
            for _, ent in pairs(TensorCore.entityList("contentid=2015294")) do
                table.insert(Data().Celestriad.AllTowers, ent)
                table.insert(Data().Celestriad.TowerFire, ent)
            end
            for _, ent in pairs(TensorCore.entityList("contentid=2015295")) do
                table.insert(Data().Celestriad.AllTowers, ent)
                table.insert(Data().Celestriad.TowerIce, ent)
            end
            for _, ent in pairs(TensorCore.entityList("contentid=2015296")) do
                table.insert(Data().Celestriad.AllTowers, ent)
                table.insert(Data().Celestriad.TowerThunder, ent)
            end
            sortTableByClock(Data().Celestriad.TowerFire)
            sortTableByClock(Data().Celestriad.TowerIce)
            sortTableByClock(Data().Celestriad.TowerThunder)
        else
            if Data().Celestriad.groupBuffPos[1] == nil or table.size(Data().Celestriad.groupBuffPos[1]) < 6 then
                Data().Celestriad.groupBuffPos[1] = {}
                Data().Celestriad.groupNoBuff = {}
                for job, member in pairs(MG.Party) do
                    if TensorCore.hasBuff(member.id, fireBuffId) then
                        Data().Celestriad.groupBuffPos[1][job] = Data().Celestriad.TowerFire[3].pos
                    elseif TensorCore.hasBuff(member.id, iceBuffId) then
                        Data().Celestriad.groupBuffPos[1][job] = Data().Celestriad.TowerIce[3].pos
                    elseif TensorCore.hasBuff(member.id, thunderBuffId) then
                        Data().Celestriad.groupBuffPos[1][job] = Data().Celestriad.TowerThunder[3].pos
                    else
                        table.insert(Data().Celestriad.groupNoBuff, job)
                    end
                end
            else
                DM.ChangeState('P5CelestriadGetData')
            end
        end
    end
    if DM.InState('P5CelestriadGetData') then
        if Cfg().draw and Data().Celestriad.CatastrophicChoiceId ~= 0 and Data().Kefka ~= nil then
            if Data().Celestriad.BossOnDraw == nil then
                Data().Celestriad.BossOnDraw = TensorCore.mGetEntity(Data().Kefka.id)
            else
                local curBoss = Data().Celestriad.BossOnDraw
                if Data().Celestriad.CatastrophicChoiceId == 49742 then
                    if ArgusDrawsPlus ~= nil and ArgusDrawsPlus.getEnabled() then
                        local drawer = MG.CreateDrawer(0, 0, 0, 1, 2, -1)
                        drawer:setGradient(0, 0.15, 0)
                        drawer:setRenderFlags(256)
                        drawer:addCircle(curBoss.pos.x, MG.drawerY, curBoss.pos.z, 10)
                    else
                        MG.CreateDrawer(1, 0, 0, 0.3, 2):addCircle(curBoss.pos.x, MG.drawerY, curBoss.pos.z, 10)
                    end
                elseif Data().Celestriad.CatastrophicChoiceId == 49743 then
                    if ArgusDrawsPlus ~= nil and ArgusDrawsPlus.getEnabled() then
                        local drawer = MG.CreateDrawer(0, 0, 0, 1, 2, -1)
                        drawer:setGradient(0, 0.15, 0)
                        drawer:setRenderFlags(256)
                        drawer:addDonut(curBoss.pos.x, MG.drawerY, curBoss.pos.z, 10, 25)
                    else
                        MG.CreateDrawer(1, 0, 0, 0.4, 2):addDonut(curBoss.pos.x, MG.drawerY, curBoss.pos.z, 10, 25)
                    end
                end
            end
        end
        loadGuidePosAndNextStart()
    end

    if Cfg().showBlackHole and DM.InState('P5Forsaken') or DM.InState('P5BeforeEnd') then
        if Data().Forsaken.AoeInfos ~= nil and table.size(Data().Forsaken.AoeInfos) > 0 then
            local out = 8.1
            local inner
            if ArgusDrawsPlus ~= nil and ArgusDrawsPlus.getEnabled() then
                inner = out - 0.15
            else
                out = out - 0.035
                inner = out - 0.08
            end
            for _, aoeInfo in pairs(Data().Forsaken.AoeInfos) do
                local drawer
                local timeSince = TimeSince(aoeInfo.startTime)
                local endTime = aoeInfo.duration * 1000 - 500
                if timeSince < 2500 then
                    drawer = MG.CreateDrawer(0, 1, 0, 1, 0, 0)
                elseif timeSince < endTime then
                    drawer = MG.CreateDrawer(1, 1, 0, 1, 0, 0)
                else
                    drawer = MG.CreateDrawer(1, 0, 0, 1, 0, 0)
                end
                drawer:setRenderFlags(256)
                drawer:addDonut(aoeInfo.x, MG.drawerY, aoeInfo.z, inner, out)
            end
        end
    end
    if DM.InState('P5Forsaken') then
        if Cfg().guide and Cfg().forsakenType == 1 then
            if Data().Forsaken.Guide[Data().Forsaken.wave] == nil then
                Data().Forsaken.Guide[Data().Forsaken.wave] = {}
                local startDir = -math.pi / 4 + (Cfg().forsakenTypeStart - 1) * math.pi / 2
                local curDir = MG.SetHeading2Pi(startDir - math.pi / 2 * (Data().Forsaken.wave - 1))
                local guidePos = TensorCore.getPosInDirection(DM.Center, curDir, 9.5)
                for job, _ in pairs(MG.Party) do
                    Data().Forsaken.Guide[Data().Forsaken.wave][job] = guidePos
                end
            elseif table.size(Data().Forsaken.Guide[Data().Forsaken.wave]) > 0 then
                MG.FrameMultiD(Data().Forsaken.Guide[Data().Forsaken.wave])
            end
        end
    end
    if DM.InState('P5BeforeEnd') then
        local curBoss = Data().Kefka ~= nil and TensorCore.mGetEntity(Data().Kefka.id) or nil
        if curBoss ~= nil and (not curBoss.alive or curBoss.hp.current <= 0) then
            MG.InfoNoLog('-----------------------------------------------')
            MG.InfoNoLog('  恭喜通关' .. DM.NameCN .. '!')
            MG.InfoNoLog('  感谢使用本插件，了解更多信息，')
            MG.InfoNoLog('  欢迎加入QQ群1106367633。')
            MG.InfoNoLog('  Powered by MuAi 2026-06')
            MG.InfoNoLog('-----------------------------------------------')
            DM.ChangeState('P5End')
        end
    end
end
return Dmu_P5
