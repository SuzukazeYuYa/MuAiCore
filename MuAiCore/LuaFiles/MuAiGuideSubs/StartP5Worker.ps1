[CmdletBinding()]
param([Parameter(Mandatory)][ValidatePattern('^[0-9-]{1,70}$')][string]$Session)

$ErrorActionPreference = 'Stop'
$root = [IO.Directory]::GetParent([IO.Directory]::GetParent($PSScriptRoot).FullName).FullName
$folder = Join-Path $root 'Temp\P5Solver'
[IO.Directory]::CreateDirectory($folder) | Out-Null
$temporary = Join-Path $folder ($Session + '.tmp')

function Get-Digest([string]$Path) {
    $stream = [IO.File]::OpenRead($Path)
    try {
        $sha = [Security.Cryptography.SHA256]::Create()
        try { return [BitConverter]::ToString($sha.ComputeHash($stream)).Replace('-', '') }
        finally { $sha.Dispose() }
    } finally { $stream.Dispose() }
}
try {
    # 从已校验的运行副本启动；在线更新可以替换 Native 中的发布文件。
    $asset = Join-Path $root 'Native\MuAiP5Worker.exe'
    $hash = Get-Digest $asset
    $copy = Join-Path $folder ("solver-$hash.exe")
    if (-not [IO.File]::Exists($copy)) {
        [IO.File]::Copy($asset, $temporary, $false)
        if ((Get-Digest $temporary) -ne $hash) { throw 'P5 solver package changed while copying.' }
        try { [IO.File]::Move($temporary, $copy) }
        catch [IO.IOException] { if (-not [IO.File]::Exists($copy)) { throw } }
    }
    if ((Get-Digest $copy) -ne $hash) { throw 'P5 solver cache hash mismatch.' }
    Start-Process -FilePath $copy -ArgumentList $Session -WorkingDirectory $folder -WindowStyle Hidden
}
catch {
    [IO.File]::WriteAllText((Join-Path $folder ($Session + '.error')), $_.Exception.Message)
    exit 1
}
finally {
    if ([IO.File]::Exists($temporary)) { [IO.File]::Delete($temporary) }
}
