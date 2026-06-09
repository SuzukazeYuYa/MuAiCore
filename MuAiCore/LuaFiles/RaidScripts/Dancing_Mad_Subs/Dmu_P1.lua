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

--- 绘制死刑
local drawDeath = function()
    if Cfg().draw and Data().Death.OnDraw and Data().Death.Timer > 0 then
        if TimeSince(Data().Death.Timer) < 9000 then
            if TimeSince(Data().Death.Timer) < 6000 then
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
            else
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
        else
            Data().Death.OnDraw = false
            Data().Death.MT = nil
            Data().Death.ST = nil
            Data().Death.Timer = 0
        end
    end
end

--- 初始化
--- @param dm DancingMad
--- @param m MuAiGuide
Dmu_P1.Init = function(dm, m)
    DM = dm
    MG = m
end

local closeList = {
    [47764] = { old0 = nil, old1 = nil },
    [47768] = { old0 = nil, old1 = nil },
    [47771] = { old0 = nil, old1 = nil },
    [47774] = { old0 = nil, old1 = nil },
    [47775] = { old0 = nil, old1 = nil },
    [47776] = { old0 = nil, old1 = nil },
    [47777] = { old0 = nil, old1 = nil },
}

local effectSwitch

local applyEffectBinder = function()
    if effectSwitch ~= Cfg().effect then
        if Cfg().effect then
            if closeList[47764].old0 == nil then
                for skillId, _ in pairs(closeList) do
                    closeList[skillId].old0 = Argus.getActionAOEType(skillId, 0)
                    closeList[skillId].old1 = Argus.getActionAOEType(skillId, 1)
                    Argus.setActionAOEType(skillId, 0, 0)
                    Argus.setActionAOEType(skillId, 1, 0)
                end
            end
            d('applyEffectBinder1')
        else
            for skillId, _ in pairs(closeList) do
                if closeList[skillId].old0 ~= nil then
                    Argus.setActionAOEType(skillId, 0, closeList[skillId].old0)
                end
                if closeList[skillId].old1 ~= nil then
                    Argus.setActionAOEType(skillId, 1, closeList[skillId].old1)
                end
            end
            d('applyEffectBinder2')
        end
        effectSwitch = Cfg().effect
    end
end

local autoLookAt = function(entityID, a1, a2, a3)
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
    MG.Info(string.format('[%.3f', TensorReactions_CurrentCombatTimer) .. ']背对缓存')
end

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
            TensorCore.API.TensorACR.toggleLockFace(true)
            MG.Info(string.format('[%.3f', TensorReactions_CurrentCombatTimer) .. ']背对开启，锁定'.. heading)
        end
    else
        MG.Info(string.format('[%.3f', TensorReactions_CurrentCombatTimer) .. ']背对结束')
        Data().AutoLookAt.Timer = 0
        Data().AutoLookAt.enable = false
        TensorCore.API.TensorACR.toggleLockFace(false)
    end
end

Dmu_P1.OnEntityChannel = function(entityID, spellID, _)
    if spellID == 50179 then
        -- 恶狠狠毁荡
        Data().Death.Timer = Now()
        Data().Death.OnDraw = true
        MG.CurRaidBoss = TensorCore.mGetEntity(entityID)
    elseif spellID == 47764 then
        if DM.BeLowState('P1TrueFalse1', true) then
            DM.ChangeState('P1TrueFalse1')
        end

    elseif spellID == 48370 then
        -- 众神之象
        if DM.OverState('P1BeamEnd') and DM.BeLowState('P1Line2Start') then
           -- DM.ChangeState('P1Line2Start')
        end
    elseif spellID == 50722 then
        -- 制裁之光，接3连死刑

    elseif spellID == 47782 then
        -- 连环环x陷阱
    elseif spellID == 48370 then
        -- 众神之像
        if DM.InState('DeathBfLine2') then
            DM.ChangeState('P1Line2Start')
        end
    end
end

Dmu_P1.OnEntityCast = function(entityID, spellID, castPos)
    if spellID == 50722 then
        local mt = TensorCore.getEntityByGroup("Main Tank", "Nearest")
        MG.CreateDrawer(1, 0.5, 0, nil, 2):addTimedCircleOnEnt(9000, mt.id, 5)
    end
end

Dmu_P1.OnMarkerAdd = function(entityID, markerID)
    if DM.BeLowState('P1TrueFalse1', true) then
        if DM.BeLowState('P1TrueFalse1') then
            DM.ChangeState('P1TrueFalse1')
        end
        if markerID == 127 or markerID == 128 then
            if Data().Fire1.PlayerMark == 0 then
                Data().Fire1.PlayerMark = markerID
            end
            if markerID == 128 then
                table.insert(Data().Fire1.GatherPlayers, entityID)
            end
        elseif markerID == 673 or markerID == 674 then
            Data().Fire1.BossMark = markerID
        end
    end
end

---@param aoeInfo DirectionalAOE
Dmu_P1.OnAOECreate = function(aoeInfo)
    -- 画制冰和雷
    if Cfg().draw then
        local drawTime = 5500
        if not Cfg().effect then
            -- 冰危险区
            if aoeInfo.aoeID == 47774 or aoeInfo.aoeID == 47768 then
                DM.yellowDrawer:addTimedCone(drawTime, aoeInfo.x, aoeInfo.y, aoeInfo.z, 40, math.pi / 2, aoeInfo.heading, 0, true)
            end
            -- 画雷危险区
            if aoeInfo.aoeID == 47775 or aoeInfo.aoeID == 47777 then
                local startPos = TensorCore.getPosInDirection({ x = aoeInfo.x, y = aoeInfo.y, z = aoeInfo.z }, aoeInfo.heading + math.pi, 5)
                DM.yellowDrawer:addTimedRect(drawTime, startPos.x, startPos.y, startPos.z, 50, 10, aoeInfo.heading, 0, true)
            end
        else
            -- 冰危险区
            if aoeInfo.aoeID == 47774 or aoeInfo.aoeID == 47768 then
                DM.purpleDrawer:addTimedCone(drawTime, aoeInfo.x, aoeInfo.y, aoeInfo.z, 20, math.pi / 2, aoeInfo.heading)
            end

            -- 画雷危险区
            if aoeInfo.aoeID == 47775 or aoeInfo.aoeID == 47777 then
                DM.purpleDrawer:addTimedRect(drawTime, aoeInfo.x, aoeInfo.y, aoeInfo.z, 40, 10, aoeInfo.heading)
            end
        end
    end

    -- 采集冰方向
    if aoeInfo.aoeID == 47774 or aoeInfo.aoeID == 47768
            and DM.InState('P1Line2Start')
            and Data().Line2.dangerDir == 0
    then
        Data().Line2.dangerDir = aoeInfo.heading
    end

    -- 采集刷的塔信息
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
    autoLookAt(entityID, a1, a2, a3)
end

Dmu_P1.OnAddEntityVFX = function(vfxID)

end

Dmu_P1.Update = function()
    applyEffectBinder()
    drawDeath()
    autoLookAtUpdate()
    if DM.InState('P1TrueFalse1') then
        -- 真假火画图
        if Cfg().draw
                and Data().Fire1.BossMark ~= 0
                and Data().Fire1.PlayerMark ~= 0
        then
            if Data().Fire1.PlayerMark == 127
                    or table.size(Data().Fire1.GatherPlayers) >= 2 then
                local radius = 5
                local drawTime = 6000
                if Data().Fire1.BossMark == 673 then
                    --火是假的
                    if Data().Fire1.PlayerMark == 127 then
                        DM.greenDrawer:addTimedCircleOnEnt(drawTime, TensorCore.mGetPlayer().id, radius)
                    else
                        for _, member in pairs(MG.Party) do
                            DM.redDrawer:addTimedCircleOnEnt(drawTime, member.id, radius)
                        end
                    end
                else
                    --火是假的
                    if Data().Fire1.PlayerMark == 127 then
                        for _, member in pairs(MG.Party) do
                            DM.redDrawer:addTimedCircleOnEnt(drawTime, member.id, radius)
                        end
                    else
                        for _, id in pairs(Data().Fire1.GatherPlayers) do
                            DM.greenDrawer:addTimedCircleOnEnt(drawTime, id, radius)
                        end
                    end
                end
                DM.ChangeState('P1TrueFalse2')
            end
        end

    end

    -- 连线画图(击退提示箭头)
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

    -- 真假火判定 转阶段
    if DM.InState('P1TrueFalse2') then
        if MG.IsAnyMemberHasBuff(2941) then
            DM.ChangeState('P1TrueFalse1End')
            Data().Fire1.Time = Now()
        end
    end

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
                    ['H2'] = { x = 80.5, z = 100 },
                    ['D4'] = { x = 119.5, z = 100 },
                }

                for i = 2, 7 do
                    local curJob = Data().Beam.Order[i]
                    local leftPlayer = curParty[Data().Beam.Order[i - 1]]
                    local rightPlayer = curParty[Data().Beam.Order[i + 1]]
                    beamWay[curJob] = { x = (leftPlayer.pos.x + rightPlayer.pos.x) / 2, z = 100 }
                end
                MG.FrameMultiD(beamWay)
            end
        end
        if TimeSince(Data().Fire1.Time) > 1500 and MG.IsAnyMemberHasBuff(2941) then
            DM.ChangeState('P1BeamEnd')
            Data().Beam.Time = Now()
        end
    end

    -- 记录激光射了谁
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

    -- 传毒开始
    if DM.InState('P1BuffTurn1') then
        -- 如果有任意一人毒buff超过50秒，判定为传毒完成
        if MG.IsAnyMemberHasBuff(5078, 50) then
            DM.ChangeState('DeathBfLine2')
        else
            local thGroup = { 'MT', 'ST', 'H1', 'H2' }
            if Data().Turn1.BuffJobs == nil then
                local buffJob = {}
                for job, member in pairs(MG.Party) do
                    if TensorCore.hasBuff(member.id, 5078) then
                        table.insert(buffJob, job)
                    end
                end
                if table.size(buffJob) >= 2 then
                    Data().Turn1.BuffJobs = buffJob
                    if table.contains(buffJob, MG.SelfPos) then
                        Data().Turn1.SelfGroupTurner = MG.SelfPos
                    else
                        for _, job in pairs(buffJob) do
                            if (table.contains(thGroup, job) and table.contains(thGroup, MG.SelfPos))
                                    or (not table.contains(thGroup, job) and not table.contains(thGroup, MG.SelfPos))
                            then
                                Data().Turn1.SelfGroupTurner = job
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
                    for _, job in pairs(Data().Turn1.BuffJobs) do
                        if table.contains(thGroup, job) then
                            thJob = job
                            guideData[job] = { x = 91, y = 0, z = 100 }
                        else
                            dpsJob = job
                            guideData[job] = { x = 109, y = 0, z = 100 }
                        end
                    end
                    local dpsObj = TensorCore.mGetEntity(MG.Party[dpsJob].id)
                    local thObj = TensorCore.mGetEntity(MG.Party[thJob].id)
                    local disDps = TensorCore.getDistance2d(dpsObj.pos, guideData[dpsJob])
                    local disTh = TensorCore.getDistance2d(thObj.pos, guideData[thJob])
                    for job, member in pairs(MG.Party) do
                        if table.contains(thGroup, job) then
                            if job ~= thJob then
                                if disTh < 2 then
                                    guideData[job] = { x = thObj.pos.x + 1, y = thObj.pos.y, z = thObj.pos.z }
                                else
                                    guideData[job] = { x = 91.5, y = 0, z = 100 }
                                end
                            end
                        else
                            if job ~= dpsJob then
                                if disDps < 2 then
                                    guideData[job] = { x = dpsObj.pos.x - 1, y = dpsObj.pos.y, z = dpsObj.pos.z }
                                else
                                    guideData[job] = { x = 108.5, y = 0, z = 100 }
                                end
                            end
                        end
                    end
                    MG.FrameMultiD(guideData)
                end
            end
        end
    end

    if DM.InState('P1Line2Start') and Data().Line2.dangerDir ~= 0 then
        if Cfg().guide then
            if Data().Line2.Guide1 == nil then
                Data().Line2.Guide1 = {}
                local dir = MG.SetHeading2Pi(Data().Line2.dangerDir)
                if (math.pi / 2 < dir and dir < math.pi) or (math.pi * 3 / 2 < dir and dir < 2 * math.pi) then
                    Data().Line2.Guide1 = {
                        ['MT'] = { x = 99.5, y = 0, z = 81 },
                        ['H1'] = { x = 99.5, y = 0, z = 81 },
                        ['D1'] = { x = 99.5, y = 0, z = 81 },
                        ['D3'] = { x = 99.5, y = 0, z = 81 },

                        ['ST'] = { x = 100.5, y = 0, z = 119 },
                        ['H2'] = { x = 100.5, y = 0, z = 119 },
                        ['D2'] = { x = 100.5, y = 0, z = 119 },
                        ['D4'] = { x = 100.5, y = 0, z = 119 },
                    }
                else
                    Data().Line2.Guide1 = {
                        ['MT'] = { x = 100.5, y = 0, z = 81 },
                        ['H1'] = { x = 100.5, y = 0, z = 81 },
                        ['D1'] = { x = 100.5, y = 0, z = 81 },
                        ['D3'] = { x = 100.5, y = 0, z = 81 },

                        ['ST'] = { x = 99.5, y = 0, z = 119 },
                        ['H2'] = { x = 99.5, y = 0, z = 119 },
                        ['D2'] = { x = 99.5, y = 0, z = 119 },
                        ['D4'] = { x = 99.5, y = 0, z = 119 },
                    }
                end
            else
                MG.FrameMultiD(Data().Line2.Guide1)
            end
        end
        if Data().Line2.Gather1Players == nil then
            Data().Line2.Gather1Players = {}
            for _, member in pairs(MG.Party) do
                local tethers = Argus.getTethersOnEnt(member)
                if tethers ~= nil and table.size(tethers) > 0 then
                    for _, tether in pairs(tethers) do
                        if tether.type == 45 then
                            local linkFrom = TensorCore.mGetEntity(tether.partnerid)
                            if linkFrom.pos.x > 110 then
                                table.insert(Data().Line2.Gather1Players, member)
                                break
                            end
                        end
                    end
                end
            end
        else
            if Cfg().draw then
                for _, member in pairs(Data().Line2.Gather1Players) do
                    local player = TensorCore.mGetEntity(member.id)
                    MG.CreateDrawer(0.2, 0, 0.6, 0.3, 2):addCircle(player.pos.x, player.pos.y, player.pos.z, 5)
                end
            end
        end
    end

    if DM.InState('P1Line2_1') then
        if Cfg().draw then
            for _, member in pairs(MG.Party) do
                local hasLine, tether = MG.HasLine(member.id, 45)
                if hasLine then
                    local from = TensorCore.mGetEntity(tether.partnerid)
                    if from and from.pos.x < 100 then
                        local drawer = MG.CreateDrawer(0.5, 0.5, 0.5)
                    end
                end
            end
        end
    end

    drawBuffKick()
end

return Dmu_P1