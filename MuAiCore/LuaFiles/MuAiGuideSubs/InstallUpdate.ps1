param(
    [Parameter(Mandatory = $true)]
    [string]$SourceRoot,
    [Parameter(Mandatory = $true)]
    [string]$TargetRoot,
    [Parameter(Mandatory = $true)]
    [string]$WorkRoot,
    [ValidateSet('main', 'dmu-String')]
    [string]$UpdateBranch = 'main',
    [switch]$PreserveUpdateChannels
)

$ErrorActionPreference = 'Stop'
$backupRoot = Join-Path $WorkRoot 'Rollback'
$createdFiles = [System.Collections.Generic.List[string]]::new()
$patchedFiles = @{}
$skipInstaller = $false
$transactionStarted = $false
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
    # Packages without the extension keep the installed module and installer. A String
    # package containing both assets can update them together in the same transaction.
    $assetRoot = if ($incomingChannels) { $SourceRoot } else { $TargetRoot }
    foreach ($relative in @($channelsRelative, $installerRelative)) {
        if (-not (Test-Path -LiteralPath (Join-Path $assetRoot $relative) -PathType Leaf)) {
            throw "Persistent update asset is missing: $relative"
        }
    }
    $channelsText = [System.IO.File]::ReadAllText((Join-Path $assetRoot $channelsRelative))
    $installerText = [System.IO.File]::ReadAllText((Join-Path $assetRoot $installerRelative))
    if (-not $channelsText.Contains('UpdateChannels.init = function(M)') -or
        -not $installerText.Contains('[switch]$PreserveUpdateChannels') -or
        -not $installerText.Contains('MUAI_UPDATE_CHANNELS_BOOTSTRAP_BEGIN')) {
        throw 'Persistent update assets are incompatible; installation was not started.'
    }
    $script:skipInstaller = -not $incomingChannels

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

    $destinationDirectory = Split-Path -Parent $Destination
    [System.IO.Directory]::CreateDirectory($destinationDirectory) | Out-Null

    $temporaryDestination = $Destination + '.muai-new'
    Remove-Item -LiteralPath $temporaryDestination -Force -ErrorAction SilentlyContinue
    Copy-Item -LiteralPath $Source -Destination $temporaryDestination -Force

    $sourceHash = (Get-FileHash -LiteralPath $Source -Algorithm SHA256).Hash
    $temporaryHash = (Get-FileHash -LiteralPath $temporaryDestination -Algorithm SHA256).Hash
    if ($sourceHash -ne $temporaryHash) {
        throw "Staged file hash mismatch: $Source"
    }

    if (Test-Path -LiteralPath $Destination -PathType Leaf) {
        $replaceBackup = $Destination + '.muai-old'
        Remove-Item -LiteralPath $replaceBackup -Force -ErrorAction SilentlyContinue
        [System.IO.File]::Replace($temporaryDestination, $Destination, $replaceBackup)
        Remove-Item -LiteralPath $replaceBackup -Force -ErrorAction SilentlyContinue
    }
    else {
        [System.IO.File]::Move($temporaryDestination, $Destination)
    }
}

function Restore-Backup {
    if (Test-Path -LiteralPath $backupRoot -PathType Container) {
        Get-ChildItem -LiteralPath $backupRoot -File -Recurse | ForEach-Object {
            $relativePath = Get-RelativePath -Root $backupRoot -Path $_.FullName
            $destination = Join-Path $TargetRoot $relativePath
            $destinationDirectory = Split-Path -Parent $destination
            [System.IO.Directory]::CreateDirectory($destinationDirectory) | Out-Null
            Copy-VerifiedFile -Source $_.FullName -Destination $destination
        }
    }

    for ($index = $createdFiles.Count - 1; $index -ge 0; $index--) {
        if (Test-Path -LiteralPath $createdFiles[$index]) {
            Remove-Item -LiteralPath $createdFiles[$index] -Force -ErrorAction Stop
        }
    }

    Get-ChildItem -LiteralPath $TargetRoot -Filter '*.muai-new' -File -Recurse -ErrorAction SilentlyContinue |
        Remove-Item -Force -ErrorAction Stop
    Get-ChildItem -LiteralPath $TargetRoot -Filter '*.muai-old' -File -Recurse -ErrorAction SilentlyContinue |
        Remove-Item -Force -ErrorAction Stop
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

    if (Test-Path -LiteralPath $backupRoot) {
        Remove-Item -LiteralPath $backupRoot -Recurse -Force -ErrorAction Stop
    }
    [System.IO.Directory]::CreateDirectory($backupRoot) | Out-Null
    $transactionStarted = $true

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
            if (Test-Path -LiteralPath $destination -PathType Leaf) {
                $backupFile = Join-Path $backupRoot $relativePath
                $backupDirectory = Split-Path -Parent $backupFile
                [System.IO.Directory]::CreateDirectory($backupDirectory) | Out-Null
                Copy-VerifiedFile -Source $destination -Destination $backupFile
            }
            else {
                $createdFiles.Add($destination)
            }

            $copySource = if ($patchedFiles.ContainsKey($relativePath)) { $patchedFiles[$relativePath] } else { $_.FullName }
            Copy-VerifiedFile -Source $copySource -Destination $destination
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
        Write-Error "Update failed and rollback was incomplete: $($_.Exception.Message)" -ErrorAction Continue
        exit 2
    }
    Write-Error "Update failed; previous files were restored: $updateError" -ErrorAction Continue
    exit 1
}

Remove-Item -LiteralPath $backupRoot -Recurse -Force -ErrorAction SilentlyContinue
exit 0
