[CmdletBinding()]
param([string]$BundleRoot = (Join-Path $env:ProgramData 'ChatHandPilot-Setup'))
$ErrorActionPreference='Stop'
$root=[IO.Path]::GetFullPath($BundleRoot).TrimEnd('\')
$manifest=Get-Content -LiteralPath (Join-Path $root 'payload-manifest.json') -Raw | ConvertFrom-Json
$checked=0
foreach($entry in $manifest.files){
    $path=[IO.Path]::GetFullPath((Join-Path $root $entry.path))
    if(-not $path.StartsWith($root+'\',[StringComparison]::OrdinalIgnoreCase)){throw 'Payload path escaped the bundle.'}
    if((Get-Item -LiteralPath $path).Attributes -band [IO.FileAttributes]::ReparsePoint){throw 'Payload link rejected.'}
    if((Get-FileHash -LiteralPath $path -Algorithm SHA256).Hash -ine $entry.sha256){throw 'Payload checksum mismatch.'}
    $checked++
}
$zipHash=(Get-FileHash -LiteralPath (Join-Path $root 'dwb-windows.zip')).Hash.ToLowerInvariant()
if($zipHash -ne 'cd94f308829515f9a4e3d381c9f9266859124bfb47f47aeda9992377f0c19de2'){throw 'Official ZIP mismatch.'}
[pscustomobject]@{result='PASS';checkedFiles=$checked;officialArchiveDigest='MATCH';scope='Read-only source-payload check, not effective pilot access or runtime/OS containment'} | ConvertTo-Json
