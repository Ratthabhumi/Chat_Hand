[CmdletBinding()]
param()
$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
Push-Location $root
try {
    Get-ChildItem evidence -Filter *.json -Recurse | ForEach-Object {
        $null = Get-Content -LiteralPath $_.FullName -Raw | ConvertFrom-Json
    }
    Get-ChildItem scripts -Filter *.mjs | ForEach-Object {
        & node --check $_.FullName
        if ($LASTEXITCODE -ne 0) { throw "JavaScript syntax failed: $($_.Name)" }
    }
    Get-ChildItem scripts -Filter *.ps1 | ForEach-Object {
        $parseErrors = $null
        $tokens = $null
        $null = [Management.Automation.Language.Parser]::ParseFile($_.FullName, [ref]$tokens, [ref]$parseErrors)
        if ($parseErrors.Count) { throw "PowerShell syntax failed: $($_.Name)" }
    }
    Get-ChildItem README.md,docs\*.md,benchmark\*.md | ForEach-Object {
        $document = $_
        foreach ($match in [regex]::Matches((Get-Content -LiteralPath $_.FullName -Raw), '\]\(([^)]+)\)')) {
            $target = $match.Groups[1].Value
            if ($target -notmatch '^https?://' -and -not (Test-Path -LiteralPath (Join-Path $document.DirectoryName $target))) {
                throw "Broken local link: $($document.Name) -> $target"
            }
        }
    }
    & powershell -NoProfile -File scripts\Test-LocalSandbox.ps1
    if ($LASTEXITCODE -ne 0) { throw 'Local sandbox probe failed' }
    & node --test scripts/check-fallback.test.cjs
    if ($LASTEXITCODE -ne 0) { throw 'Benchmark evaluator self-tests failed' }
    & git diff --check
    if ($LASTEXITCODE -ne 0) { throw 'Whitespace validation failed' }
    'PASS: JSON, local document links, local I/O, evaluator self-tests and whitespace.'
} finally { Pop-Location }
