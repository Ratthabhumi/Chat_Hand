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
$env:LOCALAPPDATA=$local
foreach ($name in @([Environment]::GetEnvironmentVariables('Process').Keys)) {
    if ($name -match '^(DWB_|CONTROL_PLANE_|TUNNEL_CLIENT_|HARPOON_)' -or $name -in @('OPENAI_API_KEY','GH_TOKEN','GITHUB_TOKEN','ANTHROPIC_API_KEY','GOOGLE_API_KEY','SSH_AUTH_SOCK')) {
        [Environment]::SetEnvironmentVariable($name,$null,'Process')
    }
}
$app=Join-Path $local 'ChatHand\DWB-beta16'
$data=Join-Path $local 'DWB-MCP-Studio-ChatHand'
$workspace=Join-Path $local 'ChatHandPilot\Sandbox'
$env:DWB_DATA_DIR=$data
$env:DWB_CONFIG_FILE=Join-Path $data 'config.json'
$resultPath=Join-Path $bundle 'results\repair-v34-result.json'
if (Test-Path -LiteralPath $resultPath) { $resultPath=Join-Path $bundle ('results\repair-v34-repeat-refused-'+[guid]::NewGuid().ToString('N')+'.json') }
$report=[ordered]@{status='BLOCKED';stage='preflight';rootCause='UNKNOWN';identityIsPilot=$true;cloudStarted=$false;checks=[ordered]@{};installerAttempts=0}
$handles=@()
$gate=$null
function Save-Report { [IO.File]::WriteAllText($resultPath,($report|ConvertTo-Json -Depth 6)) }
function Invoke-PrivateNode([string[]]$NodeArgs) {
    $info=[Diagnostics.ProcessStartInfo]::new()
    $info.FileName=$machine.Node
    $info.Arguments=($NodeArgs|ForEach-Object {ConvertTo-DwbArgument $_}) -join ' '
    $info.UseShellExecute=$false; $info.CreateNoWindow=$true
    $info.RedirectStandardOutput=$true; $info.RedirectStandardError=$true
    $p=[Diagnostics.Process]::Start($info)
    try {
        $stdout=$p.StandardOutput.ReadToEndAsync();$stderr=$p.StandardError.ReadToEndAsync()
        if (-not $p.WaitForExit(60000)) {
            $report.checks.unfinishedNodePid=$p.Id
            throw 'Local admin CLI wait expired; no kill or retry'
        }
        [IO.File]::AppendAllText((Join-Path $data 'repair-v34-node-private.log'),$stderr.GetAwaiter().GetResult())
        if ($p.ExitCode -ne 0) {
            [IO.File]::AppendAllText((Join-Path $data 'repair-v34-node-private.log'),$stdout.GetAwaiter().GetResult())
            throw 'Local admin CLI failed'
        }
        $stdout.GetAwaiter().GetResult()|ConvertFrom-Json
    } finally {$p.Dispose()}
}
function Assert-NoLinks([string]$Path) {
    $p=[IO.Path]::GetFullPath($Path)
    while ($p -and $p.Length -ge $local.Length) {
        if ((Test-Path -LiteralPath $p) -and ((Get-Item -LiteralPath $p -Force).Attributes -band [IO.FileAttributes]::ReparsePoint)) { throw 'Reparse path blocked' }
        $p=Split-Path $p -Parent
    }
}
try {
    foreach ($path in @($app,$data,$workspace)) {
        Assert-NoLinks $path
        $sid=([Security.Principal.NTAccount](Get-Acl -LiteralPath $path).Owner).Translate([Security.Principal.SecurityIdentifier]).Value
        if ($sid -ne $identity.User.Value) { throw 'Ownership mismatch' }
    }
    $gate=[IO.File]::Open((Join-Path $data 'repair-v34.lock'),'OpenOrCreate','ReadWrite','None')
    if (Test-Path -LiteralPath (Join-Path $data 'repair-v34-attempt.json')) { throw 'Recovery already attempted; inspect evidence, never retry automatically' }
    $report.stage='release-source-integrity'
    # Verify all original release files before sourcing/executing vendor code.
    $archive=Join-Path $bundle 'dwb-windows.zip'
    if ((Get-FileHash -LiteralPath $archive).Hash -ine 'cd94f308829515f9a4e3d381c9f9266859124bfb47f47aeda9992377f0c19de2') { throw 'Archive mismatch' }
    Add-Type -AssemblyName System.IO.Compression.FileSystem
    $zip=[IO.Compression.ZipFile]::OpenRead($archive)
    try {
        $count=0
        foreach ($entry in $zip.Entries) {
            if (-not $entry.Name) { continue }
            $path=[IO.Path]::GetFullPath((Join-Path $app $entry.FullName))
            if (-not $path.StartsWith($app+'\',[StringComparison]::OrdinalIgnoreCase)) { throw 'Archive escape' }
            Assert-NoLinks $path
            $stream=$entry.Open(); $sha=[Security.Cryptography.SHA256]::Create()
            try {$hash=([BitConverter]::ToString($sha.ComputeHash($stream))).Replace('-','')} finally {$stream.Dispose();$sha.Dispose()}
            if ((Get-FileHash -LiteralPath $path).Hash -ine $hash) { throw 'Original source changed; stop without patching' }
            $count++
        }
        $report.checks.releaseFilesMatched=$count
    } finally {$zip.Dispose()}
    $report.stage='payload-and-helper-integrity'
    $manifest=Get-Content -LiteralPath (Join-Path $bundle 'payload-manifest.json') -Raw|ConvertFrom-Json
    foreach ($entry in $manifest.files) {
        $path=[IO.Path]::GetFullPath((Join-Path $bundle $entry.path))
        if (-not $path.StartsWith($bundle+'\',[StringComparison]::OrdinalIgnoreCase) -or (Get-FileHash -LiteralPath $path).Hash -ine $entry.sha256) { throw 'Payload mismatch' }
    }
    $helper=Join-Path $bundle 'scripts\Invoke-PilotVendorSetup.ps1'
    if ((Get-FileHash -LiteralPath $helper).Hash -ine 'B46D13FC95F8B3B3F9B4CF79A822314BB94D440840BDB2CDBE4DFEB63B9F41F0') { throw 'Recovery helper mismatch' }
    . (Join-Path $app 'scripts\external-common.ps1')
    $report.stage='node-and-existing-request'
    $machine=Get-DwbMachineState
    if (-not $machine.NodeReady -or -not $machine.NpmReady) { throw 'Node/npm not ready' }
    $request=Get-Content -LiteralPath (Join-Path $data 'pilot-setup-request.json') -Raw|ConvertFrom-Json
    $prefs=Get-Content -LiteralPath (Join-Path $data 'preferences.json') -Raw|ConvertFrom-Json
    if ($request.workspace -cne $workspace -or $request.workerCap -ne 1 -or $prefs.startWithWindows -or $prefs.connectOnStartup -or (Test-Path -LiteralPath $env:DWB_CONFIG_FILE)) { throw 'Unexpected configuration; no overwrite' }
    # Only relevant processes owned by this pilot can share its private install.
    # Other-user unresolved owners do not establish global process absence.
    $report.stage='pilot-process-conflicts'
    foreach ($p in @(Get-CimInstance Win32_Process -Filter "Name='powershell.exe' OR Name='pwsh.exe' OR Name='node.exe' OR Name='tunnel-client.exe'")) {
        if ($p.ProcessId -eq $PID) { continue }
        $owner=Invoke-CimMethod -InputObject $p -MethodName GetOwner -ErrorAction SilentlyContinue
        if ($owner.ReturnValue -eq 0 -and $owner.User -eq $identity.Name.Split('\')[-1]) {
            if (-not $p.CommandLine -or $p.Name -in @('node.exe','tunnel-client.exe') -or $p.CommandLine -match 'setup-install|Setup-RestrictedPilot|Repair-RestrictedExternal|Invoke-PilotVendorSetup|dwb|desktop-commander') { throw 'Pilot installer/runtime conflict; no kill or retry' }
        }
    }
    $paths=Get-DwbExternalPaths
    $report.stage='vendor-locks'
    foreach ($lock in @((Join-Path $data 'setup.lock'),(Join-Path $paths.Root 'install.lock'))) {
        $handles+=,[IO.File]::Open($lock,'Open','ReadWrite','None')
    }
    $report.checks.pilotConflicts='NONE_IDENTIFIED; vendor locks held during promotion'
    $report.stage='staging-readiness-and-lock-pin'
    $candidates=@(Get-ChildItem -LiteralPath $paths.Root -Directory -Force | Where-Object Name -match '^\.install-worker-[a-f0-9]{32}$')
    if ($candidates.Count -ne 1 -or (Test-Path -LiteralPath $paths.WorkerRoot) -or (Test-Path -LiteralPath $paths.TunnelRoot)) { throw 'Unexpected staging/target state' }
    $staging=$candidates[0].FullName
    if (@(Get-ChildItem -LiteralPath $staging -Recurse -Force | Where-Object {$_.Attributes -band [IO.FileAttributes]::ReparsePoint}).Count) { throw 'Staged reparse point' }
    Assert-DwbExternalPath $staging
    $worker=Get-DwbWorkerState (Join-Path $staging 'node_modules\@wonderwhy-er\desktop-commander\dist\index.js')
    if (-not $worker.Ready) { throw 'Vendor worker readiness failed' }
    $lock=Get-Content -LiteralPath (Join-Path $staging 'package-lock.json') -Raw|ConvertFrom-Json
    $pin=$lock.packages.'node_modules/@wonderwhy-er/desktop-commander'
    if ($pin.version -ne '0.2.50' -or $pin.resolved -ne 'https://registry.npmjs.org/@wonderwhy-er/desktop-commander/-/desktop-commander-0.2.50.tgz' -or $pin.integrity -notmatch '^sha512-[A-Za-z0-9+/]+=*$') { throw 'Staged package lock mismatch' }
    $report.checks.stagedWorker='PASS_VENDOR_READINESS_AND_LOCK_PIN; not full dependency content audit'
    $report.checks.stageLockSha256=(Get-FileHash (Join-Path $staging 'package-lock.json')).Hash
    $report.stage='promote-verified-staging'
    # Persistent one-attempt record precedes the first modification of staging.
    $invocationId=[guid]::NewGuid().ToString('N')
    [IO.File]::WriteAllText((Join-Path $data 'repair-v34-attempt.json'),(@{attempt=1;automaticRetryAllowed=$false;invocationId=$invocationId}|ConvertTo-Json))
    Save-Report
    Move-Item -LiteralPath $staging -Destination $paths.WorkerRoot
    if (-not (Get-DwbManagedWorkerState).Ready) { throw 'Promoted worker failed vendor check' }
    $report.checks.workerPromotion='PASS; moved original staging, no copy/reinstall/deletion'
    foreach ($h in $handles) {$h.Dispose()}; $handles=@()
    $report.stage='vendor-setup-once'; $report.installerAttempts=1; Save-Report
    $info=[Diagnostics.ProcessStartInfo]::new()
    $info.FileName=Join-Path $PSHOME 'powershell.exe'
    $info.Arguments='-NoProfile -ExecutionPolicy RemoteSigned -File '+(ConvertTo-DwbArgument $helper)+' -InvocationId '+$invocationId
    $info.UseShellExecute=$false; $info.CreateNoWindow=$true
    $child=[Diagnostics.Process]::Start($info)
    try {
        if (-not $child.WaitForExit(1200000)) {
            $report.status='IN_PROGRESS_STOP_NO_RETRY'; $report.checks.childPid=$child.Id
            throw 'Twenty-minute wait expired; child retained, never force-killed'
        }
        $report.checks.vendorExitCode=$child.ExitCode
        if ($child.ExitCode -ne 0) { throw 'Vendor setup failed; preserve logs and stop' }
    } finally {$child.Dispose()}
    $report.stage='verify-installation'
    $vendor=Get-Content -LiteralPath (Join-Path $data 'result.json') -Raw|ConvertFrom-Json
    $cfg=Get-Content -LiteralPath $env:DWB_CONFIG_FILE -Raw|ConvertFrom-Json
    Assert-NoLinks $cfg.basePolicy
    $policy=Get-Content -LiteralPath $cfg.basePolicy -Raw|ConvertFrom-Json
    if (-not $vendor.ok -or $cfg.workerCap -ne 1 -or $cfg.workspace -cne $workspace -or @($policy.allowedDirectories).Count -ne 1 -or $policy.allowedDirectories[0] -cne $workspace) { throw 'Vendor result or isolation config failed' }
    $doctor=Invoke-PrivateNode -NodeArgs @((Join-Path $app 'scripts\doctor.mjs'))
    if (-not $doctor.ok) { throw 'Doctor failed' }
    $report.checks.installation='PASS vendor result/doctor/exact workspace/workerCap; runtime not started'
    $report.checks.managedWorker='0.2.50 vendor validated'
    $report.checks.managedTunnel='0.0.11 verified by vendor setup; no hosted connection'
    $report.stage='import-seven-skills'
    $skills=Get-Content -LiteralPath (Join-Path $bundle 'config\dwb-skills.lock.json') -Raw|ConvertFrom-Json
    $snapshot=Invoke-PrivateNode -NodeArgs @((Join-Path $app 'scripts\skills-admin.mjs'),'snapshot')
    foreach ($skill in $skills.skills) {
        $existing=@($snapshot.result.skills|Where-Object id -eq $skill.id)
        if ($existing.Count) {
            if ($existing.Count -ne 1 -or $existing[0].contentHash -ne $skill.installedContentHash -or $existing[0].policy -ne $skill.policy) {throw 'Skill drift; no overwrite'}
        } else {
            $import=Invoke-PrivateNode -NodeArgs @((Join-Path $app 'scripts\skills-admin.mjs'),'install-local',(Join-Path $bundle ('skills\'+$skill.id)),$skill.policy)
            if ($import.result.contentHash -ne $skill.installedContentHash) {throw 'Skill import failed'}
        }
    }
    $post=Invoke-PrivateNode -NodeArgs @((Join-Path $app 'scripts\skills-admin.mjs'),'snapshot')
    if (@($post.result.skills).Count -ne 7) {throw 'Unexpected skill collection'}
    $expected=@{}; foreach ($s in $skills.skills) {$expected[$s.id]=$s}
    foreach ($s in $post.result.skills) {if ($s.policy -ne $expected[$s.id].policy -or $s.contentHash -ne $expected[$s.id].installedContentHash) {throw 'Post-import mismatch'}}
    foreach ($entry in $post.result.workspacePolicies.PSObject.Properties) {
        foreach ($s in $entry.Value.PSObject.Properties) {if (-not $expected.ContainsKey($s.Name) -or $s.Value -ne $expected[$s.Name].policy) {throw 'Workspace policy mismatch'}}
    }
    $prefs=Get-Content -LiteralPath (Join-Path $data 'preferences.json') -Raw|ConvertFrom-Json
    if ($prefs.startWithWindows -or $prefs.connectOnStartup) {throw 'Startup changed; stop'}
    $report.checks.skills='PASS seven pinned hashes/defaults/overrides; activation and restart NOT TESTED'
    $report.checks.security='BLOCKED: process tools, residual risk, dependencies and runtime/reliability acceptance unresolved'
    $report.checks.hostedChat='NOT TESTED; cloud OFF'
    $report.status='PARTIAL'; $report.stage='local-installation-and-import-only'
} catch {
    $report.error='Stopped at reported stage. Private v34 logs and original evidence retained. No automatic retry.'
    # Export only numeric/type diagnostics, never exception text or paths.
    $report.errorHResult=$_.Exception.HResult
} finally {
    foreach ($h in $handles) {$h.Dispose()}
    if ($gate) {$gate.Dispose()}
    Save-Report
    $report|ConvertTo-Json -Depth 6
}
if ($report.status -ne 'PARTIAL') {exit 1}
