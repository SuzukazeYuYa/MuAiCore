local RaidMgr = {}
--[[
===========================
    Raid管理器
===========================
]]
local raidScript, currentScript
---@param M MuAiGuide
RaidMgr.init = function(M)
    --- 读取副本脚本
    M.LoadScripts = function()
        raidScript = {}
        local folderPath = MuAiGuideRoot .. "RaidScripts"
        local list = FolderList(folderPath)
        for _, fileName in pairs(list) do
            MuAiGuide.Debug("已加载副本脚本：" .. fileName)
            local filePath = folderPath .. "\\" .. fileName
            local script = FileLoad(filePath)
            if script ~= nil then
                raidScript[script.MapId] = script
            end
        end
        if currentScript ~= nil and raidScript[Player.localmapid] ~= nil then
            currentScript = raidScript[Player.localmapid]
        end
    end
    
    M.RaidMapCheck = function()
        if M.CurRaidScript ~= nil and M.RaidScript[Player.localmapid] ~= nil then
            -- 进入副本
            currentScript = M.RaidScript[Player.localmapid]
            currentScript.OnEnter()
            M.Debug("进入副本：" .. currentScript.NameCN)
        elseif currentScript ~= nil then
            M.Debug("离开副本：" .. currentScript.NameCN)
            currentScript = nil
            M.CurRaidBoss = nil
        end
    end

    M.OnRaidUpdate = function()
        if raidScript and raidScript[Player.localmapid] then
            raidScript[Player.localmapid].Update()
            if currentScript == nil then
                currentScript = raidScript[Player.localmapid]
            end
        end
    end
end
return RaidMgr