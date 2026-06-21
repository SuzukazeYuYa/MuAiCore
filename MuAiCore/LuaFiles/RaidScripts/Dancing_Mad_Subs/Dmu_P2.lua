local Dmu_P2 = {}

Dmu_P2.StateName = "P2"

---@type DancingMad
local DM
---@type MuAiGuide
local MG

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

-- 踩塔站位模版
local standTemplate = {
    odd = {-- 奇数
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
    even = { --偶数
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
        -- 奇数,uptime站位，数据由群友提供
        doing = {  --分摊半径5  钢铁半径5  塔半径4 正逆时针旋转，负顺时针旋转
            [1] = { isLeft = true, dis = 1, dir = math.pi }, --左分摊 站目标圈上
            [2] = { isLeft = true, dis = 3.8, dir = 0 }, --左扇形
            [3] = { isLeft = false, dis = 3.8, dir = 0 }, --右钢铁
            [4] = { isLeft = false, dis = 3.8, dir = math.pi }, --右分摊
        },
        standBy = {
            [1] = { isLeft = true, dis = 4.4, dir = math.pi }, --左闲人分摊
            [2] = { isLeft = true, dis = 4.4, dir = 0 }, --左闲人引导扇形
            [3] = { isLeft = false, dis = 4.4, dir = math.pi }, --右闲人分摊
            [4] = { isLeft = false, dis = 4.4, dir = math.pi }, --右闲人分摊
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
              :addCone(curCaster.pos.x, curCaster.pos.y, curCaster.pos.z, 21, math.pi, dir)
        end
    else
        Data().Towers.kickTimer = 0
        Data().Towers.kickBoss = {}
        Data().Towers.kickDrawing = false
    end
end

local resetKickTimer = function()
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

    -- 如果是扇左钢右，对B组进行调整
    if MG.Config.DmuCfg.P2.fixType == 2 then
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

---计算扇左钢右第一次当闲人时候的情况
local calcFix = function()
    local last = Data().Towers.groupOrders[3]
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

local calcGuidePos = function(wave)
    local dirL = TensorCore.getHeadingToTarget(DM.Center, Data().Towers.spawn[wave].left)
    local dirR = TensorCore.getHeadingToTarget(DM.Center, Data().Towers.spawn[wave].right)
    local curDoingPos = {}
    local curTemplate
    if wave % 2 ~= 0 then
        if MG.Config.DmuCfg.P2.fixType == 3 then
            curTemplate = standTemplate.odd_uptime
        else
            curTemplate = standTemplate.odd
        end
    else
        curTemplate = standTemplate.even
    end
    for i = 1, #curTemplate.doing do
        local t = curTemplate.doing[i]
        if t.isLeft then
            local curDir = dirL + t.dir
            curDoingPos[i] = TensorCore.getPosInDirection(Data().Towers.spawn[wave].left, curDir, t.dis)
        else
            local curDir = dirR + t.dir
            curDoingPos[i] = TensorCore.getPosInDirection(Data().Towers.spawn[wave].right, curDir, t.dis)
        end
    end

    local curStbPos = {}
    for i = 1, #curTemplate.standBy do
        local t = curTemplate.standBy[i]
        if t.isLeft then
            local curDir = dirL + t.dir
            curStbPos[i] = TensorCore.getPosInDirection(Data().Towers.spawn[wave].left, curDir, t.dis)
        else
            local curDir = dirR + t.dir
            curStbPos[i] = TensorCore.getPosInDirection(Data().Towers.spawn[wave].right, curDir, t.dis)
        end
    end
    local guideData = {}
    local standBy = Data().Towers.standBy
    if MG.Config.DmuCfg.P2.fixType == 2 and wave == 4 then
        standBy = calcFix()
    end
    for i = 1, 4 do
        local curDoingJob = Data().Towers.groupOrders[wave][i]
        local curStanByJob = standBy[i]
        guideData[curDoingJob] = curDoingPos[i]
        guideData[curStanByJob] = curStbPos[i]
    end
    return guideData
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
            --扇左钢右, TH组钢铁 在右边，且面向BOSS H左T右近左远右
            curOrder = { group[3], group[4], group[2], group[1] }
        else
            --TH组钢铁，RMTH
            curOrder = { group[4], group[3], group[1], group[2] }
        end
    else
        --DPS组钢铁，THRM, 闲固和扇左钢右一致
        curOrder = { group[1], group[2], group[4], group[3] }
    end
    Data().Towers.groupOrders[index] = curOrder
end

local calcGroupOrder = function(wave)
    if Data().Towers.groupOrders[wave] ~= nil then
        return
    end
    if wave == 1 then
        calcFirstOrderA()
    else
        if table.size(Data().Towers.markCache) < 4 then
            return
        end
        local lstOdr = Data().Towers.groupOrders[wave - 1]
        if wave % 2 == 0 then
            local curWave
            if wave == 4 then
                curWave = 8
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

-- 近U情况， 点名为扇形时候，对自身站位进行动态处理
local type3FixPos = function(wave)
    if (wave % 2) == 0
            or not table.contains(Data().Towers.doing, MG.SelfPos)
            or Data().Towers.curMarks[MG.SelfPos] ~= 717
    then
        return Data().Towers.GuideData[wave]
    end
    local leftTower = Data().Towers.spawn[wave].left
    local curGather, curJob, curGuidePos
    for _, job in pairs(Data().Towers.doing) do
        local player = TensorCore.mGetEntity(MG.Party[job].id)
        if TensorCore.getDistance2d(player.pos, leftTower) < 4 and Data().Towers.curMark[job] == 715 then
            curGather = player
            curJob = job
            break
        end
    end
    if curGather ~= nil then
        local leftHeading = TensorCore.getHeadingToTarget(DM.Center, leftTower)
        -- 计算出从这个人触发，去4.5米距离，如果在塔外，那么不做修正
        local pos = TensorCore.getPosInDirection(curGather.pos, leftHeading, 4.5)
        if TensorCore.getDistance2d(pos, leftTower) < 3.8 then
            curGuidePos = pos
        end
    end
    if curGuidePos ~= nil then
        local guideData = table.deepcopy(Data().Towers.GuideData[wave])
        guideData[MG.SelfPos] = curGuidePos
        return guideData
    else
        return Data().Towers.GuideData[wave]
    end
end

---引导过去未来
local guideFuturePastOrTakeTower = function()
    local waves = { 3, 5, 7 }
    local wave = Data().Towers.wave
    local guideData
    if Cfg().fixType == 3 then
        guideData = type3FixPos(wave)
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
            or Data().Towers.wave == 0
            or DM.OverState('P2T8End', true)
    then
        return
    end
    local wave = Data().Towers.wave
    local mid = MG.GetMidPos(Data().Towers.spawn[wave].left, Data().Towers.spawn[wave].right)
    local dir = TensorCore.getHeadingToTarget(DM.Center, mid)
    local startPos = TensorCore.getPosInDirection(DM.Center, dir, 20)
    MG.CreateDrawer(1, 1, 1, 1, 1):addArrow(startPos.x, 0, startPos.z, dir + math.pi, 39.5, 0.05, 0.5, 0.5, true)
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
        if Cfg().draw then
            local heading
            if spellID == 47821 then
                --打左边
                heading = -math.pi / 2
            else
                heading = math.pi / 2
            end
            DM.purpleDrawer:addTimedRect(4000, 100, 0, 100, 20, 40, heading)
        end
    elseif spellID == 50311 then
        Data().FarNearDeath.Timer = Now()
        Data().FarNearDeath.OnDraw = true
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

Dmu_P2.OnAOECreate = function(aoeInfo)
end

Dmu_P2.OnEventObjectScriptFunc = function(entityID, a1, a2, a3)
    local object = TensorCore.mGetEntity(entityID)
    if object.contentid == 2015154 or object.contentid == 2015155 then
        calcTrinePos(object, a1, a2, a3)
    end
end

Dmu_P2.OnAddEntityVFX = function(vfxID)

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
    if Data().FarNearDeath.OnDraw
            and Cfg().draw
            and Data().FarNearDeath.Timer > 0
    then
        if TimeSince(Data().FarNearDeath.Timer) < 5000 then
            local curParty = MG.GetPartyPlayers()
            table.sort(curParty, function(a, b)
                local disA = TensorCore.getDistance2d(DM.Center, a.pos)
                local disB = TensorCore.getDistance2d(DM.Center, b.pos)
                return disA < disB
            end)
            DM.purpleDrawer:addCircle(curParty[1].pos.x, 0, curParty[1].pos.z, 6)
            DM.purpleDrawer:addCircle(curParty[8].pos.x, 0, curParty[8].pos.z, 6)
        else
            Data().FarNearDeath.OnDraw = false
            Data().FarNearDeath.Timer = 0
        end
    end
    if DM.InState('P2T8InitMark') and Data().Towers.wave > 0 then
        local wave = Data().Towers.wave
        if Data().Towers.GuideData[wave] == nil or table.size(Data().Towers.GuideData[wave]) < 8 then
            if Data().Towers.groupOrders[wave] == nil then
                calcGroupOrder(wave)
            else
                Data().Towers.GuideData[wave] = calcGuidePos(wave)
            end
        end
        if MG.Config.Main.LogToEchoMsg and Data().Towers.groupOrders[wave] ~= nil and not loged[wave] then
            showOrderLog(Data().Towers.groupOrders[wave], '当前踩塔组顺序：')
            loged[wave] = true
        end
        if Cfg().draw then
            local color = GUI:ColorConvertFloat4ToU32(1, 0, 0, 0)
            local drawer = Argus2.ShapeDrawer:new(color, color, color, GUI:ColorConvertFloat4ToU32(1, 0, 0, 1), 2)
            local left = Data().Towers.spawn[wave].left
            local right = Data().Towers.spawn[wave].right
            drawer:addCircle(left.x, 0, left.z, 4, true)
            drawer:addCircle(right.x, 0, right.z, 4, true)
            for job, member in pairs(MG.Party) do
                if table.contains(Data().Towers.doing, job) then
                    local curMember = TensorCore.mGetEntity(member.id)
                    if TensorCore.getDistance2d(curMember.pos, left) < 4 or TensorCore.getDistance2d(curMember.pos, right) < 4 then
                        local curMark = Data().Towers.curMarks[job]
                        if curMark == 715 then
                            -- 分摊
                            DM.greenDrawer:addCircle(curMember.pos.x, 0, curMember.pos.z, 5)
                        elseif curMark == 716 then
                            -- 钢铁
                            DM.redDrawer:addCircle(curMember.pos.x, 0, curMember.pos.z, 5)
                        elseif curMark == 717 then
                            -- 扇形
                            local nearest = nil
                            local dis = 1000
                            for _, mmb in pairs(MG.Party) do
                                if mmb.id ~= curMember.id then
                                    local memberNew = TensorCore.mGetEntity(mmb.id)
                                    local distance = TensorCore.getDistance2d(memberNew.pos, curMember.pos)
                                    if distance < dis then
                                        dis = distance
                                        nearest = memberNew
                                    end
                                end
                            end
                            if nearest ~= nil then
                                local dir = TensorCore.getHeadingToTarget(curMember.pos, nearest.pos)
                                MG.CreateDrawer(0, 0.5, 1, 0.3)
                                  :addCone(curMember.pos.x, 0, curMember.pos.z, 40, math.pi / 2, dir)
                            end
                        end
                    end
                end
            end
            if wave % 2 == 0 then
                local curParty = MG.GetPartyPlayers()
                table.sort(curParty, function(a, b)
                    return TensorCore.getDistance2d(a.pos, DM.Center) < TensorCore.getDistance2d(b.pos, DM.Center)
                end)
                for i = 1, 4 do
                    DM.purpleDrawer:addCircle(curParty[i].pos.x, 0, curParty[i].pos.z, 5)
                end
            end
        end
        if Data().Towers.GuideData[wave] ~= nil and table.size(Data().Towers.GuideData[wave]) >= 8 then
            guideFuturePastOrTakeTower()
        end
    end

    if Data().Towers.wave == 8
            and TimeSince(Data().Towers.Timer) > 10000
            and DM.BeLowState('P2T8End')
    then
        DM.ChangeState('P2T8End')
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
                    DM.redDrawer:addCircle(drawPos.x, 0, drawPos.z, 6)
                end
            end
            if Cfg().trineDrawType == 2 and preIndex ~= nil and Data().Trine.DrawPos[preIndex] ~= nil then
                for _, drawPos in pairs(Data().Trine.DrawPos[preIndex]) do
                    DM.yellowDrawer:addCircle(drawPos.x,0, drawPos.z, 6)
                end
            end
        end
    end
end
return Dmu_P2