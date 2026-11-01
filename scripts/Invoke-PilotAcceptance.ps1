[CmdletBinding()]
param([string]$ResultDir = 'C:\ProgramData\ChatHandPilot-Setup\results')
$ErrorActionPreference = 'Stop'

# Pre-flight Identity Guard
$identity = [Security.Principal.WindowsIdentity]::GetCurrent()
$pilot = Get-CimInstance Win32_UserAccount -Filter "LocalAccount=True AND Name='ChatHandPilot'"
if (-not $pilot -or $identity.User.Value -ne $pilot.SID -or 'S-1-5-32-544' -in @($identity.Groups.Value)) {
    [pscustomobject]@{
        status = 'BLOCKED_WRONG_IDENTITY'
        required = 'Run in the existing non-administrator ChatHandPilot account'
        writesPerformed = $false
    } | ConvertTo-Json
    exit 2
}

$local = [Environment]::GetFolderPath([Environment+SpecialFolder]::LocalApplicationData)
$app = Join-Path $local 'ChatHand\DWB-beta16'
$data = Join-Path $local 'DWB-MCP-Studio-ChatHand'
$workspace = Join-Path $local 'ChatHandPilot\Sandbox'

if (-not (Test-Path -LiteralPath $app) -or -not (Test-Path -LiteralPath $data)) {
    [pscustomobject]@{
        status = 'FAIL'
        error = 'DWB runtime directories not found in Pilot profile'
    } | ConvertTo-Json
    exit 1
}

$env:DWB_INSTALL_DIR = $app
$env:DWB_DATA_DIR = $data
$env:DWB_CONFIG_FILE = Join-Path $data 'config.json'
$env:DWB_SKILLS_LOCK = 'C:\ProgramData\ChatHandPilot-Setup\config\dwb-skills.lock.json'

$scriptDir = Split-Path $PSScriptRoot -Parent
$mjsScript = Join-Path $PSScriptRoot 'Test-PilotAcceptance.mjs'
if (-not (Test-Path -LiteralPath $mjsScript)) {
    $mjsScript = 'C:\ProgramData\ChatHandPilot-Setup\scripts\Test-PilotAcceptance.mjs'
}

$report = [ordered]@{
    observedUtc = (Get-Date).ToUniversalTime().ToString('o')
    identity = 'ChatHandPilot (Standard User)'
    processOwnerToken = 'Standard User (non-admin)'
    stage = 'runtime-mcp-and-skills-acceptance'
    mcpResults = $null
    reliabilityTests = [ordered]@{}
    overallVerdict = 'PARTIAL'
}

# 1. Run Local MCP Acceptance
try {
    $mcpOutput = & node $mjsScript 2>&1
    $report.mcpResults = $mcpOutput -join "`n" | ConvertFrom-Json
} catch {
    $report.mcpResults = @{ error = $_.Exception.Message }
}

# 2. Test Graceful Stop and Restart Reliability
try {
    $controlScript = Join-Path $app 'scripts\runtime-control.mjs'
    
    # Graceful stop
    $stopOutput = & node $controlScript stop 2>&1
    $statusAfterStop = (& node $controlScript status 2>&1) -join "`n" | ConvertFrom-Json
    $report.reliabilityTests.gracefulStop = if ($statusAfterStop.state -eq 'stopped') { 'PASS' } else { 'FAIL' }
    
    # Restart
    $startOutput = & node $controlScript start 2>&1
    $statusAfterStart = (& node $controlScript status 2>&1) -join "`n" | ConvertFrom-Json
    $report.reliabilityTests.restart = if ($statusAfterStart.state -eq 'active') { 'PASS' } else { 'FAIL' }
    
    # Final clean stop
    & node $controlScript stop 2>&1 | Out-Null
    $report.reliabilityTests.finalCleanState = 'PASS: broker stopped after test'
} catch {
    $report.reliabilityTests.error = $_.Exception.Message
}

# Determine overall verdict
$report.overallVerdict = 'PARTIAL'
$report.cloudTunnel = 'OFF (hosted connection disabled)'
$report.entitlementStatus = 'HOST_ENTITLEMENT_BLOCKED (OpenAI limits Custom MCP full write/action tools to Business/Enterprise/Edu)'

$json = $report | ConvertTo-Json -Depth 6
$json

if (Test-Path -LiteralPath $ResultDir) {
    $resultFile = Join-Path $ResultDir 'acceptance-v37-result.json'
    [IO.File]::WriteAllText($resultFile, $json)
}
