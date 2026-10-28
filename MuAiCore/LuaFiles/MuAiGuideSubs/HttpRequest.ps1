param(
    [Parameter(Mandatory = $true)][string]$Uri,
    [Parameter(Mandatory = $true)][string]$OutputBase
)

$ErrorActionPreference = 'Stop'
$bodyPath = $OutputBase + '.body'
$donePath = $OutputBase + '.done'
$temporaryStatus = $donePath + '.tmp'
$status = 'ERROR: request did not complete'
try {
    if ($Uri -notmatch '^https://') { throw 'Only HTTPS requests are supported.' }
    # Reclaim abandoned responses after a full Lua reload/crash. This dedicated
    # directory is outside LuaMods, and only this worker's old files are removed.
    $requestDirectory = Split-Path -Parent ([IO.Path]::GetFullPath($OutputBase))
    $cutoff = (Get-Date).AddHours(-1)
    foreach ($file in Get-ChildItem -LiteralPath $requestDirectory -File) {
        if ($file.Name -match '^request_\d+_\d+_\d+\.(body|done|done\.tmp|pending)$' -and
                $file.LastWriteTime -lt $cutoff) {
            try { Remove-Item -LiteralPath $file.FullName -ErrorAction Stop }
            catch { Write-Warning ('Cannot remove expired HTTP file: ' + $_.Exception.Message) }
        }
    }
    & curl.exe --fail --silent --show-error --connect-timeout 3 --max-time 5 --max-filesize 65536 --output $bodyPath $Uri
    if ($LASTEXITCODE -ne 0) { throw ('curl exit code ' + $LASTEXITCODE) }
    $length = (Get-Item -LiteralPath $bodyPath).Length
    if ($length -eq 0 -or $length -gt 65536) { throw 'Invalid response size.' }
    $status = 'OK'
}
catch {
    $status = 'ERROR: ' + $_.Exception.Message
}
finally {
    # Publish completion last, after curl has closed the response file.
    [IO.File]::WriteAllText($temporaryStatus, $status, [Text.UTF8Encoding]::new($false))
    Move-Item -LiteralPath $temporaryStatus -Destination $donePath -Force
}
