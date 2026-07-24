local Dmu_P2 = {}

Dmu_P2.StateName = "P2"

---@type DancingMad
local DM
---@type MuAiGuide
local MG

-- 时间轴与实战判定点均为读条开始后 4.0 秒，不得由日志到达抖动延长。
local farNearDeathDrawDuration = 4000

local Cfg = function()
    return MG.Config.DmuCfg.P2
end

local Data = function()
    if MG.DancingMad == nil then
        return nil
    end
    return MG.DancingMad.P2
end

---打印当前踩塔情况到默语
---@param tbl table
local loged = {}

---输出踩塔日志
local showOrderLog = function(tbl, infoHead)
    local log = ''
    for i = 1, #tbl do
        local curJob = tbl[i]
        local mark = Data().Towers.curMarks[curJob]
        local markName
        if mark == 715 then
            markName = '摊'
        elseif mark == 716 then
            markName = '钢'
        elseif mark == 717 then
            markName = '扇'
        end
        log = log .. curJob .. '-' .. markName
        if i ~= #tbl then
            log = log .. ','
        end
    end
    MG.Info(infoHead .. log)
end

---所有塔位置定义
local towerPointByA1 = {
    [1] = { label = "上", x = 100.000, y = 0.000, z = 92.000 },
    [2] = { label = "右上", x = 105.657, y = 0.000, z = 94.343 },
    [3] = { label = "右", x = 108.000, y = 0.000, z = 100.000 },
    [4] = { label = "右下", x = 105.657, y = 0.000, z = 105.657 },
    [5] = { label = "下", x = 100.000, y = 0.000, z = 108.000 },
    [6] = { label = "左下", x = 94.343, y = 0.000, z = 105.657 },
    [7] = { label = "左", x = 92.000, y = 0.000, z = 100.000 },
    [8] = { label = "左上", x = 94.343, y = 0.000, z = 94.343 },
}

-- MuAiCore 原站位。
local legacyStandTemplate = {
    odd = {
        doing = {
            [1] = { isLeft = true, dis = 3.6, dir = -math.pi / 6 },
            [2] = { isLeft = true, dis = 3.6, dir = math.pi / 4 },
            [3] = { isLeft = false, dis = 3.6, dir = -math.pi * 3 / 4 },
            [4] = { isLeft = false, dis = 3.6, dir = math.pi / 4 },
        },
        standBy = {
            [1] = { isLeft = true, dis = 4.4, dir = -math.pi / 4 },
            [2] = { isLeft = true, dis = 4.4, dir = math.pi * 3 / 10 },
            [3] = { isLeft = false, dis = 4.4, dir = math.pi / 4 },
            [4] = { isLeft = false, dis = 4.4, dir = math.pi / 4 },
        }
    },
    even = {
        doing = {
            [1] = { isLeft = true, dis = 3.6, dir = -math.pi / 5 },
            [2] = { isLeft = true, dis = 3.6, dir = 0 },
            [3] = { isLeft = false, dis = 3.6, dir = -math.pi * 17 / 36 },
            [4] = { isLeft = false, dis = 3.6, dir = math.pi * 17 / 36 },
        },
        standBy = {
            [1] = { isLeft = true, dis = 12, dir = -math.pi * 17 / 20 },
            [2] = { isLeft = true, dis = 4.4, dir = -math.pi * 17 / 18 },
            [3] = { isLeft = false, dis = 11, dir = math.pi * 7 / 9 },
            [4] = { isLeft = false, dis = 4.4, dir = math.pi * 17 / 18 },
        }
    },
    odd_uptime = {
        doing = {
            [1] = { isLeft = true, dis = 1, dir = math.pi },
            [2] = { isLeft = true, dis = 3, dir = 0 },
            [3] = { isLeft = false, dis = 3.6, dir = 0 },
            [4] = { isLeft = false, dis = 3.6, dir = math.pi },
        },
        standBy = {
            [1] = { isLeft = true, dis = 4.4, dir = math.pi },
            [2] = { isLeft = true, dis = 4.4, dir = 0 },
            [3] = { isLeft = false, dis = 4.4, dir = math.pi },
            [4] = { isLeft = false, dis = 4.4, dir = math.pi },
        }
    },
}

-- BBY U7b v1.0.1 的 PictoACT 局部坐标。
-- x 为面向场外时的左右轴（负左正右），y 为塔轴的场外方向。
-- doing 顺序沿用 MuAiCore 的分组顺序，不等同于 BBY 的踩塔 type 顺序。
local bbyStandTemplate = {
    odd = {-- 奇数
        doing = {
            [1] = { x = -6.30, y = 4.70 }, -- 左塔分摊
            [2] = { x = -5.66, y = 9.16 }, -- 左塔扇形
            [3] = { x = 2.20, y = 6.50 }, -- 右塔钢铁
            [4] = { x = 8.19, y = 3.66 }, -- 右塔分摊
        },
        standBy = {
            [1] = { x = -8.80, y = 2.50 }, -- 左侧分摊
            [2] = { x = -5.66, y = 11.66 }, -- 扇形引导
            [3] = { x = 8.70, y = 2.34 }, -- 右侧分摊
            [4] = { x = 9.59, y = 3.45 }, -- 右侧分摊
        }
    },
    even = { --偶数
        doing = {
            [1] = { x = -9.51, y = 6.27 }, -- 左塔靠前扇形
            [2] = { x = -8.30, y = 8.52 }, -- 左塔靠后扇形
            [3] = { x = 4.71, y = 7.72 }, -- 右塔靠后钢铁
            [4] = { x = 8.69, y = 3.22 }, -- 右塔右侧钢铁
        },
        standBy = {
            [1] = { x = -1.90, y = -3.50 }, -- 左前引导分身
            [2] = { x = -3.20, y = 2.40 }, -- 左塔边引导分身
            [3] = { x = 3.97, y = -3.55 }, -- 右前引导分身
            [4] = { x = 3.20, y = 2.40 }, -- 右塔边引导分身
        }
    },
    odd_uptime = {
        -- 奇数近战优化
        doing = {
            [1] = { x = -4.95, y = 4.95 }, -- 左塔分摊
            [2] = { x = -8.00, y = 8.00 }, -- 左塔扇形
            [3] = { x = 8.13, y = 8.13 }, -- 右塔钢铁
            [4] = { x = 5.66, y = 2.16 }, -- 右塔分摊
        },
        standBy = {
            [1] = { x = -2.45, y = 2.45 }, -- 左前分摊
            [2] = { x = -9.00, y = 9.00 }, -- 扇形引导
            [3] = { x = 2.25, y = 2.65 }, -- 右前分摊
            [4] = { x = 2.65, y = 2.25 }, -- 右前分摊
        }
    },
}

---异三角爆炸位置与三角偏移量 data by String
local trineOffsets = {
    left = { { x = -5.773, z = 0 }, { x = 2.887, z = -5 }, { x = 2.887, z = 5 } },
    right = { { x = 5.773, z = 0 }, { x = -2.887, z = -5 }, { x = -2.887, z = 5 } },
}

-- 绘制毁灭之脚
local drawAllThingEnding = function()
    if not Cfg().draw
            or DM.OverState('P2TrineStart', true)
            or Data().Towers.kickTimer == 0
            or not Data().Towers.kickDrawing
            or table.size(Data().Towers.kickBoss) == 0
    then
        return
    end
    if TimeSince(Data().Towers.kickTimer) < 5500 then
        for _, id in pairs(Data().Towers.kickBoss) do
            local preSkill = Data().Towers.kickPreSkill
            local curCaster = TensorCore.mGetEntity(id)
            if curCaster == nil then
                return
            end
            local dir
            if preSkill == 47827 then
                dir = curCaster.pos.h + math.pi
            elseif preSkill == 47826 then
                dir = curCaster.pos.h
            end
            MG.CreateDrawer(1, 0.5, 0, nil, 2)
              :addRect(curCaster.pos.x, MG.drawerY, curCaster.pos.z, 25, 50, dir)
        end
    else
        Data().Towers.kickTimer = 0
        Data().Towers.kickBoss = {}
        Data().Towers.kickDrawing = false
    end
end

local resetKickTimer = function()
    if DM.OverState('P2TrineStart', true) then
        return
    end
    -- 如果用户没有开启画图，则超时100毫秒后自动重置数据
    if Data().Towers.kickTimer ~= 0
            and TimeSince(Data().Towers.kickTimer) > 5600
    then
        Data().Towers.kickTimer = 0
        Data().Towers.kickBoss = {}
        Data().Towers.kickDrawing = false
    end
end

-- 初始化AB分组
local initGroups = function()
    -- 采取当前流行的2222分组1238 4567
    if Data().Towers.curMarks.MT == 715 or Data().Towers.curMarks.H1 == 715 then
        table.insert(Data().Towers.groupA, 'MT')
        table.insert(Data().Towers.groupA, 'H1')
        table.insert(Data().Towers.groupB, 'ST')
        table.insert(Data().Towers.groupB, 'H2')
    else
        table.insert(Data().Towers.groupA, 'ST')
        table.insert(Data().Towers.groupA, 'H2')
        table.insert(Data().Towers.groupB, 'MT')
        table.insert(Data().Towers.groupB, 'H1')
    end
    if Data().Towers.curMarks.D1 == 715 or Data().Towers.curMarks.D3 == 715 then
        table.insert(Data().Towers.groupA, 'D1')
        table.insert(Data().Towers.groupA, 'D3')
        table.insert(Data().Towers.groupB, 'D2')
        table.insert(Data().Towers.groupB, 'D4')
    else
        table.insert(Data().Towers.groupA, 'D2')
        table.insert(Data().Towers.groupA, 'D4')
        table.insert(Data().Towers.groupB, 'D1')
        table.insert(Data().Towers.groupB, 'D3')
    end

    -- 扇左钢右的换组站位必须沿用初始点名，不能被后续轮次头标覆盖。
    if MG.Config.DmuCfg.P2.fixType == 2 then
        local groupA = Data().Towers.groupA
        local firstPairHasCone = Data().Towers.curMarks[groupA[1]] == 717
                or Data().Towers.curMarks[groupA[2]] == 717
        local secondPairHasCone = Data().Towers.curMarks[groupA[3]] == 717
                or Data().Towers.curMarks[groupA[4]] == 717
        assert(firstPairHasCone ~= secondPairHasCone, '扇左钢右初始分组异常：A组扇形二人组不唯一')
        if firstPairHasCone then
            Data().Towers.groupAStandByOrder = { groupA[1], groupA[2], groupA[3], groupA[4] }
        else
            Data().Towers.groupAStandByOrder = { groupA[3], groupA[4], groupA[1], groupA[2] }
        end

        local group = Data().Towers.groupB
        local mark1 = Data().Towers.curMarks[group[1]]
        if mark1 == 717 then
            Data().Towers.groupB = { group[1], group[2], group[3], group[4] }
        else
            Data().Towers.groupB = { group[3], group[4], group[1], group[2] }
        end
    end

    if MG.Config.Main.LogToEchoMsg then
        loged = {}
        showOrderLog(Data().Towers.groupA, '初始踩塔组：')
        showOrderLog(Data().Towers.groupB, '初始闲人组：')
    end
end

---计算扇左钢右闲人情况
local calcConeLeft = function(tbl)
    local last = tbl
    local mark1 = Data().Towers.curMarks[last[1]]
    local mark2 = Data().Towers.curMarks[last[2]]
    local mark3 = Data().Towers.curMarks[last[3]]
    local mark4 = Data().Towers.curMarks[last[4]]
    local result = {}
    if mark1 == 717 then
        if mark2 == 717 then
            result = { last[1], last[2], last[3], last[4] }
        elseif mark3 == 717 then
            result = { last[1], last[3], last[2], last[4] }
        elseif mark4 == 717 then
            result = { last[1], last[4], last[2], last[3] }
        end
    elseif mark2 == 717 then
        if mark3 == 717 then
            result = { last[2], last[3], last[1], last[4] }
        elseif mark4 == 717 then
            result = { last[2], last[4], last[1], last[3] }
        end
    elseif mark3 == 717 then
        result = { last[3], last[4], last[1], last[2] }
    end
    return result
end

local bbyLocalToWorld = function(axisOutward, localPos)
    local axisX = axisOutward.x - DM.Center.x
    local axisZ = axisOutward.z - DM.Center.z
    local axisLength = math.sqrt(axisX * axisX + axisZ * axisZ)
    assert(axisLength > 0.001, '遗弃末世塔轴异常：两塔中点与场中重合')

    axisX = axisX / axisLength
    axisZ = axisZ / axisLength
    local rightX = -axisZ
    local rightZ = axisX

    return {
        x = DM.Center.x + localPos.x * rightX + localPos.y * axisX,
        y = DM.Center.y or 0,
        z = DM.Center.z + localPos.x * rightZ + localPos.y * axisZ,
    }
end

local calcGuidePos = function(wave, isFix)
    local curDoingPos = {}
    local curTemplate
    local useBbyPos = Cfg().useBbyPos == true
    local standTemplate
    if useBbyPos then
        standTemplate = bbyStandTemplate
    else
        standTemplate = legacyStandTemplate
    end
    if wave % 2 ~= 0 then
        if MG.Config.DmuCfg.P2.fixType == 3 then
            curTemplate = standTemplate.odd_uptime
        else
            curTemplate = standTemplate.odd
        end
    else
        curTemplate = standTemplate.even
    end
    local spawn = Data().Towers.spawn[wave]
    local toWorld
    if useBbyPos then
        local axisOutward = MG.GetMidPos(spawn.left, spawn.right)
        toWorld = function(localPos)
            return bbyLocalToWorld(axisOutward, localPos)
        end
    else
        local dirL = TensorCore.getHeadingToTarget(DM.Center, spawn.left)
        local dirR = TensorCore.getHeadingToTarget(DM.Center, spawn.right)
        toWorld = function(templatePos)
            if templatePos.isLeft then
                return TensorCore.getPosInDirection(spawn.left, dirL + templatePos.dir, templatePos.dis)
            end
            return TensorCore.getPosInDirection(spawn.right, dirR + templatePos.dir, templatePos.dis)
        end
    end
    for i = 1, #curTemplate.doing do
        curDoingPos[i] = toWorld(curTemplate.doing[i])
    end
    local curStbPos = {}
    for i = 1, #curTemplate.standBy do
        curStbPos[i] = toWorld(curTemplate.standBy[i])
    end
    local guideData = {}
    if Cfg().fixType == 2 and wave >= 4 and wave < 8 and not isFix then
        Data().Towers.standBy = table.deepcopy(Data().Towers.groupAStandByOrder)
    end
    for i = 1, 4 do
        local curDoingJob = Data().Towers.groupOrders[wave][i]
        if curDoingPos[i] ~= nil then
            guideData[curDoingJob] = curDoingPos[i]
        end
        local curStanByJob = Data().Towers.standBy[i]
        if curStbPos[i] ~= nil then
            guideData[curStanByJob] = curStbPos[i]
        end
    end
    return guideData
end

local checkStandBy = function()
    local wave = Data().Towers.wave
    local order = Data().Towers.groupOrders[wave]
    local standBy = Data().Towers.standBy
    for i = 1, #standBy do
        if table.contains(order, standBy[i]) then
            Data().Towers.fixFlg = true
            return i
        end
    end
    return nil
end

local fixStandBy = function()
    local allElement = {}
    local wave = Data().Towers.wave
    local order = Data().Towers.groupOrders[wave]
    local standBy = Data().Towers.standBy
    for _, job in pairs(order) do
        table.insert(allElement, job)
    end
    for _, job in pairs(standBy) do
        table.insert(allElement, job)
    end
    local missJob
    for _, job in pairs(MG.JobPosName) do
        if not table.contains(allElement, job) then
            -- 找到错了的人
            missJob = job
            break
        end
    end
    local index = checkStandBy()
    Data().Towers.standBy[index] = missJob
    Data().Towers.fixFlg = false
end

local calcFirstOrderA = function()
    local group = Data().Towers.groupA
    local index = 1
    local mark1 = Data().Towers.curMarks[group[1]]
    local mark2 = Data().Towers.curMarks[group[2]]
    local mark3 = Data().Towers.curMarks[group[3]]
    local mark4 = Data().Towers.curMarks[group[4]]
    if mark1 == 717 then
        if mark3 == 716 then
            Data().Towers.groupOrders[index] = { group[2], group[1], group[3], group[4] }
        else
            Data().Towers.groupOrders[index] = { group[2], group[1], group[4], group[3] }
        end
    elseif mark2 == 717 then
        if mark3 == 716 then
            Data().Towers.groupOrders[index] = { group[1], group[2], group[3], group[4] }
        else
            Data().Towers.groupOrders[index] = { group[1], group[2], group[4], group[3] }
        end
    elseif mark3 == 717 then
        if mark1 == 716 then
            Data().Towers.groupOrders[index] = { group[4], group[3], group[1], group[2] }
        else
            Data().Towers.groupOrders[index] = { group[4], group[3], group[2], group[1] }
        end
    elseif mark4 == 717 then
        if mark1 == 716 then
            Data().Towers.groupOrders[index] = { group[3], group[4], group[1], group[2] }
        else
            Data().Towers.groupOrders[index] = { group[3], group[4], group[2], group[1] }
        end
    end
end

local calcFirstOrderB = function()
    local group = Data().Towers.groupB
    local index = 4
    local curOrder = {}

    local firstJob = group[1]
    local firstMark = Data().Towers.curMarks[firstJob] --这里一定是T
    if firstMark == 716 then
        if MG.Config.DmuCfg.P2.fixType == 2 then
            --扇左钢右, TH组钢铁 在右边，且面向BOSS H左T右 近左远右
            curOrder = { group[3], group[4], group[2], group[1] }
        else
            --TH组钢铁，MRTH
            curOrder = { group[4], group[3], group[1], group[2] }
        end
    else
        --DPS组钢铁，THRM, 闲固和扇左钢右一致
        curOrder = { group[1], group[2], group[4], group[3] }
    end
    Data().Towers.groupOrders[index] = curOrder
end

local calcGroupOrder = function(wave)
    if Data().Towers.groupOrders[wave] ~= nil and table.size(Data().Towers.groupOrders) >= 4 then
        return
    end
    if wave == 1 then
        calcFirstOrderA()
    else
        if table.size(Data().Towers.markCache) < 4 then
            return
        end
        --local lstOdr = Data().Towers.groupOrders[wave - 1]
        local lstOdr = Data().Towers.groupOrdersLast[wave - 1]
        if wave % 2 == 0 then
            if Cfg().fixType == 2 and wave == 8 then
                Data().Towers.groupOrders[wave] = calcConeLeft(Data().Towers.groupA)
            else
                local curWave
                if wave == 4 then
                    -- 如果是第四波，那么直接使用第三波数据计算第八波
                    curWave = 8
                    -- 根据初始点名计算第四波B组踩塔位置
                    calcFirstOrderB()
                else
                    curWave = wave
                end
                -- 有4个头标进行了更新
                local circle = {}
                local cone = {}
                for job, markId in pairs(Data().Towers.markCache) do
                    if markId == 716 then
                        table.insert(circle, job)
                    elseif markId == 717 then
                        table.insert(cone, job)
                    end
                end
                Data().Towers.groupOrders[curWave] = {}
                if MG.IndexOf(lstOdr, cone[1]) < MG.IndexOf(lstOdr, cone[2]) then
                    table.insert(Data().Towers.groupOrders[curWave], cone[1])
                    table.insert(Data().Towers.groupOrders[curWave], cone[2])
                else
                    table.insert(Data().Towers.groupOrders[curWave], cone[2])
                    table.insert(Data().Towers.groupOrders[curWave], cone[1])
                end

                if MG.IndexOf(lstOdr, circle[1]) < MG.IndexOf(lstOdr, circle[2]) then
                    table.insert(Data().Towers.groupOrders[curWave], circle[1])
                    table.insert(Data().Towers.groupOrders[curWave], circle[2])
                else
                    table.insert(Data().Towers.groupOrders[curWave], circle[2])
                    table.insert(Data().Towers.groupOrders[curWave], circle[1])
                end
            end
        else
            local gather = {}
            local cone, circle
            for job, markId in pairs(Data().Towers.markCache) do
                if markId == 716 then
                    circle = job
                elseif markId == 717 then
                    cone = job
                elseif markId == 715 then
                    table.insert(gather, job)
                end
            end
            if MG.IndexOf(lstOdr, gather[1]) < MG.IndexOf(lstOdr, gather[2]) then
                Data().Towers.groupOrders[wave] = { gather[1], cone, circle, gather[2] }
            else
                Data().Towers.groupOrders[wave] = { gather[2], cone, circle, gather[1] }
            end
        end
        if table.size(Data().Towers.groupOrders[wave]) == 4 then
            -- 算完丢弃
            Data().Towers.markCache = {}
        end
    end
end

local guideGatherPoint = function(idx, wave, finishPoints)
    local curData = Data().Towers.guideDir[idx]
    if curData.finish then
        if Cfg().guide then
            MG.FrameMultiD(finishPoints, 0.3)
        end
    else
        if curData.guideData == nil then
            curData.guideData = {}
            local guidePos
            local leftTw = Data().Towers.spawn[wave].left
            local rightTw = Data().Towers.spawn[wave].right
            local mid = MG.GetMidPos(leftTw, rightTw)
            local dir = TensorCore.getHeadingToTarget(leftTw, rightTw)
            if curData.skill == 47827 then
                guidePos = TensorCore.getPosInDirection(mid, dir - math.pi / 2, 3)
            elseif curData.skill == 47826 then
                guidePos = TensorCore.getPosInDirection(mid, dir + math.pi / 2, 15)
            end
            for job, _ in pairs(MG.Party) do
                curData.guideData[job] = guidePos
            end
        else
            if Cfg().guide then
                MG.FrameMultiD(curData.guideData)
            end
        end
    end
end

local getFarIntersection = function(h, centerPt, r)
    local ox = DM.Center.x
    local oz = DM.Center.z
    local ch = math.cos(h)
    local sh = math.sin(h)
    local dx0 = ox - centerPt.x
    local dz0 = oz - centerPt.z
    local b = 2 * (dx0 * ch + dz0 * sh)
    local c = dx0 ^ 2 + dz0 ^ 2 - r ^ 2
    local delta = b * b - 4 * c
    if delta < 0 then
        return nil
    end

    local sqrtDelta = math.sqrt(delta)
    local t1 = (-b - sqrtDelta) / 2
    local t2 = (-b + sqrtDelta) / 2
    local tFar
    if math.abs(t1) > math.abs(t2) then
        tFar = t1
    else
        tFar = t2
    end

    return {
        x = ox + tFar * ch,
        z = oz + tFar * sh,
    }
end

-- 原近 U 站位会根据分摊玩家的实时位置修正扇形点；BBY 使用固定坐标时不执行。
local legacyType3FixPos = function(wave)
    if (wave % 2) == 0
            or not table.contains(Data().Towers.doing, MG.SelfPos)
            or Data().Towers.curMarks[MG.SelfPos] ~= 717
    then
        return Data().Towers.GuideData[wave]
    end
    local leftTower = Data().Towers.spawn[wave].left
    local curGather
    for _, job in pairs(Data().Towers.doing) do
        local player = TensorCore.mGetEntity(MG.Party[job].id)
        if TensorCore.getDistance2d(player.pos, leftTower) < 4 and Data().Towers.curMarks[job] == 715 then
            curGather = player
            break
        end
    end

    if curGather ~= nil then
        local leftHeading = TensorCore.getHeadingToTarget(DM.Center, leftTower)
        local guidePos = getFarIntersection(leftHeading, curGather.pos, 4.6)
        if guidePos ~= nil and TensorCore.getDistance2d(guidePos, leftTower) < 3.8 then
            local guideData = table.deepcopy(Data().Towers.GuideData[wave])
            guideData[MG.SelfPos] = guidePos
            return guideData
        end
    end
    return Data().Towers.GuideData[wave]
end

---引导过去未来
local guideFuturePastOrTakeTower = function()
    local waves = { 3, 5, 7 }
    local wave = Data().Towers.wave
    local guideData
    if Cfg().fixType == 3 and Cfg().useBbyPos ~= true then
        guideData = legacyType3FixPos(wave)
    else
        guideData = Data().Towers.GuideData[wave]
    end

    if not table.contains(waves, wave) then
        if Cfg().guide then
            MG.FrameMultiD(guideData, 0.3)
        end
    else
        local idxMap = { [3] = 1, [5] = 2, [7] = 3, [8] = 4 }
        local idx = idxMap[wave]
        guideGatherPoint(idx, wave, guideData)
    end
end

--- 异三角
local calcTrinePos = function(object, a1, a2, a3)
    local appear = (a1 == 16 and a2 == 32) or (a2 == 16 and a3 == 32)
    if not appear then
        return
    end
    d(object.contentid .. ', ' .. a1 .. ', ' .. a2 .. ', ' .. a3)
    if Data().Trine.Timer ~= 0 and TimeSince(Data().Trine.Timer) > 500 then
        Data().Trine.wave = Data().Trine.wave + 1
    end
    if Data().Trine.DrawPos[Data().Trine.wave] == nil then
        Data().Trine.DrawPos[Data().Trine.wave] = {}
    end
    if Data().Trine.TimerStart == 0 then
        Data().Trine.TimerStart = Now()
    end
    local offset
    if object.contentid == 2015155 or object.pos.x < 95 and object.pos.z < 95 then
        offset = trineOffsets.left
    else
        offset = trineOffsets.right
    end
    for i = 1, #offset do
        table.insert(Data().Trine.DrawPos[Data().Trine.wave], MG.VectorXZAdd(object.pos, offset[i]))
    end
    Data().Trine.Timer = Now()
end

local drawTowerHeading = function()
    if not Cfg().draw
            or DM.OverState('P2T8End', true)
            or Data().Towers.wave == 0
    then
        return
    end
    local wave = Data().Towers.wave
    local mid = MG.GetMidPos(Data().Towers.spawn[wave].left, Data().Towers.spawn[wave].right)
    local dir = TensorCore.getHeadingToTarget(DM.Center, mid)
    local startPos = TensorCore.getPosInDirection(DM.Center, dir, 20)
    MG.CreateDrawer(1, 1, 1, 1, 1):addArrow(startPos.x, 0, startPos.z, dir + math.pi, 39.5, 0.05, 0.5, 0.5, true)
end

local drawWingsOfDestroy = function()
    if Cfg().draw and Data().Trine.WingTimer ~= 0 and Data().Trine.WingId ~= 0 then
        if TimeSince(Data().Trine.WingTimer) > 5000 then
            Data().Trine.WingId = 0
            Data().Trine.WingTimer = 0
            return
        end
        if Data().Trine.boss == nil then
            for _, ent in pairs(TensorCore.entityList("contentid=7131")) do
                local model = Argus.getEntityModel(ent.id)
                if model == 19506 then
                    Data().Trine.boss = ent
                end
            end
        else
            local curBoss = TensorCore.mGetEntity(Data().Trine.boss.id)
            if curBoss == nil or curBoss.pos == nil then
                MG.LogOnce('P2Trine', 'missing_wing_boss_' .. tostring(Data().Trine.boss.id),
                        '终末双腕绘制跳过：当前帧Boss实体不可用')
                return
            end
            local heading
            if Data().Trine.WingId == 47821 then
                --打左边
                heading = curBoss.pos.h + math.pi / 2
            else
                heading = curBoss.pos.h - math.pi / 2
            end
            DM.purpleDrawer:addRect(100, MG.drawerY, 100, 20, 40, heading)
        end
    end
end

local getDrawablePartyPlayers = function()
    local drawablePlayers = {}
    for _, member in pairs(MG.GetPartyPlayers()) do
        if member ~= nil and member.pos ~= nil then
            table.insert(drawablePlayers, member)
        end
    end
    return drawablePlayers
end

local drawFarNearDeath = function()
    if Cfg().draw
            and Data().FarNearDeath.OnDraw
            and Data().FarNearDeath.Timer > 0
    then
        if TimeSince(Data().FarNearDeath.Timer) < farNearDeathDrawDuration then
            local curParty = getDrawablePartyPlayers()
            if #curParty == 8 then
                table.sort(curParty, function(a, b)
                    local disA = TensorCore.getDistance2d(DM.Center, a.pos)
                    local disB = TensorCore.getDistance2d(DM.Center, b.pos)
                    return disA < disB
                end)
                DM.purpleDrawer:addCircle(curParty[1].pos.x, MG.drawerY, curParty[1].pos.z, 6)
                DM.purpleDrawer:addCircle(curParty[8].pos.x, MG.drawerY, curParty[8].pos.z, 6)
            else
                MG.LogOnce('P2FarNearDeath', 'incomplete_party',
                        '远近死刑绘制跳过：当前队员实体不完整', {
                            count = #curParty,
                        }, true)
            end
        else
            Data().FarNearDeath.OnDraw = false
            Data().FarNearDeath.Timer = 0
        end
    end
end
--------------------------------------------- event function ---------------------------------------------
--- 初始化
--- @param dm DancingMad
--- @param m MuAiGuide
Dmu_P2.Init = function(dm, m)
    DM = dm
    MG = m
end

Dmu_P2.OnEntityChannel = function(entityID, spellID, _)
    if spellID == 47804 then
        -- 终末双腕
        if DM.BeLowState('P2T8Start') then
            DM.ChangeState('P2T8Start')
        end
    elseif spellID == 47826 or spellID == 47827 then
        -- 未来/过去
        if Data().Towers.wave <= 3 then
            Data().Towers.guideDir[1].skill = spellID
        elseif Data().Towers.wave <= 5 then
            Data().Towers.guideDir[2].skill = spellID
        elseif Data().Towers.wave <= 7 then
            Data().Towers.guideDir[3].skill = spellID
        else
            Data().Towers.guideDir[4].skill = spellID
        end
    elseif spellID == 47836 or spellID == 47837 then
        -- 毁灭之脚
        if Data().Towers.wave <= 3 then
            Data().Towers.guideDir[1].finish = true
            Data().Towers.kickPreSkill = Data().Towers.guideDir[1].skill
        elseif Data().Towers.wave <= 5 then
            Data().Towers.guideDir[2].finish = true
            Data().Towers.kickPreSkill = Data().Towers.guideDir[2].skill
        elseif Data().Towers.wave <= 7 then
            Data().Towers.guideDir[3].finish = true
            Data().Towers.kickPreSkill = Data().Towers.guideDir[3].skill
        else
            Data().Towers.guideDir[4].finish = true
            Data().Towers.kickPreSkill = Data().Towers.guideDir[4].skill
        end
        table.insert(Data().Towers.kickBoss, entityID)
        Data().Towers.kickTimer = Now()
        Data().Towers.kickDrawing = true
    elseif spellID == 47839 or spellID == 47840 then
        -- 异三角
        if DM.BeLowState('P2TrineStart') then
            DM.ChangeState('P2TrineStart')
        end
    elseif spellID == 47821 or spellID == 47822 then
        -- 破坏之翼（左右刀）
        Data().Trine.WingId = spellID
        Data().Trine.WingTimer = Now()
    elseif spellID == 50311 then
        Data().FarNearDeath.Timer = Now()
        Data().FarNearDeath.OnDraw = true
    end
end

Dmu_P2.OnEntityCast = function(_, spellID, _)
    if spellID == 50311 or spellID == 47823 then
        Data().FarNearDeath.OnDraw = false
        Data().FarNearDeath.Timer = 0
    end
end

Dmu_P2.OnMarkerAdd = function(entityID, markerID)
    if 715 <= markerID and markerID <= 717 then
        Data().Towers.markCnt = Data().Towers.markCnt + 1
        local curMarkJob
        for job, member in pairs(MG.Party) do
            if member.id == entityID then
                curMarkJob = job
                break
            end
        end
        if curMarkJob ~= nil then
            Data().Towers.curMarks[curMarkJob] = markerID
            if Data().Towers.markCnt > 8 then
                if table.size(Data().Towers.markCache) < 4 then
                    Data().Towers.markCache[curMarkJob] = markerID
                end
            end
        end
        if Data().Towers.markCnt == 8 then
            initGroups()
            if DM.BeLowState('P2T8InitMark') then
                DM.ChangeState('P2T8InitMark')
            end
        end
    end
end

Dmu_P2.OnEventObjectScriptFunc = function(entityID, a1, a2, a3)
    local object = TensorCore.mGetEntity(entityID)
    if object == nil then
        MG.LogOnce('P2Trine', 'missing_event_object_' .. tostring(entityID),
                '异三角事件物体不可用，跳过本次回调', {
                    entityID = entityID,
                }, true)
        return
    end
    if object.contentid == 2015154 or object.contentid == 2015155 then
        calcTrinePos(object, a1, a2, a3)
    end
end

Dmu_P2.OnMapEffect = function(a1, a2, a3)
    if DM.OverState('P2T8Start', true)
            and DM.BeLowState('P2T8End')
            and a2 == 1 and a3 == 2
            and 1 <= a1 and a1 <= 8
    then
        if table.size(Data().Towers.temp) < 2 then
            table.insert(Data().Towers.temp, towerPointByA1[a1])
            if table.size(Data().Towers.temp) == 2 then
                local left, right
                local tbl = Data().Towers.temp
                if MG.GetClock(tbl[1], tbl[2]) then
                    left = tbl[2]
                    right = tbl[1]
                else
                    left = tbl[1]
                    right = tbl[2]
                end
                --记录踩塔玩家相对位置
                if Data().Towers.wave >= 1 then
                    local doingPlayers = {}
                    MG.OnCurrentPartyDo(function(job, member)
                        if table.contains(Data().Towers.doing, job) then
                            table.insert(doingPlayers, { pos = member.pos, job = job })
                            if table.size(doingPlayers) == 4 then
                                return true
                            end
                        end
                    end)
                    table.sort(doingPlayers, function(a, b)
                        return MG.GetClock(a.pos, b.pos, DM.Center) == false
                    end)
                    if Data().Towers.groupOrdersLast[Data().Towers.wave] == nil then
                        Data().Towers.groupOrdersLast[Data().Towers.wave] = {}
                    end
                    for i = 1, #doingPlayers do
                        table.insert(Data().Towers.groupOrdersLast[Data().Towers.wave], doingPlayers[i].job)
                    end
                end
                Data().Towers.wave = Data().Towers.wave + 1
                MG.Info('第' .. Data().Towers.wave .. '轮：')
                if Data().Towers.wave == 8 then
                    Data().Towers.Timer = Now()
                end
                Data().Towers.spawn[Data().Towers.wave] = { left = left, right = right }
                Data().Towers.temp = {}
            end
        end
        --- 1238 4567 其他解法改这里即可
        if Data().Towers.wave <= 3 or Data().Towers.wave == 8 then
            Data().Towers.doing = Data().Towers.groupA
            Data().Towers.standBy = Data().Towers.groupB
        else
            Data().Towers.standBy = Data().Towers.groupA
            Data().Towers.doing = Data().Towers.groupB
        end
    end
end

Dmu_P2.Update = function()
    drawAllThingEnding()
    resetKickTimer()
    drawTowerHeading()
    drawWingsOfDestroy()
    drawFarNearDeath()
    if DM.InState('P2T8InitMark') and Data().Towers.wave > 0 then
        local wave = Data().Towers.wave
        if Data().Towers.GuideData[wave] == nil or table.size(Data().Towers.GuideData[wave]) < 8 then
            if Data().Towers.groupOrders[wave] == nil then
                calcGroupOrder(wave)
            else
                Data().Towers.GuideData[wave] = calcGuidePos(wave)
                local checkIdx = checkStandBy()
                if checkIdx ~= nil then
                    MG.Info('有人站位错误，或者小队列表不正确！踩塔组和闲人组均存在[' .. Data().Towers.standBy[checkIdx] .. ']尝试修复序列。')
                    fixStandBy()
                    --如果发现序列不正确，重新调整后需要再计算一次位置
                    Data().Towers.GuideData[wave] = calcGuidePos(wave, true)
                end
            end
        end
        if MG.Config.Main.LogToEchoMsg
                and Data().Towers.standBy ~= nil
                and Data().Towers.GuideData[wave] ~= nil
                and not loged[wave] then
            showOrderLog(Data().Towers.groupOrders[wave], ' 踩塔顺序：')
            showOrderLog(Data().Towers.standBy, ' 闲人顺序：')
            loged[wave] = true
        end
        if Cfg().draw then
            local left = Data().Towers.spawn[wave].left
            local right = Data().Towers.spawn[wave].right
            local out = 4
            local inner
            if ArgusDrawsPlus ~= nil and ArgusDrawsPlus.getEnabled() then
                inner = out - 0.12
            else
                out = out - 0.035
                inner = out - 0.05
            end
            local drawer = MG.CreateDrawer(1, 0, 0, 1, 0, 0)
            drawer:setRenderFlags(256)
            drawer:addDonut(left.x, MG.drawerY, left.z, inner, out)
            drawer:addDonut(right.x, MG.drawerY, right.z, inner, out)
            for job, member in pairs(MG.Party) do
                if table.contains(Data().Towers.doing, job) then
                    local curMember = TensorCore.mGetEntity(member.id)
                    if curMember ~= nil and curMember.pos ~= nil
                            and (TensorCore.getDistance2d(curMember.pos, left) < 4
                            or TensorCore.getDistance2d(curMember.pos, right) < 4)
                    then
                        local curMark = Data().Towers.curMarks[job]
                        if curMark == 715 then
                            -- 分摊
                            DM.greenDrawer:addCircle(curMember.pos.x, MG.drawerY, curMember.pos.z, 5)
                        elseif curMark == 716 then
                            -- 钢铁
                            DM.redDrawer:addCircle(curMember.pos.x, MG.drawerY, curMember.pos.z, 5)
                        elseif curMark == 717 then
                            -- 扇形
                            local nearest = nil
                            local dis = 1000
                            for _, mmb in pairs(MG.Party) do
                                if mmb.id ~= curMember.id then
                                    local memberNew = TensorCore.mGetEntity(mmb.id)
                                    if memberNew ~= nil and memberNew.pos ~= nil then
                                        local distance = TensorCore.getDistance2d(memberNew.pos, curMember.pos)
                                        if distance < dis then
                                            dis = distance
                                            nearest = memberNew
                                        end
                                    end
                                end
                            end

                            if nearest ~= nil then
                                local dir = TensorCore.getHeadingToTarget(curMember.pos, nearest.pos)
                                MG.CreateDrawer(0, 0.6, 1, 0.3, 2, 13)
                                  :addCone(curMember.pos.x, MG.drawerY, curMember.pos.z, 40, math.pi / 2, dir)
                            end

                        end
                    end
                end
            end
            if wave % 2 == 0 then
                local curParty = getDrawablePartyPlayers()
                if #curParty >= 4 then
                    table.sort(curParty, function(a, b)
                        return TensorCore.getDistance2d(a.pos, DM.Center) < TensorCore.getDistance2d(b.pos, DM.Center)
                    end)
                    for i = 1, 4 do
                        DM.purpleDrawer:addCircle(curParty[i].pos.x, MG.drawerY, curParty[i].pos.z, 5)
                    end
                else
                    MG.LogOnce('P2Tower', 'incomplete_party_wave_' .. tostring(wave),
                            '塔绘制跳过：当前队员实体不足四人', {
                                wave = wave,
                                count = #curParty,
                            }, true)
                end
            end
        end
        if Data().Towers.GuideData[wave] ~= nil and table.size(Data().Towers.GuideData[wave]) > 0 then
            guideFuturePastOrTakeTower()
        end
    end

    if Data().Towers.wave == 8
            and TimeSince(Data().Towers.Timer) > 10000
            and DM.BeLowState('P2T8End')
    then
        DM.ChangeState('P2T8End')
        if Cfg().towerGuide then
            for i = 1, 8 do
                SendTextCommand("/mk clear <" .. i .. ">")
            end
        end
    end
    if DM.InState('P2T8End') then
        local curData = Data().Towers.guideDir[4]
        if Cfg().guide and curData.skill ~= 0 then
            if curData.guideData == nil or curData.backData == nil then
                curData.guideData = {}
                curData.backData = {}
                local needCross
                if curData.skill == 47827 then
                    needCross = false
                elseif curData.skill == 47826 then
                    needCross = true
                end
                if Cfg().endTower == 1 then
                    for job, _ in pairs(MG.Party) do
                        curData.guideData[job] = { x = 100, y = 0, z = 90 }
                        if needCross then
                            curData.backData[job] = { x = 100, y = 0, z = 110 }
                        else
                            curData.backData[job] = { x = 100, y = 0, z = 90 }
                        end
                    end
                else
                    local tower = Data().Towers.spawn[8]
                    if tower ~= nil then
                        local mid = MG.GetMidPos(tower.left, tower.right)
                        local dir = TensorCore.getHeadingToTarget(mid, DM.Center)
                        local crossPos = TensorCore.getPosInDirection(DM.Center, dir, 10)
                        for job, _ in pairs(MG.Party) do
                            curData.guideData[job] = mid
                            if needCross then
                                curData.backData[job] = crossPos
                            else
                                curData.backData[job] = mid
                            end
                        end
                    end
                end
            else
                if curData.finish then
                    MG.FrameMultiD(curData.backData)
                else
                    MG.FrameMultiD(curData.guideData)
                end
            end
        end
        if Data().Towers.kickTimer > 0 and TimeSince(Data().Towers.kickTimer) > 5000 then
            DM.ChangeState('P2T8LastKick')
        end
    end

    if DM.InState('P2TrineStart')
            and table.size(Data().Trine.DrawPos) > 0
            and Data().Trine.TimerStart > 0
    then
        if Cfg().draw then
            local index, preIndex
            local timeSince = TimeSince(Data().Trine.TimerStart)
            if timeSince < 11000 then
                index = 1
                if timeSince > 7000 then
                    preIndex = 2
                end
            elseif timeSince < 13000 then
                index = 2
                preIndex = 3
            elseif timeSince < 15000 then
                index = 3
            else
                DM.ChangeState('P2End')
            end
            if index ~= nil and Data().Trine.DrawPos[index] ~= nil then
                for _, drawPos in pairs(Data().Trine.DrawPos[index]) do
                    DM.redDrawer:addCircle(drawPos.x, MG.drawerY, drawPos.z, 6)
                end
            end
            if Cfg().trineDrawType == 2 and preIndex ~= nil and Data().Trine.DrawPos[preIndex] ~= nil then
                for _, drawPos in pairs(Data().Trine.DrawPos[preIndex]) do
                    DM.yellowDrawer:addCircle(drawPos.x, MG.drawerY, drawPos.z, 6)
                end
            end
        end
    end
end
return Dmu_P2
