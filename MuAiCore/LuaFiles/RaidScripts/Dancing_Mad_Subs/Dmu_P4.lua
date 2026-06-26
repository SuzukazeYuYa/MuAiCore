local Dmu_P4 = {}
Dmu_P4.StateName = "P4"
---@type DancingMad
local DM
---@type MuAiGuide
local MG

local Cfg = function()
    return MG.Config.DmuCfg.P4
end

local Data = function()
    if MG.DancingMad == nil then
        return nil
    end
    return MG.DancingMad.P4
end

local debugGuideData = function(eventName, key, msg, guideData, data)
    data = data or {}
    data.count = DM.DebugCount(guideData)
    data.guide = guideData
    DM.DebugOnce(eventName, key, msg, data)
end

local onUsingVfx = {
    2913, --卡奥斯-假    
    2914, --卡奥斯-真    
    --------------------
    2915, --新生艾克斯迪斯-假    
    2916, --新生艾克斯迪斯-真    
}

local buffExDeath = {
    5543, --诅咒指嚎，石化
    5544, --叉形闪电，8米钢铁
    5545, --水属性压缩，8米分摊
    5546, --加速度炸弹，停止行动
    454, --亚拉戈领域 持续时间不能吃到高伤害

    5464, --超越死亡，要吃到秒杀级伤害
    1382, --超越死亡，要吃到秒杀级伤害

    4888, -- 死者之伤，蓝buff
    5542, -- 死者之伤，蓝buff

    4887, -- 生者之伤，紫buff
    5541, -- 生者之伤，紫buff
}

local buffChaos = {
    5547, --混沌之火，6米钢铁
    5548, --混沌之水，6米月环
}

local eye1PosFix = {
    [1] = { -- L13
        th = { x = 96.11, y = 0, z = 95.41 },
        dps = { x = 104.59, y = 0, z = 103.89 },
        g = { x = 101, y = 0, z = 99 },
        real = { x = 106.00, y = 0, z = 94.00 },
    },
    [2] = { -- L24
        th = { x = 95.41, y = 0, z = 96.11 },
        dps = { x = 103.89, y = 0, z = 104.59 },
        g = { x = 99, y = 0, z = 101 },
        real = { x = 94.00, y = 0, z = 106.00 },
    },
    [3] = { -- R13
        th = { x = 103.89, y = 0, z = 95.41 },
        dps = { x = 95.41, y = 0, z = 95.41 },
        g = { x = 99, y = 0, z = 99 },
        real = { x = 94.00, y = 0, z = 94.00 },
    },
    [4] = { -- R24
        th = { x = 104.59, y = 0, z = 96.11 },
        dps = { x = 96.11, y = 0, z = 104.59 },
        g = { x = 101, y = 0, z = 101 },
        real = { x = 106.00, y = 0, z = 106.00 },
    },
}

local eye1PosMMW = {
    {   -- l24 or r24
        g = { x = 100, y = 0, z = 106 },
        real = { x = 100, y = 0, z = 110 },
        fake = { x = 100, y = 0, z = 101 }
    },
    {   -- l13 or r13
        g = { x = 100, y = 0, z = 94 },
        real = { x = 100, y = 0, z = 90 },
        fake = { x = 100, y = 0, z = 99 }
    }
}

local onAddNewBuff = function(buffTable, timer, currentVfx)
    if Data().CheckFinish[MG.DancingMad.CurrentState] == nil then
        Data().CheckFinish[MG.DancingMad.CurrentState] = false
    end
    if not Data().CheckFinish[MG.DancingMad.CurrentState]
            and timer > 0
            and TimeSince(timer) > 2000 --读条后超过0.5秒再计算
    then
        if currentVfx == nil then
            DM.DebugProblem('P4Buff', '未获取真假VFX，Buff真假无法写入', {
                state = DM.StateNames[MG.DancingMad.CurrentState],
            })
        end
        local buffCount = 0
        local buffSummary = {}
        MG.OnCurrentPartyDo(function(job, member)
            if Data().Buff[job] == nil then
                Data().Buff[job] = {}
            end

            for _, buff in pairs(member.buffs) do

                if table.contains(buffTable, buff.id)
                        and Data().Buff[job][buff.id] == nil -- 是新的BUFF
                then
                    if currentVfx == 2913 or currentVfx == 2915 then
                        Data().Buff[job][buff.id] = false
                    elseif currentVfx == 2914 or currentVfx == 2916 then
                        Data().Buff[job][buff.id] = true
                    end
                    if Data().Buff[job][buff.id] ~= nil then
                        buffCount = buffCount + 1
                        if buffSummary[job] == nil then
                            buffSummary[job] = ''
                        else
                            buffSummary[job] = buffSummary[job] .. ','
                        end
                        buffSummary[job] = buffSummary[job] .. tostring(buff.id) .. '=' .. tostring(Data().Buff[job][buff.id])
                    end
                end
            end
        end)
        Data().CheckFinish[MG.DancingMad.CurrentState] = true
        if buffCount == 0 then
            DM.DebugProblem('P4Buff', '本轮没有缓存到任何新Buff', {
                state = DM.StateNames[MG.DancingMad.CurrentState],
                vfx = currentVfx,
            })
        end
        DM.DebugOnce('P4Buff', 'state_' .. tostring(MG.DancingMad.CurrentState), 'Buff真假缓存完成', {
            state = DM.StateNames[MG.DancingMad.CurrentState],
            vfx = currentVfx,
            count = buffCount,
            buff = buffSummary,
        })
    end
end

local lockFaceCheck = function(eyeTable)
    local buffOwner = eyeTable.Owner
    if buffOwner == nil or not Cfg().autoLook then
        return
    end
    local buff1 = TensorCore.getBuff(buffOwner[1], 5543)
    if buff1 ~= nil then
        if buff1.duration < 1 and not eyeTable.Locked then
            local player = MG.GetPlayer()
            local lookHeading
            if table.contains(buffOwner, player.id) then
                --如果自己是眼
                local other
                if player.id == buffOwner[1] then
                    other = buffOwner[2]
                else
                    other = buffOwner[1]
                end
                local otherObj = TensorCore.mGetEntity(other)
                local heading = TensorCore.getHeadingToTarget(otherObj.pos, player.pos)
                if eyeTable.type then
                    lookHeading = heading
                else
                    lookHeading = heading + math.pi
                end
            else
                local eye1 = TensorCore.mGetEntity(buffOwner[1])
                local eye2 = TensorCore.mGetEntity(buffOwner[2])
                local backPos = MG.GetMidPos(eye1.pos, eye2.pos)
                lookHeading = TensorCore.getHeadingToTarget(backPos, player.pos)
                if not eyeTable.type then
                    lookHeading = lookHeading + math.pi
                end
            end
            TensorCore.API.TensorACR.setLockFaceHeading(lookHeading)
            if Cfg().harkLock then
                TensorCore.API.TensorACR.setHardLockFace(true)
            end
            TensorCore.API.TensorACR.toggleLockFace(true)
            eyeTable.Locked = true
            DM.Info('P4锁定面向开始，面向：' .. string.format("%.2f", lookHeading))
        end
    else
        if eyeTable.LostTimer == nil then
            eyeTable.LostTimer = Now()
        end
        if eyeTable.Locked and TimeSince(eyeTable.LostTimer) > 1000 then
            if Cfg().harkLock then
                TensorCore.API.TensorACR.setHardLockFace(false)
            end
            TensorCore.API.TensorACR.toggleLockFace(false)
            eyeTable.Locked = false
            DM.Info('P4锁定面向结束。')
        end
    end
end

local ThunderWater = function(wave)
    local canHit = true
    if wave == 1 then
        canHit = Data().MoveOrStopHit == nil
    else
        canHit = Data().MoveOrStopHit == false
    end
    DM.DebugOnce('P4ThunderWater', 'start_wave_' .. wave, '雷水处理开始', {
        wave = wave,
        canHit = canHit,
        moveOrStopHit = Data().MoveOrStopHit,
    })
    if Cfg().draw and canHit then
        local player = MG.GetPlayer()
        local buff = TensorCore.getBuff(player.id, 5546)
        if buff ~= nil then
            if buff.duration < 15 then
                Data().MoveOrStopHit = true
            else
                Data().MoveOrStopHit = false
            end
        end
        if Data().MoveOrStopHit then
            local text
            local buffMap = Data().Buff[MG.SelfPos]
            if buffMap[5546] then
                text = 'Stop'
            else
                text = 'Move'
            end
            if AnyoneCore ~= nil then
                AnyoneCore.addTimedWorldTextOnEnt(
                        buff.duration * 1000 + 1000,
                        text,
                        player.id,
                        GUI:ColorConvertFloat4ToU32(1, 1, 1, 1),
                        true, 1.5, 2.5
                )
            end
        end
    end
    if Cfg().draw then
        for job, member in pairs(MG.Party) do
            local buffMap = Data().Buff[job] or {}
            local bf5544 = TensorCore.getBuff(member.id, 5544)
            local bf5545 = TensorCore.getBuff(member.id, 5545)
            local buffType
            if bf5544 ~= nil and bf5544.duration < 10 then
                if buffMap[5544] then
                    buffType = 5544
                else
                    buffType = 5545
                end
            elseif bf5545 ~= nil and bf5545.duration < 10 then
                buffType = 5545
                if buffMap[5545] then
                    buffType = 5545
                else
                    buffType = 5544
                end
            end
            local drawer
            if buffType == 5544 then
                --雷
                drawer = MG.CreateDrawer(1, 0.5, 0)
            elseif buffType == 5545 then
                drawer = DM.cyanDrawer --水
            end
            if drawer ~= nil then
                local curMember = TensorCore.mGetEntity(member.id)
                drawer:addCircle(curMember.pos.x, 0, curMember.pos.z, 8)
            end
        end
    end
    if Cfg().guide then
        local needGetData
        if wave == 1 then
            needGetData = Data().ThunderWater.Guide1 == nil
        else
            needGetData = Data().ThunderWater.Guide2 == nil
        end
        local guideData = {}
        if needGetData then
            for job, member in pairs(MG.Party) do
                local buffMap = Data().Buff[job]
                local buffType = 0
                local buff5544 = TensorCore.getBuff(member.id, 5544)
                local buff5545 = TensorCore.getBuff(member.id, 5545)
                if buff5544 ~= nil and buff5544.duration < 10 then
                    if buffMap[5544] then
                        buffType = 5544
                    else
                        buffType = 5545
                    end
                elseif buff5545 ~= nil and buff5545.duration < 10 then
                    if buffMap[5545] then
                        buffType = 5545
                    else
                        buffType = 5544
                    end
                end
                if buffType == 0 then
                    if MG.IndexOf(MG.JobPosName, job) <= 4 then
                        guideData[job] = { x = 100, y = 0, z = 91 }
                    else
                        guideData[job] = { x = 100, y = 0, z = 109 }
                    end
                else
                    if buffType == 5544 then
                        if Cfg().disType == 1 then
                            if MG.IndexOf(MG.JobPosName, job) <= 4 then
                                guideData[job] = { x = 109, y = 0, z = 100 }
                            else
                                guideData[job] = { x = 91, y = 0, z = 100 }
                            end
                        else
                            if MG.IndexOf(MG.JobPosName, job) <= 4 then
                                guideData[job] = { x = 91, y = 0, z = 100 }
                            else
                                guideData[job] = { x = 109, y = 0, z = 100 }
                            end
                        end
                    else
                        if MG.IndexOf(MG.JobPosName, job) <= 4 then
                            guideData[job] = { x = 100, y = 0, z = 91 }
                        else
                            guideData[job] = { x = 100, y = 0, z = 109 }
                        end
                    end
                end
            end
            if wave == 1 then
                Data().ThunderWater.Guide1 = guideData
            else
                Data().ThunderWater.Guide2 = guideData
            end
            debugGuideData('P4ThunderWater', 'guide_wave_' .. wave, '雷水指路数据生成', guideData, {
                wave = wave,
                moveOrStopHit = Data().MoveOrStopHit,
            })
        end
    end

end
--------------------------------------------- event function ---------------------------------------------
--- 初始化
--- @param dm DancingMad
--- @param m MuAiGuide
Dmu_P4.Init = function(dm, m)
    DM = dm
    MG = m
end

Dmu_P4.OnEntityChannel = function(entityID, spellID, targetID, channelTimeMax)
    if spellID == 50067
            or spellID == 50068
            or spellID == 50069
            or spellID == 50070
            or spellID == 50081
            or spellID == 50082
    then
        DM.DebugLog('P4ThunderWater', '雷水相关读条开始', {
            spellID = spellID,
            state = DM.StateNames[MG.DancingMad.CurrentState],
            entityID = entityID,
            target = DM.DebugEntityID(targetID),
            channelTimeMax = channelTimeMax,
        })
    end
    if spellID == 50069 then
        --死者暗黑光
        Data().ExDeath.DeathBeamObj = TensorCore.mGetEntity(entityID)
        Data().ExDeath.DrawTimer = Now()
        DM.DebugLog('P4ExDeath', '死者暗黑光读条缓存', {
            spellID = spellID,
            state = DM.StateNames[MG.DancingMad.CurrentState],
            entityID = entityID,
            channelTimeMax = channelTimeMax,
        })
    elseif spellID == 50068 then
        --生者暗黑光
        Data().ExDeath.AliveBeamObj = TensorCore.mGetEntity(entityID)
        Data().ExDeath.DrawTimer = Now()
        DM.DebugLog('P4ExDeath', '生者暗黑光读条缓存', {
            spellID = spellID,
            state = DM.StateNames[MG.DancingMad.CurrentState],
            entityID = entityID,
            channelTimeMax = channelTimeMax,
        })
    elseif spellID == 50070 then
        --生死之境界
        Data().ExDeath.DothBeamObj = TensorCore.mGetEntity(entityID)
        Data().ExDeath.DrawTimer = Now()
        DM.DebugLog('P4ExDeath', '生死之境读条缓存', {
            spellID = spellID,
            state = DM.StateNames[MG.DancingMad.CurrentState],
            entityID = entityID,
            channelTimeMax = channelTimeMax,
        })
    elseif spellID == 49738 then
        --if DM.InState('P4WaterFire2Put') then
        --    DM.ChangeState('P4End')
        --end
    end
end

Dmu_P4.OnEntityCast = function(entityID, spellID, castPos)
    if spellID == 47892 then
        Data().ExDeath.Timer = Now()
        --大十字
        if DM.InState('P4Start') then
            DM.ChangeState('P4ExDeathBuff1')
        elseif DM.InState('P4ChaosBuff1') then
            DM.ChangeState('P4ExDeathBuff2')
        elseif DM.InState('P4ChaosBuff2') then
            DM.ChangeState('P4ExDeathBuff3')
        end
    elseif spellID == 47903 or spellID == 47905 -- 海啸
            or spellID == 47902 or spellID == 47904   -- 烈焰
    then
        Data().Chaos.Timer = Now()
        if spellID == 47903 or spellID == 47905 then
            Data().Chaos.CastType = 5548
        elseif spellID == 47902 or spellID == 47904 then
            Data().Chaos.CastType = 5547
        end
        if DM.InState('P4ExDeathBuff1') then
            DM.ChangeState('P4ChaosBuff1')
        elseif DM.InState('P4ExDeathBuff2') then
            DM.ChangeState('P4ChaosBuff2')
        end
    elseif spellID == 47774 or spellID == 47768 then
        if DM.InState('P4WaterFire2Put') then
            DM.ChangeState('P4End')
        end
    elseif spellID == 50067
            or spellID == 50068
            or spellID == 50081
            or spellID == 50082
    then
        DM.DebugLog('P4ThunderWater', '收到雷水起始结算读条', {
            spellID = spellID,
            state = DM.StateNames[MG.DancingMad.CurrentState],
        })
        DM.ChangeState('P4ThunderWater1')
    end
end

Dmu_P4.OnAOECreate = function(aoeInfo)
    if aoeInfo.aoeID == 47774 or aoeInfo.aoeID == 47768 then
        if DM.OverState('P4WaterFire1Put', true) and DM.BeLowState('P4Eye2') then
            Data().ThunderWater.IceType = DM.CalcIceType(aoeInfo)
            DM.DebugOnce('P4ThunderWater', 'ice_wave_2', '第二次雷水冰类型缓存', {
                aoeID = aoeInfo.aoeID,
                iceType = Data().ThunderWater.IceType,
            })
        end
        if DM.OverState('P4Eye2', true) and DM.BeLowState('P4WaterFire2Put', true) then
            Data().WaterFire2.IceType = DM.CalcIceType(aoeInfo)
            DM.DebugOnce('P4WaterFire', 'ice_wave_2', '第二次火水冰类型缓存', {
                aoeID = aoeInfo.aoeID,
                iceType = Data().WaterFire2.IceType,
            })
        end
    end
    if aoeInfo.aoeID == 47775 or aoeInfo.aoeID == 47777 then
        if DM.OverState('P4ThunderWater1', true) and DM.BeLowState('P4WaterFire1', true) then
            if Data().Eye1.thunder == nil then
                local thunderType = DM.CalcThunderType(aoeInfo)
                if thunderType ~= nil then
                    Data().Eye1.thunder = thunderType
                    DM.DebugOnce('P4Eye', 'eye1_thunder', '第一次石化眼雷类型缓存', {
                        aoeID = aoeInfo.aoeID,
                        thunderType = thunderType,
                    })
                end
            end
        end
        if DM.OverState('P4Eye2', true) and DM.BeLowState('P4WaterFire2Put', true) then
            if Data().WaterFire2.ThunderType == nil then
                local thunderType = DM.CalcThunderType(aoeInfo)
                if thunderType ~= nil then
                    Data().WaterFire2.ThunderType = thunderType
                    DM.DebugOnce('P4WaterFire', 'thunder_wave_2', '第二次火水雷类型缓存', {
                        aoeID = aoeInfo.aoeID,
                        thunderType = thunderType,
                    })
                end
            end
            Data().WaterFire2.AoeTimer = Now()
        end
    end

    if aoeInfo.aoeID == 47906
            or aoeInfo.aoeID == 47907
            or aoeInfo.aoeID == 47908
            or aoeInfo.aoeID == 47909
    then
        if DM.OverState('P4WaterFire1', true)
                and DM.BeLowState('P4WaterFire1Put', true)
        then
            DM.DebugOnce('P4WaterFire', 'aoe_wave_1', '第一次火水AOE生成', {
                aoeID = aoeInfo.aoeID,
                x = aoeInfo.x,
                z = aoeInfo.z,
                type = Data().WaterFire1.Type,
            })
            if Cfg().draw then
                if Data().WaterFire1.Type then
                    MG.CreateDrawer(1, 0, 1, 0.1, 2):addTimedCircle(5000, aoeInfo.x, 0, aoeInfo.z, 6)
                else
                    MG.CreateDrawer(1, 0, 1, 0.1, 2):addTimedDonut(5000, aoeInfo.x, 0, aoeInfo.z, 6, 40)
                end
            end
            Data().WaterFire1.AoeTimer = Now()
        elseif DM.OverState('P4WaterFire2', true)
                and DM.BeLowState('P4WaterFire2Put', true)
        then
            DM.DebugOnce('P4WaterFire', 'aoe_wave_2', '第二次火水AOE生成', {
                aoeID = aoeInfo.aoeID,
                x = aoeInfo.x,
                z = aoeInfo.z,
                type = Data().WaterFire2.Type,
            })
            if Cfg().draw then
                if Data().WaterFire2.Type then
                    MG.CreateDrawer(0, 0.5, 1, 0.2, 2):addTimedDonut(5000, aoeInfo.x, 0, aoeInfo.z, 6, 40)
                else
                    MG.CreateDrawer(0, 0.5, 1, 0.2, 2):addTimedCircle(5000, aoeInfo.x, 0, aoeInfo.z, 6)
                end
            end
        end
        -- 水火AOE放置
        if DM.InState('P4WaterFire1') then
            DM.ChangeState('P4WaterFire1Put')
        end
        if DM.InState('P4WaterFire2') then
            DM.ChangeState('P4WaterFire2Put')
        end
    end
end

Dmu_P4.OnAddEntityVFX = function(vfxID, vfxName, primaryEntityID, secondaryEntityID, time, a5, a6)
    if not table.contains(onUsingVfx, vfxID) then
        return
    end
    DM.ArrInfo('真假读条，当前VFX：' .. vfxID)
    table.insert(Data().StateVfx, vfxID)
    DM.DebugLog('P4Buff', '真假VFX缓存', {
        vfxID = vfxID,
        state = DM.StateNames[MG.DancingMad.CurrentState],
        count = #Data().StateVfx,
    })
    if DM.InState('P4ExDeathBuff3')
            and (vfxID == 2915 or vfxID == 2916)
    then
        DM.ChangeState('P4ExDeath3Judge')
    end
end

Dmu_P4.Update = function()
    -- 添加buff阶段 --
    if DM.InState('P4ExDeathBuff1') then
        onAddNewBuff(buffExDeath, Data().ExDeath.Timer, Data().StateVfx[1])
    end
    if DM.InState('P4ChaosBuff1') then
        onAddNewBuff(buffChaos, Data().Chaos.Timer, Data().StateVfx[2])
    end
    if DM.InState('P4ExDeathBuff2') then
        onAddNewBuff(buffExDeath, Data().ExDeath.Timer, Data().StateVfx[3])
    end
    if DM.InState('P4ChaosBuff2') then
        onAddNewBuff(buffChaos, Data().Chaos.Timer, Data().StateVfx[4])
    end
    if DM.InState('P4ExDeathBuff3') then
        onAddNewBuff(buffExDeath, Data().ExDeath.Timer, Data().StateVfx[5])
    end
    -- 添加执行buff阶段 --
    if DM.InState('P4ExDeath3Judge') then
        if Data().ExDeath.DeathBeamObj ~= nil
                and Data().ExDeath.AliveBeamObj ~= nil
                and Data().ExDeath.DothBeamObj ~= nil
        then
            if Data().ExDeath.deathDir == nil
                    or Data().ExDeath.deathDrawPos == nil
                    or Data().ExDeath.aliveDir == nil
                    or Data().ExDeath.aliveDrawPos == nil
            then
                local moveDis = 2
                local posDeath = Data().ExDeath.DeathBeamObj.pos
                local posAlive = Data().ExDeath.AliveBeamObj.pos
                local posBoth = Data().ExDeath.DothBeamObj.pos
                Data().ExDeath.deathDir = TensorCore.getHeadingToTarget(posBoth, posDeath)
                Data().ExDeath.deathDrawPos = TensorCore.getPosInDirection(posDeath, Data().ExDeath.deathDir, moveDis)
                Data().ExDeath.aliveDir = TensorCore.getHeadingToTarget(posBoth, posAlive)
                Data().ExDeath.aliveDrawPos = TensorCore.getPosInDirection(posAlive, Data().ExDeath.aliveDir, moveDis)
            else
                if Cfg().draw then
                    --这里画的是实际的颜色
                    local posDeath = Data().ExDeath.deathDrawPos
                    local posAlive = Data().ExDeath.aliveDrawPos
                    local posBoth = Data().ExDeath.DothBeamObj.pos
                    MG.CreateDrawer(0, 0, 1, nil, 1):addRect(posDeath.x, 0, posDeath.z, 40, 20, Data().ExDeath.DeathBeamObj.pos.h)
                    MG.CreateDrawer(1, 0, 1, nil, 1):addRect(posAlive.x, 0, posAlive.z, 40, 20, Data().ExDeath.AliveBeamObj.pos.h)
                    MG.CreateDrawer(1, 0, 0, nil, 1):addRect(posBoth.x, 0, posBoth.z, 40, 3, Data().ExDeath.DothBeamObj.pos.h)
                end
                if Cfg().guide then
                    if Data().ExDeath.GuideData == nil then
                        Data().ExDeath.GuideData = {}
                        for job, member in pairs(MG.Party) do
                            local buffMap = Data().Buff[job]
                            local goSame
                            if TensorCore.hasBuff(member.id, 5464)
                                    or TensorCore.hasBuff(member.id, 1382) then
                                if (buffMap[5464] == nil and buffMap[1382] == true)
                                        or (buffMap[5464] == true and buffMap[1382] == nil) then
                                    goSame = true
                                else
                                    goSame = false
                                end
                            elseif TensorCore.hasBuff(member.id, 454) then
                                if buffMap[454] then
                                    goSame = false
                                else
                                    goSame = true
                                end
                            end
                            local buff
                            if TensorCore.hasBuff(member.id, 4887) or TensorCore.hasBuff(member.id, 5541) then
                                if (buffMap[4887] == nil and buffMap[5541] == true)
                                        or (buffMap[5541] == nil and buffMap[4887] == true)
                                then
                                    buff = 4887
                                else
                                    buff = 4888
                                end
                            elseif TensorCore.hasBuff(member.id, 4888) or TensorCore.hasBuff(member.id, 5542) then
                                if (buffMap[4888] == nil and buffMap[5542] == true)
                                        or (buffMap[5542] == nil and buffMap[4888] == true)
                                then
                                    buff = 4888
                                else
                                    buff = 4887
                                end
                            end
                            local dir
                            if goSame == true then
                                if buff == 4887 then
                                    dir = Data().ExDeath.aliveDir
                                else
                                    dir = Data().ExDeath.deathDir
                                end
                            elseif goSame == false then
                                if buff == 4888 then
                                    dir = Data().ExDeath.aliveDir
                                else
                                    dir = Data().ExDeath.deathDir
                                end
                            end
                            if dir ~= nil then
                                Data().ExDeath.GuideData[job] = TensorCore.getPosInDirection(DM.Center, dir, 5)
                            end
                        end
                        debugGuideData('P4ExDeath', 'guide_buff_3', '执行Buff指路数据生成', Data().ExDeath.GuideData)
                    else
                        DM.DebugOnce('P4ExDeath', 'draw_buff_3', '执行Buff调用FrameMultiD', {
                            count = DM.DebugCount(Data().ExDeath.GuideData),
                        })
                        MG.FrameMultiD(Data().ExDeath.GuideData)
                    end
                end
            end
        end
    end

    if DM.InState('P4ThunderWater1') then
        --有任意一人加速度炸弹判定=当前机制已经完成
        for _, member in pairs(MG.Party) do
            if not TensorCore.hasBuff(member.id, 5546) then
                DM.ChangeState('P4Eye1')
                break
            end
        end
        ThunderWater(1)
        if Data().ThunderWater.Guide1 ~= nil and Cfg().guide then
            DM.DebugOnce('P4ThunderWater', 'draw_wave_1', '第一次雷水调用FrameMultiD', {
                count = DM.DebugCount(Data().ThunderWater.Guide1),
            })
            MG.FrameMultiD(Data().ThunderWater.Guide1)
        end
    end
    if DM.InState('P4Eye1') then
        if Data().Eye1.Owner == nil or table.size(Data().Eye1.Owner) < 2 then
            Data().Eye1.Owner = {}
            for job, member in pairs(MG.Party) do
                local buff = TensorCore.getBuff(member.id, 5543)
                if buff ~= nil and buff.duration < 10 then
                    local buffMap = Data().Buff[job]
                    table.insert(Data().Eye1.Owner, member.id)
                    if buffMap[5543] then
                        Data().Eye1.type = true
                    end
                end

            end
            if table.size(Data().Eye1.Owner) >= 2 then
                DM.DebugOnce('P4Eye', 'owner_1', '第一次石化眼目标缓存', {
                    owner = DM.DebugEntityList(Data().Eye1.Owner),
                    real = Data().Eye1.type,
                })
            end
        else
            local buff1 = TensorCore.getBuff(Data().Eye1.Owner[1], 5543)
            if buff1 == nil then
                DM.ChangeState('P4WaterFire1')
            end
            if Cfg().guide then
                if Data().Eye1.GuidePos == nil or table.size(Data().Eye1.GuidePos) < 8 then
                    Data().Eye1.GuidePos = {}
                    local tType = Data().Eye1.thunder
                    if tType ~= nil then
                        if Cfg().eyeType == 1 then
                            --盗火固定
                            local template = eye1PosFix[tType]
                            for job, member in pairs(MG.Party) do
                                if table.contains(Data().Eye1.Owner, member.id) then
                                    if Data().Eye1.type then
                                        Data().Eye1.GuidePos[job] = template.real
                                    else
                                        if MG.IndexOf(MG.JobPosName, job) <= 4 then
                                            Data().Eye1.GuidePos[job] = template.th
                                        else
                                            Data().Eye1.GuidePos[job] = template.dps
                                        end
                                    end
                                else
                                    Data().Eye1.GuidePos[job] = template.g
                                end
                            end
                        elseif Cfg().eyeType == 2 then
                            --盗火常规
                            local template = eye1PosFix[tType]
                            for job, member in pairs(MG.Party) do
                                if table.contains(Data().Eye1.Owner, member.id) then
                                    Data().Eye1.GuidePos[job] = template.g
                                end
                            end
                        elseif Cfg().eyeType == 3 then
                            --MMW
                            local template
                            if tType == DM.ThunderType.Left24 or tType == DM.ThunderType.Right24 then
                                template = eye1PosMMW[1]
                            else
                                template = eye1PosMMW[2]
                            end

                            for job, member in pairs(MG.Party) do
                                if table.contains(Data().Eye1.Owner, member.id) then
                                    if Data().Eye1.type then
                                        Data().Eye1.GuidePos[job] = template.real
                                    else
                                        Data().Eye1.GuidePos[job] = template.fake
                                    end
                                else
                                    Data().Eye1.GuidePos[job] = template.g
                                end
                            end
                        end
                        debugGuideData('P4Eye', 'guide_1', '第一次石化眼指路数据生成', Data().Eye1.GuidePos, {
                            thunderType = tType,
                            real = Data().Eye1.type,
                        })
                    else
                        DM.DebugOnce('P4Eye', 'missing_eye1_thunder', '[问题]第一次石化眼缺少雷类型，无法生成指路', {
                            owner = DM.DebugEntityList(Data().Eye1.Owner),
                        })
                    end
                else
                    DM.DebugOnce('P4Eye', 'draw_1', '第一次石化眼调用FrameMultiD', {
                        count = DM.DebugCount(Data().Eye1.GuidePos),
                    })
                    MG.FrameMultiD(Data().Eye1.GuidePos)
                end
            end
        end
    end

    if DM.OverState('P4Eye1', true)
            and DM.BeLowState('P4WaterFire1', true) then
        lockFaceCheck(Data().Eye1)
    end

    if DM.InState('P4WaterFire1') then
        if Data().WaterFire1.Guide1 == nil or table.size(Data().WaterFire1.Guide1) < 8 then
            Data().WaterFire1.Guide1 = {}
            local buffRF = Data().Buff[MG.SelfPos][5547]
            Data().WaterFire1.Type = buffRF
            for job, v in pairs(MG.Party) do
                Data().WaterFire1.Guide1[job] = { x = 100, y = 0, z = 100 }
                if buffRF then
                    if MG.IndexOf(MG.JobPosName, job) then
                        Data().WaterFire1.Guide2[job] = { x = 100, y = 0, z = 90 }
                    else
                        Data().WaterFire1.Guide2[job] = { x = 100, y = 0, z = 110 }
                    end
                else
                    Data().WaterFire1.Guide2[job] = { x = 100, y = 0, z = 100 }
                end
            end
            debugGuideData('P4WaterFire', 'guide_1', '第一次火水指路数据生成', Data().WaterFire1.Guide1, {
                type = Data().WaterFire1.Type,
                guide2Count = DM.DebugCount(Data().WaterFire1.Guide2),
            })
        else
            DM.DebugOnce('P4WaterFire', 'draw_1', '第一次火水调用FrameMultiD', {
                count = DM.DebugCount(Data().WaterFire1.Guide1),
            })
            MG.FrameMultiD(Data().WaterFire1.Guide1)
        end
    end
    if DM.InState('P4WaterFire1Put') then
        DM.DebugOnce('P4WaterFire', 'draw_1_put', '第一次火水放置后调用FrameMultiD', {
            count = DM.DebugCount(Data().WaterFire1.Guide2),
            type = Data().WaterFire1.Type,
        })
        MG.FrameMultiD(Data().WaterFire1.Guide2)
        if Data().WaterFire1.Type then
            DM.ChangeState('P4ThunderWater2')
        else
            if TimeSince(Data().WaterFire1.AoeTimer) > 4700 then
                DM.ChangeState('P4ThunderWater2')
            end
        end
    end

    if DM.InState('P4ThunderWater2') then
        local hasBuff = false
        -- 所有人加速度炸弹都炸了
        for _, member in pairs(MG.Party) do
            if TensorCore.hasBuff(member.id, 5546) then
                hasBuff = true
                break
            end
        end
        if not hasBuff then
            if Data().ThunderWater.ToEye2Timer == 0 then
                Data().ThunderWater.ToEye2Timer = Now()
            elseif TimeSince(Data().ThunderWater.ToEye2Timer) > 1200 then
                DM.ChangeState('P4Eye2')
            end
        end
        ThunderWater(2)
        if Data().ThunderWater.Guide2Offset == nil then
            if Data().ThunderWater.IceType ~= nil then
                Data().ThunderWater.Guide2Offset = {}
                if Data().ThunderWater.IceType == DM.IceType.danger13 then
                    for job, pos in pairs(Data().ThunderWater.Guide2) do
                        if pos.z < 99 then
                            Data().ThunderWater.Guide2Offset[job] = MG.VectorXZAdd(pos, { x = -1, y = 0, z = 0 })
                        elseif pos.x > 101 then
                            Data().ThunderWater.Guide2Offset[job] = MG.VectorXZAdd(pos, { x = 0, y = 0, z = 1 })
                        elseif pos.z > 101 then
                            Data().ThunderWater.Guide2Offset[job] = MG.VectorXZAdd(pos, { x = 1, y = 0, z = 0 })
                        elseif pos.x < 99 then
                            Data().ThunderWater.Guide2Offset[job] = MG.VectorXZAdd(pos, { x = 0, y = 0, z = -1 })
                        end
                    end
                elseif Data().ThunderWater.IceType == DM.IceType.danger24 then
                    for job, pos in pairs(Data().ThunderWater.Guide2) do
                        if pos.z < 99 then
                            Data().ThunderWater.Guide2Offset[job] = MG.VectorXZAdd(pos, { x = 1, y = 0, z = 0 })
                        elseif pos.x > 101 then
                            Data().ThunderWater.Guide2Offset[job] = MG.VectorXZAdd(pos, { x = 0, y = 0, z = -1 })
                        elseif pos.z > 101 then
                            Data().ThunderWater.Guide2Offset[job] = MG.VectorXZAdd(pos, { x = -1, y = 0, z = 0 })
                        elseif pos.x < 99 then
                            Data().ThunderWater.Guide2Offset[job] = MG.VectorXZAdd(pos, { x = 0, y = 0, z = 1 })
                        end
                    end
                end
                debugGuideData('P4ThunderWater', 'guide_wave_2_offset', '第二次雷水冰偏移指路数据生成', Data().ThunderWater.Guide2Offset, {
                    iceType = Data().ThunderWater.IceType,
                })
            end
        end
        if Cfg().guide then
            if Data().ThunderWater.Guide2Offset ~= nil then
                DM.DebugOnce('P4ThunderWater', 'draw_wave_2_offset', '第二次雷水调用偏移FrameMultiD', {
                    count = DM.DebugCount(Data().ThunderWater.Guide2Offset),
                })
                MG.FrameMultiD(Data().ThunderWater.Guide2Offset)
            else
                DM.DebugOnce('P4ThunderWater', 'draw_wave_2', '第二次雷水调用FrameMultiD', {
                    count = DM.DebugCount(Data().ThunderWater.Guide2),
                })
                MG.FrameMultiD(Data().ThunderWater.Guide2)
            end
        end
    end

    if DM.InState('P4Eye2') then
        local hasBuff = false
        for _, member in pairs(MG.Party) do
            if TensorCore.hasBuff(member.id, 5543) then
                hasBuff = true
            end
        end
        if not hasBuff then
            DM.ChangeState('P4WaterFire2')
        end
        if Data().Eye2.Owner == nil then
            Data().Eye2.Owner = {}
            for job, member in pairs(MG.Party) do
                local buff = TensorCore.getBuff(member.id, 5543)
                if buff ~= nil and buff.duration < 10 then
                    local buffMap = Data().Buff[job]
                    table.insert(Data().Eye2.Owner, member.id)
                    if buffMap[5543] then
                        Data().Eye2.type = true
                    end
                end
            end
            if table.size(Data().Eye2.Owner) >= 2 then
                DM.DebugOnce('P4Eye', 'owner_2', '第二次石化眼目标缓存', {
                    owner = DM.DebugEntityList(Data().Eye2.Owner),
                    real = Data().Eye2.type,
                })
            end
        else
            if Data().Eye2.GuidePos == nil then
                Data().Eye2.GuidePos = {}
                for job, member in pairs(MG.Party) do
                    if Cfg().eyeType == 1 then
                        if table.contains(Data().Eye2.Owner, member.id) then
                            if Data().Eye2.type then
                                Data().Eye2.GuidePos[job] = { x = 95, y = 0, z = 100 }
                            else
                                if MG.IndexOf(MG.JobPosName, job) <= 4 then
                                    Data().Eye2.GuidePos[job] = { x = 100, y = 0, z = 91 }
                                else
                                    Data().Eye2.GuidePos[job] = { x = 100, y = 0, z = 109 }
                                end
                            end
                        else
                            if MG.IndexOf(MG.JobPosName, job) <= 4 then
                                Data().Eye2.GuidePos[job] = { x = 100, y = 0, z = 98 }
                            else
                                Data().Eye2.GuidePos[job] = { x = 100, y = 0, z = 102 }
                            end
                        end
                    elseif Cfg().eyeType == 2 then
                        if table.contains(Data().Eye2.Owner, member.id) then
                            Data().Eye2.GuidePos[job] = { x = 100, y = 0, z = 100 }
                        end
                    elseif Cfg().eyeType == 3 then
                        if table.contains(Data().Eye2.Owner, member.id) then
                            if Data().Eye2.type then
                                Data().Eye2.GuidePos[job] = eye1PosMMW[1].real
                            else
                                Data().Eye2.GuidePos[job] = eye1PosMMW[1].fake
                            end
                        else
                            Data().Eye2.GuidePos[job] = eye1PosMMW[1].g
                        end
                    end
                end
                debugGuideData('P4Eye', 'guide_2', '第二次石化眼指路数据生成', Data().Eye2.GuidePos, {
                    real = Data().Eye2.type,
                })
            else
                DM.DebugOnce('P4Eye', 'draw_2', '第二次石化眼调用FrameMultiD', {
                    count = DM.DebugCount(Data().Eye2.GuidePos),
                })
                MG.FrameMultiD(Data().Eye2.GuidePos)
            end
        end
    end
    if DM.OverState('P4Eye2', true) and DM.BeLowState('P4WaterFire2', true) then
        lockFaceCheck(Data().Eye2)
    end

    if DM.InState('P4WaterFire2') then
        if Data().WaterFire2.Guide1 == nil or table.size(Data().WaterFire2.Guide1) < 8 then
            Data().WaterFire2.Guide1 = {}
            Data().WaterFire2.Type = Data().Buff[MG.SelfPos][5548]
            for job, _ in pairs(MG.Party) do
                Data().WaterFire2.Guide1[job] = { x = 100, y = 0, z = 100 }
            end
            debugGuideData('P4WaterFire', 'guide_2_before_put', '第二次火水集合指路数据生成', Data().WaterFire2.Guide1, {
                type = Data().WaterFire2.Type,
            })
        else
            DM.DebugOnce('P4WaterFire', 'draw_2_before_put', '第二次火水集合调用FrameMultiD', {
                count = DM.DebugCount(Data().WaterFire2.Guide1),
            })
            MG.FrameMultiD(Data().WaterFire2.Guide1)
        end
    end

    if DM.InState('P4WaterFire2Put') then
        if Data().WaterFire2.ThunderType ~= nil
                and Data().WaterFire2.IceType ~= nil then
            if Data().WaterFire2.Guide2 == nil or table.size(Data().WaterFire2.Guide2) < 8 then
                Data().WaterFire2.Guide2 = {}
                local near, far, center, same = DM.CalcMixPoint(Data().WaterFire2.ThunderType, Data().WaterFire2.IceType)
                MG.OnCurrentPartyDo(function(job, member)
                    local basePos
                    if same then
                        -- 如果是2个点情况
                        local disN = TensorCore.getDistance2d(member.pos, near)
                        local disF = TensorCore.getDistance2d(member.pos, far)
                        if disN < disF then
                            basePos = near
                        else
                            basePos = far
                        end
                    else
                        basePos = near
                    end
                    local dir = TensorCore.getHeadingToTarget(DM.Center, basePos)
                    if Data().WaterFire2.Type then
                        Data().WaterFire2.Guide2[job] = TensorCore.getPosInDirection(DM.Center, dir, 2)
                    else
                        Data().WaterFire2.Guide2[job] = TensorCore.getPosInDirection(DM.Center, dir, 8)
                    end
                end)
                debugGuideData('P4WaterFire', 'guide_2_put', '第二次火水放置后指路数据生成', Data().WaterFire2.Guide2, {
                    thunderType = Data().WaterFire2.ThunderType,
                    iceType = Data().WaterFire2.IceType,
                    same = same,
                    type = Data().WaterFire2.Type,
                    near = near,
                    far = far,
                })
            else
                DM.DebugOnce('P4WaterFire', 'draw_2_put', '第二次火水放置后调用FrameMultiD', {
                    count = DM.DebugCount(Data().WaterFire2.Guide2),
                })
                MG.FrameMultiD(Data().WaterFire2.Guide2)
            end
        else
            DM.DebugOnce('P4WaterFire', 'missing_2_put', '[问题]第二次火水缺少冰雷类型，无法生成最终指路', {
                thunderType = Data().WaterFire2.ThunderType,
                iceType = Data().WaterFire2.IceType,
            })
        end
    end
end
return Dmu_P4
