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
    -- 副本切换统一走离开/进入生命周期，避免重载或地图变化时重复触发脚本回调。
    local leaveCurrentRaid = function()
        local current = M.CurRaidScript
        if current == nil then
            return
        end
        M.Log('Lifecycle', '离开副本：' .. tostring(current.NameCN))
        M.Debug('离开副本：' .. tostring(current.NameCN))
        if type(current.OnLeave) == 'function' then
            current.OnLeave()
        end
        M.LogSystemLeave()
        M.CurRaidScript = nil
        M.CurRaidBoss = nil
    end

    -- 进入副本
    local enterRaid = function(script)
        M.CurRaidScript = script
        M.LogSystemEnter()
        if type(script.OnEnter) == 'function' then
            script.OnEnter()
        end
        M.Debug('进入副本：' .. tostring(script.NameCN))
    end

    --- 读取副本脚本
    M.LoadRaidScripts = function(isReload)
        if isReload and M.CurRaidScript ~= nil then
            M.Log('Lifecycle', '重新加载副本脚本')
            M.LogSystemInit()
        end
        raidScript = {}
        local folderPath = MuAiGuideRoot .. "RaidScripts"
        local list = FolderList(folderPath)
        local cnter = 0
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
                cnter = cnter  + 1
            end
        end
        if isReload then
            if cnter == table.size(list) then
                M.InfoNoLog('重载副本脚本成功。')
            else
                M.InfoNoLog('重载副本脚本失败，部分脚本未能正确加载。')
            end
        end
    end
    M.RaidMapCheck = function()
        local nextScript = raidScript and raidScript[Player.localmapid] or nil
        if M.CurRaidScript == nextScript then
            return
        end
        leaveCurrentRaid()
        if nextScript ~= nil then
            enterRaid(nextScript)
        end
    end

    M.OnRaidUpdate = function()
        local currentScript = raidScript and raidScript[Player.localmapid] or nil
        if M.CurRaidScript ~= currentScript then
            M.RaidMapCheck()
        end
        if M.CurRaidScript ~= nil and type(M.CurRaidScript.Update) == 'function' then
            M.CurRaidScript.Update()
        end
        -- 小工具扩展
        if raidScript[-1] ~= nil then
            raidScript[-1].Update()
        end
    end

    M.OnWipe = function()
        local currentScript = raidScript and raidScript[Player.localmapid] or nil
        if currentScript ~= nil and currentScript == M.CurRaidScript then
            if type(currentScript.OnWipe) == 'function' then
                currentScript.OnWipe()
            end
            M.LogSystemWipe()
        end
    end
end
return RaidMgr
