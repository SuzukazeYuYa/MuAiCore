local Dmu_P1 = {}
Dmu_P1.StateName = "P1"

---@type DancingMad
local DM

---@type MuAiGuide
local MG

local Cfg = function()
    return MG.Config.DmuCfg.P1
end

local Data = function()
    if MG.DancingMad == nil then
        return nil
    end
    return MG.DancingMad.P1
end
local mtGroup = { 'MT', 'H1', 'D1', 'D3' }
local thGroup = { 'MT', 'ST', 'H1', 'H2' }
local ArrowBuffs = {
    [4876] = 'up',
    [4877] = 'down',
    [4878] = 'right',
    [4879] = 'left',
    [5079] = 'up',
    [5080] = 'down',
    [5081] = 'right',
    [5082] = 'left',
}

local TeleTrouncingPos = {
    ['up_up'] = { { x = 112, z = 100 }, { x = 112, z = 106 } },
    ['left_left'] = { { x = 100, z = 88 }, { x = 106, z = 88 } },
    ['down_down'] = { { x = 88, z = 100 }, { x = 88, z = 94 } },
    ['right_right'] = { { x = 100, z = 112 }, { x = 94, z = 112 } },
    ['right_up'] = { up = { x = 112, z = 112 }, right = { x = 106, z = 112 } },
    ['up_left'] = { left = { x = 112, z = 88 }, up = { x = 112, z = 94 } },
    ['left_down'] = { down = { x = 88, z = 88 }, left = { x = 94, z = 88 } },
    ['down_right'] = { right = { x = 88, z = 112 }, down = { x = 88, z = 106 } },
}

local TeleTrouncingPos2 = {
    ['up_up'] = { { x = 112, z = 99 }, { x = 112, z = 106 } },
    ['left_left'] = { { x = 99, z = 88 }, { x = 106, z = 88 } },
    ['down_down'] = { { x = 88, z = 99 }, { x = 88, z = 94 } },
    ['right_right'] = { { x = 99, z = 112 }, { x = 94, z = 112 } },
    ['right_up'] = { up = { x = 112, z = 112 }, right = { x = 106, z = 112 } },
    ['up_left'] = { left = { x = 112, z = 88 }, up = { x = 112, z = 94 } },
    ['left_down'] = { down = { x = 88, z = 88 }, left = { x = 94, z = 88 } },
    ['down_right'] = { right = { x = 88, z = 112 }, down = { x = 88, z = 106 } },
}

local dis24 = {
    MT = { x = 94, y = 0, z = 100.5 },
    ST = { x = 99.5, y = 0, z = 106 },
    H1 = { x = 84, y = 0, z = 100.5 },
    H2 = { x = 99.5, y = 0, z = 116 },
    D1 = { x = 106, y = 0, z = 99.5 },
    D2 = { x = 100.5, y = 0, z = 94 },
    D3 = { x = 116, y = 0, z = 99.5 },
    D4 = { x = 100.5, y = 0, z = 84 },
}

local dis13 = {
    MT = { x = 99.5, y = 0, z = 94 },
    ST = { x = 94, y = 0, z = 99.5 },
    H1 = { x = 99.5, y = 0, z = 84 },
    H2 = { x = 84, y = 0, z = 99.5 },

    D1 = { x = 100.5, y = 0, z = 106 },
    D2 = { x = 106, y = 0, z = 100.5 },
    D3 = { x = 100.5, y = 0, z = 116 },
    D4 = { x = 116, y = 0, z = 100.5 },
}

--- 绘制击退
local drawBuffKick = function()
    if not Cfg().draw then
        return
    end
    local buffPlayer = {}
    local buffPlayerId = {}
    local needDo = false
    for _, member in pairs(MG.Party) do
        local buff = TensorCore.getBuff(member.id, 5078)
        if buff and buff.duration < 4 then
            local curMember = TensorCore.mGetEntity(member.id)
            table.insert(buffPlayer, curMember)
            table.insert(buffPlayerId, curMember.id)
            needDo = true
        end
    end
    if needDo then
        local player = TensorCore.mGetPlayer()
        for _, curMember in pairs(buffPlayer) do
            DM.cyanDrawer:addCircle(curMember.pos.x, curMember.pos.y, curMember.pos.z, 6)
            if not table.contains(buffPlayerId, player.id) then
                local distance = TensorCore.getDistance2d(curMember.pos, player.pos)
                if distance < 6 then
                    local kickDis = 15
                    local heading = TensorCore.getHeadingToTarget(curMember.pos, player.pos)
                    DM.greenDrawer:addArrow(player.pos.x, player.pos.y, player.pos.z, heading, kickDis - 0.4, 0.2, 0.4, 0.2, true)
                end
            end
        end
    end
end

--- 检查扇形死刑
local CheckConeDeath = function()
    if Data().Death.InState and Data().Death.Timer > 0 then
        if TimeSince(Data().Death.Timer) < 9000 then
            if TimeSince(Data().Death.Timer) < 6000 then
                if Cfg().draw then
                    if Data().Death.MT == nil then
                        Data().Death.MT = TensorCore.getEntityByGroup("Main Tank", "Nearest")
                    else
                        local curMt = TensorCore.mGetEntity(Data().Death.MT.id)
                        local dir = TensorCore.getHeadingToTarget(MG.CurRaidBoss.pos, curMt.pos)
                        local curBoss = MG.GetCurRaidBoss()
                        if curBoss ~= nil then
                            DM.redDrawer:addCone(curBoss.pos.x, curBoss.pos.y, curBoss.pos.z, 30, math.pi * 2 / 3, dir)
                        end
                    end
                end
            else
                if Cfg().draw then
                    if Data().Death.ST == nil then
                        local curMt = TensorCore.getEntityByGroup("Main Tank", "Nearest")
                        for job, member in pairs(MG.Party) do
                            if (job == 'MT' or job == 'ST') and member.id ~= curMt then
                                Data().Death.ST = member
                                break
                            end
                        end
                    else
                        local cur = TensorCore.mGetEntity(Data().Death.MT.id)
                        local dir = TensorCore.getHeadingToTarget(MG.CurRaidBoss.pos, cur.pos)
                        local curBoss = MG.GetCurRaidBoss()
                        if curBoss ~= nil then
                            DM.redDrawer:addCone(curBoss.pos.x, curBoss.pos.y, curBoss.pos.z, 30, math.pi * 2 / 3, dir)
                        end
                    end
                end
            end
        else
            Data().Death.InState = false
            Data().Death.MT = nil
            Data().Death.ST = nil
            Data().Death.Timer = 0
            if DM.InState('P1Line2_2') then
                DM.ChangeState('P1DeathBfLine3')
            end
        end
    end
end

--- 缓存自动背对 data by string
local autoLookAtCache = function(entityID, a1, a2, a3)
    if not Cfg().autoLookAt then
        return
    end
    local obj = TensorCore.mGetEntity(entityID)
    local enabled = (a1 == 64 and a2 == 128) or (a2 == 64 and a3 == 128)
    local cid = obj.contentid or obj.contentID
    if cid ~= 2015166 and cid ~= 2015167 or not enabled then
        return
    end
    Data().AutoLookAt.boss = obj
    Data().AutoLookAt.Timer = Now()
end

--- 画半场刀 data by string

local halfGroupAOE = function(entityID, a1, a2, a3)
    if not Cfg().draw or not ((a1 == 64 and a2 == 128) or (a2 == 64 and a3 == 128)) then
        return
    end
    local obj = TensorCore.mGetEntity(entityID)
    local x, heading
    if obj.contentid == 2015164 then
        x = 90
        heading = -math.pi / 2
    elseif obj.contentid == 2015165 then
        x = 110
        heading = math.pi / 2
    else
        return
    end
    DM.purpleDrawer:addTimedCenteredRect(5150, x, 0, 100, 20, 42, heading)
end

--- 紫圈爆炸
local shitBoom = function(entityID, a1, a2, a3)
    if not (a1 == 4 and a2 == 8 and a3 == 0) then
        return
    end
    local boomObj = TensorCore.mGetEntity(entityID)
    if boomObj == nil or boomObj.contentid ~= 2015266 then
        return
    end
    table.insert(Data().Shit.Boomed, boomObj)
end

--- 自动背对 执行/取消
local autoLookAtUpdate = function()
    if not Cfg().autoLookAt or Data().AutoLookAt.Timer == 0 then
        return
    end
    if TimeSince(Data().AutoLookAt.Timer) < 11000 then
        if TimeSince(Data().AutoLookAt.Timer) > 8000
                and not Data().AutoLookAt.enable
        then
            local player = TensorCore.mGetPlayer()
            local boss = Data().AutoLookAt.boss
            local heading = TensorCore.getHeadingToTarget(player.pos, boss.pos)
            if boss.contentid == 2015166 then
                heading = heading + math.pi;
            end
            Data().AutoLookAt.enable = true
            TensorCore.API.TensorACR.setLockFaceHeading(heading)
            if Cfg().hardLock then
                TensorCore.API.TensorACR.setHardLockFace(true)
            end
            TensorCore.API.TensorACR.toggleLockFace(true)
            MG.Info('P1锁定面向开始，面向：' .. string.format("%.2f", heading))
        end
    else
        Data().AutoLookAt.Timer = 0
        Data().AutoLookAt.enable = false
        if Cfg().hardLock then
            TensorCore.API.TensorACR.setHardLockFace(false)
        end
        TensorCore.API.TensorACR.toggleLockFace(false)
        MG.Info('P1锁定面向结束。')
    end
end

-- 2、3次被连线画图和指路
local guideAndDrawL2L3 = function(lineData)
    if Cfg().draw then
        for _, id in pairs(lineData.DisPlayers) do
            local player = TensorCore.mGetEntity(id)
            MG.CreateDrawer(1, 0.5, 0, 0.3, 2):addCircle(player.pos.x, player.pos.y, player.pos.z, 5)
        end
    end
    if Cfg().guide then
        if lineData.Guide2 == nil then
            lineData.Guide2 = {}
            for job, member in pairs(MG.Party) do
                if table.contains(lineData.DisPlayers, member.id) then
                    if job == 'MT' or job == 'D1' then
                        lineData.Guide2[job] = { x = 108, y = 0, z = 95 }
                    elseif job == 'ST' or job == 'D2' then
                        lineData.Guide2[job] = { x = 92, y = 0, z = 105 }
                    elseif job == 'H1' or job == 'D3' then
                        lineData.Guide2[job] = { x = 88, y = 0, z = 94 }
                    elseif job == 'H2' or job == 'D4' then
                        lineData.Guide2[job] = { x = 112, y = 0, z = 106 }
                    end
                else
                    lineData.Guide2[job] = { x = 100, y = 0, z = 100 }
                end
            end
        else
            MG.FrameMultiD(lineData.Guide2)
        end
    end
end

--- buff传递
local turnBuff = function(dataTable, stateChangeFunc)
    if stateChangeFunc() then
        DM.ChangeState(dataTable.NextState)
    else
        if dataTable.BuffJobs == nil then
            local buffJob = {}
            for job, member in pairs(MG.Party) do
                if TensorCore.hasBuff(member.id, 5078) then
                    table.insert(buffJob, job)
                end
            end
            if table.size(buffJob) >= 2 then
                dataTable.BuffJobs = buffJob
                if table.contains(buffJob, MG.SelfPos) then
                    dataTable.SelfGroupTurner = MG.SelfPos
                else
                    for _, job in pairs(buffJob) do
                        if (table.contains(thGroup, job) and table.contains(thGroup, MG.SelfPos))
                                or (not table.contains(thGroup, job) and not table.contains(thGroup, MG.SelfPos))
                        then
                            dataTable.SelfGroupTurner = job
                            break
                        end
                    end
                end
            end
        else
            if Cfg().guide then
                local guideData = {}
                local dpsJob, thJob
                -- 填入
                for _, job in pairs(dataTable.BuffJobs) do
                    if table.contains(thGroup, job) then
                        thJob = job
                        guideData[job] = dataTable.thGroupGuidePos
                    else
                        dpsJob = job
                        guideData[job] = dataTable.dpsGroupGuidePos
                    end
                end

                local dpsObj = TensorCore.mGetEntity(MG.Party[dpsJob].id)
                local thObj = TensorCore.mGetEntity(MG.Party[thJob].id)
                local disDps = TensorCore.getDistance2d(dpsObj.pos, guideData[dpsJob])
                local disTh = TensorCore.getDistance2d(thObj.pos, guideData[thJob])
                for job, _ in pairs(MG.Party) do
                    if table.contains(thGroup, job) then
                        if job ~= thJob then
                            if disTh < 3 then
                                guideData[job] = {
                                    x = thObj.pos.x + dataTable.offSetTh.x,
                                    y = thObj.pos.y + dataTable.offSetTh.y,
                                    z = thObj.pos.z + dataTable.offSetTh.z,
                                }
                            else
                                guideData[job] = {
                                    x = guideData[thJob].x + dataTable.offSetTh.x,
                                    y = guideData[thJob].y + dataTable.offSetTh.y,
                                    z = guideData[thJob].z + dataTable.offSetTh.z,
                                }
                            end
                        end
                    else
                        if job ~= dpsJob then
                            if disDps < 2 then
                                guideData[job] = {
                                    x = dpsObj.pos.x + dataTable.offSetDps.x,
                                    y = dpsObj.pos.y + dataTable.offSetDps.y,
                                    z = dpsObj.pos.z + dataTable.offSetDps.z,
                                }
                            else
                                guideData[job] = {
                                    x = guideData[dpsJob].x + dataTable.offSetDps.x,
                                    y = guideData[dpsJob].y + dataTable.offSetDps.y,
                                    z = guideData[dpsJob].z + dataTable.offSetDps.z,
                                }
                            end
                        end
                    end
                end
                MG.FrameMultiD(guideData)
            end
        end
    end
end

-- 计算出移动表
local getThunderMoveTable = function(curThunders)
    local moveTable = {}
    local thunderType = DM.CalcThunderType(curThunders)
    if thunderType == DM.ThunderType.Right13 then
        moveTable.H1 = math.pi / 4
        moveTable.MT = math.pi / 4
        moveTable.H2 = math.pi / 4
        moveTable.D4 = math.pi / 4
        moveTable.D2 = math.pi / 4
        moveTable.D3 = math.pi / 4
        moveTable.D1 = math.pi * 5 / 4
        moveTable.ST = math.pi * 5 / 4
    elseif thunderType == DM.ThunderType.Right24 then
        moveTable.H1 = math.pi * 5 / 4
        moveTable.MT = math.pi * 5 / 4
        moveTable.H2 = math.pi * 5 / 4
        moveTable.D4 = math.pi * 5 / 4
        moveTable.D2 = math.pi * 5 / 4
        moveTable.D3 = math.pi * 5 / 4
        moveTable.D1 = math.pi / 4
        moveTable.ST = math.pi / 4
    elseif thunderType == DM.ThunderType.Left13 then
        moveTable.H1 = math.pi * 7 / 4
        moveTable.D1 = math.pi * 7 / 4
        moveTable.D4 = math.pi * 7 / 4
        moveTable.H2 = math.pi * 7 / 4
        moveTable.ST = math.pi * 7 / 4
        moveTable.D3 = math.pi * 7 / 4
        moveTable.MT = math.pi * 3 / 4
        moveTable.D2 = math.pi * 3 / 4
    elseif thunderType == DM.ThunderType.Left24 then
        moveTable.H1 = math.pi * 3 / 4
        moveTable.D1 = math.pi * 3 / 4
        moveTable.D4 = math.pi * 3 / 4
        moveTable.H2 = math.pi * 3 / 4
        moveTable.ST = math.pi * 3 / 4
        moveTable.D3 = math.pi * 3 / 4
        moveTable.MT = math.pi * 7 / 4
        moveTable.D2 = math.pi * 7 / 4
    end
    return moveTable
end

--- 真假火画图
local drawFire = function(dataTable)
    if not Cfg().draw then
        return
    end
    if dataTable.PlayerMark == 127
            or table.size(dataTable.GatherPlayers) >= 2 then
        local radius = 5
        local drawTime = 6000
        if dataTable.BossMark == 673 then
            --火是假的
            if dataTable.PlayerMark == 127 then
                DM.greenDrawer:addTimedCircleOnEnt(drawTime, TensorCore.mGetPlayer().id, radius)
            else
                for _, member in pairs(MG.Party) do
                    DM.redDrawer:addTimedCircleOnEnt(drawTime, member.id, radius)
                end
            end
        else
            --真的
            if dataTable.PlayerMark == 127 then
                for _, member in pairs(MG.Party) do
                    DM.redDrawer:addTimedCircleOnEnt(drawTime, member.id, radius)
                end
            else
                for _, id in pairs(dataTable.GatherPlayers) do
                    DM.greenDrawer:addTimedCircleOnEnt(drawTime, id, radius)
                end
            end
        end
    end
end

--------------------------------------------- event function ---------------------------------------------
--- 初始化
--- @param dm DancingMad
--- @param m MuAiGuide
Dmu_P1.Init = function(dm, m)
    DM = dm
    MG = m
end

Dmu_P1.OnEntityChannel = function(entityID, spellID, _)
    if spellID == 50179 then
        -- 恶狠狠毁荡
        Data().Death.Timer = Now()
        Data().Death.InState = true
        MG.CurRaidBoss = TensorCore.mGetEntity(entityID)
    elseif spellID == 47764 then
        if DM.BeLowState('P1TrueFalse1', true) then
            DM.ChangeState('P1TrueFalse1')
        end
    elseif spellID == 48370 then
        -- 众神之像
        if DM.InState('P1DeathBfLine2') then
            -- 死刑后，开始处理线
            DM.ChangeState('P1Line2Start')
        end
        -- 回转寿司后的众神之象 = 神像连线那次; 记时, 之后延迟到连环环陷阱(击退)判定后才画站位
        if Data().Link ~= nil and Data().Link.sushiSeenTime ~= nil
                and TimeSince(Data().Link.sushiSeenTime) < 10000 then
            Data().Link.gsTime = Now()
        end
    elseif spellID == 50722 then
        -- 制裁之光，接3连死刑

    elseif spellID == 47782 then
        -- 连环环陷阱
    end
end

Dmu_P1.OnEntityCast = function(entityID, spellID, castPos)
    if spellID == 50722 then
        local mt = TensorCore.getEntityByGroup("Main Tank", "Nearest")
        MG.CreateDrawer(1, 0.5, 0, nil, 2):addTimedCircleOnEnt(9000, mt.id, 5)
    elseif spellID == 47801 or spellID == 47802 then
        -- 唰啦啦传送
        if DM.BeLowState('P1TeleTrouncing') then
            DM.ChangeState('P1TeleTrouncing')
        end
    end
end

Dmu_P1.OnMarkerAdd = function(entityID, markerID)
    local DataTable
    if DM.BeLowState('P1TrueFalse1', true) then
        if DM.BeLowState('P1TrueFalse1') then
            DM.ChangeState('P1TrueFalse1')
        end
        DataTable = Data().Fire1
    elseif DM.OverState('P1SleepOrConfused') then
        DataTable = Data().FireThunder
    end
    if DataTable ~= nil then
        if markerID == 127 or markerID == 128 then
            DataTable.PlayerMark = markerID
            if markerID == 128 then
                table.insert(DataTable.GatherPlayers, entityID)
            end
        elseif markerID == 673 or markerID == 674 then
            DataTable.BossMark = markerID
        end
    end
end

---@param aoeInfo DirectionalAOE
Dmu_P1.OnAOECreate = function(aoeInfo)
    -- 画制冰和雷
    --if Cfg().draw then
    --    local drawTime = 5500
    --    if not MG.Config.DmuCfg.BindEffect then
    --        -- 冰危险区
    --        if aoeInfo.aoeID == 47774 or aoeInfo.aoeID == 47768 then
    --            DM.yellowDrawer:addTimedCone(drawTime, aoeInfo.x, aoeInfo.y, aoeInfo.z, 40, math.pi / 2, aoeInfo.heading, 0, true)
    --        end
    --        -- 画雷危险区
    --        if aoeInfo.aoeID == 47775 or aoeInfo.aoeID == 47777 then
    --            local startPos = TensorCore.getPosInDirection({ x = aoeInfo.x, y = aoeInfo.y, z = aoeInfo.z }, aoeInfo.heading + math.pi, 5)
    --            DM.yellowDrawer:addTimedRect(drawTime, startPos.x, startPos.y, startPos.z, 50, 10, aoeInfo.heading, 0, true)
    --        end
    --    else
    --        -- 冰危险区
    --        if aoeInfo.aoeID == 47774 or aoeInfo.aoeID == 47768 then
    --            DM.purpleDrawer:addTimedCone(drawTime, aoeInfo.x, aoeInfo.y, aoeInfo.z, 20, math.pi / 2, aoeInfo.heading)
    --        end
    --
    --        -- 画雷危险区
    --        if aoeInfo.aoeID == 47775 or aoeInfo.aoeID == 47777 then
    --            MG.CreateDrawer(0.5, 0, 1, nil, 2):addTimedRect(drawTime, aoeInfo.x, aoeInfo.y, aoeInfo.z, 40, 10, aoeInfo.heading)
    --        end
    --    end
    --end

    if DM.BeLowState('P1TrueFalse2', true) and (aoeInfo.aoeID == 47774 or aoeInfo.aoeID == 47768) then
        if Data().Fire1.iceDir == nil then
            Data().Fire1.iceDir = MG.SetHeading2Pi(aoeInfo.heading)
        end
    end

    if (aoeInfo.aoeID == 47775 or aoeInfo.aoeID == 47777)
            and DM.InState('P1FireThunder')
    then
        if Data().FireThunder.MoveTable == nil then
            local moveTable = getThunderMoveTable(aoeInfo)
            if moveTable ~= nil and table.size(moveTable) > 0 then
                Data().FireThunder.MoveTable = moveTable
            end
        end
    end

    if (aoeInfo.aoeID == 47774 or aoeInfo.aoeID == 47768)
            and DM.InState('P1Line2Start')
            and Data().Line2.dangerDir == nil
    then
        -- 采集冰方向
        Data().Line2.dangerDir = aoeInfo.heading
    end

    -- 激光-采集刷的塔信息
    if aoeInfo.aoeID == 47786 and DM.BeLowState('P2Start') then
        table.insert(Data().Tower.Aoe, aoeInfo)
        if table.size(Data().Tower.Aoe) == 4 then
            table.sort(Data().Tower.Aoe, function(t1, t2)
                return t1.x < t2.x
            end)
        end
    end
end

Dmu_P1.OnEventObjectScriptFunc = function(entityID, a1, a2, a3)
    autoLookAtCache(entityID, a1, a2, a3)
    halfGroupAOE(entityID, a1, a2, a3)
    shitBoom(entityID, a1, a2, a3)
end

Dmu_P1.OnAddEntityVFX = function(vfxID)

end

Dmu_P1.OnTetherChange = function(sourceEntityID, oldTetherID, oldTetherFlags, oldTargetID, newTetherID, newTetherFlags, newTargetID)
    if oldTetherID ~= 0 and newTetherID == 0 then
        if DM.BeLowState('P1TrueFalse1End', true) then
            Data().Fire1.linkGuideFinish = true
        end
        local fromObj = TensorCore.mGetEntity(sourceEntityID)
        if fromObj.contentid == 7132 then
            -- 线消失
            if DM.InState('P1Line2Start') then
                local oldTarget = TensorCore.mGetEntity(oldTargetID)
                if oldTarget ~= nil and oldTarget.charType == 4 then
                    DM.ChangeState('P1Line2_1')
                    Data().Line2.Timer = Now()
                end
            elseif DM.InState('P1Line2_1')
                    and Data().Line2.Timer > 0
                    and TimeSince(Data().Line2.Timer) > 3000 then
                local oldTarget = TensorCore.mGetEntity(oldTargetID)
                if oldTarget ~= nil and oldTarget.charType == 4 then
                    DM.ChangeState('P1Line2_2')
                end
            elseif DM.InState('P1DeathBfLine3') then
                local oldTarget = TensorCore.mGetEntity(oldTargetID)
                if oldTarget ~= nil and oldTarget.charType == 4 then
                    DM.ChangeState('P1Line3_1')
                    Data().Line3.Timer = Now()
                end
            elseif DM.InState('P1Line3_1')
                    and Data().Line3.Timer > 0
                    and TimeSince(Data().Line3.Timer) > 3000 then
                local oldTarget = TensorCore.mGetEntity(oldTargetID)
                if oldTarget ~= nil and oldTarget.charType == 4 then
                    DM.ChangeState('P1Line3_2')
                end
            end
        end
    end
end

Dmu_P1.Update = function()
    autoLookAtUpdate()  
    CheckConeDeath()
    drawBuffKick()   
    if Cfg().draw
            and (DM.InState('P1Line3_1') or DM.InState('P1Line3_2'))
            and Data().Line3.Shits ~= nil and table.size(Data().Line3.Shits) >= 0
    then
        for _, ent in pairs(Data().Line3.Shits) do
            local color = GUI:ColorConvertFloat4ToU32(1, 0, 0, 0)
            local drawer = Argus2.ShapeDrawer:new(color, color, color, GUI:ColorConvertFloat4ToU32(1, 0, 0, 1), 2)
            drawer:addCircle(ent.pos.x, ent.pos.y, ent.pos.z, 5, true)
        end
    end
    -- 一神击退范围画图
    if DM.BeLowState('P1TrueFalse2', true) then
        if Cfg().draw then
            local kickDis = 10
            local player = TensorCore.mGetPlayer()
            local hasLine, tether = MG.HasLine(player.id, 45)
            if hasLine and tether ~= nil then
                local from = TensorCore.mGetEntity(tether.partnerid)
                if from ~= nil then
                    local heading = TensorCore.getHeadingToTarget(from.pos, player.pos)
                    DM.greenDrawer:addArrow(player.pos.x, player.pos.y, player.pos.z,
                            heading, kickDis - 0.4, 0.2, 0.4, 0.2, true)
                end
            end
        end
    end
    -- 真假火开始
    if DM.InState('P1TrueFalse1') then
        -- 真假火画图
        if Data().Fire1.BossMark ~= 0 and Data().Fire1.PlayerMark ~= 0 then
            drawFire(Data().Fire1)
            DM.ChangeState('P1TrueFalse2')
        end
    end
    -- 真假火判定 转阶段
    if DM.InState('P1TrueFalse2') then
        if MG.IsAnyMemberHasBuff(2941) then
            DM.ChangeState('P1TrueFalse1End')
            Data().Fire1.Time = Now()
        end
        if Cfg().guide and Data().Fire1.iceDir ~= nil then
            local dataTable = Data().Fire1
            if dataTable.GuideData == nil then
                dataTable.GuideData = {}
                if dataTable.PlayerMark == 127 or table.size(dataTable.GatherPlayers) >= 2 then
                    if dataTable.BossMark == 673 then
                        --火是假的
                        if dataTable.PlayerMark == 127 then
                            --点名分散，实际是分摊
                            if (0 < dataTable.iceDir and dataTable.iceDir < math.pi / 2)
                                    or (math.pi < dataTable.iceDir and dataTable.iceDir < math.pi * 3 / 2)
                            then
                                -- 如果危险区在13象限
                                for job, _ in pairs(MG.Party) do
                                    if table.contains(thGroup, job) then
                                        dataTable.GuideData[job] = { x = 96, y = 0, z = 104 }
                                    else
                                        dataTable.GuideData[job] = { x = 104, y = 0, z = 96 }
                                    end
                                end
                            else
                                for job, _ in pairs(MG.Party) do
                                    if table.contains(thGroup, job) then
                                        dataTable.GuideData[job] = { x = 96, y = 0, z = 96 }
                                    else
                                        dataTable.GuideData[job] = { x = 104, y = 0, z = 104 }
                                    end
                                end
                            end
                        else
                            if (0 < dataTable.iceDir and dataTable.iceDir < math.pi / 2)
                                    or (math.pi < dataTable.iceDir and dataTable.iceDir < math.pi * 3 / 2)
                            then
                                -- 如果危险区在13象限
                                dataTable.GuideData = dis24
                            else
                                dataTable.GuideData = dis13
                            end
                        end
                    else
                        --真的
                        if dataTable.PlayerMark == 127 then
                            --点名分散
                            if (0 < dataTable.iceDir and dataTable.iceDir < math.pi / 2)
                                    or (math.pi < dataTable.iceDir and dataTable.iceDir < math.pi * 3 / 2)
                            then
                                -- 如果危险区在13象限
                                dataTable.GuideData = dis24
                            else
                                dataTable.GuideData = dis13
                            end
                        else
                            --点名分摊
                            if (0 < dataTable.iceDir and dataTable.iceDir < math.pi / 2)
                                    or (math.pi < dataTable.iceDir and dataTable.iceDir < math.pi * 3 / 2)
                            then
                                -- 如果危险区在13象限
                                for job, _ in pairs(MG.Party) do
                                    if table.contains(thGroup, job) then
                                        dataTable.GuideData[job] = { x = 96, y = 0, z = 104 }
                                    else
                                        dataTable.GuideData[job] = { x = 104, y = 0, z = 96 }
                                    end
                                end
                            else
                                for job, _ in pairs(MG.Party) do
                                    if table.contains(thGroup, job) then
                                        dataTable.GuideData[job] = { x = 96, y = 0, z = 96 }
                                    else
                                        dataTable.GuideData[job] = { x = 104, y = 0, z = 104 }
                                    end
                                end
                            end
                        end
                    end
                end
            else
                if Data().Fire1.linkGuideFinish then
                    MG.FrameMultiD(dataTable.GuideData)
                else
                    if Data().Fire1.GuideDataLink == nil then
                        Data().Fire1.GuideDataLink = {}
                        for job, ent in pairs(MG.Party) do
                            if MG.HasLine(ent.id, 45) then
                                if table.contains(thGroup, job) then
                                    Data().Fire1.GuideDataLink[job] = { x = 98, y = 0, z = 88 }
                                else
                                    Data().Fire1.GuideDataLink[job] = { x = 102, y = 0, z = 88 }
                                end
                            else
                                Data().Fire1.GuideDataLink[job] = dataTable.GuideData[job]
                            end
                        end
                    else
                        MG.FrameMultiD(dataTable.GuideDataLink)
                    end
                end
            end
        end
    end
    -- 真假火结束，准备激光
    if DM.OverState('P1TrueFalse1End', true) and DM.BeLowState('P1BeamEnd') then
        if Cfg().draw then
            -- 画激光
            local point = { x = 100, y = 0, z = 70 }
            for _, member in pairs(MuAiGuide.Party) do
                local curMember = TensorCore.mGetEntity(member.id)
                if curMember ~= nil then
                    local dir = TensorCore.getHeadingToTarget(point, curMember.pos)
                    DM.cyanDrawer:addRect(point.x, point.y, point.z, 60, 6, dir, false)
                end
            end
        end
        if Cfg().guide then
            --这里可能涉及计算
            if Data().Beam.Order == nil then
                Data().Beam.Order = Cfg().BeamOrder
            end
            local curParty = {}
            for job, member in pairs(MG.Party) do
                curParty[job] = TensorCore.mGetEntity(member.id)
            end

            -- 一字横排法
            local beamWay = {
                [Data().Beam.Order[1]] = { x = 80.5, z = 100 },
                [Data().Beam.Order[8]] = { x = 119.5, z = 100 },
            }
            for i = 2, 7 do
                local curJob = Data().Beam.Order[i]
                local leftPlayer = curParty[Data().Beam.Order[i - 1]]
                local rightPlayer = curParty[Data().Beam.Order[i + 1]]
                beamWay[curJob] = { x = (leftPlayer.pos.x + rightPlayer.pos.x) / 2, z = 100 }
            end
            MG.FrameMultiD(beamWay)
        end

        if TimeSince(Data().Fire1.Time) > 1500 and MG.IsAnyMemberHasBuff(2941) then
            DM.ChangeState('P1BeamEnd')
            Data().Beam.Time = Now()
        end
    end
    -- 激光射完了
    if DM.InState('P1BeamEnd') then
        -- 计算被射了的人
        if Data().Beam.Order ~= nil and Data().Beam.Shoot == nil then
            local shoot = {}
            for _, job in pairs(Data().Beam.Order) do
                local member = MG.Party[job]
                if TensorCore.hasBuff(member.id, 2941) then
                    table.insert(shoot, job)
                end
            end
            if table.size(shoot) >= 4 then
                Data().Beam.Shoot = shoot
            end
        end
        --计算没被射的人
        if Data().Beam.Order ~= nil
                and Data().Beam.Shoot ~= nil
                and Data().Beam.UnShoot == nil
        then
            local unshoot = {}
            for _, job in pairs(Data().Beam.Order) do
                if not table.contains(Data().Beam.Shoot, job) then
                    table.insert(unshoot, job)
                end
            end
            Data().Beam.UnShoot = unshoot
        end

        -- 激光判定小于4秒，指路踩塔
        if TimeSince(Data().Beam.Time) < 4000 then
            if table.size(Data().Beam.Shoot) >= 4
                    and table.size(Data().Tower.Aoe) >= 4
            then
                if Cfg().guide then
                    -- 计算踩塔指路位置
                    if Data().Tower.GuideData == nil then
                        Data().Tower.GuideData = {}
                        for _, job in pairs(Data().Beam.Order) do
                            if table.contains(Data().Beam.Shoot, job) then
                                local curIdx = MG.IndexOf(Data().Beam.Shoot, job)
                                local tower = Data().Tower.Aoe[curIdx]
                                Data().Tower.GuideData[job] = { x = tower.x, z = tower.z + 5 }
                            else
                                local curIdx = MG.IndexOf(Data().Beam.UnShoot, job)
                                local tower = Data().Tower.Aoe[curIdx]
                                Data().Tower.GuideData[job] = { x = tower.x, z = tower.z }
                            end
                        end
                    else
                        MG.FrameMultiD(Data().Tower.GuideData)
                    end
                end
            end
        else
            -- 超过4秒进入传毒阶段
            DM.ChangeState('P1BuffTurn1')
        end
    end
    -- 第一次传毒
    if DM.InState('P1BuffTurn1') then
        turnBuff(Data().Turn1, function()
            return MG.IsAnyMemberHasBuff(5078, 50)
        end)
    end
    -- 第一次放圈前
    if DM.InState('P1Line2Start') then
        -- 可能线还没出现，所以要找一帧确认4个人都有的情况
        if Data().Line2.GatherPlayers == nil or table.size(Data().Line2.GatherPlayers) < 4 then
            Data().Line2.GatherPlayers = {}
            for _, member in pairs(MG.Party) do
                local tethers = Argus.getTethersOnEnt(member)
                if tethers ~= nil and table.size(tethers) > 0 then
                    for _, tether in pairs(tethers) do
                        if tether.type == 45 then
                            local linkFrom = TensorCore.mGetEntity(tether.partnerid)
                            if linkFrom.pos.x < 110 then
                                table.insert(Data().Line2.GatherPlayers, member.id)
                                break
                            end
                        end
                    end
                end
            end
        else
            if Cfg().draw then
                for _, id in pairs(Data().Line2.GatherPlayers) do
                    local player = TensorCore.mGetEntity(id)
                    MG.CreateDrawer(0.2, 0, 0.6, 0.3, 2):addCircle(player.pos.x, player.pos.y, player.pos.z, 5)
                end
            end
        end
        if Cfg().guide then
            if Data().Line2.Guide1 == nil then
                if Data().Line2.dangerDir ~= nil then
                    Data().Line2.Guide1 = {}
                    local dir = MG.SetHeading2Pi(Data().Line2.dangerDir)
                    if (math.pi / 2 < dir and dir < math.pi) or (math.pi * 3 / 2 < dir and dir < 2 * math.pi) then
                        for job, _ in pairs(MG.Party) do
                            if table.contains(mtGroup, job) then
                                Data().Line2.Guide1[job] = { x = 99.5, y = 0, z = 81 }
                            else
                                Data().Line2.Guide1[job] = { x = 100.5, y = 0, z = 119 }
                            end
                        end
                    else
                        for job, _ in pairs(MG.Party) do
                            if table.contains(mtGroup, job) then
                                Data().Line2.Guide1[job] = { x = 100.5, y = 0, z = 81 }
                            else
                                Data().Line2.Guide1[job] = { x = 99.5, y = 0, z = 119 }
                            end
                        end
                    end
                else
                    if Data().Line2.Guide0 == nil then
                        Data().Line2.Guide0 = {}
                        for job, _ in pairs(MG.Party) do
                            if table.contains(mtGroup, job) then
                                Data().Line2.Guide0[job] = { x = 100, y = 0, z = 81 }
                            else
                                Data().Line2.Guide0[job] = { x = 100, y = 0, z = 119 }
                            end
                        end
                    else
                        MG.FrameMultiD(Data().Line2.Guide0)
                    end
                end
            else
                MG.FrameMultiD(Data().Line2.Guide1)
            end
        end
    end
    -- 对一次放圈后分撒
    if DM.InState('P1Line2_1') then
        if Data().Line2.DisPlayers == nil then
            Data().Line2.DisPlayers = {}
            for _, member in pairs(MG.Party) do
                if not table.contains(Data().Line2.GatherPlayers, member.id) then
                    table.insert(Data().Line2.DisPlayers, member.id)
                end
            end
        else
            guideAndDrawL2L3(Data().Line2)
        end
    end
    -- 第二次扇形死刑后
    if DM.InState('P1DeathBfLine3') then
        if Data().Line3.Guide1 == nil
                or Data().Line3.GatherPlayers == nil
                or table.size(Data().Line3.GatherPlayers) < 4 then
            Data().Line3.Guide1 = {}
            Data().Line3.DisPlayers = {}
            Data().Line3.GatherPlayers = {}
            --找到前次黑泥，
            local upZ = 0
            local downZ = 1000
            for _, ent in pairs(TensorCore.entityList("contentid=2015266")) do
                if ent.pos.z > 100 then
                    if ent.pos.z < downZ then
                        downZ = ent.pos.z
                    end
                else
                    if ent.pos.z > upZ then
                        upZ = ent.pos.z
                    end
                end
            end
            for job, member in pairs(MG.Party) do
                if table.contains(mtGroup, job) then
                    Data().Line3.Guide1[job] = { x = 100, y = 0, z = upZ + 6 }
                else
                    Data().Line3.Guide1[job] = { x = 100, y = 0, z = downZ - 6 }
                end
                local tethers = Argus.getTethersOnEnt(member)
                if tethers ~= nil and table.size(tethers) > 0 then
                    for _, tether in pairs(tethers) do
                        if tether.type == 45 then
                            local linkFrom = TensorCore.mGetEntity(tether.partnerid)
                            if linkFrom.pos.x > 110 then
                                table.insert(Data().Line3.DisPlayers, member.id)
                            else
                                table.insert(Data().Line3.GatherPlayers, member.id)
                            end
                        end
                    end
                end
            end
        else
            MG.FrameMultiD(Data().Line3.Guide1)
            if Cfg().draw then
                for _, id in pairs(Data().Line3.GatherPlayers) do
                    local player = TensorCore.mGetEntity(id)
                    MG.CreateDrawer(0.2, 0, 0.6, 0.3, 2):addCircle(player.pos.x, player.pos.y, player.pos.z, 5)
                end
            end
        end
    end
    -- 第二次放圈后分散
    if DM.InState('P1Line3_1') then
        guideAndDrawL2L3(Data().Line3)
        if Data().Line3.Shits == nil or table.size(Data().Line3.Shits) < 8 then
            Data().Line3.Shits = {}
            for _, ent in pairs(TensorCore.entityList("contentid=2015266")) do
                table.insert(Data().Line3.Shits, ent)
                if ent.pos.z > 100 then
                    if Data().Line3.DownShit == nil or ent.pos.z < Data().Line3.DownShit.pos.z then
                        Data().Line3.DownShit = ent
                    end
                else
                    if Data().Line3.UpShit == nil or ent.pos.z > Data().Line3.UpShit.pos.z then
                        Data().Line3.UpShit = ent
                    end
                end
            end
        end
    end
    
    -- 第二次传毒
    if DM.InState('P1Line3_2') then
        if Data().Turn2.thGroupGuidePos == nil or
                Data().Turn2.dpsGroupGuidePos == nil
        then
            Data().Turn2.thGroupGuidePos = {
                x = Data().Line3.UpShit.pos.x,
                y = Data().Line3.UpShit.pos.y,
                z = Data().Line3.UpShit.pos.z + 5.5
            }
            Data().Turn2.dpsGroupGuidePos = {
                x = Data().Line3.DownShit.pos.x,
                y = Data().Line3.DownShit.pos.y,
                z = Data().Line3.DownShit.pos.z - 5.5
            }
        else
            turnBuff(Data().Turn2, function()
                return MG.IsAnyMemberHasBuff(5078, 40)
            end)
        end
    end

    if DM.InState('P1Turn2End') then
        if table.size(Data().Shit.Boomed) >= 8 then
            DM.ChangeState('P1ShitBoom')
        end
        if Data().Shit.StateTimer == 0 then
            Data().Shit.StateTimer = Now()
        end
        if TimeSince(Data().Shit.StateTimer) > 1200 then
            local player = MG.GetPlayer()
            if Data().Shit.Guide1 == nil
                    or Data().Shit.Guide2 == nil
            then
                if player.pos.z > 100 then
                    Data().Shit.Guide1 = Data().Line3.DownShit.pos
                    Data().Shit.Guide2 = MG.VectorXZAdd(Data().Line3.DownShit.pos, { x = 0, y = 0, z = 6 })
                else
                    Data().Shit.Guide1 = Data().Line3.UpShit.pos
                    Data().Shit.Guide2 = MG.VectorXZAdd(Data().Line3.UpShit.pos, { x = 0, y = 0, z = -6 })
                end
            else
                if Data().Shit.first then
                    for _, shit in pairs(Data().Shit.Boomed) do
                        if TensorCore.getDistance2d(shit.pos, player.pos) < 6 then
                            Data().Shit.first = false
                        end
                    end
                    MG.FrameDirect(Data().Shit.Guide1.x, Data().Shit.Guide1.z)
                else
                    MG.FrameDirect(Data().Shit.Guide2.x, Data().Shit.Guide2.z)
                end
            end
        end
    end
    --箭头
    if DM.InState('P1TeleTrouncing') then
        for buffId, buffType in pairs(ArrowBuffs) do
            if TensorCore.hasBuff(TensorCore.mGetPlayer().id, buffId) then
                DM.ChangeState('P1TeleTrouncingGetBuff')
                Data().TeleTrouncing.Timer = Now()
                break
            end
        end
    end

    if DM.InState('P1TeleTrouncingGetBuff')
            and Data().TeleTrouncing.Timer ~= 0
            and TimeSince(Data().TeleTrouncing.Timer) > 500
    then
        if Data().TeleTrouncing.BuffInfo == nil or table.size(Data().TeleTrouncing.BuffInfo) < 8 then
            Data().TeleTrouncing.BuffInfo = {}
            Data().TeleTrouncing.Guide1 = {}
            Data().TeleTrouncing.Guide2 = {}
            local buffInfo = Data().TeleTrouncing.BuffInfo
            for job, member in pairs(MG.Party) do
                buffInfo[job] = {}
                local key1, key2
                local curPlayer = TensorCore.mGetEntity(member.id)
                local buffs = curPlayer.buffs
                for _, buff in pairs(buffs) do
                    local buffType = ArrowBuffs[buff.id]
                    if ArrowBuffs[buff.id] ~= nil then
                        if buff.duration > 7 then
                            buffInfo[job].long = buff.id
                            buffInfo[job].longKey = buffType
                        else
                            buffInfo[job].short = buff.id
                            buffInfo[job].shortKey = buffType
                        end
                    end
                end
                if buffInfo[job].short ~= nil and buffInfo[job].long ~= nil then
                    key1 = buffInfo[job].shortKey .. '_' .. buffInfo[job].longKey
                    key2 = buffInfo[job].longKey .. '_' .. buffInfo[job].shortKey
                    if Cfg().transUnOpt then
                        if TeleTrouncingPos2[key1] ~= nil then
                            buffInfo[job].posInfo = TeleTrouncingPos2[key1]
                        elseif TeleTrouncingPos2[key2] ~= nil then
                            buffInfo[job].posInfo = TeleTrouncingPos2[key2]
                        end
                    else
                        if TeleTrouncingPos[key1] ~= nil then
                            buffInfo[job].posInfo = TeleTrouncingPos[key1]
                        elseif TeleTrouncingPos[key2] ~= nil then
                            buffInfo[job].posInfo = TeleTrouncingPos[key2]
                        end
                    end
                    if buffInfo[job].longKey == buffInfo[job].shortKey then
                        Data().TeleTrouncing.Guide1[job] = buffInfo[job].posInfo[1]
                        Data().TeleTrouncing.Guide2[job] = buffInfo[job].posInfo[2]
                    else
                        if Data().TeleTrouncing.Reference == nil then
                            Data().TeleTrouncing.Reference = {
                                id = member.id,
                                short = buffInfo[job].short,
                                long = buffInfo[job].long
                            }
                        end
                        Data().TeleTrouncing.Guide1[job] = buffInfo[job].posInfo[buffInfo[job].shortKey]
                        Data().TeleTrouncing.Guide2[job] = buffInfo[job].posInfo[buffInfo[job].longKey]
                    end
                end
            end
        else
            local ref = Data().TeleTrouncing.Reference
            local curShortBuff = TensorCore.getBuff(ref.id, ref.short)
            local curLongBuff = TensorCore.getBuff(ref.id, ref.long)
            if curLongBuff ~= nil and curLongBuff.duration > 0 then
                if Cfg().guide then
                    if curShortBuff ~= nil and curShortBuff.duration > 0 then
                        MG.FrameMultiD(Data().TeleTrouncing.Guide1)
                    else
                        MG.FrameMultiD(Data().TeleTrouncing.Guide2)
                    end
                end
            else
                if Data().TeleTrouncing.Timer ~= 0 and TimeSince(Data().TeleTrouncing.Timer) > 10000 then
                    DM.ChangeState('P1ArrowPut')
                end
            end
        end
    end
    -- 放完箭头去击退位置
    if DM.InState('P1ArrowPut') then
        turnBuff(Data().Turn3, function()
            for _, member in pairs(MG.Party) do
                if TensorCore.hasBuff(member.id, 5078) then
                    return false
                end
            end
            return true
        end)
    end
    -- 睡眠点名
    if DM.InState('P1SleepOrConfused') then
        if MG.IsAnyMemberHasBuff(4894) then
            DM.ChangeState('P1Teleport')
            Data().LastLink.Timer = Now()
        end
        if Data().LastLink.SleepGroup == nil or table.size(Data().LastLink.SleepGroup) < 4 then
            Data().LastLink.SleepGroup = {}
            for job, member in pairs(MG.Party) do
                local tethers = Argus.getTethersOnEnt(member)
                if tethers ~= nil and table.size(tethers) > 0 then
                    for _, tether in pairs(tethers) do
                        if tether.type == 45 then
                            local linkFrom = TensorCore.mGetEntity(tether.partnerid)
                            if linkFrom.pos.x > 100 then
                                table.insert(Data().LastLink.SleepGroup, job)
                                break
                            end
                        end
                    end
                end
            end
        else
            if Cfg().draw then
                for _, job in pairs(Data().LastLink.SleepGroup) do
                    local player = TensorCore.mGetEntity(MG.Party[job].id)
                    MG.CreateDrawer(0.2, 0, 0.6, 0.3, 2)
                      :addCircle(player.pos.x, player.pos.y, player.pos.z, 5)
                end
            end
        end
        if Cfg().guide then
            if Cfg().transUnOpt then
                if table.size(Data().LastLink.SleepGroup) >= 4 then
                    if not Data().LastLink.exchanged then
                        Data().LastLink.GuideData2 = {}
                        for _, job in pairs(Data().LastLink.SleepGroup) do
                            -- 如果睡眠点了远程组，和同组互换位置
                            if table.contains({ 'H1', 'H2', 'D3', 'D4' }, job) then
                                local partner = MG.CalcPartner(job)
                                Data().LastLink.GuideData[job], Data().LastLink.GuideData[partner] = Data().LastLink.GuideData[partner], Data().LastLink.GuideData[job]
                            end
                        end
                        Data().LastLink.exchanged = true
                    else
                        MG.FrameMultiD(Data().LastLink.GuideData)
                    end
                end
            else
                MG.FrameMultiD(Data().LastLink.GuideData)
            end
        end
    end
    -- 开始传送
    if DM.InState('P1Teleport')
            and Data().LastLink.Timer ~= 0
            and TimeSince(Data().LastLink.Timer) > 4000 then
        local anyoneNoBuff = true
        for _, player in pairs(MG.Party) do
            if TensorCore.hasBuff(player.id, 4894)
                    or TensorCore.hasBuff(player.id, 1283)
            then
                anyoneNoBuff = false
                break
            end
        end
        if anyoneNoBuff then
            DM.ChangeState('P1FireThunder')
        end
    end
    if DM.InState('P1FireThunder') then
        if MG.IsAnyMemberHasBuff(2941) then
            DM.ChangeState('P1End')
        end
        if Data().FireThunder.PlayerMark ~= nil
                and Data().FireThunder.BossMark ~= nil
                and Data().FireThunder.MoveTable ~= nil
        then
            if not Data().FireThunder.DrawCalled then
                Data().FireThunder.DrawCalled = true
                drawFire(Data().FireThunder)
            end
            if Cfg().guide then
                if Data().FireThunder.GuideData == nil
                        or table.size(Data().FireThunder.GuideData) < 8
                then
                    Data().FireThunder.GuideData = {}
                    local moveTable = Data().FireThunder.MoveTable
                    local movePos = {}
                    for job, pos in pairs(Data().FireThunder.BaseGuideData) do
                        movePos[job] = TensorCore.getPosInDirection(pos, moveTable[job], 0.5)
                    end
                    if Data().FireThunder.BossMark == 673 then
                        --火假
                        if Data().FireThunder.PlayerMark == 127 then
                            for job, _ in pairs(MG.Party) do
                                if table.contains(thGroup, job) then
                                    Data().FireThunder.GuideData[job] = movePos.MT
                                else
                                    Data().FireThunder.GuideData[job] = movePos.D2
                                end
                            end
                        else
                            Data().FireThunder.GuideData = movePos
                        end
                    else
                        --真的
                        if Data().FireThunder.PlayerMark == 127 then
                            Data().FireThunder.GuideData = movePos
                        else
                            for job, _ in pairs(MG.Party) do
                                if table.contains(thGroup, job) then
                                    Data().FireThunder.GuideData[job] = movePos.MT
                                else
                                    Data().FireThunder.GuideData[job] = movePos.D2
                                end
                            end
                        end
                    end
                else
                    MG.FrameMultiD(Data().FireThunder.GuideData)
                end
            end
        end
    end
end
return Dmu_P1