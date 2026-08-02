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
        local previousCurrent = M.CurRaidScript
        local currentMapId = Player ~= nil and Player.localmapid or nil
        local preserveCurrentState = isReload
                and previousCurrent ~= nil
                and previousCurrent.MapId == currentMapId

        local loadedScripts = {}
        local folderPath = MuAiGuideRoot .. "RaidScripts"
        local list = FolderList(folderPath)
        if type(list) ~= 'table' then
            M.Diagnostic('ERROR', 'RaidLoader', '读取副本脚本目录失败', {
                path = folderPath,
                result = list,
                resultType = type(list),
            }, 'folder_list')
            return false
        end
        M.Diagnostic('INFO', 'RaidLoader', isReload and '开始热重载副本脚本' or '开始加载副本脚本', {
            currentMapID = currentMapId,
            files = table.size(list),
        }, isReload and 'reload_start' or 'initial_start')
        local cnter = 0
        for _, fileName in pairs(list) do
            M.Debug('   加载副本脚本：' .. fileName)
            local filePath = folderPath .. "\\" .. fileName
            local loadOk, script = M.DiagnosticCall('RaidLoader', '加载副本脚本', function()
                return FileLoad(filePath)
            end, { file = fileName, path = filePath })
            if not loadOk or type(script) ~= 'table' or script.MapId == nil then
                M.Debug('   加载副本脚本：' .. fileName .. '加载失败，获取到内容如下：')
                M.Debug('-----------------------')
                d(script)
                M.Debug('-----------------------')
                M.Diagnostic('ERROR', 'RaidLoader', '副本脚本加载结果无效', {
                    file = fileName,
                    path = filePath,
                    result = script,
                    resultType = type(script),
                }, 'invalid_' .. tostring(fileName))
            else
                local initOk = true
                if script.Init ~= nil then
                    -- 此处为脚本定义初始化，和进入副本之后逻辑不同
                    if type(script.Init) ~= 'function' then
                        initOk = false
                        M.Diagnostic('ERROR', 'RaidLoader', '副本脚本Init不是函数', {
                            file = fileName,
                            mapID = script.MapId,
                            resultType = type(script.Init),
                        }, 'invalid_init_' .. tostring(fileName))
                    else
                        initOk = M.DiagnosticCall('RaidLoader', '初始化副本脚本', function()
                            script.Init(M)
                        end, { file = fileName, mapID = script.MapId })
                    end
                end
                if initOk then
                    loadedScripts[script.MapId] = script
                    M.Debug('   加载副本脚本：' .. fileName .. '成功')
                    cnter = cnter + 1
                end
            end
        end
        if preserveCurrentState then
            local reloadedCurrent = loadedScripts[currentMapId]
            if reloadedCurrent ~= nil then
                -- 手动热重载只替换函数实现，不触发 OnLeave/OnEnter，保留当前机制进度。
                M.CurRaidScript = reloadedCurrent
            else
                -- 当前副本脚本加载失败时继续使用旧实例，便于修正代码后再次重载。
                loadedScripts[currentMapId] = previousCurrent
                M.CurRaidScript = previousCurrent
            end
        end
        raidScript = loadedScripts
        local allLoaded = cnter == table.size(list)
        M.Diagnostic(allLoaded and 'INFO' or 'ERROR', 'RaidLoader',
                isReload and '副本脚本热重载完成' or '副本脚本加载完成', {
                    failed = table.size(list) - cnter,
                    loaded = cnter,
                    total = table.size(list),
                }, isReload and 'reload_complete' or 'initial_complete')
        if isReload then
            if allLoaded then
                M.InfoNoLog('重载副本脚本成功。')
            else
                M.InfoNoLog('重载副本脚本失败，部分脚本未能正确加载。')
            end
        end
        return allLoaded
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
