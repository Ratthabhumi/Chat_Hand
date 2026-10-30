[CmdletBinding()]
param([string]$InvocationId='')
$ErrorActionPreference='Stop'
$identity=[Security.Principal.WindowsIdentity]::GetCurrent()
$pilot=Get-CimInstance Win32_UserAccount -Filter "LocalAccount=True AND Name='ChatHandPilot'"
if (-not $pilot -or $identity.User.Value -ne $pilot.SID -or 'S-1-5-32-544' -in @($identity.Groups.Value)) {
    '{"status":"BLOCKED_WRONG_IDENTITY","writesPerformed":false}'
    exit 2
}
$local=[Environment]::GetFolderPath([Environment+SpecialFolder]::LocalApplicationData)
$data=Join-Path $local 'DWB-MCP-Studio-ChatHand'
$app=Join-Path $local 'ChatHand\DWB-beta16'
if (-not $InvocationId -or $InvocationId -notmatch '^[a-f0-9]{32}$') { exit 3 }
$attempt=Get-Content -LiteralPath (Join-Path $data 'repair-v34-attempt.json') -Raw|ConvertFrom-Json
if ($attempt.invocationId -cne $InvocationId) {exit 3}
$once=[IO.File]::Open((Join-Path $data 'repair-v34-helper-started.json'),'CreateNew','Write','None')
$once.Dispose()
$env:DWB_DATA_DIR=$data
$env:DWB_CONFIG_FILE=Join-Path $data 'config.json'
# Independent child owns its log handles even if parent times out. No native
# PowerShell all-stream redirection boundary and no raw output to the caller.
$out=[IO.StreamWriter]::new((Join-Path $data 'repair-v34-console-private.log'),$false)
$out.AutoFlush=$true
[Console]::SetOut($out)
[Console]::SetError($out)
try {
    $global:LASTEXITCODE=0
    & (Join-Path $app 'scripts\setup-install.ps1') -RequestFile (Join-Path $data 'pilot-setup-request.json') *> (Join-Path $data 'repair-v34-streams-private.log')
    if ($LASTEXITCODE -ne 0) {exit $LASTEXITCODE}
} catch {
    $out.WriteLine($_.Exception.ToString())
    exit 1
} finally { $out.Dispose() }
