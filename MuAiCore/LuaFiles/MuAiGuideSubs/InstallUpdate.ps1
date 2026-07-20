param(
    [Parameter(Mandatory = $true)]
    [string]$SourceRoot,
    [Parameter(Mandatory = $true)]
    [string]$TargetRoot,
    [Parameter(Mandatory = $true)]
    [string]$WorkRoot
)

$ErrorActionPreference = 'Stop'
$backupRoot = Join-Path $WorkRoot 'Rollback'
$createdFiles = [System.Collections.Generic.List[string]]::new()

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
            Copy-Item -LiteralPath $_.FullName -Destination $destination -Force
        }
    }

    for ($index = $createdFiles.Count - 1; $index -ge 0; $index--) {
        Remove-Item -LiteralPath $createdFiles[$index] -Force -ErrorAction SilentlyContinue
    }

    Get-ChildItem -LiteralPath $TargetRoot -Filter '*.muai-new' -File -Recurse -ErrorAction SilentlyContinue |
        Remove-Item -Force -ErrorAction SilentlyContinue
    Get-ChildItem -LiteralPath $TargetRoot -Filter '*.muai-old' -File -Recurse -ErrorAction SilentlyContinue |
        Remove-Item -Force -ErrorAction SilentlyContinue
}

try {
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

    Remove-Item -LiteralPath $backupRoot -Recurse -Force -ErrorAction SilentlyContinue
    [System.IO.Directory]::CreateDirectory($backupRoot) | Out-Null

    foreach ($topLevel in @('MuAiCore', 'TensorReactions')) {
        $sourceDirectory = Join-Path $SourceRoot $topLevel
        Get-ChildItem -LiteralPath $sourceDirectory -File -Recurse | ForEach-Object {
            $relativePath = Get-RelativePath -Root $SourceRoot -Path $_.FullName
            if ($relativePath -match '^MuAiCore\\(Configs|Log|Temp)(\\|$)' -or $_.Name -eq '.gitignore') {
                return
            }

            $destination = Join-Path $TargetRoot $relativePath
            if (Test-Path -LiteralPath $destination -PathType Leaf) {
                $backupFile = Join-Path $backupRoot $relativePath
                $backupDirectory = Split-Path -Parent $backupFile
                [System.IO.Directory]::CreateDirectory($backupDirectory) | Out-Null
                Copy-Item -LiteralPath $destination -Destination $backupFile -Force
            }
            else {
                $createdFiles.Add($destination)
            }

            Copy-VerifiedFile -Source $_.FullName -Destination $destination
        }
    }
}
catch {
    try {
        Restore-Backup
    }
    catch {
        Write-Error "Update failed and rollback was incomplete: $($_.Exception.Message)"
        exit 2
    }
    Write-Error "Update failed; previous files were restored: $($_.Exception.Message)"
    exit 1
}

Remove-Item -LiteralPath $backupRoot -Recurse -Force -ErrorAction SilentlyContinue
exit 0
