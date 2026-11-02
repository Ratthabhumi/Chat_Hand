[CmdletBinding()]
param([string]$ArchivePath='', [string]$ReviewedSources='')
$ErrorActionPreference='Stop'
$repo=Split-Path $PSScriptRoot -Parent
if(-not $ArchivePath){$ArchivePath=Join-Path $repo 'local-evidence\dwb-beta16\dwb-mcp-studio-core-0.1.0-beta.16-windows.zip'}
if(-not $ReviewedSources){$ReviewedSources=Join-Path $repo 'local-evidence\skills-reviewed'}
$target=Join-Path $env:ProgramData 'ChatHandPilot-Setup'
if(Test-Path -LiteralPath $target){throw 'Transfer already exists; inspect it rather than overwriting.'}
$pilot=Get-CimInstance Win32_UserAccount -Filter "LocalAccount=True AND Name='ChatHandPilot'"
$owner=[Security.Principal.WindowsIdentity]::GetCurrent().User.Value
if(-not $pilot -or $pilot.SID -eq $owner){throw 'Prepare from the original account for the existing separate pilot.'}
if((Get-FileHash -LiteralPath $ArchivePath).Hash -ine 'cd94f308829515f9a4e3d381c9f9266859124bfb47f47aeda9992377f0c19de2'){throw 'Verified release archive required.'}
$lock=Get-Content -LiteralPath (Join-Path $repo 'config\dwb-skills.lock.json') -Raw | ConvertFrom-Json
foreach($skill in $lock.skills){
    $source=Join-Path $ReviewedSources $skill.id
    if((Get-FileHash -LiteralPath (Join-Path $source 'SKILL.md')).Hash -ine $skill.mainSha256){throw 'Reviewed skill source mismatch.'}
    if(@(Get-ChildItem -LiteralPath $source -Recurse -Force | Where-Object {$_.Attributes -band [IO.FileAttributes]::ReparsePoint}).Count){throw 'Source links not allowed.'}
}
function Protect-NewDirectory([string]$Path,[bool]$PilotWrites=$false,[bool]$PilotReads=$true){
    $acl=New-Object Security.AccessControl.DirectorySecurity
    $acl.SetAccessRuleProtection($true,$false)
    foreach($sid in @($owner,'S-1-5-18','S-1-5-32-544')){
        $acl.AddAccessRule([Security.AccessControl.FileSystemAccessRule]::new([Security.Principal.SecurityIdentifier]::new($sid),'FullControl','ContainerInherit,ObjectInherit','None','Allow'))
    }
    if($PilotReads){
        $rights=if($PilotWrites){'Modify'}else{'ReadAndExecute'}
        $acl.AddAccessRule([Security.AccessControl.FileSystemAccessRule]::new([Security.Principal.SecurityIdentifier]::new($pilot.SID),$rights,'ContainerInherit,ObjectInherit','None','Allow'))
    }
    Set-Acl -LiteralPath $Path -AclObject $acl
}
$null=New-Item -ItemType Directory -Path $target
Protect-NewDirectory $target
foreach($dir in 'scripts','config','skills','results'){$null=New-Item -ItemType Directory -Path (Join-Path $target $dir)}
Protect-NewDirectory (Join-Path $target 'results') $true
Copy-Item -LiteralPath $ArchivePath -Destination (Join-Path $target 'dwb-windows.zip')
Copy-Item -LiteralPath (Join-Path $repo 'scripts\Setup-RestrictedPilot.ps1') -Destination (Join-Path $target 'scripts\Setup-RestrictedPilot.ps1')
$lock.quarantinedExisting=@()
[IO.File]::WriteAllText((Join-Path $target 'config\dwb-skills.lock.json'),($lock|ConvertTo-Json -Depth 6))
foreach($skill in $lock.skills){Copy-Item -LiteralPath (Join-Path $ReviewedSources $skill.id) -Destination (Join-Path $target 'skills') -Recurse}
$fixtureRoot=Join-Path $env:LOCALAPPDATA ('ChatHand\isolation-fixture-'+[guid]::NewGuid().ToString('N'))
$null=New-Item -ItemType Directory -Path $fixtureRoot
Protect-NewDirectory $fixtureRoot $false $false
$fixture=Join-Path $fixtureRoot 'synthetic.txt'
[IO.File]::WriteAllText($fixture,'Harmless primary-user isolation fixture. No credentials or customer data.')
[IO.File]::WriteAllText((Join-Path $target 'private-inputs.json'),(@{protectedSyntheticFixture=$fixture}|ConvertTo-Json))
$files=@(Get-ChildItem -LiteralPath $target -Recurse -File | ForEach-Object {[pscustomobject]@{path=$_.FullName.Substring($target.Length+1);sha256=(Get-FileHash -LiteralPath $_.FullName).Hash.ToLowerInvariant()}})
[IO.File]::WriteAllText((Join-Path $target 'payload-manifest.json'),(@{files=$files}|ConvertTo-Json -Depth 5))
[pscustomobject]@{status='PREPARED_NOT_MIGRATED';files=$files.Count;skills=$lock.skills.Count;next='Owner runs Setup-RestrictedPilot.ps1 in the pilot session';secretsCopied=$false;cloudStarted=$false} | ConvertTo-Json
