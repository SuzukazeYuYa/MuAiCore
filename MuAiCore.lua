local MuAiCore = {}
local AddonName = "MuAiCore"
local core = MuAiCore
local autoPopMap = { 1238, 1122 }
local lastMap

core.Info = {
    Creator = "MuAi",
    Version = "0.0.0",
    StartDate = "20/03/2025",
    LastUpdate = "20/03/2025",
    ChangeLog = { }
}
local LuaPath = GetStartupPath() .. "\\LuaMods\\"
core.Override = {}
core.InitMuAiGuide = function()
    MuAiGuideRoot = GetStartupPath() .. "\\LuaMods\\MuAiCore\\LuaFiles\\"
    MuAiGuide = FileLoad(MuAiGuideRoot .. "MuAiGuide.lua")
    local configsLoader = FileLoad(MuAiGuideRoot .. "FruOneKeyConfigs.lua")
    configsLoader(MuAiGuide)
end
core.InitMuAiGuide()

local mainDrawer, fruConfigDrawer = nil, nil
core.DrawMainUI = function()
    if mainDrawer == nil or MuAiGuide.DevelopMode then
        local path = MuAiGuideRoot .. "MainUI.lua"
        mainDrawer = FileLoad(path)
    end
    mainDrawer(MuAiGuide)
end

core.DrawFriConfigUI = function()
    if fruConfigDrawer == nil or MuAiGuide.DevelopMode then
        local path = MuAiGuideRoot .. "FruConfigUI.lua"
        fruConfigDrawer = FileLoad(path)
    end
    fruConfigDrawer(MuAiGuide)
end

core.Initialize = function()
    local Icon = GetStartupPath() .. "\\LuaMods\\MuAiCore\\Image\\MainIcon.png"
    local tooltip = "暮霭指路核心功能"
    ml_gui.ui_mgr:AddMember({ id = "MuAiCore", name = "MuAiGuide", onClick = function() MuAiGuide.UI.open = not MuAiGuide.UI.open end, tooltip = tooltip, texture = Icon }, "FFXIVMINION##MENU_HEADER")
end

core.Update = function()
    if MuAiGuide == nil then
        core.InitMuAiGuide()
    end
    if GUI:IsKeyPressed(88) and GUI:IsKeyDown(17) then
        MuAiGuide.UI.open = not MuAiGuide.UI.open
    end
    if lastMap ~= Player.localmapid then
        MuAiGuide.Party = nil
        MuAiGuide.SelfPos = nil
        if table.contains(autoPopMap, Player.localmapid) then
            if MuAiGuide.UI.open == false then
                MuAiGuide.UI.open = true
            end
            MuAiGuide.LoadParty()
        end
        lastMap = Player.localmapid
    end
end

core.Draw = function()
    if MuAiGuide and MuAiGuide.UI.open then
        core.DrawMainUI()
    end
    if MuAiGuide and MuAiGuide.FruConfigUI.open then
        core.DrawFriConfigUI()
    end
end

function core.Updater(k, v)
    if core.Data.UpdateTick == nil then
        if k == "reactions" and v == "check" then
            io.popen([[start /b powershell -Command "-Force; [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12, [Net.SecurityProtocolType]::Tls11; $json = (Invoke-WebRequest -Uri https://api.github.com/repos/QwertOfficial/Healer-reactions/releases -UseBasicParsing | ConvertFrom-Json); Set-Content -Path ']] .. LuaPath .. [[\QwertCore\Data\RVersion.txt' -Value $json[0].tag_name; stop-process -Id $PID"]]):close()
            core.Data.UpdateTick = true
            core.Data.LastCheckVerR = Now()
            core.Data.CheckVerR = true
        end
        if k == "reactions" and v == "update" then
            io.popen([[start /b powershell -Command "Compress-Archive -Path ']] .. LuaPath .. [[TensorReactions\GeneralTriggers', ']] .. LuaPath .. [[TensorReactions\TimelineTriggers' -DestinationPath ]] .. LuaPath .. [[\TensorReactions\GeneralTriggers\Qwert\TensorReactions_$((Get-Date).ToString('MM_dd_HHmm')).zip -Force; [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12, [Net.SecurityProtocolType]::Tls11; $tag = (Invoke-WebRequest -Uri https://api.github.com/repos/QwertOfficial/Healer-reactions/releases -UseBasicParsing | ConvertFrom-Json)[0].tag_name; Invoke-WebRequest https://github.com/QwertOfficial/Healer-reactions/releases/download/$tag/TensorReactions.zip -Out ']] .. LuaPath .. [[\TensorReactions\TensorReactions.zip'; Expand-Archive ']] .. LuaPath .. [[\TensorReactions\TensorReactions.zip' -DestinationPath ]] .. LuaPath .. [[ -Force; Remove-Item ']] .. LuaPath .. [[\TensorReactions\TensorReactions.zip' -Force; stop-process -Id $PID"]]):close()
            io.popen([[start /b powershell -Command "Set-Content -Path ']] .. LuaPath .. [[\QwertCore\Data\RStatus.txt' -Value 'Done'; stop-process -Id $PID"]]):close()
            core.Data.UpdateTick = true
            core.Data.UpdateVerR = true
        end
        if k == "core" and v == "check" then
            io.popen([[start /b powershell -Command "-Force; [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12, [Net.SecurityProtocolType]::Tls11; $json = (Invoke-WebRequest -Uri https://api.github.com/repos/QwertOfficial/QwertCore/releases -UseBasicParsing | ConvertFrom-Json); Set-Content -Path ']] .. LuaPath .. [[\QwertCore\Data\CVersion.txt' -Value $json[0].tag_name; stop-process -Id $PID"]]):close()
            core.Data.UpdateTick = true
            core.Data.LastCheckVerC = Now()
            core.Data.CheckVerC = true
        end
        if k == "core" and v == "update" then
            io.popen([[start /b powershell -Command "-Force; [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12, [Net.SecurityProtocolType]::Tls11; $tag = (Invoke-WebRequest -Uri https://api.github.com/repos/QwertOfficial/QwertCore/releases -UseBasicParsing | ConvertFrom-Json)[0].tag_name; Invoke-WebRequest https://github.com/QwertOfficial/QwertCore/releases/download/$tag/QwertCore.zip -Out ']] .. LuaPath .. [[\QwertCore\QwertCore.zip'; Expand-Archive ']] .. LuaPath .. [[\QwertCore\QwertCore.zip' -DestinationPath ]] .. LuaPath .. [[ -Force; Remove-Item ']] .. LuaPath .. [[\QwertCore\QwertCore.zip' -Force; stop-process -Id $PID"]]):close()
            io.popen([[start /b powershell -Command "Set-Content -Path ']] .. LuaPath .. [[\QwertCore\Data\CStatus.txt' -Value 'Done'; stop-process -Id $PID"]]):close()
            core.Data.UpdateTick = true
            core.Data.UpdateVerC = true
        end
    end
end

RegisterEventHandler("Module.Initalize", core.Initialize, AddonName)
RegisterEventHandler("Gameloop.Update", core.Update, AddonName)
RegisterEventHandler("Gameloop.Draw", core.Draw, AddonName)
d("MuAiCore Loaded!")