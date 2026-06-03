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

--- 初始化
--- @param dm DancingMad
--- @param m MuAiGuide
Dmu_P1.Init = function(dm, m)
    DM = dm
    MG = m
end

Dmu_P1.OnEntityChannel = function(entityID, spellID, _)
    if spellID == 47764 then
        if DM.BeLowState('P1TrueFalse1', true) then
            DM.ChangeState('P1TrueFalse1')
        end
    elseif spellID == 48370 then
        -- 众神之象
        if DM.OverState('P1BeamEnd') then
            DM.ChangeState('P1Line2_1')
        end
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
        -- 冰危险区
        if aoeInfo.aoeID == 47774 or aoeInfo.aoeID == 47768 then
            DM.yellowDrawer:addTimedCone(drawTime, aoeInfo.x, aoeInfo.y, aoeInfo.z, 40, math.pi / 2, aoeInfo.heading, 0, true)
        end

        -- 画雷危险区
        if aoeInfo.aoeID == 47775 or aoeInfo.aoeID == 47777 then
            local startPos = TensorCore.getPosInDirection({ x = aoeInfo.x, y = aoeInfo.y, z = aoeInfo.z }, aoeInfo.heading + math.pi, 5)
            DM.yellowDrawer:addTimedRect(drawTime, startPos.x, startPos.y, startPos.z, 50, 10, aoeInfo.heading, 0, true)
        end
    end

    -- 采集刷的塔信息
    if aoeInfo.aoeID == 47786 and DM.BeLowState('P2Start') then
        table.insert(Data().TowerAoe, aoeInfo)
    end
end

Dmu_P1.OnEventObjectScriptFunc = function(entityID)


end

Dmu_P1.OnAddEntityVFX = function(vfxID)


end

Dmu_P1.Update = function()
    local data = MG.DancingMad
    if data == nil then
        return
    end

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

    if DM.InState('P1TrueFalse1End') then
        if Cfg().draw then
            -- 画激光
            local point = { x = 100, y = 0, z = 70 }
            for _, member in pairs(MuAiGuide.Party) do
                local curMember = TensorCore.mGetEntity(member.id)
                if curMember ~= nil then
                    local dir = TensorCore.getHeadingToTarget(point, curMember.pos)
                    local color = GUI:ColorConvertFloat4ToU32(0, 1, 1, 0.2)
                    Argus2.ShapeDrawer:new(color, color, color, GUI:ColorConvertFloat4ToU32(0, 0, 1, 1), 0)
                          :addRect(point.x, point.y, point.z, 60, 6, dir, false)
                end
            end
        end
        if TimeSince(Data().Fire1.Time) > 2500 and MG.IsAnyMemberHasBuff(2941) then
            DM.ChangeState('P1BeamEnd')
        end
    end

    -- 记录激光射了谁
    if DM.InState('P1BeamEnd') then
        for _, member in pairs(MG.Party) do
            local debuff = TensorCore.getBuff(member.id, 2941)
            if debuff ~= nil and table.contains(Data().BeamShoot, member.id) then
                table.insert(Data().BeamShoot, member.id)
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
end

return Dmu_P1