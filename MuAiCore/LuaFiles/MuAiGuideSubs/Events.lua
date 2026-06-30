local Events = {}
--[[
===========================
    事件模块
===========================
]]
local lastMap, lastJob
local autoPopMap = { 1238, 1122, 1325, 1327, 1317, 1363 }
---@type MuAiGuide
local MG
local lastBattleTime = 0
---@param M MuAiGuide
local checkAndPopMainUI = function()
    MG.CloseAllUI()
    if table.contains(autoPopMap, Player.localmapid) then
        MG.LoadParty()
        if MG.MainUI.tabs ~= nil then
            for i = 1, 6 do
                MG.MainUI.tabs.tabs[i].isselected = i == 1
            end
        end
        MG.OpenUI("MainUI")
    end
end

local isDrawBlackListOn = function()
    return MG.Config.Main.DrawBlackListEnable
            and MG.Config.Main.DrawBlackList
            and table.size(MG.Config.Main.DrawBlackList) > 0
end

--- 绘图黑名单控制
local disableDrawCheck = function()
    if isDrawBlackListOn() then
        if lastMap ~= Player.localmapid then
            if table.contains(MG.Config.Main.DrawBlackList, Player.localmapid) then
                MG.InfoNoLog("进入绘制黑名单区域，MoogleTelegraphs的[敌人范围]已关闭。")
                MoogleTelegraphs.Settings.DrawEnemyAoE = false
            elseif table.contains(MG.Config.Main.DrawBlackList, lastMap) then
                MG.InfoNoLog("离开绘制黑名单区域，MoogleTelegraphs的[敌人范围]已开启。")
                MoogleTelegraphs.Settings.DrawEnemyAoE = true
            end
        end
    end
end

---@param M MuAiGuide
local MoogleExCheck = function()
    if MoogleTelegraphs and MoogleTelegraphs.Settings then
        disableDrawCheck()
        if isDrawBlackListOn()
                and not table.contains(MG.Config.Main.DrawBlackList, Player.localmapid)
                and MoogleTelegraphs and MoogleTelegraphs.Settings
                and MoogleTelegraphs.Settings.DrawEnemyAoE == false
        then
            MoogleTelegraphs.Settings.DrawEnemyAoE = true
            MG.Info("当前已由MuAiCore管理莫古力敌人范围开关，检测MoogleTelegraphs的[敌人范围]被关闭，已将其恢复到开启状态。")
        end
    end
end

---@param M MuAiGuide
local attackRangeReMake = function()
    if not MG.Config.Main.AttackRangeReplace
            or MoogleTelegraphs == nil or MoogleTelegraphs.Settings == nil
            or Player == nil
    then
        return
    end
    local curTarget = TensorCore.mGetTarget()
    if curTarget == nil or not curTarget.attackable or curTarget.type == 1 then
        return
    end
    MoogleTelegraphs.Settings.DrawAttackRange = false
    local curDistance = TensorCore.getDistance2d(Player.pos, curTarget.pos)
    local hitRange = curTarget.hitRadius
    local deltaDistance = curDistance - hitRange
    local alpha, color
    local radius
    local maxRange
    if (not MG.IsTank(Player.job)) and (not MG.IsMelee(Player.job)) then
        maxRange = 25.5
    else
        maxRange = 3.5
    end
    radius = hitRange + maxRange
    local minRange = maxRange - 1.5
    local inSideColor = MoogleTelegraphs.Settings.outlineRGB.rangeInside
    local outSideColor = MoogleTelegraphs.Settings.outlineRGB.rangeOutside
    if MoogleTelegraphs.Settings.AlwaysShowAttackRange then
        if deltaDistance >= maxRange then
            alpha = outSideColor.a
            color = outSideColor
        else
            alpha = inSideColor.a
            color = inSideColor
        end
    else
        if deltaDistance >= maxRange then
            alpha = outSideColor.a
            color = outSideColor
        elseif deltaDistance >= minRange then
            local sub = deltaDistance - minRange
            if sub < 1 then
                alpha = inSideColor.a * sub
            else
                alpha = inSideColor.a
            end
            color = inSideColor
        else
            return
        end
    end
    local drawer = Argus2.ShapeDrawer:new(
            (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, 0)),
            (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, 0)),
            (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, 0)),
            (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, alpha)),
            MoogleTelegraphs.Settings.outlineThickness.range
    )
    drawer:addCircle(curTarget.pos.x, curTarget.pos.y, curTarget.pos.z, radius)
end

local attackRangeHackHelper = function()
    if Player == nil or Player.hitradius == nil or (not MG.Config.Main.AttackRangeHelper) then
        return
    end
    local addRange = Player.hitradius - 0.5
    if math.abs(addRange) <= 0.001 then
        return
    end
    local curTarget = TensorCore.mGetTarget()
    if curTarget == nil or not curTarget.attackable then
        return
    end
    local curDistance = TensorCore.getDistance2d(Player.pos, curTarget.pos)
    local deltaDistance = curDistance - curTarget.hitradius + addRange
    local alpha, color, radius, maxRange
    if (not MG.IsTank(Player.job)) and (not MG.IsMelee(Player.job)) then
        maxRange = 25.5
    else
        maxRange = 3.5
    end
    radius = curTarget.hitradius - addRange + maxRange
    local minRange = maxRange - 1.5
    if deltaDistance >= maxRange then
        alpha = MG.Config.Main.OutRangeColor.a
        color = MG.Config.Main.OutRangeColor
    elseif deltaDistance >= minRange then
        local sub = deltaDistance - minRange
        if sub < 1 then
            alpha = MG.Config.Main.InRangeColor.a * sub
        else
            alpha = MG.Config.Main.InRangeColor.a
        end
        color = MG.Config.Main.InRangeColor
    else
        return
    end
    local drawer = Argus2.ShapeDrawer:new(
            (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, 0)),
            (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, 0)),
            (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, 0)),
            (GUI:ColorConvertFloat4ToU32(color.r, color.g, color.b, alpha)),
            MG.Config.Main.LineSize
    )
    drawer:addCircle(curTarget.pos.x, curTarget.pos.y, curTarget.pos.z, radius)
end

---@param M MuAiGuide
local checkHotKeyPress = function()
    if GUI:IsKeyDown(MG.Config.Main.KeyBindFirst)
            and GUI:IsKeyPressed(MG.Config.Main.KeyBindSecond)
    then
        MG.MainUI.open = not MG.MainUI.open
    end
end

---@param M MuAiGuide
local onMapChange = function()
    if Player.localmapid ~= nil then
        lastBattleTime = 0
        MG.Party = nil
        MG.SelfPos = nil
        checkAndPopMainUI()
        MG.RaidMapCheck()
        MG.MultiGuide.onMapChange()
        MoogleExCheck()
        MG.inArr = nil
        --MuAiGuide.Info("地图发生改变，当前地图为：" .. Player.localmapid)
    end
end

local onWipeCheck = function()
    if TensorReactions_CurrentCombatTimer ~= nil and TensorReactions_CurrentCombatTimer ~= 0 then
        if lastBattleTime ~= TensorReactions_CurrentCombatTimer then
            if lastBattleTime == nil
                    or lastBattleTime == 0
                    or TensorReactions_CurrentCombatTimer < lastBattleTime
            then
                MG.LogSystemInit()
            end
            lastBattleTime = TensorReactions_CurrentCombatTimer
        end
    else
        if lastBattleTime ~= nil and lastBattleTime ~= 0 then
            lastBattleTime = 0
            MG.Debug('团灭')
            MG.OnWipe()
        end
    end
end

---@param M MuAiGuide
local onPlayerChangeJob = function()
    MG.FruMitigation.ChangeJob()
    MG.DumCfgJobChange()
end

---@param M MuAiGuide
local onMapChangeCheck = function()
    if Player.localmapid ~= 0 and lastMap ~= Player.localmapid then
        onMapChange()
        lastMap = Player.localmapid
    end
end

---@param M MuAiGuide
local onJobChangeCheck = function()
    if lastJob ~= Player.job then
        onPlayerChangeJob()
        if lastJob ~= nil and lastJob > 0 then
            MG.Debug('职业切换' .. MG.GetJobFullNameById(lastJob) .. ' -> ' .. MG.GetJobFullNameById(Player.job))
        end
        lastJob = Player.job
    end
end

---@param M MuAiGuide
Events.init = function(M)
    M.Update = function()
        if MuAiGuide == nil then
            return
        end
        if MG == nil then
            MG = MuAiGuide
        end
        MG.CheckArgusRegister()
        checkHotKeyPress()
        onMapChangeCheck()
        onJobChangeCheck()
        MG.OnRaidUpdate()
        attackRangeHackHelper()
        attackRangeReMake()
        onWipeCheck()
        MG.DrawTargetPos()
        MG.DrawAllLink()
        MG.CheckNeedReload()
    end
end
return Events
