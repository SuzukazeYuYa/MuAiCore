local Dmu_P1 = {}
Dmu_P1.StateName = "P1"

---@type DancingMad
local DM
---@type MuAiGuide
local MG

--- 初始化
--- @param dm DancingMad
--- @param m MuAiGuide
Dmu_P1.Init = function(dm, m)
    DM = dm
    MG = m
end

Dmu_P1.OnEntityChannel = function(entityID, spellID, _)
    local data = MG.DancingMad
    if spellID == 47764 then
        if data.CurrentState < DM.State.P1TrueFalse1 then
            DM.ChangeState(DM.State.P1TrueFalse1)
        end
    end
end

Dmu_P1.OnMarkerAdd = function(entityID, markerID)
    local data = MG.DancingMad
    if data.CurrentState <= DM.State.P1TrueFalse1 then
        if data.CurrentState < DM.State.P1TrueFalse1 then
            DM.ChangeState(DM.State.P1TrueFalse1)
        end
        if markerID == 127 or markerID == 128 then
            if data.P1_1Fire.PlayerMark == 0 then
                data.P1_1Fire.PlayerMark = markerID
                if markerID == 128 then
                    table.insert(data.P1_1Fire.GatherPlayers, entityID)
                end
            end
        elseif markerID == 673 or markerID == 674 then
            data.P1_1Fire.BossMark = markerID
        end
    end
end

---@param aoeInfo DirectionalAOE
Dmu_P1.OnAOECreate = function(aoeInfo)
    local M = MuAiGuide
    if M.Config.DmuCfg.state.P1.draw then
        local drawTime = 5500
        -- 冰危险区
        if aoeInfo.aoeID == 47774 or aoeInfo.aoeID == 47768 then
            DM.yellowDrawer:addTimedCone(drawTime, aoeInfo.x, aoeInfo.y, aoeInfo.z, 40, math.pi / 2, aoeInfo.heading, 0, true)
        end

        -- 画雷危险区
        if aoeInfo.aoeID == 47775 or aoeInfo.aoeID == 47777 then
            DM.yellowDrawer:addTimedRect(drawTime, aoeInfo.x, aoeInfo.y, aoeInfo.z, 45, 10, aoeInfo.heading, 0, true)
        end
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
    if data.CurrentState == DM.State.P1TrueFalse1 then
        if MG.Config.DmuCfg.state.P1.draw
                and data.P1_1Fire.BossMark ~= 0
                and data.P1_1Fire.PlayerMark ~= 0
        then
            if data.P1_1Fire.PlayerMark == 127
                    or table.size(data.P1_1Fire.GatherPlayers) >= 2 then
                local radius = 5
                local drawTime = 6000
                if data.P1_1Fire.BossMark == 673 then
                    --火是假的
                    if data.P1_1Fire.PlayerMark == 127 then
                        DM.greenDrawer:addTimedCircleOnEnt(drawTime, TensorCore.mGetPlayer().id, radius)
                    else
                        for _, member in pairs(MG.Party) do
                            DM.redDrawer:addTimedCircleOnEnt(drawTime, member.id, radius)
                        end
                    end
                else
                    --火是假的
                    if data.P1_1Fire.PlayerMark == 127 then
                        for _, member in pairs(MG.Party) do
                            DM.redDrawer:addTimedCircleOnEnt(drawTime, member.id, radius)
                        end
                    else
                        for _, id in pairs(data.P1_1Fire.GatherPlayers) do
                            DM.greenDrawer:addTimedCircleOnEnt(drawTime, TensorCore.mGetPlayer().id, radius)
                        end
                    end
                end
                DM.ChangeState(DM.State.P1TrueFalse2)
            end
        end
    end

    if data.CurrentState == DM.State.P1TrueFalse2 then
        if MG.IsAnyMemberHasBuff(2941) then
            DM.ChangeState(DM.State.P1TrueFalse1End)
        end
    end
end

return Dmu_P1