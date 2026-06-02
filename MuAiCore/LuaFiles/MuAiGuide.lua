local M = {} ---@class MuAiGuide 识别符
--[[
===========================
    MuAiGuide逻辑总脚本
===========================
]]
M.VERSION = 286
M.GlobalGuideY = nil
M.IsInit = false;
--- 输出信息到控制台 
--- @param msg string
M.Debug = function(msg)
    local info = "[MuAiGuide]" .. msg
    d(info)
end

-- 代码加载顺序
local modules = {
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

M.Debug("加载子脚本!")
for i = 1, #modules do
    local curPath =  MuAiGuideRoot .. 'MuAiGuideSubs' .. '\\' .. modules[i] .. '.lua'
    M.Debug('  加载:' .. modules[i])
    local model = FileLoad(curPath)
    model.init(M)
end
M.IsInit = true
M.FruMitigation.ChangeJob()
M.CheckVersion(true)
M.GetSponsorsList()
M.LoadRaidScripts()
M.Debug("初始化完成!")
return M
