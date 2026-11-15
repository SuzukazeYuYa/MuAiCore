param(
    [Parameter(Mandatory = $true)]
    [string]$SourceRoot,
    [Parameter(Mandatory = $true)]
    [string]$TargetRoot,
    [Parameter(Mandatory = $true)]
    [string]$WorkRoot,
    [ValidateSet('main', 'String')]
    [string]$UpdateBranch = 'main',
    [switch]$PreserveUpdateChannels
)

$ErrorActionPreference = 'Stop'
# 事务版本独立于发布版本；切换渠道时不退回旧的批量改名安装器。
$installerTransactionVersion = 2
$backupRoot = Join-Path $WorkRoot 'Rollback'
$createdFiles = [System.Collections.Generic.List[string]]::new()
$changedFiles = [System.Collections.Generic.List[object]]::new()
$patchedFiles = @{}
$skipInstaller = $false
$transactionStarted = $false
$removedFiles = [System.Collections.Generic.List[string]]::new()
$channelsRelative = 'MuAiCore\LuaFiles\MuAiGuideSubs\UpdateChannels.lua'
$installerRelative = 'MuAiCore\LuaFiles\MuAiGuideSubs\InstallUpdate.ps1'

function Test-WithinPath {
    param([string]$Path, [string]$Root)

    return $Path.Equals($Root, [System.StringComparison]::OrdinalIgnoreCase) -or
        $Path.StartsWith($Root + '\', [System.StringComparison]::OrdinalIgnoreCase)
}

function Replace-RequiredText {
    param([string]$Content, [string]$Before, [string]$After, [string]$Description)

    $matches = [regex]::Matches($Content, [regex]::Escape($Before)).Count
    if ($matches -ne 1) {
        throw "Unsupported update layout ($Description): expected one anchor, found $matches"
    }
    return $Content.Replace($Before, $After)
}

function Add-ChannelHook {
    param([string]$Content, [string]$Anchor, [string]$Hook, [string]$Marker, [string]$Description)

    $markerCount = [regex]::Matches($Content, [regex]::Escape($Marker)).Count
    if ($markerCount -gt 0) {
        if ($markerCount -ne 1 -or [regex]::Matches($Content, [regex]::Escape($Hook)).Count -ne 1) {
            throw "Incomplete or duplicate update hook: $Description"
        }
        return $Content
    }
    return Replace-RequiredText $Content $Anchor ($Hook + $Anchor) $Description
}

function Prepare-UpdateChannels {
    $incomingChannels = Test-Path -LiteralPath (Join-Path $SourceRoot $channelsRelative) -PathType Leaf
    # 不带渠道扩展的包保留已安装模块；带扩展的包可以更新模块及兼容安装器。
    $assetRoot = if ($incomingChannels) { $SourceRoot } else { $TargetRoot }
    foreach ($relative in @($channelsRelative, $installerRelative)) {
        if (-not (Test-Path -LiteralPath (Join-Path $assetRoot $relative) -PathType Leaf)) {
            throw "Persistent update asset is missing: $relative"
        }
    }
    $channelsText = [System.IO.File]::ReadAllText((Join-Path $assetRoot $channelsRelative))
    # 异步检查需要同时保留传输模块；旧包未引用该依赖时仍可正常安装。
    if ($channelsText.Contains('AsyncHttp.lua')) {
        $httpNames = @('AsyncHttp.lua')
        $httpText = [IO.File]::ReadAllText((Join-Path $assetRoot ('MuAiCore\LuaFiles\MuAiGuideSubs\AsyncHttp.lua')))
        if ($httpText.Contains('HttpRequest.ps1')) { $httpNames += 'HttpRequest.ps1' }
        foreach ($name in $httpNames) {
            $relative = 'MuAiCore\LuaFiles\MuAiGuideSubs\' + $name
            if (-not (Test-Path -LiteralPath (Join-Path $assetRoot $relative) -PathType Leaf)) {
                throw "Persistent update asset is missing: $relative"
            }
        }
    }
    $installerText = [System.IO.File]::ReadAllText((Join-Path $assetRoot $installerRelative))
    if (-not $channelsText.Contains('UpdateChannels.init = function(M)') -or
        -not $installerText.Contains('[switch]$PreserveUpdateChannels') -or
        -not $installerText.Contains('MUAI_UPDATE_CHANNELS_BOOTSTRAP_BEGIN')) {
        throw 'Persistent update assets are incompatible; installation was not started.'
    }
    $script:skipInstaller = -not $incomingChannels
    if ($incomingChannels) {
        $incomingVersion = [regex]::Match($installerText, '(?m)^\$installerTransactionVersion = ([0-9]+)\s*$')
        # 旧包仍更新业务源码；首次安装或从外部运行时，也部署当前已修复的安装器。
        if (-not $incomingVersion.Success -or [long]$incomingVersion.Groups[1].Value -lt $installerTransactionVersion) {
            $script:patchedFiles[$installerRelative] = $PSCommandPath
        }
    }

    $bootstrapHook = @'
    -- MUAI_UPDATE_CHANNELS_BOOTSTRAP_BEGIN
    local updateChannels = FileLoad(MuAiGuideRoot .. 'MuAiGuideSubs\\UpdateChannels.lua')
    if type(updateChannels) ~= 'table' or type(updateChannels.init) ~= 'function' then
        error('更新渠道模块加载失败，无法保留分支选择。')
    end
    updateChannels.init(M)
    -- MUAI_UPDATE_CHANNELS_BOOTSTRAP_END
'@
    $settingsHook = @'
    -- MUAI_UPDATE_CHANNELS_SETTINGS_BEGIN
    M.DrawUpdateBranchSettings()
    -- MUAI_UPDATE_CHANNELS_SETTINGS_END
    GUI:Columns(2, 'BindKey', false)
'@
    $statusHook = @'
    -- MUAI_UPDATE_CHANNELS_STATUS_BEGIN
    if type(M.DrawUpdateBranchStatus) == 'function' then
        M.DrawUpdateBranchStatus()
        return
    end
    -- MUAI_UPDATE_CHANNELS_STATUS_END
'@
    $oldSettings = @'
    GUI:Columns(2, 'BindKey', false)
    GUI:Dummy(6, 0)
    GUI:SameLine()
    GUI:AlignFirstTextHeightToWidgets()
    GUI:Text('更新下载源：  ')
    GUI:NextColumn()
    GUI:PushItemWidth(123)
    M.Config.Main.DownLoadSource = GUI:Combo('##DownLoadSource', M.Config.Main.DownLoadSource, { 'GitHub', '腾讯云' }, 2)
    GUI:PopItemWidth()
    GUI:NextColumn()
'@
    $bootstrapHook = $bootstrapHook.Replace("`r`n", "`n") + "`n"
    $settingsHook = $settingsHook.Replace("`r`n", "`n") + "`n"
    $statusHook = $statusHook.Replace("`r`n", "`n") + "`n"
    $oldSettings = $oldSettings.Replace("`r`n", "`n") + "`n"
    $oldLogLink = "io.popen('start https://docs.qq.com/doc/DWnhXRXBxSXJpU0tS?rtkey=07822459d679f67ae55c279c801Xw1&nlc=1')"
    $newLogLink = "io.popen('start ' .. M.GetUpdateLogUrl())"

    foreach ($relative in @('MuAiCore\LuaFiles\MuAiGuide.lua', 'MuAiCore\LuaFiles\UI\MainUI.lua', 'MuAiCore\LuaFiles\UI\MsgUI.lua')) {
        $sourceFile = Join-Path $SourceRoot $relative
        if (-not (Test-Path -LiteralPath $sourceFile -PathType Leaf)) {
            throw "Update entry file is missing: $relative"
        }
        $content = [System.IO.File]::ReadAllText($sourceFile).Replace("`r`n", "`n")
        if ($relative -eq 'MuAiCore\LuaFiles\MuAiGuide.lua') {
            $content = Add-ChannelHook $content "    M.CheckVersion(true)`n" $bootstrapHook `
                'MUAI_UPDATE_CHANNELS_BOOTSTRAP_BEGIN' 'MuAiGuide startup'
        }
        else {
            if ($relative -eq 'MuAiCore\LuaFiles\UI\MainUI.lua') {
                if ($content.Contains('MUAI_UPDATE_CHANNELS_SETTINGS_BEGIN')) {
                    $content = Add-ChannelHook $content '' $settingsHook `
                        'MUAI_UPDATE_CHANNELS_SETTINGS_BEGIN' 'MainUI settings'
                }
                else {
                    $content = Replace-RequiredText $content $oldSettings $settingsHook 'MainUI download settings'
                }
                $content = Add-ChannelHook $content "    if M.LatestVer == nil then`n" $statusHook `
                    'MUAI_UPDATE_CHANNELS_STATUS_BEGIN' 'MainUI version status'
            }
            if (-not $content.Contains($newLogLink)) {
                $content = Replace-RequiredText $content $oldLogLink $newLogLink 'update log link'
            }
            elseif ([regex]::Matches($content, [regex]::Escape($newLogLink)).Count -ne 1 -or $content.Contains($oldLogLink)) {
                throw "Ambiguous update log link: $relative"
            }
        }
        $patchedPath = Join-Path (Join-Path $WorkRoot 'Patched') $relative
        [System.IO.Directory]::CreateDirectory((Split-Path -Parent $patchedPath)) | Out-Null
        [System.IO.File]::WriteAllText($patchedPath, $content, [System.Text.UTF8Encoding]::new($false))
        $script:patchedFiles[$relative] = $patchedPath
    }
}

function Get-RelativePath {
    param([string]$Root, [string]$Path)

    return $Path.Substring($Root.Length).TrimStart([char[]]'\/')
}

function Copy-VerifiedFile {
    param([string]$Source, [string]$Destination)

    # 相同内容不重复替换文件；正常更新只写入实际发生变化的发布资产。
    $sourceHash = (Get-FileHash -LiteralPath $Source -Algorithm SHA256).Hash
    if ((Test-Path -LiteralPath $Destination -PathType Leaf) -and
        (Get-FileHash -LiteralPath $Destination -Algorithm SHA256).Hash -eq $sourceHash) {
        return $sourceHash
    }
    $destinationDirectory = Split-Path -Parent $Destination
    [System.IO.Directory]::CreateDirectory($destinationDirectory) | Out-Null

    # 旧内容已在 WorkRoot 中校验备份；直接复制，避免为每个文件重复改名。
    # 写入失败或目标哈希不符时，由外层事务恢复，成功前必须读回目标文件。
    [System.IO.File]::Copy($Source, $Destination, $true)
    if ((Get-FileHash -LiteralPath $Destination -Algorithm SHA256).Hash -ne $sourceHash) {
        throw "Copied file hash mismatch: $Destination"
    }
    return $sourceHash
}

function Restore-Backup {
    $restoreErrors = [System.Collections.Generic.List[string]]::new()
    # 只恢复本轮已校验、随后尝试修改的文件；不使用失败或不完整的备份。
    for ($index = $changedFiles.Count - 1; $index -ge 0; $index--) {
        $entry = $changedFiles[$index]
        try {
            if ((Get-FileHash -LiteralPath $entry.Backup -Algorithm SHA256).Hash -ne $entry.Hash) {
                throw "Rollback backup hash mismatch: $($entry.Backup)"
            }
            Copy-VerifiedFile -Source $entry.Backup -Destination $entry.Destination | Out-Null
        }
        catch { $restoreErrors.Add("$($entry.Destination): $($_.Exception.Message)") }
    }

    for ($index = $createdFiles.Count - 1; $index -ge 0; $index--) {
        try {
            if (Test-Path -LiteralPath $createdFiles[$index]) {
                Remove-Item -LiteralPath $createdFiles[$index] -Force -ErrorAction Stop
            }
        }
        catch { $restoreErrors.Add("$($createdFiles[$index]): $($_.Exception.Message)") }
    }
    if ($restoreErrors.Count -gt 0) { throw ($restoreErrors -join '; ') }
}

try {
    $SourceRoot = [System.IO.Path]::GetFullPath($SourceRoot).TrimEnd([char[]]'\/')
    $TargetRoot = [System.IO.Path]::GetFullPath($TargetRoot).TrimEnd([char[]]'\/')
    $WorkRoot = [System.IO.Path]::GetFullPath($WorkRoot).TrimEnd([char[]]'\/')
    if ((Test-WithinPath $SourceRoot $TargetRoot) -or (Test-WithinPath $TargetRoot $SourceRoot) -or
        (Test-WithinPath $WorkRoot $TargetRoot) -or (Test-WithinPath $TargetRoot $WorkRoot)) {
        throw 'Source, target and work paths must not overlap the installed directory.'
    }
    $backupRoot = [System.IO.Path]::GetFullPath((Join-Path $WorkRoot 'Rollback'))
    $patchedRoot = [System.IO.Path]::GetFullPath((Join-Path $WorkRoot 'Patched'))
    if (-not (Test-WithinPath $backupRoot $WorkRoot) -or -not (Test-WithinPath $patchedRoot $WorkRoot) -or
        (Test-WithinPath $SourceRoot $backupRoot) -or (Test-WithinPath $SourceRoot $patchedRoot) -or
        (Test-WithinPath $backupRoot $SourceRoot) -or (Test-WithinPath $patchedRoot $SourceRoot)) {
        throw 'Unsafe updater preparation or rollback path.'
    }
    $requiredFiles = @(
        'MuAiCore\MuAiCore.lua',
        'MuAiCore\module.def'
    )
    foreach ($requiredFile in $requiredFiles) {
        if (-not (Test-Path -LiteralPath (Join-Path $SourceRoot $requiredFile) -PathType Leaf)) {
            throw "Required update file is missing: $requiredFile"
        }
    }
    if (-not (Test-Path -LiteralPath (Join-Path $SourceRoot 'TensorReactions') -PathType Container)) {
        throw 'Required update directory is missing: TensorReactions'
    }

    if ($PreserveUpdateChannels) {
        Prepare-UpdateChannels
    }

    # 清单只允许删除本插件已退役的 Lua 源码，所有路径在开始写入前核验。
    $removalList = Join-Path $SourceRoot 'MuAiCore\RemovedFiles.txt'
    if (Test-Path -LiteralPath $removalList -PathType Leaf) {
        $codeRoot = [System.IO.Path]::GetFullPath((Join-Path $TargetRoot 'MuAiCore\LuaFiles'))
        foreach ($line in [System.IO.File]::ReadAllLines($removalList)) {
            $relative = $line.Trim().Replace('/', '\')
            if ($relative -eq '' -or $relative.StartsWith('#')) { continue }
            if ($relative -notmatch '^MuAiCore\\LuaFiles\\[^:]+\.lua$' -or $relative -match '(^|\\)\.\.(\\|$)') {
                throw "Invalid removed-file entry: $relative"
            }
            $destination = [System.IO.Path]::GetFullPath((Join-Path $TargetRoot $relative))
            if (-not (Test-WithinPath $destination $codeRoot) -or
                (Test-Path -LiteralPath (Join-Path $SourceRoot $relative))) {
                throw "Conflicting removed-file entry: $relative"
            }
            $parent = Split-Path -Parent $destination
            while (Test-WithinPath $parent $TargetRoot) {
                if ((Test-Path -LiteralPath $parent) -and
                    ((Get-Item -LiteralPath $parent -Force).Attributes -band [IO.FileAttributes]::ReparsePoint)) {
                    throw "Removed-file path crosses a linked directory: $relative"
                }
                if ($parent -eq $TargetRoot) { break }
                $parent = Split-Path -Parent $parent
            }
            if (Test-Path -LiteralPath $destination) {
                $item = Get-Item -LiteralPath $destination -Force
                if ($item.PSIsContainer -or ($item.Attributes -band [IO.FileAttributes]::ReparsePoint)) {
                    throw "Removed-file path is not a regular file: $relative"
                }
            }
            if (-not $removedFiles.Contains($relative)) { $removedFiles.Add($relative) }
        }
    }

    if (Test-Path -LiteralPath $backupRoot) {
        Remove-Item -LiteralPath $backupRoot -Recurse -Force -ErrorAction Stop
    }
    [System.IO.Directory]::CreateDirectory($backupRoot) | Out-Null
    $transactionStarted = $true

    # 与覆盖文件共用回滚目录；后续任一安装步骤失败时，旧文件也能恢复。
    foreach ($relative in $removedFiles) {
        $destination = Join-Path $TargetRoot $relative
        if (Test-Path -LiteralPath $destination -PathType Leaf) {
            $backupFile = Join-Path $backupRoot $relative
            $backupHash = Copy-VerifiedFile -Source $destination -Destination $backupFile
            $changedFiles.Add(@{ Backup = $backupFile; Destination = $destination; Hash = $backupHash })
            Remove-Item -LiteralPath $destination -Force -ErrorAction Stop
        }
    }

    foreach ($topLevel in @('MuAiCore', 'TensorReactions')) {
        $sourceDirectory = Join-Path $SourceRoot $topLevel
        Get-ChildItem -LiteralPath $sourceDirectory -File -Recurse | ForEach-Object {
            $relativePath = Get-RelativePath -Root $SourceRoot -Path $_.FullName
            if ($relativePath -match '^MuAiCore\\(Configs|Log|Temp)(\\|$)' -or $_.Name -eq '.gitignore') {
                return
            }
            if ($skipInstaller -and $relativePath -eq $installerRelative) {
                return
            }

            $destination = Join-Path $TargetRoot $relativePath
            if ((Test-Path -LiteralPath $destination) -and -not (Test-Path -LiteralPath $destination -PathType Leaf)) {
                throw "Update file path is occupied by a directory: $relativePath"
            }
            $copySource = if ($patchedFiles.ContainsKey($relativePath)) { $patchedFiles[$relativePath] } else { $_.FullName }
            if ((Test-Path -LiteralPath $destination -PathType Leaf) -and
                (Get-FileHash -LiteralPath $copySource -Algorithm SHA256).Hash -eq
                (Get-FileHash -LiteralPath $destination -Algorithm SHA256).Hash) {
                return
            }
            if (Test-Path -LiteralPath $destination -PathType Leaf) {
                $backupFile = Join-Path $backupRoot $relativePath
                $backupDirectory = Split-Path -Parent $backupFile
                [System.IO.Directory]::CreateDirectory($backupDirectory) | Out-Null
                $backupHash = Copy-VerifiedFile -Source $destination -Destination $backupFile
                $changedFiles.Add(@{ Backup = $backupFile; Destination = $destination; Hash = $backupHash })
            }
            else {
                $createdFiles.Add($destination)
            }

            Copy-VerifiedFile -Source $copySource -Destination $destination | Out-Null
        }
    }
}
catch {
    $updateError = $_.Exception.Message
    if (-not $transactionStarted) {
        Write-Output '__MUAI_UPDATE_PREFLIGHT_FAILED__'
        Write-Error "Update preflight failed; installed files were not changed: $updateError" -ErrorAction Continue
        exit 1
    }
    try {
        Restore-Backup
    }
    catch {
        Write-Output '__MUAI_ROLLBACK_INCOMPLETE__'
        Write-Error "Update failed ($updateError) and rollback was incomplete: $($_.Exception.Message). Backups: $backupRoot" -ErrorAction Continue
        exit 2
    }
    Write-Error "Update failed; previous files were restored: $updateError" -ErrorAction Continue
    exit 1
}

try { Remove-Item -LiteralPath $backupRoot -Recurse -Force -ErrorAction Stop }
catch { Write-Warning "Update completed; rollback backup cleanup failed: $backupRoot : $($_.Exception.Message)" }
exit 0
