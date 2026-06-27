local MuAiCore = {}
local AddonName = "MuAiCore"
local core = MuAiCore

core.InitMuAiGuide = function()
    if MuAiGuide ~= nil and MuAiGuide.LogSystemLeave ~= nil then
        if MuAiGuide.CurRaidScript ~= nil then
            MuAiGuide.Log('Lifecycle', '重新初始化插件')
        end
        MuAiGuide.LogSystemLeave()
    end
    MuAiGuideRoot = GetLuaModsPath() .. "MuAiCore\\LuaFiles\\"
    MuAiGuide = FileLoad(MuAiGuideRoot .. "MuAiGuide.lua")
    local downloadPath = GetLuaModsPath() .. "MuAiCore\\Temp\\Download\\"
    if FolderExists(downloadPath) then
        FolderDelete(downloadPath)
    end
end

core.Initialize = function()
    core.InitMuAiGuide(true)
    local Icon = GetLuaModsPath() .. "MuAiCore\\Image\\MainIcon.png"
    local tooltip = "暮霭指路核心功能"
    ml_gui.ui_mgr:AddMember({ id = "MuAiCore",
                              name = "MuAiCore",
                              onClick = function()
                                  MuAiGuide.MainUI.open = not MuAiGuide.MainUI.open
                              end,
                              tooltip = tooltip, texture = Icon },
            "FFXIVMINION##MENU_HEADER"
    )
end

core.Update = function()
    if MuAiGuide and MuAiGuide.IsInit then
        MuAiGuide.Update()
    end
end

core.Draw = function()
    if MuAiGuide and MuAiGuide.IsInit then
        MuAiGuide.DrawUIs()
    end
end

RegisterEventHandler("Module.Initalize", core.Initialize, AddonName)
RegisterEventHandler("Gameloop.Update", core.Update, AddonName)
RegisterEventHandler("Gameloop.Draw", core.Draw, AddonName)
d("[MuAiCore]加载成功!")
