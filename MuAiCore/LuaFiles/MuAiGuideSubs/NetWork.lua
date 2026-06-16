local NetWork = {}
--[[
===========================
    HTTP处理模块
===========================
]]
local updateTime
local updateNeedReLoad = false

---@param M MuAiGuide
NetWork.init = function(M)
    M.FinalSponsorList = nil
    M.LocalSponsorList = {
        { id = 'W', icon = 'W' },
        { id = 'Master Lee', icon = 'MasterLee' },
        { id = 'Jackpot', icon = 'Jackpot' },
        { id = '芝麻酷豆', icon = 'SesameCoolBean' },
        { id = '一箱老雪', icon = 'Snowbeer' },
        { id = '楪祈', icon = 'Inori' },
    }

    M.ThxList = {
        { id = 'kaze', icon = 'kaze' },
        { id = 'megaminx', icon = 'megaminx' },
        { id = 'ppu', icon = 'ppu' },
        { id = 'Shippo', icon = 'Shippo' },
        { id = 'String', icon = 'String' },
        { id = 'catZ', icon = 'catZ' },
        { id = 'Master Lee', icon = 'MasterLee' },
        { id = 'Jackpot', icon = 'Jackpot' },
        { id = 'Rikuduo', icon = 'Rikuduo' },
        { id = '倦', icon = 'juan' },
        { id = '蛙', icon = 'fog' },
        { id = 'SEA_AI', icon = 'SEA_AI' },
    }
    M.ShuffleListInPlace(M.LocalSponsorList)
    M.ShuffleListInPlace(M.ThxList)
    ---使用系统CMD请求网络数据
    ---@param url string 地址
    ---@return string 获取的值
    M.WebRequest = function(url)
        local urlStr = url .. '?t=' .. os.time()
        local handle = io.popen('curl -s "' .. urlStr .. '"')
        local result = handle:read("*all")
        handle:close()
        return result
    end

    ---使用系统CMD检查版本
    ---@param isAuto boolean 是否为自动检查
    M.CheckVersion = function(isAuto)
        M.LatestVer = nil
        M.LogInfo = nil
        --local resp = M.WebRequest('https://gist.githubusercontent.com/SuzukazeYuYa/cb01eb35b958b57d7d962235262ea05d/raw/MuAiCoreChangeLog.txt')
        -- 改用腾讯云存储
        local resp = M.WebRequest('https://muai-guide-main-1435131442.cos.ap-shanghai.myqcloud.com/versionLog.txt')
        if resp ~= nil and resp ~= '' then
            local logsData = M.StringSplit(resp, "|")
            if logsData ~= nil and table.size(logsData) >= 0 then
                M.LatestVer = tonumber(logsData[1])
                local infoTable = { "版本检查完毕：",
                                    "Tab|当前版本：" .. M.VERSION,
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
                            function() M.ForceUpdate() end,
                            '确认', '强制更新')
                else
                    M.ShowMsgUI(2, M.LogInfo)
                end
            else
                M.ShowMsgUI(3, { "版本检查失败，请检查网络或重新启动游戏后再次尝试。" })
            end
        end
    end

    M.GetSponsorsList = function()
        --local resp = M.WebRequest('https://gist.github.com/SuzukazeYuYa/e598918cc010089df3387e8246b9c0dd/raw/SponsorsList.txt')
        -- 改用腾讯云存储
        local resp = M.WebRequest('https://muai-guide-main-1435131442.cos.ap-shanghai.myqcloud.com/sponsorsList.txt')
        if resp ~= nil and resp ~= '' then
            M.FinalSponsorList = loadstring(resp)()
        else
            M.FinalSponsorList = M.LocalSponsorList
        end
        M.ShuffleListInPlace(M.FinalSponsorList)
        --local iconUrl = "https://raw.githubusercontent.com/SuzukazeYuYa/MuAiCore/main/MuAiCore/Image/HeadIcons/"
        local iconUrl = "https://muai-guide-main-1435131442.cos.ap-shanghai.myqcloud.com/HeadIcons/"
        for _, spName in pairs(M.FinalSponsorList) do
            local iconPath = GetLuaModsPath() .. 'MuAiCore/Image/HeadIcons/' .. spName.icon .. '.png'
            iconPath = string.gsub(iconPath, "\\", "/")
            if not FileExists(iconPath) then
                local url = iconUrl .. spName.icon .. '.png'
                local cmd = string.format('powershell -Command "Invoke-WebRequest -Uri \'%s\' -OutFile \'%s\' -UseBasicParsing"', url, iconPath)
                local f = io.popen(cmd, "r")
                if f then
                    f:close()
                end
                local msg = '[MuAiGuide]赞助人的[' .. spName.id .. ']头像图标' .. spName.icon .. '.png下载成功！'
            end
        end
    end

    --- 检查更新是否需要重新加载
    M.CheckNeedReload = function()
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
        local gitZipUrl = "https://codeload.github.com/SuzukazeYuYa/MuAiCore/zip/refs/heads/main"
        local tempPath = GetLuaModsPath() .. "MuAiCore\\Temp\\Download\\"
        local replacePath = GetStartupPath() .. "\\LuaMods"
        local zipFilePath = tempPath .. "repository.zip"
        local extractPath = tempPath .. "Extracted"
        -- 执行系统命令的函数
        local function runCommand(cmd)
            local handle = io.popen(cmd)
            local result = handle:read("*a")
            handle:close()
            return result
        end

        -- 下载文件
        local function downloadFile(url, destination)
            d("[MuAiCore]正在下载文件...")
            local cmd = 'curl -L -o "' .. destination .. '" "' .. url .. '"'
            runCommand(cmd)
            d("[MuAiCore]文件下载完成: " .. destination)
        end
        updateTime = nil
        updateNeedReLoad = false
        -- 清理并创建临时目录
        FolderDelete(tempPath)
        FolderCreate(tempPath)

        -- 下载 Zip 文件
        downloadFile(gitZipUrl, zipFilePath)

        -- 检查下载是否成功
        if not io.open(zipFilePath) then
            d("[MuAiCore]下载失败，无法找到 Zip 文件。")
            return
        end

        -- 解压 Zip 文件
        runCommand('powershell -Command "Expand-Archive -Path \'' .. zipFilePath .. '\' -DestinationPath \'' .. extractPath .. '\'"')
        d("[MuAiCore]解压完成，开始替换更新文件...")
        local exPath = GetLuaModsPath() .. "MuAiCore\\Temp\\Download\\Extracted\\MuAiCore-main"
        local excludeFiles = {
            ".gitignore",
            "README.md"
        }
        -- 检查文件名是否需要排除
        function isExcluded(fileName)
            for _, excluded in ipairs(excludeFiles) do
                if fileName == excluded then
                    return true
                end
            end
            return false
        end

        function copyFiles(srcFolder, destFolder)
            -- 列出源文件夹中的所有文件和子文件夹
            local filesInSrc = FolderList(srcFolder, [[.*]], true)
            -- 遍历文件列表
            for _, fileName in ipairs(filesInSrc) do
                -- 如果当前文件需要排除，则跳过
                if not isExcluded(fileName) then
                    -- 获取源文件的完整路径
                    local srcFile = srcFolder .. "\\" .. fileName
                    local destFile = destFolder .. "\\" .. fileName
                    -- 如果是文件夹
                    if FolderExists(srcFile) then
                        -- 如果目标文件夹不存在，创建它
                        if not FolderExists(destFile) then
                            FolderCreate(destFile)
                        end
                        -- 递归复制该子文件夹中的内容
                        copyFiles(srcFile, destFile)  -- 递归调用
                        -- 如果是文件
                    elseif FileExists(srcFile) then
                        -- 确保目标文件夹存在
                        local destFolderPath = string.match(destFile, "^(.*[\\/])")  -- 获取文件夹路径
                        if not FolderExists(destFolderPath) then
                            FolderCreate(destFolderPath)
                        end
                        -- 如果目标文件存在，比较文件内容
                        if FileExists(destFile) then
                            d("[MuAiCore]更新：" .. destFile)
                        else
                            d("[MuAiCore]新增：" .. destFile)
                        end
                        runCommand("copy /Y " .. srcFile .. " " .. destFile)
                    end
                end
            end
        end
        copyFiles(exPath, replacePath)
        -- 清理临时目录
        updateTime = Now()
        updateNeedReLoad = true
    end
end

return NetWork
