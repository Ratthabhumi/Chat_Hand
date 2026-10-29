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
    'PASS: actual recovery transport retains JSON/quoted arguments despite stderr and rejects nonzero exit. Synthetic only; no pilot installation.'
} finally {
    $log=Join-Path $data 'repair-v34-node-private.log'
    if ([IO.File]::Exists($log)) {Remove-Item -LiteralPath $log}
    Remove-Item -LiteralPath $data
}
