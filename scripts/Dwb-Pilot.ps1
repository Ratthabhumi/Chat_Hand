[CmdletBinding()]
param([ValidateSet('Dashboard','Status','Stop','Restart')][string]$Action = 'Status')
$ErrorActionPreference = 'Stop'
$app = Join-Path $env:LOCALAPPDATA 'ChatHand\DWB-beta16'
$env:DWB_DATA_DIR = Join-Path $env:LOCALAPPDATA 'DWB-MCP-Studio-ChatHand'
$env:DWB_CONFIG_FILE = Join-Path $env:DWB_DATA_DIR 'config.json'
if (-not (Test-Path -LiteralPath $env:DWB_CONFIG_FILE)) { throw 'Pilot installation is missing; follow INSTALLATION.md.' }
$manifest = Get-Content -LiteralPath (Join-Path $app 'package.json') -Raw | ConvertFrom-Json
if ($manifest.name -ne 'dwb-mcp-studio-core' -or $manifest.version -ne '0.1.0-beta.16') { throw 'Installation changed; review before operating.' }
. (Join-Path $app 'scripts\runtime-upgrade.ps1')
if ($Action -eq 'Stop' -or $Action -eq 'Restart') {
    Stop-DwbTunnel
    Stop-DwbRuntimeForSetup (Get-Command node).Source
}
if ($Action -eq 'Dashboard' -or $Action -eq 'Restart') {
    $prefs = Get-Content -LiteralPath (Join-Path $env:DWB_DATA_DIR 'preferences.json') -Raw | ConvertFrom-Json
    if ($prefs.startWithWindows -or $prefs.connectOnStartup) { throw 'Pilot requires startup and automatic connection disabled.' }
    Start-Process powershell.exe -ArgumentList @('-NoProfile','-STA','-File',('"'+(Join-Path $app 'scripts\app.ps1')+'"')) -WorkingDirectory $app -WindowStyle Hidden
    'Dashboard requested. This does NOT start a cloud tunnel; security/account acceptance gates remain.'
}
if ($Action -eq 'Status') {
    $runtime = (& node (Join-Path $app 'scripts\runtime-control.mjs') status) | ConvertFrom-Json
    if ($LASTEXITCODE -ne 0) { throw 'Runtime status failed.' }
    $tunnel = Get-DwbTunnelStatus
    [pscustomobject]@{broker=$runtime.state;tunnel=$tunnel.state;tunnelReady=$tunnel.ready;version=$manifest.version;cloudAcceptance='NOT VERIFIED'} | ConvertTo-Json
}
