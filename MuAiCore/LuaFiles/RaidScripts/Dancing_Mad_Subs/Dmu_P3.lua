local Dmu_P3 = {}

Dmu_P3.StateName = "P3"

---@type DancingMad
local DM
---@type MuAiGuide
local MG

local markIndex = {
    [336] = 1,
    [337] = 2,
    [338] = 3,
    [339] = 4,
    [437] = 5,
    [438] = 6,
    [439] = 7,
    [440] = 8,
}

-- 死认记号模式
local catchMarkMap

-- 在哪些阶段修妖修正
local needFixState = {
    'P3BlackHole2_1',
    'P3BlackHole2_2',
    'P3BlackHole3_1',
    'P3BlackHole3_2',
}

local Cfg = function()
    return MG.Config.DmuCfg.P3
end

local Data = function()
    if MG.DancingMad == nil then
        return nil
    end
    return MG.DancingMad.P3
end

local bossChaos, bossExDeath

--- 水火画图
local drawFireWater = function(buffId)
    if not Cfg().draw then
        return
    end
    ---@type ShapeDrawer
    local drawer
    local object
    if buffId == 1600 then
        drawer = DM.redDrawer
        object = Data().Elements.Fire
    elseif buffId == 1601 then
        drawer = DM.cyanDrawer
        object = Data().Elements.Water
    end

    local anyHasBuff = false
    for _, member in pairs(MG.Party) do
        local buff = TensorCore.getBuff(member.id, buffId)
        if buff ~= nil then
            anyHasBuff = true
            if buff.duration < 7 then
                local curMember = TensorCore.mGetEntity(member.id)
                if buffId == 1600 then
                    drawer:addCircle(curMember.pos.x, curMember.pos.y, curMember.pos.z, 5, 5)
                elseif buffId == 1601 then
                    drawer:addDonut(curMember.pos.x, curMember.pos.y, curMember.pos.z, 4, 10)
                end
                if Data().Elements.BuffStart[buffId] == false then
                    Data().Elements.BuffStart[buffId] = true
                end
            end
        end
    end
    if Data().Elements.BuffStart[buffId] then
        -- 所有人都没BUFF,且没有开始计时
        if anyHasBuff == false and Data().Elements.BuffEndTimer[buffId] == 0 then
            Data().Elements.BuffEndTimer[buffId] = Now()
        end

        if Data().Elements.BuffEndTimer[buffId] ~= 0
                and TimeSince(Data().Elements.BuffEndTimer[buffId]) > 2000 then
            if buffId == Data().Elements.ShortBuff then
                Data().Elements.Buff1End = true
            else
                Data().Elements.Buff2End = true
            end
        end
        if anyHasBuff or Data().Elements.BuffEndTimer[buffId] ~= 0
                and TimeSince(Data().Elements.BuffEndTimer[buffId]) < 2000 then
            local curFramePlayer = {}
            for _, member in pairs(MG.Party) do
                table.insert(curFramePlayer, TensorCore.mGetEntity(member.id))
            end
            table.sort(curFramePlayer, function(a, b)
                if a.alive and not b.alive then
                    return true
                elseif not a.alive and b.alive then
                    return false
                else
                    return TensorCore.getDistance2d(object.pos, a.pos) < TensorCore.getDistance2d(object.pos, b.pos)
                end
            end)
            if buffId == 1600 then
                drawer:addDonut(curFramePlayer[1].pos.x, curFramePlayer[1].pos.y, curFramePlayer[1].pos.z, 4, 10)
                drawer:addDonut(curFramePlayer[2].pos.x, curFramePlayer[2].pos.y, curFramePlayer[2].pos.z, 4, 10)
            elseif buffId == 1601 then
                drawer:addCircle(curFramePlayer[1].pos.x, curFramePlayer[1].pos.y, curFramePlayer[1].pos.z, 5)
                drawer:addCircle(curFramePlayer[2].pos.x, curFramePlayer[2].pos.y, curFramePlayer[2].pos.z, 5)
            end
        end
    end
end

--- 画经纬
local drawImplosion = function()
    if not Cfg().draw or Data().Implosion.OnDraw == false or Data().Implosion.Timer <= 0 then
        return
    end
    local pos = TensorCore.mGetEntity(bossChaos.id).pos
    local timeSince = TimeSince(Data().Implosion.Timer)
    local skillId = Data().Implosion.skillId
    if timeSince < 8000 then
        if skillId == 47869 then
            if timeSince < 5500 then
                --先打前后
                DM.redDrawer:addCone(pos.x, pos.y, pos.z, 40, math.pi / 2, pos.h)
                DM.redDrawer:addCone(pos.x, pos.y, pos.z, 40, math.pi / 2, pos.h + math.pi)
            else
                DM.redDrawer:addCone(pos.x, pos.y, pos.z, 40, math.pi / 2, pos.h + math.pi / 2)
                DM.redDrawer:addCone(pos.x, pos.y, pos.z, 40, math.pi / 2, pos.h - math.pi / 2)
            end
        elseif skillId == 47870 then
            if timeSince < 5500 then
                DM.redDrawer:addCone(pos.x, pos.y, pos.z, 40, math.pi / 2, pos.h + math.pi / 2)
                DM.redDrawer:addCone(pos.x, pos.y, pos.z, 40, math.pi / 2, pos.h - math.pi / 2)
            else
                DM.redDrawer:addCone(pos.x, pos.y, pos.z, 40, math.pi / 2, pos.h)
                DM.redDrawer:addCone(pos.x, pos.y, pos.z, 40, math.pi / 2, pos.h + math.pi)
            end
        end
    else
        Data().Implosion.Timer = 0
        Data().Implosion.OnDraw = false
    end
end

---检查背对
local lockFaceCheck = function()
    if not Cfg().LockFace or not Data().LockFace.onDoing then
        return
    end
    local player = TensorCore.mGetPlayer()
    if Data().LockFace.buffType == 0 then
        local buff1602 = TensorCore.getBuff(player.id, 1602) --背对buff
        --local buff1603 = TensorCore.getBuff(player.id, 1603) --正对buff 无需获取
        if buff1602 ~= nil then
            Data().LockFace.buffType = 1602
        else
            Data().LockFace.buffType = 1603
        end
    else
        local curBoss = TensorCore.mGetEntity(bossExDeath.id)
        local curBuff = TensorCore.getBuff(player.id, Data().LockFace.buffType)
        if curBuff ~= nil then
            local during = 5.5
            if Cfg().HardLockFace then
                during = 4.5
            end
            -- 真空波读条完成时候，buff剩余4秒（>4 <4.5）所以5秒开始进行背对
            if curBuff.duration < during and Data().LockFace.enable == false then
                MG.Debug('P3 一运自动面向开始')
                local heading
                if Data().LockFace.buffType == 1602 then
                    heading = TensorCore.getHeadingToTarget(curBoss.pos, player.pos)
                else
                    heading = TensorCore.getHeadingToTarget(player.pos, curBoss.pos)
                end
                TensorCore.API.TensorACR.setLockFaceHeading(heading)
                if Cfg().HardLockFace then
                    TensorCore.API.TensorACR.setHardLockFace(true)
                end
                TensorCore.API.TensorACR.toggleLockFace(true)
                Data().LockFace.enable = true
            end
        else
            if Data().LockFace.enable then
                -- buff消失背对结束
                MG.Debug('P3 一运自动面向结束')
                Data().LockFace.onDoing = false
                Data().LockFace.enable = false
                if Cfg().HardLockFace then
                    TensorCore.API.TensorACR.setHardLockFace(false)
                end
                TensorCore.API.TensorACR.toggleLockFace(false)
            end
        end
    end
end

local getBoss = function()
    if bossExDeath == nil then
        for _, ent in pairs(TensorCore.entityList("contentid=6052")) do
            bossExDeath = ent
        end
    end
    if bossChaos == nil then
        for _, ent in pairs(TensorCore.entityList("contentid=7691")) do
            bossChaos = ent
        end
    end
end

--- 绘制暴雷（死刑）
local drawThunderIII = function()
    if not Cfg().draw or not Data().ThunderIII.Start then
        return
    end
    if TimeSince(Data().ThunderIII.Timer) < 8500 then
        local curTarget, distance
        local curEx = TensorCore.mGetEntity(bossExDeath.id)
        MG.OnCurrentPartyDo(function(job, member)
            local dis = TensorCore.getDistance2d(curEx.pos, member.pos)
            if curTarget == nil or distance == nil or dis < distance then
                curTarget = member
                distance = dis
            end
        end)
        if curTarget ~= nil then
            DM.purpleDrawer:addCircle(curTarget.pos.x, curTarget.pos.y, curTarget.pos.z, 5)
        end
    else
        Data().ThunderIII.Timer = 0
        Data().ThunderIII.Start = false
    end
end

local getBuffType = function(player)
    local buff3004 = TensorCore.getBuff(player.id, 3004)
    if buff3004 ~= nil then
        return 3004
    end
    local buff3005 = TensorCore.getBuff(player.id, 3005)
    if buff3005 ~= nil then
        return 3005
    end
    local buff3006 = TensorCore.getBuff(player.id, 3006)
    if buff3006 ~= nil then
        return 3006
    end
    return 0
end

-- 根据buff，使用手摇宏标记自己
local markSelfMacro = function()
    local player = TensorCore.mGetPlayer()
    local buffType = getBuffType(player)
    if buffType == 3004 then
        SendTextCommand('/mk attack <me>')
        Data().Mark.SelfType = 3004
    elseif buffType == 3005 then
        SendTextCommand('/mk bind <me>')
        Data().Mark.SelfType = 3005
    elseif buffType == 3006 then
        SendTextCommand('/mk stop <me>')
        Data().Mark.SelfType = 3006
    end
end

--- 响亮亮耳光画图
local drawSlapHappy = function()
    if not Cfg().draw or not Data().SlapHappy.OnDraw then
        return
    end
    local r3 = 14
    local r = 10
    local distance = { r * 1.414, r, r * 1.414, }
    local curCaster = TensorCore.mGetEntity(Data().SlapHappy.CasterId)
    local curHeading = curCaster.pos.h
    local headingTable
    if Data().SlapHappy.SkillId == 47846 then
        headingTable = {
            curHeading - math.pi * 3 / 4,
            curHeading - math.pi * 1 / 2,
            curHeading - math.pi * 1 / 4,
        }
        local dir = TensorCore.getHeadingToTarget(DM.Center, TensorCore.mGetPlayer().pos)
        DM.litBlue:addCone(100, 0, 100, 30, math.pi / 3, dir)
    elseif Data().SlapHappy.SkillId == 47847 then
        headingTable = {
            curHeading + math.pi * 3 / 4,
            curHeading + math.pi * 1 / 2,
            curHeading + math.pi * 1 / 4,
        }
        local curMt = TensorCore.mGetEntity(MG.Party.MT.id)
        local curH1 = TensorCore.mGetEntity(MG.Party.H1.id)
        local curD1 = TensorCore.mGetEntity(MG.Party.D1.id)
        local dirMt = TensorCore.getHeadingToTarget(DM.Center, curMt.pos)
        local dirH1 = TensorCore.getHeadingToTarget(DM.Center, curH1.pos)
        local dirD1 = TensorCore.getHeadingToTarget(DM.Center, curD1.pos)
        MG.CreateDrawer(0, 0.15, 0.3, 0.4):addCone(100, 0, 100, 20, math.pi / 3, dirMt)
        MG.CreateDrawer(0, 0.3, 0, 0.4):addCone(100, 0, 100, 20, math.pi / 3, dirH1)
        MG.CreateDrawer(0.3, 0, 0, 0.4):addCone(100, 0, 100, 20, math.pi / 3, dirD1)
    end
    for i = 1, 3 do
        local h = headingTable[i]
        local dis = distance[i]
        local pos = TensorCore.getPosInDirection(DM.Center, h, dis)
        if i == 1 then
            pos = TensorCore.getPosInDirection(pos, curCaster.pos.h + math.pi, 6)
        elseif i == 3 then
            pos = TensorCore.getPosInDirection(pos, curCaster.pos.h, 4)
        end
        MG.CreateDrawer(0.9, 0.3, 0):addCircle(pos.x, pos.y, pos.z, r3)
    end
    MG.CreateDrawer(0.7, 0.1, 0):addCircle(100, 0, 100, 6)
    if TimeSince(Data().SlapHappy.Timer) > 9000 then
        Data().SlapHappy.OnDraw = false
        Data().SlapHappy.SkillId = 0
    end
end

---本色出演得的我画图
local drawLookUponMe = function()
    if not Cfg().draw or not Data().LookUponMe.OnDraw then
        return
    end
    local curCaster = TensorCore.mGetEntity(Data().LookUponMe.CasterId)
    local curHeading = curCaster.pos.h
    MG.CreateDrawer(1, 0.1, 0):addCenteredRect(100, 0, 100, 40, 16, curHeading)
    if TimeSince(Data().LookUponMe.Timer) > 5700 then
        Data().LookUponMe.OnDraw = false
        Data().LookUponMe.CasterId = 0
        Data().LookUponMe.Timer = 0
    end
end

-- 画卡奥斯诅咒赦令
local drawDamningEdict = function()
    if not Cfg().draw or not Data().DamningEdict.OnDraw then
        return
    end
    local curCaster = TensorCore.mGetEntity(bossChaos.id)
    local curHeading = curCaster.pos.h
    MG.CreateDrawer(1, 0.5, 0):addRect(curCaster.pos.x, 0, curCaster.pos.z, 50, 50, curHeading)
    if TimeSince(Data().DamningEdict.Timer) > 5000 then
        Data().DamningEdict.OnDraw = false
        Data().DamningEdict.CasterId = 0
        Data().DamningEdict.Timer = 0
    end
end

local getFarestFromChaos = function()
    local curChaos = TensorCore.mGetEntity(bossChaos.id)
    local distance = 0
    local farest = nil
    for _, member in pairs(MG.Party) do
        local curMember = TensorCore.mGetEntity(member.id)
        local dis = TensorCore.getDistance2d(curChaos.pos, curMember.pos)
        if farest == nil or dis > distance then
            distance = dis
            farest = curMember
        end
    end
    return farest
end

local getEntTethers = function(contentId, tetherType)
    local allTethers = Argus.getCurrentTethers()
    if allTethers == nil or table.size(allTethers) == 0 then
        return nil
    end
    local result = {}
    for sourceId, tethers in pairs(allTethers) do
        for _, tether in pairs(tethers) do
            if tetherType == tether.type then
                local object = TensorCore.mGetEntity(sourceId)
                if object.contentid == contentId then
                    table.insert(result, {
                        sourceid = sourceId,
                        targetid = tether.targetid,
                        type = tether.type,
                        flags = tether.flags
                    })
                end
            end
        end
    end
    return result
end

-- 绘制黑洞（防撞）
local drawBlackHole = function()
    local curWave = Data().BlackHolds.wave
    if not Cfg().draw or curWave == 0 then
        return
    end
    local endCnt
    if curWave == 1 or curWave == 4 then
        endCnt = 1
    else
        endCnt = 2
    end
    local startState = 'P3BlackHoleAppear' .. tostring(curWave)
    local endState = 'P3BlackHole' .. tostring(curWave) .. '_' .. tostring(endCnt)
    if DM.OverState(startState, true) and DM.BeLowState(endState, true) then
        for _, obj in pairs(Data().BlackHolds.Object[curWave]) do
            MG.CreateDrawer(1, 0, 0, 0.4, 1):addCircle(obj.pos.x, obj.pos.y, obj.pos.z, 2, true)
        end
        local tethers = getEntTethers(8343, 84)
        if tethers == nil or table.size(tethers) == 0 then
            return
        end
        for _, tether in pairs(tethers) do
            local object = TensorCore.mGetEntity(tether.sourceid)
            local target = TensorCore.mGetEntity(tether.targetid)
            local dir = TensorCore.getHeadingToTarget(object.pos, target.pos)
            DM.litBlue:addRect(object.pos.x, object.pos.y, object.pos.z, 40, 6, dir)
        end
    end
end

local isMarkAllRight = function(markTable)
    -- 检查是否合法
    local cnts = {}
    --重复性和存在性检查 
    for markId, job in pairs(markTable) do
        if cnts[job] == nil then
            cnts[job] = 1
        else
            cnts[job] = cnts[job] + 1
        end
        if cnts[job] > 1 then
            return false
        end
        if markId == 4 or markId == 5 or markId > 10 then
            return false
        end
    end
    return true
end

--- 持续查找玩家标记，直到全部找到为止
local loadMarkPlayer = function()
    if Data().BlackHolds.allMarkFind
            or DM.BeLowState('P3BlackHoleStart')
            or DM.OverState('P3BlackHole4_2')
    then
        return
    end
    if Data().BlackHolds.MarkCheckTimer == nil or
            Data().BlackHolds.MarkCheckTimer == 0
            or TimeSince(Data().BlackHolds.MarkCheckTimer) > 2000 then
        if table.size(Data().BlackHolds.MarkedPlayers) < 8 then
            MG.OnCurrentPartyDo(function(job, member)
                if member.marker ~= nil and member.marker > 0 then
                    Data().BlackHolds.MarkedPlayers[member.marker] = job
                end
            end)
        else
            if table.size(Data().BlackHolds.MarkedPlayers) >= 8 then
                local checkTable
                if Data().BlackHolds.MarkCheckCnt == 0 then
                    local isAllOk = isMarkAllRight(Data().BlackHolds.MarkedPlayers)
                    if isAllOk then
                        Data().BlackHolds.MarkCheckTimer = Now()
                        Data().BlackHolds.MarkCheckCnt = Data().BlackHolds.MarkCheckCnt + 1
                        MG.ArrInfo('第' .. Data().BlackHolds.MarkCheckCnt .. '次头标检测完成')
                    else
                        Data().BlackHolds.MarkedPlayers = {}
                    end
                elseif Data().BlackHolds.MarkCheckTimer ~= nil and Data().BlackHolds.MarkCheckTimer ~= 0
                        and TimeSince(Data().BlackHolds.MarkCheckTimer) > 2000 then
                    checkTable = {}
                    MG.OnCurrentPartyDo(function(job, member)
                        if member.marker ~= nil and member.marker > 0 then
                            checkTable[member.marker] = job
                        end
                    end)
                    local newTableIsOK = isMarkAllRight(checkTable)
                    if newTableIsOK then
                        -- 如果新的表也是合法的，那么对比2个表
                        local isChanged = false
                        for id, job in pairs(checkTable) do
                            if Data().BlackHolds.MarkedPlayers[id] ~= job then
                                isChanged = true
                                break
                            end
                        end
                        Data().BlackHolds.MarkCheckCnt = Data().BlackHolds.MarkCheckCnt + 1
                        if isChanged then
                            Data().BlackHolds.MarkedPlayers = checkTable
                            MG.ArrInfo('第' .. Data().BlackHolds.MarkCheckCnt .. '次头标检测完成，发现变更，已更新头标表格！')
                        else
                            MG.ArrInfo('第' .. Data().BlackHolds.MarkCheckCnt .. '次头标检测完成，未发现变更，维持表格不变！')
                        end
                        Data().BlackHolds.MarkCheckTimer = Now()
                    end
                end
                if Data().BlackHolds.MarkCheckCnt >= 3 then
                    MG.ArrInfo('3次检测完成, 终止检测！')
                    Data().BlackHolds.allMarkFind = true
                end
            end
        end
    end
end

local guideTakeLine = function(curStateGuide, curCnt, isDouble)
    local data = Data().BlackHolds
    -- 当前阶段ID
    local curState = MG.DancingMad.CurrentState
    if data.sourceObject[curState] == nil or table.size(data.sourceObject[curState]) < curCnt then
        --获取场上所有连线
        local tethers = getEntTethers(8343, 84)
        if tethers ~= nil and table.size(tethers) >= curCnt then
            --当前场内线数量保证充足
            --初始化表格
            data.sourceObject[curState] = {}
            -- 获取当前BOSS面向
            local bigKfk = TensorCore.mGetEntity(Data().SlapHappy.CasterId)
            -- 实际计算的12点是BOSS面向的反方向
            local dir = bigKfk.pos.h + math.pi
            -- 从12点开始正点找线
            for i = 1, 8 do
                --当前查找的面向
                local curDir = MG.SetHeading2Pi(dir - (i - 1) * math.pi / 4)
                -- 分析场内线情况并且将其按照12点排序，且将线出发点的黑洞缓存下来
                for _, tether in pairs(tethers) do
                    local fromObj = TensorCore.mGetEntity(tether.sourceid)
                    local teDir = TensorCore.getHeadingToTarget(DM.Center, fromObj.pos)
                    if MG.IsSameDirection(MG.SetHeading2Pi(teDir), curDir, 0.1) then
                        --如果当前面向近似于黑洞方向，则添加到表格，这样循环过后会生成一个自然有序列
                        table.insert(data.sourceObject[curState], fromObj)
                    end
                end
            end
        end
    else
        if data.guideData[curState] == nil then
            data.guideData[curState] = {}
        end
        local guideData = {}
        local doubleLinePos = {}
        local doubleJob = nil
        local takeLineData = {}
        --要的数据都已经获取到了
        for i = 1, #curStateGuide do
            local curMark = curStateGuide[i]
            local curJob = Data().BlackHolds.MarkedPlayers[curMark]
            local curSourceObj = data.sourceObject[curState][i]
            if curJob ~= nil then
                --如果当前标记的人没有找到，跳过
                local curPlayer = TensorCore.mGetEntity(MG.Party[curJob].id)
                local tethers = Argus.getTethersOnEnt(curSourceObj.id)
                local curTarget
                if tethers ~= nil then
                    for _, tether in pairs(tethers) do
                        if tether.type == 84 then
                            curTarget = TensorCore.mGetEntity(tether.partnerid)
                            break
                        end
                    end
                end
                if curTarget ~= nil then
                    if curTarget.id == curPlayer.id then
                        local fromDir = TensorCore.getHeadingToTarget(DM.Center, curSourceObj.pos)
                        if DM.InState('P3BlackHole4_1') then
                            local dir = MG.SetHeading2Pi(fromDir)
                            local bigKfk = TensorCore.mGetEntity(Data().SlapHappy.CasterId)
                            local front = MG.SetHeading2Pi(bigKfk.pos.h)
                            local back = MG.SetHeading2Pi(bigKfk.pos.h + math.pi)
                            local guidePos
                            if MG.IsSame(dir, front) or MG.IsSame(dir, back) then
                                guidePos = TensorCore.getPosInDirection(DM.Center, fromDir - math.pi / 4, 19)
                            else
                                guidePos = TensorCore.getPosInDirection(curSourceObj.pos, front, 4)
                            end
                        else
                            if isDouble then
                                table.insert(doubleLinePos, curSourceObj.pos)
                                doubleJob = curJob
                            else
                                --已经接到了线，那么指路去引导位置
                                if data.guideData[curState][i] == nil then
                                    local curHeading = fromDir - math.pi * 3 / 4
                                    local finalGuidePos = TensorCore.getPosInDirection(curSourceObj.pos, curHeading, 10)
                                    data.guideData[curState][i] = finalGuidePos
                                end
                                guideData[curJob] = data.guideData[curState][i]
                            end
                        end
                    else
                        local needFix = false
                        --修正
                        for _, stateName in pairs(needFixState) do
                            if DM.InState(stateName) then
                                needFix = true
                                break
                            end
                        end
                        local focusPlayer
                        if needFix then
                            local targetMark = catchMarkMap[curMark]
                            if targetMark == nil then
                                focusPlayer = curTarget
                            else
                                if targetMark == curTarget.marker then
                                    focusPlayer = curTarget
                                else
                                    local targetJob = Data().BlackHolds.MarkedPlayers[targetMark]
                                    focusPlayer = TensorCore.mGetEntity(MG.Party[targetJob].id)
                                end
                            end
                        else
                            focusPlayer = curTarget
                        end
                        -- takeLineData[curJob] = { posObj = curSourceObj.pos, posPlayer = focusPlayer.pos, disObj = 4.5, disPlayer = 3, }
                        if takeLineData[curJob] == nil then
                            takeLineData[curJob] = {}
                        end
                        table.insert(takeLineData[curJob], { posObj = curSourceObj.pos, posPlayer = focusPlayer.pos, disObj = 3, disPlayer = 2 })
                    end
                end
            end
        end
        --开始执行绘制：
        if isDouble then
            if table.size(doubleLinePos) > 1 and doubleJob ~= nil then
                local doubleData = {}
                local mid = MG.GetMidPos(doubleLinePos[1], doubleLinePos[2])
                if TensorCore.getDistance2d(DM.Center, mid) < 2 then
                    --倒霉孩子 打场中了
                    local bigKfk = TensorCore.mGetEntity(Data().SlapHappy.CasterId)
                    local dir1 = bigKfk.h + math.pi / 2
                    local dir2 = bigKfk.h - math.pi / 2
                    local pos1 = TensorCore.getPosInDirection(DM.Center, dir1, 12)
                    local pos2 = TensorCore.getPosInDirection(DM.Center, dir2, 12)
                    local curPlayer = TensorCore.mGetEntity(MG.Party[doubleJob].id)
                    local dis1 = TensorCore.getDistance2d(curPlayer.pos, pos1)
                    local dis2 = TensorCore.getDistance2d(curPlayer.pos, pos2)
                    --根据当前位置，判断去左还是右边
                    if dis1 < dis2 then
                        doubleData[doubleJob] = pos1
                    else
                        doubleData[doubleJob] = pos2
                    end
                else
                    doubleData[doubleJob] = mid
                end

                MG.FrameMultiD(doubleData)
            end
        elseif table.size(guideData) > 0 then
            MG.FrameMultiD(guideData)
        end
        if table.size(takeLineData) > 0 then
            MG.MultiTakeLine(takeLineData)
        end
    end
end

--------------------------------------------- event function ---------------------------------------------
--- 初始化
--- @param dm DancingMad
--- @param m MuAiGuide
Dmu_P3.Init = function(dm, m)
    DM = dm
    MG = m
    catchMarkMap = {
        [MG.HeadMark.Bind1] = MG.HeadMark.Attack1,
        [MG.HeadMark.Bind2] = MG.HeadMark.Attack2,
        [MG.HeadMark.Stop1] = MG.HeadMark.Bind1,
        [MG.HeadMark.Stop2] = MG.HeadMark.Bind2,
    }
end

Dmu_P3.OnEntityChannel = function(entityID, spellID, _)
    if spellID == 49890 or spellID == 49891 then
        --决战
        local boss = TensorCore.mGetEntity(entityID)
        if boss.contentid == 6052 then
            bossExDeath = boss
        elseif boss.contentid == 7691 then
            bossChaos = boss
        end
        if DM.OverState('P3UltimaBlaster', true) then
            for i = 1, 8 do
                SendTextCommand("/mk clear <" .. i .. ">")
            end
        end
    elseif spellID == 47869 or spellID == 47870 then
        --经度聚爆 纬度聚爆
        Data().Implosion.Timer = Now()
        Data().Implosion.OnDraw = true
        Data().Implosion.skillId = spellID
    elseif spellID == 47891 then
        -- 真空波
        Data().WacuumWave.Timer = Now()
        Data().WacuumWave.Start = true
        -- 开始检查自动背对
        Data().LockFace.onDoing = true
    elseif spellID == 47890 then
        -- 暴雷，大钢铁
        if DM.InState('P3ElementsStart') then
            Data().Elements.bigCircleTimer = Now()
            Data().Elements.exCasting = true
        end
    elseif spellID == 47881 then
        --死刑暴雷
        Data().ThunderIII.Timer = Now()
        Data().ThunderIII.Start = true
    elseif spellID == 47872 then
        -- 本影暴碎
        Data().UmbraSmash.Start = true
        Data().UmbraSmash.Timer = Now()
    elseif spellID == 50545 or spellID == 50546 then
        --地震，2运开始
        if DM.BeLowState('P3BlackHoleStart') then
            DM.ChangeState('P3BlackHoleStart')
        end
    elseif spellID == 47847 or spellID == 47846 then
        -- 响亮亮耳光----打右--------------打左
        Data().SlapHappy.OnDraw = true
        Data().SlapHappy.Timer = Now()
        Data().SlapHappy.CasterId = entityID
        Data().SlapHappy.SkillId = spellID
    elseif spellID == 47854 then
        -- 本色出演的我
        Data().LookUponMe.OnDraw = true
        Data().LookUponMe.Timer = Now()
        Data().LookUponMe.CasterId = entityID
    elseif spellID == 47873 then
        Data().DamningEdict.OnDraw = true
        Data().DamningEdict.Timer = Now()
    elseif spellID == 47877 then
        if DM.OverState('P3Tower1', true) then
            Data().TakeTower.Timer = Now()
        end
    elseif spellID == 47889 then
        if DM.OverState('P3Tower2', true) then
            AnyoneCore.addTimedWorldTextOnEnt(
                    6000,
                    'Move',
                    TensorCore.mGetPlayer().id,
                    GUI:ColorConvertFloat4ToU32(1, 1, 1, 1),
                    true, 1.5, 2.5
            )
        end
    end
end

Dmu_P3.OnEntityCast = function(entityID, spellID, castPos)
    if spellID == 47858 then
        --深层痛楚
        if DM.BeLowState('P3ElementsStart') then
            DM.ChangeState('P3ElementsStart')
        end
    elseif spellID == 47843 then
        local obj = TensorCore.mGetEntity(entityID)
        table.insert(Data().UltimaBlaster.Lines, obj)
    elseif spellID == 47868 then
        local timer = Data().BlackHolds.JumpTimer
        if timer == 0 or TimeSince(timer) > 2000 then
            -- 只要触发激光射击，且距离前次被射击超过2秒
            -- 进入到下一个阶段
            Data().BlackHolds.JumpTimer = Now()
            DM.GoNextSate()
        end
    end
end

Dmu_P3.OnAOECreate = function(aoeInfo)
    if aoeInfo.aoeID == 47885 then
        table.insert(Data().TakeTower.aoeCache, aoeInfo)
        if table.size(Data().TakeTower.aoeCache) == 8 then
            DM.ChangeState('P3AoePut1')
        elseif table.size(Data().TakeTower.aoeCache) == 16 then
            DM.ChangeState('P3AoePut2')
        end
    elseif aoeInfo.aoeID == 47856 then
        table.insert(Data().TakeTower.castCache, aoeInfo)
        if table.size(Data().TakeTower.castCache) == 2 then
            Data().TakeTower.TimerTower1 = Now()
        elseif table.size(Data().TakeTower.castCache) == 4 then
            Data().TakeTower.TimerTower2 = Now()
        end
    end
end

Dmu_P3.OnMarkerAdd = function(entityID, markerID)
    if markIndex[markerID] ~= nil then
        for job, member in pairs(MG.Party) do
            if member.id == entityID then
                Data().UltimaBlaster.Markers[job] = markerID
                break
            end
        end
        if Data().UltimaBlaster .StartTimer == 0 then
            Data().UltimaBlaster .StartTimer = Now()
        end
    end
    if markerID == 161 and DM.OverState('P3BlackHole4_2', true) then
        for job, member in pairs(MG.Party) do
            if entityID == member.id and Data().TakeTower.isDps == nil then
                local curDir = TensorCore.mGetEntity(Data().SlapHappy.CasterId).pos.h
                local left = TensorCore.getPosInDirection(DM.Center, curDir - math.pi / 2, 10)
                local right = TensorCore.getPosInDirection(DM.Center, curDir + math.pi / 2, 10)
                if Cfg().towerHeading == 2 then
                    left, right = right, left
                end
                -- 先后踩踏的站位
                local dpsFirst, thFirst
                thFirst = { MT = DM.Center, ST = DM.Center, H1 = DM.Center, H2 = DM.Center,
                            D1 = left, D3 = left, D2 = right, D4 = right, }
                if Cfg().towerGround == 1 then
                    dpsFirst = { MT = right, ST = left, H1 = right, H2 = left,
                                 D1 = DM.Center, D3 = DM.Center, D2 = DM.Center, D4 = DM.Center, }
                else
                    dpsFirst = { MT = left, ST = right, H1 = left, H2 = right,
                                 D1 = DM.Center, D3 = DM.Center, D2 = DM.Center, D4 = DM.Center, }
                end

                if MG.IndexOf(MG.JobPosName, job) <= 4 then
                    Data().TakeTower.isDps = false
                    Data().TakeTower.Guide1 = thFirst
                    Data().TakeTower.Guide2 = dpsFirst
                else
                    Data().TakeTower.isDps = true
                    Data().TakeTower.Guide1 = dpsFirst
                    Data().TakeTower.Guide2 = thFirst
                end
                break
            end
        end
    end
end

--Dmu_P3.OnEventObjectScriptFunc = function(entityID, a1, a2, a3)
--end
--
--Dmu_P3.OnAddEntityVFX = function(vfxID)
--end
--
--Dmu_P3.OnMapEffect = function(a1, a2, a3)
--end

Dmu_P3.OnEntityAdd = function(entityID, entityName)
    local obj = TensorCore.mGetEntity(entityID)
    if obj == nil or obj.contentid == nil or obj.contentid ~= 8343 then
        return
    end
    local data = Data().BlackHolds
    table.insert(data.temp, obj)
    if table.size(data.temp) == 11 then
        data.wave = data.wave + 1
        if data.Object[data.wave] == nil then
            data.Object[data.wave] = data.temp
        end
        MG.Info('第' .. data.wave .. '轮黑洞')
        local goState = 'P3BlackHoleAppear' .. tostring(data.wave)
        if DM.BeLowState(goState) then
            DM.ChangeState(goState)
        end
        data.temp = {}
    end
end

Dmu_P3.Update = function()
    getBoss()
    lockFaceCheck()
    drawThunderIII()
    drawSlapHappy()
    drawLookUponMe()
    drawDamningEdict()
    drawBlackHole()
    loadMarkPlayer()
    drawImplosion()
    if Data().Elements.bigCircleTimer > 0 then
        if TimeSince(Data().Elements.bigCircleTimer) < 8500 then
            local boss = TensorCore.mGetEntity(bossExDeath.id)
            DM.purpleDrawer:addCircle(boss.pos.x, 0, boss.pos.z, 15)
        else
            Data().Elements.bigCircleTimer = 0
        end
    end
    -- 第一波buff判定前
    if DM.InState('P3ElementsStart') then
        if Data().Elements.ShortBuff ~= 0 then
            local anyHasShort = false
            for job, member in pairs(MG.Party) do
                if TensorCore.hasBuff(member.id, Data().Elements.ShortBuff) then
                    anyHasShort = true
                end
            end
            if not anyHasShort then
                DM.ChangeState('P3ElementsBuff1')
            end
        end
        if Data().Elements.Fire == nil then
            for _, ent in pairs(TensorCore.entityList("contentid=2015290")) do
                Data().Elements.Fire = ent
            end
        end
        if Data().Elements.Water == nil then
            for _, ent in pairs(TensorCore.entityList("contentid=2015291")) do
                Data().Elements.Water = ent
            end
        end
        if Data().Elements.Wind == nil then
            for _, ent in pairs(TensorCore.entityList("contentid=2015292")) do
                Data().Elements.Wind = ent
            end
        end
        if Data().Elements.Fire ~= nil
                and Data().Elements.Water ~= nil
                and Data().Elements.Wind ~= nil
        then
            if Data().Elements.Guide1 == nil
                    or Data().Elements.Guide2 == nil
                    or table.size(Data().Elements.Guide1) < 8
                    or table.size(Data().Elements.Guide2) < 8
            then
                Data().Elements.Guide1 = {}
                Data().Elements.Guide2 = {}
                local dir = TensorCore.getHeadingToTarget(DM.Center, Data().Elements.Fire.pos)
                Data().Elements.exPull = TensorCore.getPosInDirection(DM.Center, dir + math.pi, 19)
                Data().Elements.chaosPull = TensorCore.getPosInDirection(DM.Center, dir, 19)
                Data().Elements.gather = TensorCore.getPosInDirection(DM.Center, dir, 17)
                local dis1 = TensorCore.getPosInDirection(DM.Center, dir + math.pi / 4, 10)
                local dis2 = TensorCore.getPosInDirection(DM.Center, dir - math.pi / 4, 10)
                --判定时候站位
                Data().Elements.FireBuff = {}
                for job, ent in pairs(MG.Party) do
                    local fireBuff = TensorCore.getBuff(ent.id, 1600)
                    if fireBuff ~= nil then
                        if Data().Elements.LongBuff == 0 or Data().Elements.ShortBuff == 0 then
                            if fireBuff.duration > 30 then
                                Data().Elements.LongBuff = 1600
                                Data().Elements.ShortBuff = 1601
                            else
                                Data().Elements.LongBuff = 1601
                                Data().Elements.ShortBuff = 1600
                            end
                        end
                        table.insert(Data().Elements.FireBuff, job)
                    else
                        Data().Elements.Guide2[job] = Data().Elements.gather
                    end
                end
                table.sort(Data().Elements.FireBuff, function(a, b)
                    return MG.IndexOf(Cfg().fireBuffOrder, a) < MG.IndexOf(Cfg().fireBuffOrder, a)
                end)
                Data().Elements.Guide2[Data().Elements.FireBuff[1]] = dis2
                Data().Elements.Guide2[Data().Elements.FireBuff[2]] = dis1
                -- 这里将最终指路进行拷贝，修改MT ST的初始位置
                Data().Elements.Guide1 = table.deepcopy(Data().Elements.Guide2)
                if Cfg().ExDeathTank == 2 then
                    Data().Elements.Guide1.ST = Data().Elements.chaosPull
                    Data().Elements.Guide1.MT = Data().Elements.exPull
                else
                    Data().Elements.Guide1.ST = Data().Elements.exPull
                    Data().Elements.Guide1.MT = Data().Elements.chaosPull
                end
            else
                -- 这里以exDeath读条为分界
                if Data().Elements.exCasting then
                    MG.FrameMultiD(Data().Elements.Guide2)
                else
                    MG.FrameMultiD(Data().Elements.Guide1)
                end
            end
        end
    end

    -- 画水火判定
    if DM.OverState('P3ElementsStart', true)
            and DM.BeLowState('P3ElementsBuff2', true)
            and not Data().Elements.Buff2End then
        if Data().Elements.ShortBuff ~= nil and Data().Elements.LongBuff ~= nil then
            if Data().Elements.Buff1End then
                drawFireWater(Data().Elements.LongBuff)
            else
                drawFireWater(Data().Elements.ShortBuff)
            end
        end
    end

    -- 第一波BUFF判定后
    if DM.InState('P3ElementsBuff1') then
        local anyHasLong = false
        for _, member in pairs(MG.Party) do
            if TensorCore.hasBuff(member.id, Data().Elements.LongBuff) then
                anyHasLong = true
            end
        end
        if not anyHasLong then
            DM.ChangeState('P3ElementsBuff2')
        end
    end
    -- 第二波buff判定后，检测风buff情况，以player为参考
    if DM.InState('P3ElementsBuff2') then
        if MG.IsAnyMemberHasBuff(1052) then
            DM.ChangeState('P3UltimaBlaster')
        end
        -- 本阶段绘图，超级跳 击退，风圈
        if Data().WacuumWave.Start and Data().WacuumWave.Timer ~= 0 then
            -- 画击退箭头
            local timeSince = TimeSince(Data().WacuumWave.Timer)
            if timeSince < 7700 then
                local player = TensorCore.mGetPlayer()
                local curEx = TensorCore.mGetEntity(bossExDeath.id)
                if Cfg().draw and timeSince > 4000 then
                    DM.greenDrawer:addArrow(
                            player.pos.x, player.pos.y, player.pos.z,
                            TensorCore.getHeadingToTarget(curEx.pos, player.pos),
                            9.6, 0.2, 0.4, 0.2, true
                    )
                end
            elseif Cfg().draw and timeSince < 12700 then
                local drawer = MG.CreateDrawer(0.1, 0.5, 0, 0.1)
                MG.OnCurrentPartyDo(function(job, member)
                    drawer:addCircle(member.pos.x, member.pos.y, member.pos.z, 6)
                end)
            end
        end

        --指路超级跳引导
        if not Data().UmbraSmash.LeadEnd then
            if Data().UmbraSmash.Start
                    and Data().UmbraSmash.Timer ~= 0
                    and TimeSince(Data().UmbraSmash.Timer) > 1500 then
                Data().UmbraSmash.LeadEnd = true
            elseif Cfg().guide then
                if Cfg().superJump == 1 and MG.SelfPos == 'D3'
                        or Cfg().superJump == 2 and MG.SelfPos == 'D4'
                then
                    MG.FrameDirect(Data().Elements.exPull.x, Data().Elements.exPull.z)
                end
            end
        end
        --绘制超级跳范围
        if Cfg().draw then
            if not Data().UmbraSmash.Start or TimeSince(Data().UmbraSmash.Timer) < 30 then
                local farest = getFarestFromChaos()
                if farest ~= nil then
                    if Data().UmbraSmash.LeadPlayer == nil then
                        Data().UmbraSmash.LeadPlayer = farest
                    end
                    DM.redDrawer:addCircle(farest.pos.x, farest.pos.y, farest.pos.z, 18)
                end
            else
                if TimeSince(Data().UmbraSmash.Timer) < 4700 then
                    if Data().UmbraSmash.drawPos == nil then
                        local farest = getFarestFromChaos()
                        Data().UmbraSmash.drawPos = farest.pos
                    end
                    local pos = Data().UmbraSmash.drawPos
                    DM.redDrawer:addCircle(pos.x, pos.y, pos.z, 18)
                end
            end
        end
    end

    if DM.InState('P3UltimaBlaster') then
        if Data().UltimaBlaster.StartTimer ~= 0 and TimeSince(Data().UltimaBlaster.StartTimer) > 14000 then
            DM.ChangeState('P3BlackHolePre')
        end
        if Data().UltimaBlaster.GuideData == nil or table.size(Data().UltimaBlaster.GuideData) < 8 then
            if table.size(Data().UltimaBlaster.Lines) >= 2 and table.size(Data().UltimaBlaster.Markers) >= 8 then
                Data().UltimaBlaster.GuideData = {}
                Data().UltimaBlaster.DrawData = {}
                local line = Data().UltimaBlaster.Lines
                local dir = TensorCore.getHeadingToTarget(DM.Center, line[1].pos)
                if MG.GetClock(line[1].pos, line[2].pos) then
                    for i = 1, 8 do
                        local curDir = dir + (i - 1) * math.pi / 4
                        local curPos = TensorCore.getPosInDirection(DM.Center, curDir, 20)
                        local aimPos = TensorCore.getPosInDirection(DM.Center, curDir + math.pi + math.pi / 8, 19)
                        Data().UltimaBlaster.DrawData[i] = { from = curPos, target = aimPos }
                    end
                else
                    for i = 1, 8 do
                        local curDir = dir - (i - 1) * math.pi / 4
                        local curPos = TensorCore.getPosInDirection(DM.Center, curDir, 20)
                        local aimPos = TensorCore.getPosInDirection(DM.Center, curDir + math.pi - math.pi / 8, 19)
                        Data().UltimaBlaster.DrawData[i] = { from = curPos, target = aimPos }
                    end
                end
                for job, member in pairs(MG.Party) do
                    local curMark = Data().UltimaBlaster.Markers[job]
                    local curIndex = markIndex[curMark]
                    Data().UltimaBlaster.GuideData[job] = Data().UltimaBlaster.DrawData[curIndex].target
                end
            end
        else
            if Cfg().guide then
                MG.FrameMultiD(Data().UltimaBlaster.GuideData)
            end
            if Cfg().draw then
                for job, member in pairs(MG.Party) do
                    local curMark = Data().UltimaBlaster.Markers[job]
                    local curIndex = markIndex[curMark]
                    local curDrawData = Data().UltimaBlaster.DrawData[curIndex]
                    local curMember = TensorCore.mGetEntity(member.id)
                    local dir = TensorCore.getHeadingToTarget(curDrawData.from, curMember.pos)
                    DM.litBlue:addRect(curDrawData.from.x, curDrawData.from.y, curDrawData.from.z, 40, 10, dir)
                end
            end
        end
    end

    if DM.InState('P3BlackHoleStart') then
        if Cfg().markType ~= 1 and not Data().Mark.Finish then
            if Cfg().markType == 2 then
                -- 开始检查Buff
                if Cfg().delayMark then
                    local anyHasMark = false
                    MG.OnCurrentPartyDo(function(job, member)
                        if member.marker ~= nil and member.marker > 0 then
                            anyHasMark = true
                            return true
                        end
                    end)
                    if anyHasMark then
                        markSelfMacro()
                    end
                else
                    markSelfMacro()
                end
                if Data().Mark.SelfType ~= 0 then
                    Data().Mark.Finish = true
                end
            elseif Cfg().markType == 3 then
                local buffMap = {}
                -- 开始检查全队buff
                for job, member in pairs(MG.Party) do
                    local buffType = getBuffType(member)
                    if buffType ~= 0 then
                        buffMap[job] = buffType
                    end
                end
                -- 全队都有buff
                if table.size(buffMap) >= 8 then
                    Data().Mark.BuffTypeMap = buffMap
                    for i = 1, #Cfg().markOrder do
                        local job = Cfg().markOrder[i]
                        local curMember = MG.Party[job]
                        local buffType = buffMap[job]
                        local curMarkId
                        if buffType == 3004 then
                            curMarkId = MG.HeadMark.Attack1 + Data().Mark.MarkCnt[buffType]
                        elseif buffType == 3005 then
                            curMarkId = MG.HeadMark.Bind1 + Data().Mark.MarkCnt[buffType]
                        elseif buffType == 3006 then
                            curMarkId = MG.HeadMark.Stop1 + Data().Mark.MarkCnt[buffType]
                        end
                        MG.MarkParty(curMarkId, curMember.id)
                        Data().Mark.MarkCnt[buffType] = Data().Mark.MarkCnt[buffType] + 1
                        if MG.IsVideo() then
                            --如果回放，直接输出出来方便debug
                            MG.Info('对' .. curMember.name .. '标注了“' .. MG.GetHeadMarkCN(curMarkId) .. '”标记。')
                        end
                    end
                    Data().Mark.Finish = true
                end
            end
        end
    end

    if Cfg().guide then
        --第一轮黑洞
        if Cfg().takeLineAttack12 then
            if DM.InState('P3BlackHoleAppear1') then
                guideTakeLine({ MG.HeadMark.Attack2 }, 1)
            end
            if DM.InState('P3BlackHole1_1') then
                guideTakeLine({ MG.HeadMark.Attack1, MG.HeadMark.Attack1 }, 2, true)
            end
        else
            if DM.InState('P3BlackHoleAppear1') then
                guideTakeLine({ MG.HeadMark.Attack1 }, 1)
            end
            if DM.InState('P3BlackHole1_1') then
                guideTakeLine({ MG.HeadMark.Attack1, MG.HeadMark.Attack2 }, 2)
            end
        end

        --第二轮黑洞
        if DM.InState('P3BlackHoleAppear2') then
            guideTakeLine({ MG.HeadMark.Attack1, MG.HeadMark.Attack2, MG.HeadMark.Attack3 }, 3)
        end
        if DM.InState('P3BlackHole2_1') then
            guideTakeLine({ MG.HeadMark.Bind1, MG.HeadMark.Attack2, MG.HeadMark.Attack3 }, 3)
        end
        if DM.InState('P3BlackHole2_2') then
            guideTakeLine({ MG.HeadMark.Bind1, MG.HeadMark.Bind2, MG.HeadMark.Attack3 }, 3)
        end

        --第三轮黑洞
        if DM.InState('P3BlackHoleAppear3') then
            guideTakeLine({ MG.HeadMark.Bind1, MG.HeadMark.Bind2, MG.HeadMark.Bind3 }, 3)
        end
        if DM.InState('P3BlackHole3_1') then
            guideTakeLine({ MG.HeadMark.Stop1, MG.HeadMark.Bind2, MG.HeadMark.Bind3 }, 3)
        end
        if DM.InState('P3BlackHole3_2') then
            guideTakeLine({ MG.HeadMark.Stop1, MG.HeadMark.Stop2, MG.HeadMark.Bind3 }, 3)
        end

        if Cfg().takeLineStop22 then
            --第四轮黑洞
            if DM.InState('P3BlackHoleAppear4') then
                guideTakeLine({ MG.HeadMark.Stop2, MG.HeadMark.Stop2 }, 2, true)
            end
            if DM.InState('P3BlackHole4_1') then
                guideTakeLine({ MG.HeadMark.Stop1 }, 1)
            end
        else
            --第四轮黑洞
            if DM.InState('P3BlackHoleAppear4') then
                guideTakeLine({ MG.HeadMark.Stop1, MG.HeadMark.Stop2 }, 2)
            end
            if DM.InState('P3BlackHole4_1') then
                guideTakeLine({ MG.HeadMark.Stop2 }, 1)
            end
        end

        if DM.InState('P3AoePut2') and Data().TakeTower.Guide1 ~= nil then
            if Data().TakeTower.TimerTower1 ~= 0
                    and TimeSince(Data().TakeTower.TimerTower1) > 1500 then
                DM.ChangeState('P3Tower1')
            else
                MG.FrameMultiD(Data().TakeTower.Guide1)
            end
        end
        if DM.InState('P3Tower1') and Data().TakeTower.Guide2 ~= nil then
            if Data().TakeTower.TimerTower2 ~= 0
                    and TimeSince(Data().TakeTower.TimerTower2) > 1500 then
                DM.ChangeState('P3Tower2')
            else
                MG.FrameMultiD(Data().TakeTower.Guide2)
            end
        end
        if DM.InState('P3Tower2') then
            local isFinish = false
            if Data().TakeTower.Timer ~= 0 and TimeSince(Data().TakeTower.Timer) > 800 then
                for job, member in pairs(MG.Party) do
                    if Data().TakeTower.isDps == true then
                        local curMember = TensorCore.mGetEntity(member.id)
                        if MG.IndexOf(MG.JobPosName, job) <= 4 then
                            isFinish = true
                            DM.redDrawer:addTimedCircle(4000, curMember.pos.x, curMember.pos.y, curMember.pos.z, 6)
                        end
                    else
                        local curMember = TensorCore.mGetEntity(member.id)
                        if MG.IndexOf(MG.JobPosName, job) > 4 then
                            isFinish = true
                            DM.redDrawer:addTimedCircle(4000, curMember.pos.x, curMember.pos.y, curMember.pos.z, 6)
                        end
                    end
                end
                DM.ChangeState('P3End')
            end
        end
    end
end
return Dmu_P3