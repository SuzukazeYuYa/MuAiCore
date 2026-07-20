local MuAiCore = {}
local AddonName = "MuAiCore"
local core = MuAiCore

local function isValidGuide(guide)
    return type(guide) == 'table'
            and guide.IsInit == true
            and type(guide.Update) == 'function'
            and type(guide.DrawUIs) == 'function'
            and type(guide.LogSystemLeave) == 'function'
end

core.InitMuAiGuide = function()
    MuAiGuideRoot = GetLuaModsPath() .. "MuAiCore\\LuaFiles\\"
    local candidate = FileLoad(MuAiGuideRoot .. "MuAiGuide.lua")
    if not isValidGuide(candidate) then
        d('[MuAiCore]初始化失败，保留当前可用实例：' .. tostring(candidate))
        return false
    end

    local previous = MuAiGuide
    if type(previous) == 'table' and type(previous.LogSystemLeave) == 'function' then
        if previous.CurRaidScript ~= nil and type(previous.Log) == 'function' then
            previous.Log('Lifecycle', '重新初始化插件')
        end
        previous.LogSystemLeave()
    end
    MuAiGuide = candidate

    local downloadPath = GetLuaModsPath() .. "MuAiCore\\Temp\\Download\\"
    if FolderExists(downloadPath) then
        FolderDelete(downloadPath)
    end
    return true
end

core.Initialize = function()
    local initialized = core.InitMuAiGuide(true)
    if initialized ~= true and not isValidGuide(MuAiGuide) then
        return
    end

    local Icon = GetLuaModsPath() .. "MuAiCore\\Image\\MainIcon.png"
    local tooltip = "暮霭指路核心功能"
    ml_gui.ui_mgr:AddMember({ id = "MuAiCore",
                              name = "MuAiCore",
                              onClick = function()
                                  if not isValidGuide(MuAiGuide) or type(MuAiGuide.MainUI) ~= 'table' then
                                      d('[MuAiCore]界面不可用：初始化未完成')
                                      return
                                  end
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
