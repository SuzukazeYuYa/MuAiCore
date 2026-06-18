local Dmu_P5 = {}
Dmu_P5.StateName = "P5"
---@type DancingMad
local DM
---@type MuAiGuide
local MG

local Cfg = function()
    return MG.Config.DmuCfg.P5
end

local Data = function()
    if MG.DancingMad == nil then
        return nil
    end
    return MG.DancingMad.P5
end

local floodPos = {
    { x = 100, y = 0, z = 99 }, --A
    { x = 101, y = 0, z = 100 }, --B
    { x = 100, y = 0, z = 101 }, --C
    { x = 99, y = 0, z = 100 }, --D
}
local blueBuffId = 5351 -- 顺手加一个神圣
local redBuffId = 5350 -- 顺手加一个核爆
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
    DM.redDrawer:addRect(Data().Blood.Aoe[index1].x, 0, Data().Blood.Aoe[index1].z, 40, 10, Data().Blood.Aoe[index1].heading)
    DM.redDrawer:addRect(Data().Blood.AoeOut[index1].x, 0, Data().Blood.AoeOut[index1].z, 40, 10, Data().Blood.AoeOut[index1].heading)
    if index2 ~= nil then
        DM.yellowDrawer:addRect(Data().Blood.Aoe[index2].x, 0, Data().Blood.Aoe[index2].z, 40, 10, Data().Blood.Aoe[index2].heading)
        DM.yellowDrawer:addRect(Data().Blood.AoeOut[index2].x, 0, Data().Blood.AoeOut[index2].z, 40, 10, Data().Blood.AoeOut[index2].heading)
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

Dmu_P5.Init = function(dm, m)
    DM = dm
    MG = m
end

Dmu_P5.OnEntityChannel = function(entityID, spellID, _)
    if spellID == 49471 then
        -- 洪水
        if DM.BeLowState('P5BloodStart') then
            DM.ChangeState('P5BloodStart')
        end
    elseif spellID == 47952 then
        --癫狂交响曲
        if DM.BeLowState('P5MaddeningOrchestra') then
            DM.ChangeState('P5MaddeningOrchestra')
        end
    elseif spellID == 47938 then
        -- 三星
        if DM.BeLowState('P5CelestriadPre') then
            DM.ChangeState('P5CelestriadPre')
            --终止对3平A站位指路
        end
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
    end
end

Dmu_P5.OnMapEffect = function(a1, a2, a3)
end

Dmu_P5.Update = function()
    if DM.InState('P5Start') --P5UltimaRepeater1
            or DM.InState('P5UltimaRepeater2') then
        MG.FrameMultiD(ultimaRepeater)
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
        if Data().Blood.Cross34 ~= nil and Cfg().guide then
            setDataAndGuide(1, Data().Blood.Cross34)
        end
        if Cfg().draw and table.size(Data().Blood.Aoe) >= 2 and table.size(Data().Blood.AoeOut) >= 2 then
            drawCurBlood(1, 2)
        end
    end

    if DM.InState('P5Blood1End') then
        if Data().Blood.Cross14 ~= nil and Cfg().guide then
            setDataAndGuide(2, Data().Blood.Cross14)
        end
        if Cfg().draw and table.size(Data().Blood.Aoe) >= 3
                and table.size(Data().Blood.AoeOut) >= 3 then
            drawCurBlood(2, 3)
        end
    end

    if DM.InState('P5Blood2End') then
        if Data().Blood.Cross12 ~= nil and Cfg().guide then
            setDataAndGuide(3, Data().Blood.Cross12)
        end
        if Cfg().draw and table.size(Data().Blood.Aoe) >= 4
                and table.size(Data().Blood.AoeOut) >= 4 then
            drawCurBlood(3, 4)
        end
    end

    if DM.InState('P5Blood3End') then
        if Data().Blood.Cross12 ~= nil and Cfg().guide then
            setDataAndGuide(3, Data().Blood.Cross12)
        end
        if Cfg().draw and table.size(Data().Blood.Aoe) >= 4
                and table.size(Data().Blood.AoeOut) >= 4 then
            drawCurBlood(4)
        end
    end
    if DM.InState('P5MaddeningOrchestra') then
        if MG.IsAnyMemberHasBuff(2941) then
            DM.ChangeState('P5MaddeningOrchestra1End')
            Data().MaddeningOrchestra.FirstHitTimer = Now()
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
                Data().MaddeningOrchestra.Guide1[pos[i]] = TensorCore.getPosInDirection(DM.Center, dir, 7.5)
                local dis = 11
                if pos[i] == 'MT' then
                    dis = 9
                end
                Data().MaddeningOrchestra.GuideOut[pos[i]] = TensorCore.getPosInDirection(DM.Center, dir, dis)
            end
        else
            if Cfg().guide then
                MG.FrameMultiD(Data().MaddeningOrchestra.Guide1)
            end
        end
        if Cfg().draw then
            MG.OnCurrentPartyDo(function(job, member)
                local drawer
                if MG.IsTank(member.job) then
                    drawer = MG.CreateDrawer(1, 0.5, 0, 0.3, 2)
                else
                    drawer = MG.CreateDrawer(0, 0.5, 1, 0.3, 2)
                end
                drawer:addCircle(member.pos.x, 0, member.pos.z, 5)
            end)
        end
    end

    if DM.InState('P5MaddeningOrchestra1End') then
        -- 获取DebuffHD
        if Data().MaddeningOrchestra.Guide2 == nil or table.size(Data().MaddeningOrchestra.Guide2) < 8 then
            if TimeSince(Data().MaddeningOrchestra.FirstHitTimer) > 500 then
                Data().MaddeningOrchestra.Guide2 = {}
                if Cfg().isLeaning then
                    Data().MaddeningOrchestra.Guide2.ST = { x = 100, y = 0, z = 91 }
                    Data().MaddeningOrchestra.Guide2.MT = { x = 100, y = 0, z = 91 }
                else
                    Data().MaddeningOrchestra.Guide2.ST = Data().MaddeningOrchestra.Guide1.MT
                    Data().MaddeningOrchestra.Guide2.MT = Data().MaddeningOrchestra.Guide1.MT
                end
                for job, member in pairs(MG.Party) do
                    if TensorCore.hasBuff(member.id, 2941) and job ~= 'MT' and job ~= 'ST' then
                        table.insert(Data().MaddeningOrchestra.FirstHits, job)
                        Data().MaddeningOrchestra.Guide2[job] = Data().MaddeningOrchestra.GuideOut[job]
                    else
                        Data().MaddeningOrchestra.Guide2[job] = Data().MaddeningOrchestra.Guide1[job]
                    end
                end
            end
        else
            if Cfg().guide then
                MG.FrameMultiD(Data().MaddeningOrchestra.Guide2)
            end
        end
        if Cfg().draw then
            local curParty = MG.getCurParty()
            table.sort(curParty, function(a, b)
                return TensorCore.getDistance2d(DM.Center, a.pos)
                        < TensorCore.getDistance2d(DM.Center, b.pos)
            end)
        end
        if TimeSince(Data().MaddeningOrchestra.FirstHitTimer) > 4200 then
            for job, member in pairs(MG.Party) do
                if job ~= 'MT' and job ~= 'ST'
                        and TensorCore.hasBuff(member.id, 2941)
                        and (not table.contains(Data().MaddeningOrchestra.FirstHits, job)) then
                end
                DM.ChangeState('P5MaddeningOrchestra2End')
                break
            end
        end
    end

    if DM.InState('P5MaddeningOrchestra2End') then
        if Data().MaddeningOrchestra.Guide3 == nil or table.size(Data().MaddeningOrchestra.Guide2) < 8 then
            Data().MaddeningOrchestra.Guide3 = {}
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
        else
            if Cfg().guide then
                MG.FrameMultiD(Data().MaddeningOrchestra.Guide3)
            end
        end
        if Cfg().draw then
            if Data().MaddeningOrchestra.RedBuff ~= nil then
                local curPlayer = TensorCore.mGetEntity(Data().MaddeningOrchestra.RedBuff.id)
                MG.CreateDrawer(1, 0.5, 0, 3, 2):addCircle(curPlayer.pos.x, 0, curPlayer.pos.z, 26)  --todo 待采集 临时写30
            end
            if Data().MaddeningOrchestra.BlueBuff ~= nil then
                local curPlayer = TensorCore.mGetEntity(Data().MaddeningOrchestra.BlueBuff.id)
                MG.CreateDrawer(0, 0.5, 1, 0.3, 2):addCircle(curPlayer.pos.x, 0, curPlayer.pos.z, 6)  --todo 待采集 临时写6
            end
        end
        if not TensorCore.hasBuff(Data().MaddeningOrchestra.RedBuff.id, redBuffId)
                and not TensorCore.hasBuff(Data().MaddeningOrchestra.BlueBuff.id, blueBuffId)
        then
            DM.ChangeState('P5UltimaRepeater2')
        end
    end
    --if DM.InState('P5Celestriad') then
    --    if Data().Celestriad.AllTowers == nil or table.size(Data().Celestriad.AllTowers) < 9 then
    --        Data().Celestriad.AllTowers = {}
    --        Data().Celestriad.TowerFire = {}
    --        Data().Celestriad.TowerIce = {}
    --        Data().Celestriad.TowerThunder = {}
    --        for _, ent in pairs(TensorCore.entityList("contentid=2015294")) do
    --            table.insert(Data().Celestriad.AllTowers, ent)
    --            table.insert(Data().Celestriad.TowerFire, ent)
    --        end
    --        for _, ent in pairs(TensorCore.entityList("contentid=2015295")) do
    --            table.insert(Data().Celestriad.AllTowers, ent)
    --            table.insert(Data().Celestriad.TowerIce, ent)
    --        end
    --        for _, ent in pairs(TensorCore.entityList("contentid=2015296")) do
    --            table.insert(Data().Celestriad.AllTowers, ent)
    --            table.insert(Data().Celestriad.TowerThunder, ent)
    --        end
    --        if table.size(Data().Celestriad.TowerThunder) == 3 then
    --            table.sort(Data().Celestriad.TowerThunder, function(a, b)
    --                return MG.GetClock(a.pos, b.posz)
    --            end)
    --        end
    --    else
    --
    --    end
    --end
end
return Dmu_P5