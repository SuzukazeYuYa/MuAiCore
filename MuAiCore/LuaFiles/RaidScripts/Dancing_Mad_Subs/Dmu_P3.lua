local Dmu_P3 = {}

Dmu_P3.StateName = "P3"

---@type DancingMad
local DM
---@type MuAiGuide
local MG

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
            -- 真空波读条完成时候，buff剩余4秒（>4 <4.5）所以5秒开始进行背对
            if curBuff.duration < 5.5 and Data().LockFace.enable == false then
                MG.Debug('P3 一运自动面向开始')
                local heading
                if Data().LockFace.buffType == 1602 then
                    heading = TensorCore.getHeadingToTarget(curBoss.pos, player.pos)
                else
                    heading = TensorCore.getHeadingToTarget(player.pos, curBoss.pos)
                end
                TensorCore.API.TensorACR.setLockFaceHeading(heading)
                TensorCore.API.TensorACR.toggleLockFace(true)
                Data().LockFace.enable = true
            end
        else
            if Data().LockFace.enable then
                -- buff消失背对结束
                MG.Debug('P3 一运自动面向结束')
                Data().LockFace.onDoing = false
                Data().LockFace.enable = false
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
    if TimeSince(Data().ThunderIII.Timer) < 4700 then
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

--------------------------------------------- event function ---------------------------------------------
--- 初始化
--- @param dm DancingMad
--- @param m MuAiGuide
Dmu_P3.Init = function(dm, m)
    DM = dm
    MG = m
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
    end
end

Dmu_P3.OnEntityCast = function(entityID, spellID, castPos)
    if spellID == 47858 then
        --深层痛楚
        if DM.BeLowState('P3ElementsStart') then
            DM.ChangeState('P3ElementsStart')
        end
    end
end

Dmu_P3.OnAOECreate = function(aoeInfo)
end

Dmu_P3.OnEventObjectScriptFunc = function(entityID, a1, a2, a3)
end

Dmu_P3.OnAddEntityVFX = function(vfxID)
end

Dmu_P3.OnMapEffect = function(a1, a2, a3)
end

Dmu_P3.Update = function()
    getBoss()
    drawImplosion()
    lockFaceCheck()
    drawThunderIII()
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
                    return MG.IndexOf(MG.JobPosName, a) < MG.IndexOf(MG.JobPosName, a)
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
            elseif timeSince < 12700 then
                local drawer = MG.CreateDrawer(0.1, 0.5, 0)
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
            if not Data().UmbraSmash.Start then
                local curChaos = TensorCore.mGetEntity(bossChaos.id)
                local distance = 0
                local farest = nil
                for job, member in pairs(MG.Party) do
                    local curMember = TensorCore.mGetEntity(member.id)
                    local dis = TensorCore.getDistance2d(curChaos.pos, curMember.pos)
                    if farest == nil or dis > distance then
                        distance = dis
                        farest = curMember
                    end
                end
                if farest ~= nil then
                    if Data().UmbraSmash.LeadPlayer == nil then
                        Data().UmbraSmash.LeadPlayer = farest
                    end
                    DM.redDrawer:addCircle(farest.pos.x, farest.pos.y, farest.pos.z, 17)
                end
            elseif Data().UmbraSmash.Timer ~= 0 then
                if Data().UmbraSmash.drawPos == nil then
                    local curLeadPlayer = TensorCore.mGetEntity(Data().UmbraSmash.LeadPlayer.id)
                    Data().UmbraSmash.drawPos = curLeadPlayer.pos
                end
                if TimeSince(Data().UmbraSmash.Timer) < 4700 then
                    local pos = Data().UmbraSmash.drawPos
                    DM.redDrawer:addCircle(pos.x, pos.y, pos.z, 17)
                end
            end
        end
    end
end
return Dmu_P3