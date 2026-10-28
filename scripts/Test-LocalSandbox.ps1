[CmdletBinding()]
param()
$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
$sandbox = Join-Path $root 'sandbox'
$hello = Join-Path $sandbox 'hello.txt'
$outputDir = Join-Path $sandbox 'test-output'
if ((Get-Item -LiteralPath $sandbox).Attributes -band [IO.FileAttributes]::ReparsePoint) {
    throw 'Sandbox is a reparse point; refusing this local probe.'
}
if ((Get-Item -LiteralPath $outputDir).Attributes -band [IO.FileAttributes]::ReparsePoint) {
    throw 'Output directory is a reparse point; refusing this local probe.'
}
$expected = 'Chat_Hand sandbox: synthetic data only. No production access authorized.'
if ((Get-Content -LiteralPath $hello -Raw).Trim() -ne $expected) { throw 'Unexpected fixture content.' }
$output = Join-Path $outputDir ('probe-' + [guid]::NewGuid().ToString('N') + '.txt')
$payload = 'local-probe-' + [guid]::NewGuid().ToString('N')
$readback = $false
try {
    [IO.File]::WriteAllText($output, $payload)
    $readback = [IO.File]::ReadAllText($output) -ceq $payload
    if (-not $readback) { throw 'Write/read mismatch.' }
} finally {
    if (Test-Path -LiteralPath $output) { Remove-Item -LiteralPath $output }
}
if (Test-Path -LiteralPath $output) { throw 'Cleanup failed.' }
[pscustomobject]@{
    observedUtc = [DateTime]::UtcNow.ToString('o')
    transport = 'Local PowerShell launched by Codex; NOT MCP or ChatGPT web'
    fixtureRead = 'PASS'
    syntheticWriteReadback = if ($readback) { 'PASS' } else { 'FAIL' }
    probeCleanup = 'PASS'
    boundaryEnforcement = 'NOT TESTED; this script is not a sandbox security boundary'
} | ConvertTo-Json
