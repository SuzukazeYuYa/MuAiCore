local UpdateChannels = {}
-- 更新渠道独立于作者源码；安装 main 时由 InstallUpdate.ps1 保留并重新接入。
local updateTime
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

local function powerShellLiteral(value)
    return "'" .. tostring(value):gsub("'", "''") .. "'"
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
                    '如进行更新，过程中会短暂卡屏，请耐心等待。',
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
                table.insert(infoTable, "如进行更新，过程中会短暂卡屏，请耐心等待。")
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

    --- 检查更新是否需要重新加载
    M.CheckNeedReload = function()
        if M.PollWebRequests ~= nil then M.PollWebRequests() end
        if not updateNeedReLoad
                or updateTime == nil or updateTime == 0
                or TimeSince(updateTime) < 3000
        then
            return
        end
        M.CloseAllUI()
        Reload()
    end

    ---强制更新所有脚本
    M.ForceUpdate = function()
        local branch = M.GetUpdateBranch()
        local gitZipUrl
        if branch == 'String' or M.Config.Main.DownLoadSource == 1 then
            gitZipUrl = 'https://codeload.github.com/SuzukazeYuYa/MuAiCore/zip/refs/heads/' .. branch
        elseif M.Config.Main.DownLoadSource == 2 then
            gitZipUrl = "https://muai-guide-main-1435131442.cos.ap-shanghai.myqcloud.com/MuAiCore-main.zip"
        end
        if gitZipUrl == nil then
            M.LogError('Update', '更新失败：下载源设置无效。', { source = M.Config.Main.DownLoadSource }, true)
            M.ShowMsgUI(3, { '更新失败：下载源设置无效，请在基本设置中重新选择。' })
            return
        end

        -- Minion 的 Lua 沙箱不提供 os.getenv，更新工作目录固定放在 LuaMods 之外。
        local tempPath = GetStartupPath() .. "\\MuAiCoreUpdater_" .. tostring(os.time())
        local replacePath = GetStartupPath() .. "\\LuaMods"
        local zipFilePath = tempPath .. "\\repository.zip"
        local extractPath = tempPath .. "\\Extracted"
        local exPath = extractPath .. '\\MuAiCore-' .. branch
        local installerPath = MuAiGuideRoot .. "MuAiGuideSubs\\InstallUpdate.ps1"
        local successToken = '__MUAI_COMMAND_OK__'

        -- Lua 5.1 的 io.popen 不能稳定提供退出码，用成功标记区分命令输出与执行结果。
        local function runCommand(cmd)
            local handle = io.popen(cmd .. ' 2>&1 && echo ' .. successToken)
            if handle == nil then
                return false, 'failed to start command'
            end
            local result = handle:read("*a")
            handle:close()
            local success = result:find(successToken, 1, true) ~= nil
            result = result:gsub(successToken, '')
            return success, result
        end

        local function downloadFile(url, destination)
            d("[MuAiCore]正在下载文件...")
            d('当前源' .. gitZipUrl)
            local cmd = 'curl.exe --fail --silent --show-error --location --connect-timeout 5 --max-time 90 --output "'
                    .. destination .. '" "' .. url .. '"'
            local ok, output = runCommand(cmd)
            if ok then
                d("[MuAiCore]文件下载完成: " .. destination)
            end
            return ok, output
        end

        local function fileSize(path)
            local file = io.open(path, 'rb')
            if file == nil then
                return nil
            end
            local size = file:seek('end')
            file:close()
            return size
        end

        local function deleteTempFolder()
            if type(M.DeleteFolder) ~= 'function' then
                return false, 'MuAiGuide.DeleteFolder is unavailable'
            end
            if not FolderExists(tempPath) then
                if FileExists(tempPath) then
                    return false, 'Update work directory path is occupied by a file: ' .. tempPath
                end
                return true
            end
            local callOk, deleted, deleteError = pcall(M.DeleteFolder, tempPath)
            if not callOk then
                return false, 'DeleteFolder raised an error: ' .. tostring(deleted)
            end
            if not FolderExists(tempPath) and not FileExists(tempPath) then
                return true
            end
            return false, deleteError or ('Update work directory still exists: ' .. tempPath
                    .. '; DeleteFolder returned ' .. tostring(deleted))
        end

        local function failUpdate(message, detail, skipCleanup)
            d('[MuAiCore]' .. message)
            if detail ~= nil and detail ~= '' then
                d(detail)
            end
            M.LogError('Update', message, { path = tempPath, detail = detail }, true)
            if skipCleanup ~= true then
                local cleanupOk, cleanupError = deleteTempFolder()
                if cleanupOk == false then
                    M.LogError('Update', '更新临时目录清理失败', {
                        path = tempPath,
                        detail = cleanupError,
                    }, true)
                end
            end
            M.ShowMsgUI(3, { message })
        end

        updateTime = nil
        updateNeedReLoad = false
        -- 每次更新使用独立临时目录，失败路径统一清理，不在 LuaMods 内留下半成品。
        local cleanupOk, cleanupError = deleteTempFolder()
        if cleanupOk == false then
            failUpdate('更新失败：无法清理临时目录。', cleanupError, true)
            return
        end
        FolderCreate(tempPath)
        if not FolderExists(tempPath) then
            failUpdate('更新失败：无法创建临时目录。', tempPath, true)
            return
        end

        -- 下载完成后先校验文件存在及合理大小，再进入解压阶段。
        local downloadOk, downloadOutput = downloadFile(gitZipUrl, zipFilePath)
        local zipSize = fileSize(zipFilePath)
        if not downloadOk or zipSize == nil or zipSize < 1024 or zipSize > 209715200 then
            failUpdate('更新失败：下载文件无效。', downloadOutput)
            return
        end

        -- Expand-Archive 同时承担 ZIP 完整性检查，解压失败不会触碰当前安装。
        FolderCreate(extractPath)
        local expandCommand = 'powershell.exe -NoProfile -NonInteractive -Command "try { Expand-Archive -LiteralPath '
                .. powerShellLiteral(zipFilePath) .. ' -DestinationPath ' .. powerShellLiteral(extractPath)
                .. ' -Force -ErrorAction Stop; exit 0 } catch { Write-Error $_; exit 1 }"'
        local expandOk, expandOutput = runCommand(expandCommand)
        if not expandOk then
            failUpdate('更新失败：ZIP 解压或完整性检查失败。', expandOutput)
            return
        end

        -- 只接受完整的 MuAiCore 发布目录，避免错误压缩包覆盖现有 runtime。
        if not FileExists(exPath .. "\\MuAiCore\\MuAiCore.lua")
                or not FileExists(exPath .. "\\MuAiCore\\module.def")
                or not FolderExists(exPath .. "\\TensorReactions")
                or not FileExists(installerPath)
        then
            failUpdate('更新失败：压缩包目录结构不完整。')
            return
        end

        d("[MuAiCore]解压和结构校验完成，开始替换更新文件...")
        -- 文件替换、备份和失败回滚由事务安装脚本一次完成。
        local installCommand = 'powershell.exe -NoProfile -NonInteractive -ExecutionPolicy Bypass -File "'
                .. installerPath .. '" -SourceRoot "' .. exPath .. '" -TargetRoot "'
                .. replacePath .. '" -WorkRoot "' .. tempPath .. '" -PreserveUpdateChannels -UpdateBranch "' .. branch .. '"'
        local installOk, installOutput = runCommand(installCommand)
        if not installOk then
            if installOutput:find('__MUAI_ROLLBACK_INCOMPLETE__', 1, true) then
                failUpdate('更新失败且回滚未完成，请查看诊断日志。', installOutput, true)
            elseif installOutput:find('__MUAI_UPDATE_PREFLIGHT_FAILED__', 1, true) then
                failUpdate('更新准备失败，当前安装未被修改，请查看诊断日志。', installOutput)
            else
                failUpdate('更新失败：已回滚到更新前文件。', installOutput)
            end
            return
        end

        -- 安装成功后再删除工作目录，并延迟到下一帧触发 Reload。
        cleanupOk, cleanupError = deleteTempFolder()
        if cleanupOk == false then
            M.LogError('Update', '更新完成但临时目录清理失败', {
                path = tempPath,
                detail = cleanupError,
            }, true)
        end
        d('[MuAiCore]更新文件替换完成。')
        updateTime = Now()
        updateNeedReLoad = true
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
