local M = {} ---@class MuAiGuide 识别符
--[[
===========================
    MuAiGuide逻辑总脚本
===========================
]]
M.VERSION = 341
M.GlobalGuideY = nil
M.IsInit = false;
--- 输出信息到控制台 
--- @param msg string
M.Debug = function(msg)
    local info = "[MuAiCore]" .. msg
    d(info)
end

-- 代码加载顺序
local modules = {
    'LogSystem',
    'Tools',
    'NetWork',
    'ArgusEvents',
    'Config',
    'Develop',
    'Drawers',
    'Events',
    'FruFastCfg',
    'FruMitigCfg',
    'GameTools',
    'MultiGuide',
    'RaidMgr',
    'UIMgr',
}

M.Debug("----------------------------- 初始化开始 -----------------------------")
local loadFailures = 0
for i = 1, #modules do
    local moduleName = modules[i]
    local curPath = MuAiGuideRoot .. 'MuAiGuideSubs' .. '\\' .. moduleName .. '.lua'
    M.Debug('加载:' .. moduleName)
    local loadOk = true
    local model
    if type(M.DiagnosticCall) == 'function' then
        loadOk, model = M.DiagnosticCall('ModuleLoader', '加载基础模块', function()
            return FileLoad(curPath)
        end, { module = moduleName, path = curPath })
    else
        model = FileLoad(curPath)
    end
    if not loadOk or type(model) ~= 'table' or type(model.init) ~= 'function' then
        loadFailures = loadFailures + 1
        M.Debug('加载失败，获取到内容如下：')
        M.Debug('-----------------------')
        d(model)
        M.Debug('-----------------------')
        if type(M.Diagnostic) == 'function' then
            M.Diagnostic('ERROR', 'ModuleLoader', '基础模块加载结果无效', {
                module = moduleName,
                path = curPath,
                result = model,
                resultType = type(model),
            }, 'invalid_' .. moduleName)
        end
    else
        local initOk = true
        if type(M.DiagnosticCall) == 'function' then
            initOk = M.DiagnosticCall('ModuleLoader', '初始化基础模块', function()
                model.init(M)
            end, { module = moduleName, path = curPath })
        else
            model.init(M)
        end
        if not initOk then
            loadFailures = loadFailures + 1
        end
    end
end

if loadFailures > 0 then
    if type(M.Diagnostic) == 'function' then
        M.Diagnostic('ERROR', 'ModuleLoader', '基础模块初始化未完成', {
            failures = loadFailures,
            total = #modules,
        }, 'module_load_summary')
    end
    return M
end

local initOk = M.DiagnosticCall('Lifecycle', '执行初始化收尾', function()
    M.FruMitigation.ChangeJob()
    M.DumCfgJobChange()
    M.CheckVersion(true)
    M.GetSponsorsList()
end, { version = M.VERSION })
if not initOk then
    return M
end

M.Debug('基础模块加载完成')
M.Debug("加载副本脚本")
local raidLoadOk = M.LoadRaidScripts()
if raidLoadOk ~= true then
    M.Diagnostic('ERROR', 'RaidLoader', '副本脚本初始化未完成', nil, 'initial_raid_load')
    return M
end
M.Debug("副本脚本加载完成")
M.IsInit = true
M.Diagnostic('INFO', 'Lifecycle', 'MuAiGuide初始化完成', {
    version = M.VERSION,
    diagnosticPath = M.GetDiagnosticLogPath(),
}, 'guide_initialized')
M.Debug("----------------------------- 初始化完成 -----------------------------")
return M
