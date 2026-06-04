local RaidMgr = {}
--[[
===========================
    Raid管理器
===========================
]]
local raidScript

--- 初始化
---@param M MuAiGuide
RaidMgr.init = function(M)
    --- 读取副本脚本
    M.LoadRaidScripts = function()
        raidScript = {}
        local folderPath = MuAiGuideRoot .. "RaidScripts"
        local list = FolderList(folderPath)
        for _, fileName in pairs(list) do
            M.Debug('   加载副本脚本：' .. fileName)
            local filePath = folderPath .. "\\" .. fileName
            local script = FileLoad(filePath)
            if type(script) ~= "table" then
                M.Debug('   加载副本脚本：' .. fileName .. '加载失败，获取到内容如下：')
                M.Debug('-----------------------')
                d(script)
                M.Debug('-----------------------')
            else
                raidScript[script.MapId] = script
                if script.Init ~= nil then
                    -- 此处为脚本定义初始化，和进入副本之后逻辑不同
                    script.Init(M)
                end
                M.Debug('   加载副本脚本：' .. fileName .. '成功')
            end
        end
        if M.CurRaidScript ~= nil and raidScript[Player.localmapid] ~= nil then
            M.CurRaidScript = raidScript[Player.localmapid]
        end
    end
    
    M.RaidMapCheck = function()
        if M.CurRaidScript == nil and raidScript[Player.localmapid] ~= nil then
            -- 进入副本
            M.CurRaidScript = raidScript[Player.localmapid]
            M.CurRaidScript.OnEnter()
            M.Debug("进入副本：" .. M.CurRaidScript.NameCN)
        elseif M.CurRaidScript ~= nil then
            M.Debug("离开副本：" .. M.CurRaidScript.NameCN)
            M.CurRaidScript = nil
            M.CurRaidBoss = nil
        end
    end

    M.OnRaidUpdate = function()
        if raidScript and raidScript[Player.localmapid] then
            raidScript[Player.localmapid].Update()
            if M.CurRaidScript == nil then
                M.CurRaidScript = raidScript[Player.localmapid]
            end
        end
        -- 小工具扩展
        if raidScript[-1] ~= nil then
            raidScript[-1].Update()
        end
    end
end
return RaidMgr