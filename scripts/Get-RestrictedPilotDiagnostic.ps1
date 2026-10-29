[CmdletBinding()]
param()
$ErrorActionPreference = 'Stop'
$identity = [Security.Principal.WindowsIdentity]::GetCurrent()
$pilot = Get-CimInstance Win32_UserAccount -Filter "LocalAccount=True AND Name='ChatHandPilot'"
if (-not $pilot -or $identity.User.Value -ne $pilot.SID -or 'S-1-5-32-544' -in @($identity.Groups.Value)) {
    '{"status":"BLOCKED_WRONG_IDENTITY","writesPerformed":false}'
    exit 2
}
# Reads existing files only; no installer, runtime, network, secrets or raw log output.
$bundle = Join-Path $env:ProgramData 'ChatHandPilot-Setup'
$local = [Environment]::GetFolderPath([Environment+SpecialFolder]::LocalApplicationData)
$data = Join-Path $local 'DWB-MCP-Studio-ChatHand'
$app = Join-Path $local 'ChatHand\DWB-beta16'
$report = [ordered]@{status='DIAGNOSTIC_ONLY';installationRetried=$false;cloudStarted=$false;checks=[ordered]@{}}
try {
    $report.checks.nodeCommandAvailable = [bool](Get-Command node.exe -ErrorAction SilentlyContinue)
    $report.checks.appPackagePresent = [IO.File]::Exists((Join-Path $app 'package.json'))
    $report.checks.configurationPresent = [IO.File]::Exists((Join-Path $data 'config.json'))
    $phase = Join-Path $data 'phase.txt'
    if ([IO.File]::Exists($phase)) {
        $value = [IO.File]::ReadAllText($phase).Trim()
        $report.checks.vendorPhase = if ($value -in @('checking','migrating','external','installing','building','runtime','saving','verifying','complete','failed')) {$value} else {'UNRECOGNIZED'}
    }
    $result = Join-Path $data 'result.json'
    $report.checks.vendorResultPresent = [IO.File]::Exists($result)
    if ([IO.File]::Exists($result)) {
        $vendor = [IO.File]::ReadAllText($result) | ConvertFrom-Json
        $report.checks.vendorSetupOk = ($vendor.ok -eq $true)
        # Only fixed classifications leave this profile. Never export the message.
        $message = [string]$vendor.message
        $report.checks.vendorErrorClass = if ($vendor.ok -eq $true) {'NONE'}
            elseif ($message -match 'Node.js 22.16') {'NODE_OR_NPM_NOT_READY'}
            elseif ($message -match 'Access.*denied|UnauthorizedAccess|permission denied|EACCES|EPERM') {'ACCESS_DENIED'}
            elseif ($message -match 'ENOTFOUND|ETIMEDOUT|ECONN|certificate|SSL|TLS') {'NETWORK_OR_CERTIFICATE'}
            elseif ($message -match 'DWB_UPGRADE_BUSY') {'RUNTIME_BUSY'}
            else {'UNCLASSIFIED_PRIVATE_ERROR'}
    }
    $log = Join-Path $data 'setup-private.log'
    $report.checks.privateLogPresent = [IO.File]::Exists($log)
    if ([IO.File]::Exists($log)) {
        $text = [IO.File]::ReadAllText($log)
        $report.checks.logSignals = @(@{
            EXECUTION_POLICY='PSSecurityException|running scripts is disabled|not digitally signed'
            NODE_OR_NPM='Install Node.js 22.16|node.+not recognized'
            ACCESS_DENIED='UnauthorizedAccess|Access.+denied|EACCES|EPERM'
            NETWORK_OR_CERTIFICATE='ENOTFOUND|ETIMEDOUT|ECONN|certificate|SSL|TLS'
        }.GetEnumerator() | Where-Object { $text -match $_.Value } | ForEach-Object { $_.Key })
    }
    $inputs = [IO.File]::ReadAllText((Join-Path $bundle 'private-inputs.json')) | ConvertFrom-Json
    try {
        $null = [IO.File]::ReadAllText($inputs.protectedSyntheticFixture)
        $report.checks.primarySyntheticFixtureDenied='FAIL'
    } catch {
        # PowerShell wraps .NET method exceptions; inspect the complete inner chain.
        $errorNode=$_.Exception
        $denied=$false
        $missing=$false
        while ($null -ne $errorNode) {
            if ($errorNode -is [UnauthorizedAccessException]) { $denied=$true }
            if ($errorNode -is [IO.FileNotFoundException] -or $errorNode -is [IO.DirectoryNotFoundException]) { $missing=$true }
            $errorNode=$errorNode.InnerException
        }
        $report.checks.primarySyntheticFixtureDenied = if ($denied) {'PASS'} elseif ($missing) {'NOT_VERIFIED_MISSING_PATH'} else {'NOT_VERIFIED_OTHER_ERROR'}
    }
} catch {
    $report.status='DIAGNOSTIC_INCOMPLETE'
    $report.error='Private diagnostic read failed; no raw error exported.'
}
$json=$report | ConvertTo-Json -Depth 5
$json
[IO.File]::WriteAllText((Join-Path $bundle 'results\pilot-diagnostic.json'),$json)
