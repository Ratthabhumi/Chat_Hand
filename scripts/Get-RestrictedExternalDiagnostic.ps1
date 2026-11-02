[CmdletBinding()]
param()
$ErrorActionPreference='Stop'
$identity=[Security.Principal.WindowsIdentity]::GetCurrent()
$pilot=Get-CimInstance Win32_UserAccount -Filter "LocalAccount=True AND Name='ChatHandPilot'"
if (-not $pilot -or $identity.User.Value -ne $pilot.SID -or 'S-1-5-32-544' -in @($identity.Groups.Value)) {
    '{"status":"BLOCKED_WRONG_IDENTITY","writesPerformed":false}'
    exit 2
}
$bundle=Join-Path $env:ProgramData 'ChatHandPilot-Setup'
$local=[Environment]::GetFolderPath([Environment+SpecialFolder]::LocalApplicationData)
$app=Join-Path $local 'ChatHand\DWB-beta16'
$data=Join-Path $local 'DWB-MCP-Studio-ChatHand'
$external=Join-Path $app 'external'
$checks=[ordered]@{}
$report=[ordered]@{status='DIAGNOSTIC_ONLY';installationRetried=$false;cloudStarted=$false;checks=$checks}
function Probe([string]$Name,[scriptblock]$Read) {
    try { $checks[$Name]=& $Read } catch { $checks[$Name]='UNAVAILABLE_OR_READ_FAILED' }
}
function LockState([string]$Path) {
    if (-not [IO.File]::Exists($Path)) { return 'ABSENT' }
    try {
        $handle=[IO.File]::Open($Path,[IO.FileMode]::Open,[IO.FileAccess]::Read,[IO.FileShare]::None)
        $handle.Dispose()
        return 'EXCLUSIVE_READ_AVAILABLE_NOT_PROOF_OF_STALE_LOCK'
    } catch [IO.IOException] { return 'BUSY_OR_IO_ERROR' }
    catch { return 'ACCESS_OR_OTHER_ERROR' }
}
function SyntheticRead([string]$Path) {
    try { $null=[IO.File]::ReadAllText($Path); return 'FAIL_READABLE' }
    catch {
        $e=$_.Exception
        while ($null -ne $e) {
            if ($e -is [UnauthorizedAccessException]) { return 'ACCESS_DENIED' }
            if ($e -is [IO.FileNotFoundException] -or $e -is [IO.DirectoryNotFoundException]) { return 'MISSING_OR_HIDDEN_PATH_NOT_PASS' }
            $e=$e.InnerException
        }
        return 'OTHER_ERROR_NOT_PASS'
    }
}
Probe sourceIntegrity {
    $archive=Join-Path $bundle 'dwb-windows.zip'
    if ((Get-FileHash -LiteralPath $archive).Hash -ine 'cd94f308829515f9a4e3d381c9f9266859124bfb47f47aeda9992377f0c19de2') { throw 'Archive mismatch' }
    Add-Type -AssemblyName System.IO.Compression.FileSystem
    $zip=[IO.Compression.ZipFile]::OpenRead($archive)
    try {
        foreach ($name in @('setup-install.ps1','external-common.ps1','setup-common.ps1')) {
            $entries=@($zip.Entries | Where-Object { $_.FullName.Replace('\','/') -eq ('scripts/'+$name) })
            if ($entries.Count -ne 1) { throw 'Archive source entry mismatch' }
            $stream=$entries[0].Open()
            $sha=[Security.Cryptography.SHA256]::Create()
            try { $expected=([BitConverter]::ToString($sha.ComputeHash($stream))).Replace('-','') }
            finally { $stream.Dispose(); $sha.Dispose() }
            if ((Get-FileHash -LiteralPath (Join-Path $app ('scripts\'+$name))).Hash -ine $expected) { throw 'Installed source mismatch' }
        }
        'PASS_THREE_SCRIPTS_MATCH_VERIFIED_ARCHIVE'
    } finally { $zip.Dispose() }
}
Probe executionPolicies { @(Get-ExecutionPolicy -List | ForEach-Object { @{scope=[string]$_.Scope;policy=[string]$_.ExecutionPolicy} }) }
Probe nodeVersion {
    $node=(Get-Command node.exe -ErrorAction Stop).Source
    $v=(& $node --version) -join ''
    if ($LASTEXITCODE -eq 0 -and $v -match '^v\d+\.\d+\.\d+$') {$v} else {'INVALID_OR_FAILED'}
}
Probe npmVersion {
    $node=(Get-Command node.exe -ErrorAction Stop).Source
    $npm=Join-Path (Split-Path $node -Parent) 'node_modules\npm\package.json'
    $v=([IO.File]::ReadAllText($npm)|ConvertFrom-Json).version
    if ($v -match '^\d+\.\d+\.\d+$') {$v} else {'UNRECOGNIZED'}
}
Probe processSnapshot {
    $found=@()
    foreach ($p in @(Get-CimInstance Win32_Process -Filter "Name='powershell.exe' OR Name='node.exe' OR Name='tunnel-client.exe' OR Name='pwsh.exe'")) {
        $o=Invoke-CimMethod -InputObject $p -MethodName GetOwner -ErrorAction SilentlyContinue
        $mine=($o.ReturnValue -eq 0 -and $o.User -eq $identity.Name.Split('\')[-1])
        if ($mine -or $o.ReturnValue -ne 0) {
            # Command lines are inspected only in memory; never exported.
            $role=if (-not $mine) {'OWNER_UNRESOLVED'}
                elseif ($p.ProcessId -eq $PID) {'THIS_DIAGNOSTIC'}
                elseif ($p.CommandLine -match 'setup-install\.ps1|Setup-RestrictedPilot\.ps1') {'INSTALLER'}
                elseif ($p.CommandLine -match 'npm-cli\.js.+install') {'NPM_INSTALL'}
                elseif ($p.CommandLine -match 'dwb|desktop-commander|tunnel-client') {'DWB_RELATED'}
                else {'OTHER_PILOT_PROCESS'}
            $found+=@{name=$p.Name;pid=$p.ProcessId;parentPid=$p.ParentProcessId;role=$role;pilotOwner=$mine}
        }
    }
    $found
}
Probe setupLock { LockState (Join-Path $data 'setup.lock') }
Probe externalLock { LockState (Join-Path $external 'install.lock') }
Probe vendorState {
    $phase='ABSENT'
    if ([IO.File]::Exists((Join-Path $data 'phase.txt'))) {
        $raw=[IO.File]::ReadAllText((Join-Path $data 'phase.txt')).Trim()
        $phase=if ($raw -in @('checking','migrating','external','installing','building','runtime','saving','verifying','complete','failed')) {$raw} else {'UNRECOGNIZED'}
    }
    @{phase=$phase;resultPresent=[IO.File]::Exists((Join-Path $data 'result.json'));configPresent=[IO.File]::Exists((Join-Path $data 'config.json'))}
}
Probe externalStaging {
    $items=@(Get-ChildItem -LiteralPath $external -Directory -Force -ErrorAction Stop)
    @($items | ForEach-Object {
        $kind=if ($_.Name -match '^\.install-worker-[a-f0-9]{32}$') {'WORKER_STAGING'}
            elseif ($_.Name -match '^\.install-tunnel-[a-f0-9]{32}$') {'TUNNEL_STAGING'}
            elseif ($_.Name -eq 'desktop-commander') {'MANAGED_WORKER'}
            elseif ($_.Name -eq 'tunnel-client') {'MANAGED_TUNNEL'} else {'OTHER_DIRECTORY'}
        $reparse=[bool]($_.Attributes -band [IO.FileAttributes]::ReparsePoint)
        $v='ABSENT_OR_NOT_READ'
        if (-not $reparse -and $kind -in @('WORKER_STAGING','MANAGED_WORKER')) {
            $pkg=Join-Path $_.FullName 'node_modules\@wonderwhy-er\desktop-commander\package.json'
            if ([IO.File]::Exists($pkg)) {
                $value=([IO.File]::ReadAllText($pkg)|ConvertFrom-Json).version
                $v=if ($value -eq '0.2.50') {'EXPECTED_0.2.50'} else {'UNEXPECTED_VERSION'}
            }
        }
        @{kind=$kind;reparsePoint=$reparse;workerVersion=$v;lastWriteUtc=$_.LastWriteTimeUtc.ToString('o')}
    })
}
Probe tunnelFile {
    $file=Join-Path $external 'tunnel-client\tunnel-client.exe'
    $digest=if ([IO.File]::Exists($file)) {(Get-FileHash -LiteralPath $file).Hash} else {$null}
    @{present=[IO.File]::Exists($file);sha256=$digest;executed=$false;version='NOT_EXECUTED_NOT_VERIFIED'}
}
Probe npmDebugLog {
    # Known default cache only; do not inspect custom credential-bearing npm config.
    $logs=Join-Path $local 'npm-cache\_logs'
    if (-not [IO.Directory]::Exists($logs)) { return 'DEFAULT_CACHE_LOGS_ABSENT' }
    $latest=Get-ChildItem -LiteralPath $logs -Filter '*debug*.log' -File | Sort-Object LastWriteTimeUtc -Descending | Select-Object -First 1
    if (-not $latest) { return 'NO_DEBUG_LOG' }
    $text=(Get-Content -LiteralPath $latest.FullName -Tail 120) -join "`n"
    $exits=@([regex]::Matches($text,'(?m)^\d+\s+(?:verbose\s+)?exit\s+(-?\d+)\s*$') | ForEach-Object {$_.Groups[1].Value})
    $codes=@(@('EACCES','EPERM','ENOTFOUND','ETIMEDOUT','ECONNRESET','CERT_HAS_EXPIRED','SELF_SIGNED_CERT_IN_CHAIN','EINTEGRITY','ENOSPC') | Where-Object {$text -match ('\b'+$_+'\b')})
    @{lastWriteUtc=$latest.LastWriteTimeUtc.ToString('o');exitCodes=$exits;knownErrorCodes=$codes;correlation='Latest default-cache log may belong to another npm operation; not installation proof'}
}
Probe privateLog {
    $file=Join-Path $data 'setup-private.log'
    $info=Get-Item -LiteralPath $file -ErrorAction Stop
    # Bound memory use; don't export any line or exception text.
    $text=(Get-Content -LiteralPath $file -Tail 120 -ErrorAction Stop) -join "`n"
    $signals=@(@{
        NATIVE_STDERR='NativeCommandError|RemoteException'
        NPM_WARNING='npm warn|npm WARN|deprecated'
        NPM_ERROR='npm ERR!|npm error'
        EXECUTION_POLICY='PSSecurityException|running scripts is disabled|not digitally signed'
        NETWORK='ENOTFOUND|ETIMEDOUT|ECONN|certificate|SSL|TLS'
        PERMISSION='UnauthorizedAccess|Access.+denied|EACCES|EPERM'
        NODE_FAILURE='FATAL ERROR|out of memory|ERR_DLOPEN_FAILED|node-gyp'
    }.GetEnumerator() | Where-Object {$text -match $_.Value} | ForEach-Object {$_.Key})
    @{bytes=$info.Length;lastWriteUtc=$info.LastWriteTimeUtc.ToString('o');tailSignals=$signals}
}
Probe originalSyntheticFixture {
    $inputData=[IO.File]::ReadAllText((Join-Path $bundle 'private-inputs.json'))|ConvertFrom-Json
    SyntheticRead $inputData.protectedSyntheticFixture
}
Probe neutralProtectedSyntheticFixture { SyntheticRead (Join-Path $bundle 'protected-synthetic-v33.txt') }
Probe publicSyntheticFixture {
    if ([IO.File]::ReadAllText((Join-Path $bundle 'public-synthetic-v33.txt')) -ceq 'ChatHand harmless public fixture') {'PASS'} else {'FAIL'}
}
$report.interpretation='Snapshot only: no-active-process and available locks do not prove why the prior installer exited. No timeout/crash/root cause inferred automatically.'
$json=$report|ConvertTo-Json -Depth 7
$json
[IO.File]::WriteAllText((Join-Path $bundle 'results\external-diagnostic-v33.json'),$json)
