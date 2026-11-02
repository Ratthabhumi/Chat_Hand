[CmdletBinding()]
param()
$ErrorActionPreference='Stop'
$root=Split-Path $PSScriptRoot -Parent
$errors=$null; $tokens=$null
$ast=[Management.Automation.Language.Parser]::ParseFile((Join-Path $PSScriptRoot 'Repair-RestrictedExternal.ps1'),[ref]$tokens,[ref]$errors)
if ($errors.Count) {throw 'Recovery parse failed'}
$function=$ast.Find({param($a) $a -is [Management.Automation.Language.FunctionDefinitionAst] -and $a.Name -eq 'Invoke-PrivateNode'},$true)
# Load only the transport function, never the recovery body or pilot files.
. ([scriptblock]::Create($function.Extent.Text))
function ConvertTo-DwbArgument([string]$Value) {
    '"'+[regex]::Replace([regex]::Replace($Value,'(\\*)"','$1$1\"'),'(\\+)$','$1$1')+'"'
}
$data=Join-Path ([IO.Path]::GetTempPath()) ('chathand-transport-'+[guid]::NewGuid().ToString('N'))
$null=New-Item -ItemType Directory -Path $data
$machine=@{Node=(Get-Command node.exe -ErrorAction Stop).Source}
$report=@{checks=@{}}
try {
    $expected=@('a"b','tail\','literal $(no-execution)')
    $result=Invoke-PrivateNode -NodeArgs (@('--eval','process.stderr.write("synthetic warning");process.stdout.write(JSON.stringify({ok:true,args:process.argv.slice(1)}))','--')+$expected)
    if (-not $result.ok -or ($result.args|ConvertTo-Json -Compress) -cne ($expected|ConvertTo-Json -Compress)) {throw 'Argument/JSON transport mismatch'}
    if ([IO.File]::ReadAllText((Join-Path $data 'repair-v34-node-private.log')) -cne 'synthetic warning') {throw 'Stderr not captured privately'}
    $rejected=$false
    try {$null=Invoke-PrivateNode -NodeArgs @('--eval','process.stderr.write("synthetic failure");process.exit(9)')} catch {if ($_.Exception.Message -eq 'Local admin CLI failed') {$rejected=$true}}
    if (-not $rejected) {throw 'Nonzero exit was not rejected'}
    $lockPath=Join-Path $data 'synthetic-package-lock.json'
    $json='{"lockfileVersion":3,"packages":{"":{},"node_modules/@wonderwhy-er/desktop-commander":{"version":"0.2.50","resolved":"https://registry.npmjs.org/@wonderwhy-er/desktop-commander/-/desktop-commander-0.2.50.tgz","integrity":"sha512-c3ludGhldGlj"}}}'
    [IO.File]::WriteAllText($lockPath,$json)
    $oldParserFailed=$false
    try {$null=$json|ConvertFrom-Json} catch {
        $oldParserFailed=($_.Exception.HResult -eq -2147024809 -and $_.FullyQualifiedErrorId -eq 'Argument,Microsoft.PowerShell.Commands.ConvertFromJsonCommand')
    }
    if (-not $oldParserFailed) {throw 'Expected Windows PowerShell empty-key parser regression was not reproduced'}
    $validated=Invoke-PrivateNode -NodeArgs @((Join-Path $PSScriptRoot 'Check-StagedWorkerLock.mjs'),$lockPath)
    if (-not $validated.ok -or -not $validated.checks.emptyRootKeyPresent) {throw 'Corrected npm lock parser failed the same fixture'}
    'PASS: Windows PowerShell legacy empty-key HRESULT reproduced; corrected actual Node validator accepts the same lock without dropping pin checks.'
    'PASS: actual recovery transport retains JSON/quoted arguments despite stderr and rejects nonzero exit. Synthetic only; no pilot installation.'
} finally {
    $log=Join-Path $data 'repair-v34-node-private.log'
    if ([IO.File]::Exists($log)) {Remove-Item -LiteralPath $log}
    $lockPath=Join-Path $data 'synthetic-package-lock.json'
    if ([IO.File]::Exists($lockPath)) {Remove-Item -LiteralPath $lockPath}
    Remove-Item -LiteralPath $data
}
