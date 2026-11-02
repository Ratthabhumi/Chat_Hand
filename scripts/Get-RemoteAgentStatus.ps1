[CmdletBinding()]
param()
$ErrorActionPreference = 'Stop'
# Presence is not proof of connector readiness or directory confinement.
$agents = @(Get-CimInstance Win32_Process | Where-Object {
    $_.Name -eq 'node.exe' -and
    $_.CommandLine -match '@wonderwhy-er[/\\]desktop-commander' -and
    $_.CommandLine -match '\sremote(?:\s|$)'
})
[pscustomobject]@{
    observedUtc = [DateTime]::UtcNow.ToString('o')
    localRemoteProcessCount = $agents.Count
    processIds = @($agents | ForEach-Object { $_.ProcessId })
    countScope = 'Matching processes may include npm/npx wrappers; this is not a device or worker count'
    action = if ($agents.Count) { 'Do not start another instance. Check connector device presence and actual file tools.' }
             else { 'No matching local process. Inspect pinned installation and existing saved session before manual start.' }
    connectorReadiness = 'NOT CHECKED by this local process inventory'
    credentialsRead = $false
} | ConvertTo-Json -Depth 3
