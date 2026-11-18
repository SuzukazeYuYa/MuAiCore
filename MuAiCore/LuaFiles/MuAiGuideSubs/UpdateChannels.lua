local UpdateChannels = {}
-- 更新渠道独立于作者源码；安装 main 时由 InstallUpdate.ps1 保留并重新接入。
local workSequence = 0
local updateTime
local nextReloadCheck = 0
local updateNeedReLoad = false

local function formatVersion(base, revision)
    if base == nil then return nil end
    if type(revision) == 'number' and revision > 0 and revision % 1 == 0 then
        return tostring(base) .. '.' .. string.format('%d', revision)
    end
    return tostring(base)
end

local function isNewerVersion(base, revision, currentBase, currentRevision)
    return base > currentBase or (base == currentBase and (revision or 0) > (currentRevision or 0))
end

local function parseIntegerField(source, field)
    local assignment = source:match('M%.' .. field .. '%s*=%s*([^\r\n;]+)')
    if not assignment then return nil end
    local digits = assignment:gsub('%-%-.*$', ''):match('^%s*(%d+)%s*$')
    local value = digits and tonumber(digits)
    if value and value <= 2147483647 then return value end
    return nil
end

---@param M MuAiGuide
UpdateChannels.init = function(M)
    if type(M.WebRequestAsync) ~= 'function' then
        local http = FileLoad(MuAiGuideRoot .. 'MuAiGuideSubs\\AsyncHttp.lua')
        assert(type(http) == 'table' and type(http.init) == 'function', '后台 HTTP 模块不可用')
        http.init(M)
    end
    -- main 更新包保留此模块时，作者 Config.lua 不负责迁移旧分支名称。
    if M.Config.Main.UpdateBranch == 'dmu-String' or M.Config.Main.UpdateBranch == 'dmu_string' then
        M.Config.Main.UpdateBranch = 'String'
    end
    if M.Config.Main.UpdateBranch ~= 'main' and M.Config.Main.UpdateBranch ~= 'String' then
        M.Config.Main.UpdateBranch = 'main'
    end
    M.GetUpdateBranch = function()
        if M.Config.Main.UpdateBranch == 'String' then
            return 'String'
        end
        return 'main'
    end

    M.GetVersionLabel = function()
        return formatVersion(M.VERSION, M.STRING_REVISION)
    end

    M.GetOnlineVersionLabel = function()
        return formatVersion(M.LatestVer, M.LatestStringRevision)
    end

    M.GetUpdateLogUrl = function()
        if M.GetUpdateBranch() == 'String' then
            return 'https://github.com/SuzukazeYuYa/MuAiCore/commits/String/'
        end
        return 'https://docs.qq.com/doc/DWnhXRXBxSXJpU0tS?rtkey=07822459d679f67ae55c279c801Xw1&nlc=1'
    end

    M.RequestUpdateBranch = function(branch)
        if branch ~= 'main' and branch ~= 'String' then
            return false
        end
        if branch == M.GetUpdateBranch() then
            return true
        end
        local lines, okText
        if branch == 'String' then
            lines = {
                '切换到 String 测试分支？',
                '此分支有时是测试版本，可能出现 bug，',
                '但可以提前体验最新功能。',
                'String 分支通过 GitHub 下载。',
                '确认后仅保存选择，下次更新时生效。',
            }
            okText = '切换到 String'
        else
            lines = {
                '切换到Muai主分支（main）？',
                '后续更新将使用Muai主分支脚本，',
                'String 分支的额外功能会被替换。',
                '更新设置和分支选择入口会继续保留，',
                '之后可在这里再次切换到 String 分支。',
                '确认后仅保存选择，下次更新时生效。',
            }
            okText = '确认切换'
        end
        M.ShowMsgUI(1, lines, function()
            local previousBranch = M.Config.Main.UpdateBranch
            M.Config.Main.UpdateBranch = branch
            if M.SaveConfig(M.Config.MainPath, M.Config.MainFile, 'Main') ~= true then
                M.Config.Main.UpdateBranch = previousBranch
                M.ShowMsgUI(3, { '更新分支保存失败，已保留原选择。' })
                return
            end
            M.LatestVer = nil
            M.LatestStringRevision = nil
            M.LogInfo = nil
            M.CheckVersion(true)
        end, nil, okText, '保留原分支')
        return true
    end
    local applyVersionResponse = function(branch, isAuto, resp)
        if branch == 'String' then
            -- 只提取版本号，不执行远端 Lua；同版本号的提交仍允许手动更新。
            if type(resp) == 'string' and #resp <= 65536 then
                M.LatestVer = parseIntegerField(resp, 'VERSION')
                M.LatestStringRevision = parseIntegerField(resp, 'STRING_REVISION')
                if resp:find('M%.STRING_REVISION%s*=') and M.LatestStringRevision == nil then
                    M.LatestVer = nil
                end
            end
            if M.LatestVer ~= nil then
                M.LogInfo = {
                    '更新分支：String',
                    'Tab|当前版本：' .. M.GetVersionLabel(),
                    'Tab|分支在线版本：' .. M.GetOnlineVersionLabel(),
                    '此分支有时是测试版本，可能出现 bug，',
                    '但可以提前体验最新功能。',
                    '版本号相同也可能有新提交，更新将下载分支最新内容。',
                    '更新在后台完成，安装成功后会重新加载。',
                }
            end
            if not isAuto then
                if M.LogInfo ~= nil then
                    M.ShowMsgUI(2, M.LogInfo)
                else
                    M.ShowMsgUI(3, { 'String 分支版本检查失败，请检查 GitHub 网络连接后重试。' })
                end
            end
            return
        end
        if resp ~= nil and resp ~= '' then
            local logsData = M.StringSplit(resp, "|")
            if logsData ~= nil and tonumber(logsData[1]) ~= nil then
                M.LatestVer = tonumber(logsData[1])
                local infoTable = { "版本检查完毕（Muai主分支 main）：",
                                    "Tab|当前版本：" .. M.GetVersionLabel(),
                                    "Tab|最新版本：" .. tostring(M.LatestVer)
                }
                table.insert(infoTable, "")
                table.insert(infoTable, tostring(M.LatestVer) .. "版本更新内容：")
                for i = 2, #logsData do
                    table.insert(infoTable, ("Tab|" .. logsData[i]))
                end
                table.insert(infoTable, "")
                table.insert(infoTable, "是否立刻进行更新？")
                table.insert(infoTable, "更新在后台完成，安装成功后会重新加载。")
                M.LogInfo = infoTable
            end
        end
        if not isAuto then
            if M.LatestVer ~= nil then
                if M.LatestVer == M.VERSION then
                    M.ShowMsgUI(1,
                            { "版本检查完毕：没有发现新的版本！" },
                            nil,
                            function()
                                M.CloseAllUI()
                                M.ForceUpdate()
                            end,
                            '确认', '强制更新')
                else
                    M.ShowMsgUI(2, M.LogInfo)
                end
            else
                M.ShowMsgUI(3, { "版本检查失败，请检查网络后重试。" })
            end
        end
    end

    local versionRequest
    ---@param isAuto boolean 是否为自动检查
    M.CheckVersion = function(isAuto)
        local branch = M.GetUpdateBranch()
        if versionRequest ~= nil and versionRequest.branch == branch then
            -- A manual click during the automatic request still gets its result UI.
            versionRequest.manual = versionRequest.manual or not isAuto
            return true
        end
        M.LatestVer, M.LatestStringRevision, M.LogInfo = nil, nil, nil
        local request = { branch = branch, manual = not isAuto }
        versionRequest = request
        local function complete(resp, requestError)
            if versionRequest ~= request or M.GetUpdateBranch() ~= branch then return end
            versionRequest = nil
            if requestError ~= nil then
                M.LogError('Update', '版本检查请求失败', { branch = branch, error = requestError })
            end
            applyVersionResponse(branch, not request.manual, resp)
        end
        local url = branch == 'String'
                and 'https://raw.githubusercontent.com/SuzukazeYuYa/MuAiCore/String/MuAiCore/LuaFiles/MuAiGuide.lua'
                or 'https://muai-guide-main-1435131442.cos.ap-shanghai.myqcloud.com/versionLog.txt'
        local accepted, err = M.WebRequestAsync('version_' .. branch, url, complete)
        if not accepted then complete(nil, err) end
        return accepted
    end

    local startup = type(GetStartupPath) == 'function' and GetStartupPath()
    startup = type(startup) == 'string' and startup ~= '' and startup:gsub('[\\/]+$', '')
    local pid = type(GetCurrentPID) == 'function' and GetCurrentPID()
    local pendingFile = startup and pid and (startup .. '\\MuAiCoreUpdatePending_' .. pid .. '.txt')
    local job
    local function readText(path, size)
        local f, err = io.open(path, 'rb')
        if not f then return nil, err end
        local value, readError = f:read(size)
        f:close()
        return value, readError
    end
    local function writeText(path, value)
        local f, err = io.open(path, 'wb')
        if not f then return false, err end
        local wrote, writeError = f:write(value)
        local closed, closeError = f:close()
        return wrote and closed, writeError or closeError
    end
    local function cleanWork(path)
        if type(FolderDelete) ~= 'function' then
            -- 部分宿主的 DeleteFolder 兼容层会同步等待 PowerShell。只交给后台删除已处理的回执。
            local token = path:match('\\(MuAiCoreUpdater_%d+_%d+_%d+)$')
            if token and path == startup .. '\\' .. token and not startup:find('[%%!"\r\n]') then
                local command = 'start "" /b /d "' .. startup .. '" powershell.exe -NoLogo -NoProfile -NonInteractive -WindowStyle Hidden '
                        .. '-ExecutionPolicy Bypass -File LuaMods\\MuAiCore\\LuaFiles\\MuAiGuideSubs\\InstallUpdate.ps1 '
                        .. '-Cleanup -TargetRoot LuaMods -WorkRoot ' .. token .. ' <nul >nul 2>&1'
                local pipe = io.popen(command, 'r')
                if pipe then pipe:close(); return end
            end
            M.LogError('Update', '无法启动后台回执清理', { path = path }, true)
            return
        end
        local ok, result, detail = pcall(M.DeleteFolder, path)
        if FolderExists(path) or FileExists(path) then
            M.LogError('Update', '更新临时目录清理失败', { path = path, detail = tostring(detail or result or ok) }, true)
        end
    end
    local function watch(token)
        job = { token = token, path = startup .. '\\' .. token, phase = 'queued', since = Now(), nextPoll = 0 }
    end
    if pendingFile and FileExists(pendingFile) then
        local token = readText(pendingFile, 128)
        if token and token:match('^MuAiCoreUpdater_' .. pid .. '_%d+_%d+$') then
            if readText(startup .. '\\' .. token .. '\\ack', 128) == token then
                FileDelete(pendingFile)
            else
                watch(token)
            end
        else
            M.LogError('Update', '后台更新任务记录无法读取或格式无效', { path = pendingFile }, true)
        end
    end

    local progress = { queued = '正在启动更新', downloading = '正在下载更新', extracting = '正在解压更新', installing = '正在安装更新' }
    local failures = {
        preflight = '更新准备失败，当前安装未被修改。',
        rolledback = '更新失败，已回滚到更新前文件。',
        incomplete = '更新失败且回滚未完成。',
        busy = '另一个实例正在更新，当前任务未安装文件。',
        unknown = '更新结果未知。',
    }
    M.UpdateFilesBusy = function()
        return updateNeedReLoad or (job ~= nil and not job.stalled)
                or (startup and FileExists(startup .. '\\MuAiCoreUpdate.lock')) or false
    end
    local function pollInstall()
        if not job then return end
        local now = Now()
        if now < job.nextPoll then return end
        job.nextPoll = now + 350
        local path = job.path
        if not FileExists(path .. '\\worker.exit') then
            local phase = FileExists(path .. '\\installing') and 'installing'
                    or FileExists(path .. '\\extracting') and 'extracting'
                    or FileExists(path .. '\\downloading') and 'downloading' or 'queued'
            if phase ~= job.phase then
                job.phase, job.since, job.stalled = phase, now, false
            elseif not job.stalled and now - job.since > (phase == 'queued' and 30000 or 300000) then
                job.stalled = true
                M.LogError('Update', '尚未收到后台更新结果，继续等待回执', { path = path, phase = phase }, true)
                M.ShowMsgUI(3, { '后台更新未返回，请查看恢复目录：' .. path, '仍在检查结果，未再次安装。' })
            end
            return
        end
        local response, readError = readText(path .. '\\result', 8192)
        local state, disposition, detail
        if response then state, disposition, detail = response:match('^(%a+)\n(%a+)\n(.*)$') end
        if not state or (state ~= 'installed' and not failures[state])
                or (disposition ~= 'clean' and disposition ~= 'keep') then
            state, disposition, detail = 'unknown', 'keep', readError or '后台没有返回有效的事务结果'
        end
        if state == 'incomplete' or state == 'unknown' then disposition = 'keep' end
        local handled = true
        if FileExists(pendingFile) then
            -- 删除记录失败时留下已处理标记，避免重载后再次消费同一张回执。
            local token = readText(pendingFile, 128)
            if token == job.token then FileDelete(pendingFile) end
            if not token or (token == job.token and FileExists(pendingFile)) then
                handled = writeText(path .. '\\ack', job.token)
                disposition = 'keep'
                M.LogError('Update', '无法清理已结束的任务记录', { path = pendingFile, acknowledged = handled }, true)
            end
        end
        job = nil
        if state ~= 'installed' then
            local message = failures[state] .. (disposition == 'keep' and (' 恢复目录：' .. path) or '')
            M.LogError('Update', message, { path = path, detail = detail }, true)
            M.ShowMsgUI(3, { message })
        elseif handled then
            updateNeedReLoad, updateTime = true, now
            d('[MuAiCore]更新已完成，脱战并结束切图后重新加载。')
        else
            M.ShowMsgUI(3, { '安装已完成，任务回执无法确认。请手动重载。', path })
        end
        if disposition == 'clean' then
            cleanWork(path)
        elseif state == 'installed' then
            M.LogError('Update', '更新完成，临时目录需要清理', { path = path, detail = detail }, true)
        end
    end
    M.CheckNeedReload = function()
        if M.PollWebRequests then M.PollWebRequests() end
        if job then pollInstall() end
        if updateNeedReLoad and TimeSince(updateTime) >= 3000 and Now() >= nextReloadCheck then
            nextReloadCheck = Now() + 350
            if (type(IsLoading) == 'function' and IsLoading()) or (Player and Player.incombat)
                    or (type(TensorReactions_CurrentCombatTimer) == 'number' and TensorReactions_CurrentCombatTimer > 0)
                    or FileExists(startup .. '\\MuAiCoreUpdate.lock') then return end
            updateNeedReLoad = false
            M.CloseAllUI()
            Reload()
        end
    end
    M.ForceUpdate = function()
        if job and M.UpdateFilesBusy() then
            M.ShowMsgUI(3, { progress[job.phase] })
            return
        end
        if updateNeedReLoad then return end
        local branch = M.GetUpdateBranch()
        local configured = M.Config.Main.DownLoadSource
        local source = (branch == 'String' or configured == 1) and 'GitHub' or configured == 2 and 'Mirror'
        if not source or not pendingFile or startup:find('[%%!"\r\n]') then
            M.ShowMsgUI(3, { '更新失败，请检查下载源及安装路径。' })
            M.LogError('Update', '下载源或更新目录不可用', { source = configured, path = startup }, true)
            return
        end
        local token, path
        repeat
            workSequence = workSequence + 1
            token = 'MuAiCoreUpdater_' .. pid .. '_' .. os.time() .. '_' .. workSequence
            path = startup .. '\\' .. token
        until not FolderExists(path) and not FileExists(path)
        FolderCreate(path)
        if not FolderExists(path) then
            M.ShowMsgUI(3, { '更新失败：无法创建临时目录。' })
            M.LogError('Update', '无法创建临时目录', { path = path }, true)
            return
        end
        local wrote, err = writeText(pendingFile, token)
        if not wrote then
            cleanWork(path)
            M.LogError('Update', '无法记录后台更新任务', { path = pendingFile, detail = err }, true)
            M.ShowMsgUI(3, { '无法记录后台更新任务，安装未启动。' })
            return
        end
        watch(token)
        -- 只等启动命令返回。后台命令在 PowerShell 退出后写结束标记，崩溃也能识别。
        local command = 'start "" /b /d "' .. path .. '" cmd.exe /d /v:off /s /c "powershell.exe -NoLogo -NoProfile '
                .. '-NonInteractive -WindowStyle Hidden -ExecutionPolicy Bypass -File ..\\LuaMods\\MuAiCore\\LuaFiles\\MuAiGuideSubs\\InstallUpdate.ps1 '
                .. '-Download -TargetRoot ..\\LuaMods -WorkRoot . -UpdateBranch ' .. branch .. ' -DownloadSource ' .. source
                .. ' >worker.log 2>&1 & echo done>worker.exit" <nul >nul 2>&1'
        local pipe, launchError = io.popen(command, 'r')
        if not pipe then
            job = nil
            FileDelete(pendingFile)
            cleanWork(path)
            M.LogError('Update', '无法启动后台更新', { path = path, detail = launchError }, true)
            M.ShowMsgUI(3, { '无法启动后台更新，请查看诊断日志。' })
            return
        end
        pipe:close()
        d('[MuAiCore]已开始后台更新。')
    end

    M.DrawUpdateBranchSettings = function()
        GUI:Columns(2, 'BindKey', false)
        GUI:Dummy(6, 0)
        GUI:SameLine()
        GUI:AlignFirstTextHeightToWidgets()
        GUI:Text('更新分支：  ')
        GUI:NextColumn()
        GUI:PushItemWidth(165)
        local branch = M.GetUpdateBranch()
        local branchIndex = branch == 'String' and 2 or 1
        local selectedBranch, branchChanged = GUI:Combo('##UpdateBranch', branchIndex,
                { 'Muai主分支', 'String 测试分支' }, 2)
        if branchChanged then
            M.RequestUpdateBranch(selectedBranch == 2 and 'String' or 'main')
        end
        GUI:PopItemWidth()
        GUI:NextColumn()
        GUI:Dummy(6, 0)
        GUI:SameLine()
        GUI:AlignFirstTextHeightToWidgets()
        GUI:Text('更新下载源：  ')
        GUI:NextColumn()
        if branch == 'String' then
            GUI:Text('GitHub（String 分支）')
        else
            GUI:PushItemWidth(123)
            M.Config.Main.DownLoadSource = GUI:Combo('##DownLoadSource', M.Config.Main.DownLoadSource, { 'GitHub', '腾讯云' }, 2)
            GUI:PopItemWidth()
        end
        GUI:NextColumn()
        GUI:Columns(1)
    end

    M.DrawUpdateBranchStatus = function()
        if updateNeedReLoad then GUI:TextWrapped('更新已完成，脱战并结束切图后重新加载。'); return end
        if job then
            GUI:TextWrapped(job.stalled and '等待后台更新回执' or progress[job.phase])
            if job.stalled then
                GUI:Button('重新请求更新', 165, 25)
                if GUI:IsItemClicked(0) then M.ForceUpdate() end
            end
            return
        end
        if M.GetUpdateBranch() == 'String' then
            GUI:Text('   来源：String 分支')
            GUI:Text('   当前版本：ver.' .. M.GetVersionLabel())
            if M.LatestVer ~= nil then
                local online = '   分支在线版本：ver.' .. M.GetOnlineVersionLabel()
                if isNewerVersion(M.LatestVer, M.LatestStringRevision, M.VERSION, M.STRING_REVISION) then
                    GUI:TextColored(0, 1, 0, 1, online)
                else
                    GUI:Text(online)
                end
            else
                GUI:TextColored(1, 1, 0, 1, '   尚未取得 String 分支在线版本。')
            end
            GUI:TextWrapped('测试版本可能出现 bug，但可提前体验最新功能；版本号相同也可能有新提交。')
            GUI:Button('更新 String 分支', 165, 25)
            if GUI:IsItemClicked(0) then
                M.ShowMsgUI(2, M.LogInfo or {
                    '更新分支：String',
                    '此分支有时是测试版本，可能出现 bug，',
                    '但可以提前体验最新功能。',
                    '更新将通过 GitHub 下载分支最新内容。',
                })
            end
            GUI:SameLine(0, 5)
            GUI:Button('检查 String 版本', 165, 25)
            if GUI:IsItemClicked(0) then
                M.CheckVersion()
            end
            return
        end
        GUI:Text('   来源：Muai主分支（main）')
        if M.STRING_REVISION ~= nil then
            GUI:Text('   当前安装：ver.' .. M.GetVersionLabel())
        end
        if M.LatestVer == nil then
            GUI:TextColored(1, 1, 0, 1, '   获取在线版本信息失败！请检查网络状态，')
            GUI:TextColored(1, 1, 0, 1, '   或点击上方链接查看版本状态！')
            GUI:AlignFirstTextHeightToWidgets()
            GUI:Text('                      ver.' .. M.VERSION .. ' ')
            GUI:SameLine(0, 0)
            GUI:Button('尝试检查版本', 120, 20)
            if GUI:IsItemClicked(0) then
                M.CheckVersion()
            end
        else
            if M.LatestVer > M.VERSION then
                GUI:TextColored(0, 1, 0, 1, '  有新的版本: ver.' .. M.LatestVer)
                GUI:SameLine(0, 20)
                GUI:TextColored(1, 0, 0, 1, ' 当前版本: ver.' .. M.VERSION .. ' ')
                GUI:Button('点击此处进行更新', 335, 20)
                if GUI:IsItemClicked(0) then
                    if M.LogInfo ~= nil then
                        M.ShowMsgUI(2, M.LogInfo)
                    else
                        M.ForceUpdate()
                    end
                end
                GUI:TextColored(1, 1, 0, 1, '提示：如无法正常更新，请点击上方链接手动覆盖！')
            else
                GUI:AlignFirstTextHeightToWidgets()
                GUI:TextColored(0, 1, 0, 1, '   当前已是最新版本: ver.' .. M.VERSION .. '   ')
                GUI:SameLine(0, 0)
                GUI:Button('检查更新', 100, 20)
                if GUI:IsItemClicked(0) then
                    M.CheckVersion()
                end
            end
        end
    end
end

return UpdateChannels
