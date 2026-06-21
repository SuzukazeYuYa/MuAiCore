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
    { x = 100, y = 0, z = 98 }, --A
    { x = 102, y = 0, z = 100 }, --B
    { x = 100, y = 0, z = 102 }, --C
    { x = 98, y = 0, z = 100 }, --D
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

local boss

local getBoss = function()
    if boss == nil then
        for _, ent in pairs(TensorCore.entityList("contentid=7131")) do
            local model = Argus.getEntityModel(ent.id)
            if model == 19511 and Argus.isEntityVisible(ent) then
                boss = ent
                break
            end
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

local sortTableByClock = function(tbl)
    if table.size(tbl) == 3 then
        table.sort(tbl, function(a, b)
            return MG.GetClock(a.pos, b.pos)
        end)
    end
end

local drawCelestriadChoice = function(spellID, entityID, drawTime)
    if not Cfg().draw then
        return
    end
    local curBoss
    if entityID ~= nil then
        curBoss = TensorCore.mGetEntity(entityID)
    end
    if curBoss == nil and boss ~= nil then
        curBoss = TensorCore.mGetEntity(boss.id)
    end
    if curBoss == nil or curBoss.pos == nil then
        return
    end
    drawTime = drawTime or 5000
    if spellID == 49742 then
        MG.CreateDrawer(1, 0, 0, 0.3, 2):addTimedCircle(drawTime, curBoss.pos.x, 0, curBoss.pos.z, 10)
    elseif spellID == 49743 then
        MG.CreateDrawer(1, 0, 0, 0.4, 2):addTimedDonut(drawTime, curBoss.pos.x, 0, curBoss.pos.z, 10, 25)
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
    else
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

---@param aoeInfo DirectionalAOE
local drawGroundFire = function(aoeInfo)
    if not Cfg().draw then
        return
    end
    Data().GroundFire.seen = Data().GroundFire.seen or {}
    local key = tostring(aoeInfo.entityID or 0)
            .. ':' .. tostring(math.floor((aoeInfo.x or 0) * 10 + 0.5))
            .. ':' .. tostring(math.floor((aoeInfo.z or 0) * 10 + 0.5))
            .. ':' .. tostring(math.floor((aoeInfo.heading or 0) * 1000 + 0.5))
    if Data().GroundFire.seen[key] then
        return
    end
    Data().GroundFire.seen[key] = true

    local pos = { x = aoeInfo.x, y = 0, z = aoeInfo.z }
    local radius = aoeInfo.aoeLength or 6
    local step = 7.07106781187
    local firstDelay = math.floor((aoeInfo.duration or 3.7) * 1000 + 250)
    local interval = 520
    for i = 0, 6 do
        local p = TensorCore.getPosInDirection(pos, aoeInfo.heading, step * i)
        local resolveDelay = firstDelay + interval * i
        local drawDelay = math.max(0, resolveDelay - 3000)
        local drawTime = math.max(250, resolveDelay - drawDelay + interval)
        DM.redDrawer:addTimedCircle(drawTime, p.x, 0, p.z, radius, drawDelay, true, false)
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
        drawCelestriadChoice(spellID, entityID)
    elseif spellID == 47931 then
        if DM.BeLowState('P5GroundFire') then
            DM.ChangeState('P5GroundFire')
        end
    elseif spellID == 47934 or spellID == 47935 then
        for _, member in pairs(MG.Party) do
            MG.CreateDrawer(1, 0, 1, 0.1):addTimedCircleOnEnt(5000, member.id, 5)
        end
    elseif spellID == 47925 then
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
        drawGroundFire(aoeInfo)
    end
end

Dmu_P5.OnEventObjectScriptFunc = function(entityID, a1, a2, a3)
    if a1 == 16 and a2 == 32 then
        local obj = TensorCore.mGetEntity(entityID)
        if 2015294 <= obj.contentid and obj.contentid <= 2015296 then
            Data().Celestriad.castingCache[entityID] = {
                dir = TensorCore.getHeadingToTarget(DM.Center, obj.pos),
                Obj = TensorCore.mGetEntity(entityID)
            }
            if table.size(Data().Celestriad.castingCache) == 4 then
                Data().Celestriad.wave = Data().Celestriad.wave + 1
                MG.ArrInfo('第' .. Data().Celestriad.wave .. '波踩塔。')
                Data().Celestriad.CastingTowers[Data().Celestriad.wave] = Data().Celestriad.castingCache
                Data().Celestriad.castingCache = {}
            end
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
    if DM.InState('P5Start') --P5UltimaRepeater1
            or DM.InState('P5UltimaRepeater2')
            or DM.InState('P5UltimaRepeater3')
            or DM.InState('P5UltimaRepeater4')
    then
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
                drawer:addCircle(member.pos.x, 0, member.pos.z, 5)
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
                Data().MaddeningOrchestra.Guide1[pos[i]] = TensorCore.getPosInDirection(DM.Center, dir, 7.5)
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
                    MG.CreateDrawer(0, 0.5, 1, 0.2, 2):addCircle(member.pos.x, 0, member.pos.z, 5)
                end
            end
            local mt = TensorCore.mGetEntity(MG.Party.MT.id)
            MG.CreateDrawer(1, 0.5, 0, 0.2, 2):addCircle(mt.pos.x, 0, mt.pos.z, 5)
        end
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
        if TimeSince(Data().MaddeningOrchestra.FirstHitTimer) > 4200 then
            for job, member in pairs(MG.Party) do
                if job ~= 'MT' and job ~= 'ST'
                        and TensorCore.hasBuff(member.id, 2941)
                        and (not table.contains(Data().MaddeningOrchestra.FirstHits, job)) then
                end
                if DM.InState('P5MaddeningOrchestra1End') then
                    DM.ChangeState('P5MaddeningOrchestra2End')
                else
                    DM.ChangeState('P5MaddeningOrchestra2_2End')
                end
                break
            end
        end
    end

    if DM.InState('P5MaddeningOrchestra2End')
            or DM.InState('P5MaddeningOrchestra2_2End')
    then
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
        end
        if Cfg().draw then
            if Data().MaddeningOrchestra.RedBuff ~= nil then
                local curPlayer = TensorCore.mGetEntity(Data().MaddeningOrchestra.RedBuff.id)
                MG.CreateDrawer(1, 0.5, 0, 0.2, 2):addCircle(curPlayer.pos.x, 0, curPlayer.pos.z, 26)
            end
            if Data().MaddeningOrchestra.BlueBuff ~= nil then
                local curPlayer = TensorCore.mGetEntity(Data().MaddeningOrchestra.BlueBuff.id)
                MG.CreateDrawer(0, 0.5, 1, 0.2, 2):addCircle(curPlayer.pos.x, 0, curPlayer.pos.z, 6)
            end
        end
        if Cfg().guide and Data().MaddeningOrchestra.Guide3 ~= nil then
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
    if DM.InState('P5Celestriad') then
        if Data().Celestriad.AllTowers == nil or table.size(Data().Celestriad.AllTowers) < 9 then
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
        loadGuidePosAndNextStart()
    end
    if DM.InState('P5BeforeEnd') then
        local curBoss = TensorCore.mGetEntity(boss.id)
        if curBoss ~= nil and (not curBoss.alive or curBoss.hp.current <= 0) then
            MG.Info('------------------------------------------')
            MG.Info('恭喜通关' .. DM.NameCN .. '!')
            MG.Info('感谢使用本插件，了解更多信息请加入QQ群1106367633。')
            MG.Info('Powered by MuAi 2026-06')
            MG.Info('------------------------------------------')
            DM.ChangeState('P5End')
        end
    end
end
return Dmu_P5
