local MuAiCore = {}
local AddonName = "MuAiCore"
local core = MuAiCore

local function tracebackError(err)
    if debug ~= nil and type(debug.traceback) == 'function' then
        return debug.traceback(tostring(err), 2)
    end
    return tostring(err)
end

local function diagnose(guide, level, message, data, key)
    if type(guide) == 'table' and type(guide.Diagnostic) == 'function' then
        guide.Diagnostic(level, 'Bootstrap', message, data, key)
        return
    end
    d('[MuAiCore][' .. tostring(level) .. '][Bootstrap] ' .. tostring(message))
end

local function isValidGuide(guide)
    return type(guide) == 'table'
            and guide.IsInit == true
            and type(guide.Update) == 'function'
            and type(guide.DrawUIs) == 'function'
            and type(guide.LogSystemLeave) == 'function'
end

core.InitMuAiGuide = function()
    MuAiGuideRoot = GetLuaModsPath() .. "MuAiCore\\LuaFiles\\"
    local guidePath = MuAiGuideRoot .. 'MuAiGuide.lua'
    local previous = MuAiGuide
    diagnose(previous, 'INFO', '开始加载MuAiGuide', { path = guidePath }, 'guide_load_start')
    local candidate
    local loaded, loadError = xpcall(function()
        candidate = FileLoad(guidePath)
    end, tracebackError)
    if not loaded then
        diagnose(previous, 'ERROR', '加载MuAiGuide时发生Lua异常，保留当前可用实例', {
            path = guidePath,
            traceback = loadError,
        }, 'guide_load_exception')
        return false
    end
    if not isValidGuide(candidate) then
        diagnose(type(candidate) == 'table' and candidate or previous,
                'ERROR', 'MuAiGuide初始化结果无效，保留当前可用实例', {
                    path = guidePath,
                    result = candidate,
                    resultType = type(candidate),
                }, 'guide_load_invalid')
        d('[MuAiCore]初始化失败，保留当前可用实例：' .. tostring(candidate))
        return false
    end

    if type(previous) == 'table' and type(previous.LogSystemLeave) == 'function' then
        if previous.CurRaidScript ~= nil and type(previous.Log) == 'function' then
            previous.Log('Lifecycle', '重新初始化插件')
        end
        previous.LogSystemLeave()
    end
    MuAiGuide = candidate
    diagnose(candidate, 'INFO', 'MuAiGuide实例已激活', {
        path = guidePath,
        version = candidate.VERSION,
    }, 'guide_activated')

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
