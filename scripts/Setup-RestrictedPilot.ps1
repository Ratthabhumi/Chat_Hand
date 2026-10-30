[CmdletBinding()]
param([string]$BundleRoot = '')
$ErrorActionPreference = 'Stop'
# This guard precedes all writes, extraction, network access and child processes.
$identity = [Security.Principal.WindowsIdentity]::GetCurrent()
$pilot = Get-CimInstance Win32_UserAccount -Filter "LocalAccount=True AND Name='ChatHandPilot'"
if (-not $pilot -or $identity.User.Value -ne $pilot.SID -or
    'S-1-5-32-544' -in @($identity.Groups.Value)) {
    [pscustomobject]@{status='BLOCKED_WRONG_IDENTITY';required='Run in the existing non-administrator pilot account';passwordRequiredByScript=$false;writesPerformed=$false} | ConvertTo-Json
    exit 2
}
if (-not $BundleRoot) { $BundleRoot = Split-Path $PSScriptRoot -Parent }
foreach ($name in @([Environment]::GetEnvironmentVariables('Process').Keys)) {
    if ($name -match '^(DWB_|CONTROL_PLANE_|TUNNEL_CLIENT_|HARPOON_)' -or $name -in @('OPENAI_API_KEY','GH_TOKEN','GITHUB_TOKEN','ANTHROPIC_API_KEY','GOOGLE_API_KEY','SSH_AUTH_SOCK')) {
        [Environment]::SetEnvironmentVariable($name,$null,'Process')
    }
}
$local = [Environment]::GetFolderPath([Environment+SpecialFolder]::LocalApplicationData)
$env:LOCALAPPDATA = $local
$stage = 'verify-payload'
$report = [ordered]@{status='PARTIAL';identityIsPilot=$true;administratorTokenPresent=$false;cloudStarted=$false;credentialsCopied=$false;tests=[ordered]@{}}
$data = Join-Path $local 'DWB-MCP-Studio-ChatHand'
try {
    $manifest = Get-Content -LiteralPath (Join-Path $BundleRoot 'payload-manifest.json') -Raw | ConvertFrom-Json
    foreach ($entry in $manifest.files) {
        $file = [IO.Path]::GetFullPath((Join-Path $BundleRoot $entry.path))
        if (-not $file.StartsWith(([IO.Path]::GetFullPath($BundleRoot).TrimEnd('\')+'\'),[StringComparison]::OrdinalIgnoreCase)) { throw 'Payload path escapes bundle.' }
        if ((Get-FileHash -LiteralPath $file -Algorithm SHA256).Hash -ine $entry.sha256) { throw 'Payload integrity mismatch.' }
    }
    $archive = Join-Path $BundleRoot 'dwb-windows.zip'
    if ((Get-FileHash -LiteralPath $archive).Hash -ine 'cd94f308829515f9a4e3d381c9f9266859124bfb47f47aeda9992377f0c19de2') { throw 'Release checksum mismatch.' }
    $report.tests.payloadIntegrity='PASS'
    $stage = 'os-fixture-tests'
    $inputs = Get-Content -LiteralPath (Join-Path $BundleRoot 'private-inputs.json') -Raw | ConvertFrom-Json
    try {
        $null = [IO.File]::ReadAllText($inputs.protectedSyntheticFixture)
        $report.tests.primarySyntheticFixtureDenied='FAIL'
    } catch [UnauthorizedAccessException] { $report.tests.primarySyntheticFixtureDenied='PASS' }
    catch { $report.tests.primarySyntheticFixtureDenied='NOT VERIFIED: unexpected filesystem error' }
    $workspace = Join-Path $env:LOCALAPPDATA 'ChatHandPilot\Sandbox'
    $null = New-Item -ItemType Directory -Path $workspace -Force
    $hello = Join-Path $workspace 'hello.txt'
    if (-not (Test-Path -LiteralPath $hello)) { [IO.File]::WriteAllText($hello,'Chat_Hand sandbox: synthetic data only. No production access authorized.') }
    $probe = Join-Path $workspace ('probe-'+[guid]::NewGuid().ToString('N')+'.txt')
    try {
        [IO.File]::WriteAllText($probe,'synthetic-pilot-file')
        if ([IO.File]::ReadAllText($probe) -cne 'synthetic-pilot-file') { throw 'Local I/O mismatch.' }
    } finally { if (Test-Path -LiteralPath $probe) { Remove-Item -LiteralPath $probe } }
    $report.tests.localSyntheticReadWriteCleanup='PASS (Windows file I/O, not MCP)'
    $stage = 'setup-dwb'
    $app = Join-Path $env:LOCALAPPDATA 'ChatHand\DWB-beta16'
    $env:DWB_DATA_DIR=$data
    $env:DWB_CONFIG_FILE=Join-Path $data 'config.json'
    if (-not (Test-Path -LiteralPath $app)) { Expand-Archive -LiteralPath $archive -DestinationPath $app }
    $pkg=Get-Content -LiteralPath (Join-Path $app 'package.json') -Raw | ConvertFrom-Json
    if ($pkg.name -ne 'dwb-mcp-studio-core' -or $pkg.version -ne '0.1.0-beta.16') { throw 'Unexpected installation; left unchanged.' }
    $null=New-Item -ItemType Directory -Path $data -Force
    $prefs=Join-Path $data 'preferences.json'
    if (-not (Test-Path -LiteralPath $prefs)) { [IO.File]::WriteAllText($prefs,'{"startWithWindows":false,"connectOnStartup":false,"minimizeToTray":false,"closeAction":"exit"}') }
    $request=Join-Path $data 'pilot-setup-request.json'
    [IO.File]::WriteAllText($request,(@{workspace=$workspace;workerCap=1}|ConvertTo-Json))
    if (-not (Test-Path -LiteralPath $env:DWB_CONFIG_FILE)) {
        & powershell.exe -NoProfile -File (Join-Path $app 'scripts\setup-install.ps1') -RequestFile $request *> (Join-Path $data 'setup-private.log')
        if ($LASTEXITCODE -ne 0) { throw 'Setup failed; inspect private setup log, do not reinstall in a loop.' }
    }
    $cfg=Get-Content -LiteralPath $env:DWB_CONFIG_FILE -Raw | ConvertFrom-Json
    $policy=Get-Content -LiteralPath $cfg.basePolicy -Raw | ConvertFrom-Json
    $preferences=Get-Content -LiteralPath $prefs -Raw | ConvertFrom-Json
    if ($cfg.workerCap -ne 1 -or $cfg.workspace -ne $workspace -or @($policy.allowedDirectories).Count -ne 1 -or $policy.allowedDirectories[0] -ne $workspace -or $preferences.startWithWindows -or $preferences.connectOnStartup) { throw 'Existing policy differs; review without overwriting.' }
    $report.tests.isolatedSetupPolicy='PASS'
    foreach ($ownedPath in @($app,$data,$workspace)) {
        $ownerSid=([Security.Principal.NTAccount](Get-Acl -LiteralPath $ownedPath).Owner).Translate([Security.Principal.SecurityIdentifier]).Value
        if ($ownerSid -ne $identity.User.Value) { throw 'Pilot runtime/data/workspace ownership mismatch.' }
    }
    $report.tests.runtimeDataWorkspaceOwnedByPilot='PASS (NTFS owner, not live process-owner evidence)'
    $stage='import-reviewed-skills'
    $lock=Get-Content -LiteralPath (Join-Path $BundleRoot 'config\dwb-skills.lock.json') -Raw | ConvertFrom-Json
    $snapshot=(& node (Join-Path $app 'scripts\skills-admin.mjs') snapshot 2> (Join-Path $data 'skills-private.log')) | ConvertFrom-Json
    if ($LASTEXITCODE -ne 0) { throw 'Cannot inspect skill state.' }
    foreach ($skill in $lock.skills) {
        $existing=@($snapshot.result.skills | Where-Object id -eq $skill.id)
        if ($existing.Count) {
            if ($existing[0].contentHash -ne $skill.installedContentHash -or $existing[0].policy -ne $skill.policy) { throw 'Skill drift; existing package retained for review.' }
            continue
        }
        $source=Join-Path $BundleRoot ('skills\'+$skill.id)
        $result=(& node (Join-Path $app 'scripts\skills-admin.mjs') install-local $source $skill.policy 2> (Join-Path $data 'skills-private.log')) | ConvertFrom-Json
        if ($LASTEXITCODE -ne 0 -or $result.result.contentHash -ne $skill.installedContentHash) { throw 'Skill import mismatch.' }
    }
    $post=(& node (Join-Path $app 'scripts\skills-admin.mjs') snapshot 2> (Join-Path $data 'skills-private.log')) | ConvertFrom-Json
    if ($LASTEXITCODE -ne 0 -or @($post.result.skills).Count -ne @($lock.skills).Count) { throw 'Unexpected skill collection; left for review.' }
    $expectedPolicies=@{}
    foreach ($skill in $lock.skills) { $expectedPolicies[$skill.id]=$skill.policy }
    foreach ($skill in $post.result.skills) { if ($skill.policy -ne $expectedPolicies[$skill.id]) { throw 'Default skill policy mismatch.' } }
    foreach ($entry in $post.result.workspacePolicies.PSObject.Properties) {
        foreach ($item in $entry.Value.PSObject.Properties) { if ($item.Value -ne $expectedPolicies[$item.Name]) { throw 'Workspace skill override differs from manifest.' } }
    }
    $report.tests.reviewedSkillsImported='PASS: source/hash/default policy only; no activation or model test'
    $report.tests.mcpProcessOwners='NOT TESTED: broker, worker, Dashboard and Tunnel not started'
    $report.tests.serverToolFiltering='BLOCKED: still requires verified filtering or explicit bounded-risk decision'
    $report.tests.dependencies='UNRESOLVED: no blind fixes or managed binary replacements'
    $report.tests.hostedChat='BLOCKED: never start cloud or enter credentials from this script'
    $report.appLocation='Pilot LOCALAPPDATA/ChatHand/DWB-beta16'
    $report.dataLocation='Pilot LOCALAPPDATA/DWB-MCP-Studio-ChatHand'
} catch {
    $report.status='BLOCKED'
    $report.stage=$stage
    $report.error='Operation stopped; inspect private pilot logs. Do not publish raw logs or retry blindly.'
} finally {
    $json=$report | ConvertTo-Json -Depth 5
    $json
    $returnDir=Join-Path $BundleRoot 'results'
    if (Test-Path -LiteralPath $returnDir) { [IO.File]::WriteAllText((Join-Path $returnDir 'pilot-result.json'),$json) }
}
if ($report.status -eq 'BLOCKED') { exit 1 }
