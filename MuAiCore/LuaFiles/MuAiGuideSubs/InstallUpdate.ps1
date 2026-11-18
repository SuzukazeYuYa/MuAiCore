[CmdletBinding(DefaultParameterSetName = 'Install')]
param(
    [Parameter(Mandatory = $true, ParameterSetName = 'Install')]
    [string]$SourceRoot,
    [Parameter(Mandatory = $true)]
    [string]$TargetRoot,
    [Parameter(Mandatory = $true)]
    [string]$WorkRoot,
    [ValidateSet('main', 'String')]
    [string]$UpdateBranch = 'main',
    [switch]$PreserveUpdateChannels,
    [Parameter(Mandatory = $true, ParameterSetName = 'Download')]
    [switch]$Download,
    [Parameter(Mandatory = $true, ParameterSetName = 'Download')]
    [ValidateSet('GitHub','Mirror')]
    [string]$DownloadSource,
    [Parameter(Mandatory = $true, ParameterSetName = 'Cleanup')]
    [switch]$Cleanup
)

$ErrorActionPreference = 'Stop'
# 事务版本独立于发布版本；切换渠道时不退回旧的批量改名安装器。
$installerTransactionVersion = 4
$backupRoot = Join-Path $WorkRoot 'Rollback'
$createdFiles = [System.Collections.Generic.List[string]]::new()
$changedFiles = [System.Collections.Generic.List[object]]::new()
$patchedFiles = @{}
$skipInstaller = $false
$transactionStarted = $false
$removedFiles = [System.Collections.Generic.List[string]]::new()
$channelsRelative = 'MuAiCore\LuaFiles\MuAiGuideSubs\UpdateChannels.lua'
$installerRelative = 'MuAiCore\LuaFiles\MuAiGuideSubs\InstallUpdate.ps1'

function Get-UpdateWorkDirectory {
    $work = (Resolve-Path -LiteralPath $WorkRoot).ProviderPath.TrimEnd('\')
    $target = (Resolve-Path -LiteralPath $TargetRoot).ProviderPath.TrimEnd('\')
    $parent = [IO.Path]::GetDirectoryName($work)
    $token = [IO.Path]::GetFileName($work)
    $name = [regex]::Match($token, '^MuAiCoreUpdater_([0-9]+)_[0-9]+_[0-9]+$')
    if (-not $name.Success -or $target -ne (Join-Path $parent 'LuaMods') -or
        ((Get-Item -LiteralPath $work).Attributes -band [IO.FileAttributes]::ReparsePoint)) {
        throw 'Invalid update work directory.'
    }
    return $work
}

if ($Cleanup) {
    $work = Get-UpdateWorkDirectory
    try {
        foreach ($file in @('downloading','extracting','installing','worker.log','installer.log','installer.err','result','worker.exit','ack')) {
            [IO.File]::Delete((Join-Path $work $file))
        }
        [IO.Directory]::Delete($work, $false)
    } catch {
        [IO.File]::WriteAllText((Join-Path $work 'cleanup-error.txt'), $_.Exception.Message)
        exit 1
    }
    exit 0
}

# 后台完成下载、解压、安装和大目录清理。Lua 只读取进度与最终回执。
function Invoke-DownloadUpdate {
    $work = Get-UpdateWorkDirectory
    $target = (Resolve-Path -LiteralPath $TargetRoot).ProviderPath.TrimEnd('\')
    $parent = [IO.Path]::GetDirectoryName($work)
    $token = [IO.Path]::GetFileName($work)
    $name = [regex]::Match($token, '^MuAiCoreUpdater_([0-9]+)_')
    $pending = Join-Path $parent ('MuAiCoreUpdatePending_' + $name.Groups[1].Value + '.txt')
    $lock = $null
    $result = 'preflight'
    $detail = ''
    try {
        try {
            $lock = [IO.FileStream]::new((Join-Path $parent 'MuAiCoreUpdate.lock'), [IO.FileMode]::OpenOrCreate,
                [IO.FileAccess]::ReadWrite, [IO.FileShare]::None, 4096, [IO.FileOptions]::DeleteOnClose)
        } catch [IO.IOException] {
            if (($_.Exception.GetBaseException().HResult -band 65535) -in @(32,33)) { $result = 'busy' }
            throw
        }
        if ([IO.File]::ReadAllText($pending).Trim() -ne $token) { throw 'Update request was replaced.' }
        [IO.File]::WriteAllText((Join-Path $work 'downloading'), '')
        $zip = Join-Path $work 'repository.zip'
        $url = if ($UpdateBranch -eq 'String' -or $DownloadSource -eq 'GitHub') {
            "https://codeload.github.com/SuzukazeYuYa/MuAiCore/zip/refs/heads/$UpdateBranch"
        } else { 'https://muai-guide-main-1435131442.cos.ap-shanghai.myqcloud.com/MuAiCore-main.zip' }
        & curl.exe --fail --silent --show-error --location --connect-timeout 5 --max-time 90 --output $zip $url
        if ($LASTEXITCODE -ne 0) { throw "Download failed ($LASTEXITCODE)." }
        $size = (Get-Item -LiteralPath $zip).Length
        if ($size -lt 1024 -or $size -gt 209715200) { throw "Invalid ZIP size: $size" }
        [IO.File]::WriteAllText((Join-Path $work 'extracting'), '')
        $unpacked = Join-Path $work 'Extracted'
        Expand-Archive -LiteralPath $zip -DestinationPath $unpacked -ErrorAction Stop
        $package = Join-Path $unpacked ('MuAiCore-' + $UpdateBranch)
        if (-not (Test-Path -LiteralPath (Join-Path $package 'MuAiCore\MuAiCore.lua') -PathType Leaf) -or
            -not (Test-Path -LiteralPath (Join-Path $package 'MuAiCore\module.def') -PathType Leaf) -or
            -not (Test-Path -LiteralPath (Join-Path $package 'TensorReactions') -PathType Container)) {
            throw 'Invalid archive layout.'
        }
        if ([IO.File]::ReadAllText($pending).Trim() -ne $token) { throw 'Update request was replaced.' }
        [IO.File]::WriteAllText((Join-Path $work 'installing'), '')
        $result = 'unknown'
        $receipt = Join-Path $work 'installer.log'
        $errors = Join-Path $work 'installer.err'
        $arguments = @('-NoProfile', '-NonInteractive', '-ExecutionPolicy', 'Bypass',
            '-File', ('"' + $PSCommandPath + '"'), '-SourceRoot', ('"' + $package + '"'),
            '-TargetRoot', ('"' + $target + '"'), '-WorkRoot', ('"' + $work + '"'),
            '-PreserveUpdateChannels', '-UpdateBranch', $UpdateBranch)
        $process = Start-Process -FilePath 'powershell.exe' -ArgumentList $arguments -WindowStyle Hidden -Wait -PassThru -RedirectStandardOutput $receipt -RedirectStandardError $errors
        $installExit = $process.ExitCode
        $lines = @(Get-Content -LiteralPath $receipt)
        if ($installExit -eq 0 -and $lines -ccontains '__MUAI_UPDATE_INSTALLED__') { $result = 'installed' }
        elseif ($installExit -ne 0 -and $lines -ccontains '__MUAI_ROLLBACK_INCOMPLETE__') { $result = 'incomplete' }
        elseif ($installExit -ne 0 -and $lines -ccontains '__MUAI_ROLLBACK_COMPLETE__') { $result = 'rolledback' }
        elseif ($installExit -ne 0 -and $lines -ccontains '__MUAI_UPDATE_PREFLIGHT_FAILED__') { $result = 'preflight' }
        if ($result -ne 'installed') {
            $reason = (Get-Content -LiteralPath $errors -TotalCount 12) -join ' '
            $detail = "Installer exit $installExit. " + $reason.Substring(0, [Math]::Min($reason.Length, 1500))
        }
    } catch { $detail = $_.Exception.Message }
    finally {
        $retain = $result -in @('unknown','incomplete')
        if (-not $retain) {
            try {
                foreach ($entry in @('repository.zip','Extracted','Patched','Rollback')) {
                    $path = [IO.Path]::GetFullPath((Join-Path $work $entry))
                    if ([IO.Path]::GetDirectoryName($path) -ne $work) { throw 'Invalid cleanup path.' }
                    if (Test-Path -LiteralPath $path) { Remove-Item -LiteralPath $path -Recurse -Force -ErrorAction Stop }
                }
            } catch { $retain = $true; $detail += ' ' + $_.Exception.Message }
        }
        if ($lock) { $lock.Dispose() }
        $keep = if ($retain) { 'keep' } else { 'clean' }
        [IO.File]::WriteAllText((Join-Path $work 'result.tmp'), "$result`n$keep`n$detail", [Text.UTF8Encoding]::new($false))
        [IO.File]::Move((Join-Path $work 'result.tmp'), (Join-Path $work 'result'))
    }
    return $result
}

if ($Download) {
    if ((Invoke-DownloadUpdate) -eq 'installed') { exit 0 }
    exit 1
}

function Test-WithinPath {
    param([string]$Path, [string]$Root)

    return $Path.Equals($Root, [System.StringComparison]::OrdinalIgnoreCase) -or
        $Path.StartsWith($Root + '\', [System.StringComparison]::OrdinalIgnoreCase)
}

# 安装和回滚只允许写目标根内的普通文件。已有父目录和文件都要检查。
function Assert-InstallDestination([string]$Destination) {
    if (-not (Test-WithinPath $Destination $TargetRoot) -or $Destination -eq $TargetRoot) {
        throw "Invalid installation target: $Destination"
    }
    $path = $Destination
    while ($true) {
        try { $attributes = [IO.File]::GetAttributes($path) }
        catch [IO.FileNotFoundException] { $attributes = $null }
        catch [IO.DirectoryNotFoundException] { $attributes = $null }
        if ($null -ne $attributes) {
            if ($attributes -band [IO.FileAttributes]::ReparsePoint) { throw "Linked installation path: $path" }
            $isDirectory = [bool]($attributes -band [IO.FileAttributes]::Directory)
            if ($isDirectory -eq ($path -eq $Destination)) { throw "Unexpected installation path type: $path" }
        }
        if ($path -eq $TargetRoot) { break }
        $path = [IO.Path]::GetDirectoryName($path)
    }
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
            # 渠道模块与安装器共用事务回执，切回旧包时成对保留。
            $script:patchedFiles[$channelsRelative] = Join-Path $PSScriptRoot 'UpdateChannels.lua'
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

function Get-FileDigest([string]$Path) {
    $stream = [IO.File]::OpenRead($Path)
    try {
        $sha = [Security.Cryptography.SHA256]::Create()
        try { return [BitConverter]::ToString($sha.ComputeHash($stream)).Replace('-', '') }
        finally { $sha.Dispose() }
    } finally { $stream.Dispose() }
}

function Copy-VerifiedFile {
    param([string]$Source, [string]$Destination)

    # 相同内容不重复替换文件；正常更新只写入实际发生变化的发布资产。
    $sourceHash = Get-FileDigest $Source
    if ((Test-Path -LiteralPath $Destination -PathType Leaf) -and
        (Get-FileDigest $Destination) -eq $sourceHash) {
        return $sourceHash
    }
    $destinationDirectory = Split-Path -Parent $Destination
    [System.IO.Directory]::CreateDirectory($destinationDirectory) | Out-Null

    # 旧内容已在 WorkRoot 中校验备份；直接复制，避免为每个文件重复改名。
    # 写入失败或目标哈希不符时，由外层事务恢复，成功前必须读回目标文件。
    [System.IO.File]::Copy($Source, $Destination, $true)
    if ((Get-FileDigest $Destination) -ne $sourceHash) {
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
            Assert-InstallDestination $entry.Destination
            if ((Get-FileDigest $entry.Backup) -ne $entry.Hash) {
                throw "Rollback backup hash mismatch: $($entry.Backup)"
            }
            Copy-VerifiedFile -Source $entry.Backup -Destination $entry.Destination | Out-Null
        }
        catch { $restoreErrors.Add("$($entry.Destination): $($_.Exception.Message)") }
    }

    for ($index = $createdFiles.Count - 1; $index -ge 0; $index--) {
        try {
            Assert-InstallDestination $createdFiles[$index]
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
            Assert-InstallDestination $destination
            if (-not $removedFiles.Contains($relative)) { $removedFiles.Add($relative) }
        }
    }

    $installFiles = [System.Collections.Generic.List[object]]::new()
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
            Assert-InstallDestination $destination
            $copySource = if ($patchedFiles.ContainsKey($relativePath)) { $patchedFiles[$relativePath] } else { $_.FullName }
            $installFiles.Add(@{ Relative = $relativePath; Destination = $destination; Source = $copySource })
        }
    }

    if (Test-Path -LiteralPath $backupRoot) {
        throw "Previous rollback directory exists. Use a new work directory: $backupRoot"
    }
    [System.IO.Directory]::CreateDirectory($backupRoot) | Out-Null
    $transactionStarted = $true

    # 与覆盖文件共用回滚目录；后续任一安装步骤失败时，旧文件也能恢复。
    foreach ($relative in $removedFiles) {
        $destination = Join-Path $TargetRoot $relative
        Assert-InstallDestination $destination
        if (Test-Path -LiteralPath $destination -PathType Leaf) {
            $backupFile = Join-Path $backupRoot $relative
            $backupHash = Copy-VerifiedFile -Source $destination -Destination $backupFile
            $changedFiles.Add(@{ Backup = $backupFile; Destination = $destination; Hash = $backupHash })
            Remove-Item -LiteralPath $destination -Force -ErrorAction Stop
        }
    }

    foreach ($file in $installFiles) {
        $destination, $relativePath, $copySource = $file.Destination, $file.Relative, $file.Source
        Assert-InstallDestination $destination
        if ((Test-Path -LiteralPath $destination -PathType Leaf) -and
            (Get-FileDigest $copySource) -eq (Get-FileDigest $destination)) {
            continue
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
    Write-Output '__MUAI_ROLLBACK_COMPLETE__'
    Write-Error "Update failed; previous files were restored: $updateError" -ErrorAction Continue
    exit 1
}

try { Remove-Item -LiteralPath $backupRoot -Recurse -Force -ErrorAction Stop }
catch { Write-Warning "Update completed; rollback backup cleanup failed: $backupRoot : $($_.Exception.Message)" }
Write-Output '__MUAI_UPDATE_INSTALLED__'
exit 0
