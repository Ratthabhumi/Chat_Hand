[CmdletBinding()]
param()
$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
Push-Location $root
try {
    Get-ChildItem evidence -Filter *.json -Recurse | ForEach-Object {
        $jsonText = Get-Content -LiteralPath $_.FullName -Raw
        if ([string]::IsNullOrWhiteSpace($jsonText)) { throw "Empty evidence JSON: $($_.Name)" }
        $null = $jsonText | ConvertFrom-Json
    }
    $skillLock = Join-Path $root 'config\dwb-skills.lock.json'
    Get-ChildItem config -Filter *.json -ErrorAction SilentlyContinue | ForEach-Object {
        $null = Get-Content -LiteralPath $_.FullName -Raw | ConvertFrom-Json
    }
    if (Test-Path -LiteralPath $skillLock) {
        $lock = Get-Content -LiteralPath $skillLock -Raw | ConvertFrom-Json
        if ($lock.skills.Count -lt 5) { throw 'Preserve the original five-skill collection.' }
        foreach ($id in @('systematic-debugging','test-driven-development','verification-before-completion','receiving-code-review','security-best-practices')) {
            $original = @($lock.skills | Where-Object id -eq $id)
            if ($original.Count -ne 1) { throw 'Missing or duplicated original skill.' }
            $expectedCommit = if ($id -eq 'security-best-practices') { '49f948faa9258a0c61caceaf225e179651397431' } else { '2ce8aa15d05bd57213e6f746f953aafb7ded7a8b' }
            if ($original[0].commit -ne $expectedCommit) { throw 'Original skill source pin changed; review required.' }
        }
        foreach ($skill in $lock.skills) {
            if ($skill.policy -notin @('manual','ask') -or $skill.commit -notmatch '^[a-f0-9]{40}$' -or $skill.mainSha256 -notmatch '^[a-f0-9]{64}$') { throw 'Invalid skill source pin or policy.' }
        }
        foreach ($skill in $lock.quarantinedExisting) {
            if ($skill.policy -ne 'manual') { throw 'Unreviewed retained skills must remain MANUAL.' }
        }
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
    $pilotAccount = Get-CimInstance Win32_UserAccount -Filter "LocalAccount=True AND Name='ChatHandPilot'"
    if (-not $pilotAccount -or [Security.Principal.WindowsIdentity]::GetCurrent().User.Value -ne $pilotAccount.SID) {
        $identityGuard = (& powershell -NoProfile -File scripts\Setup-RestrictedPilot.ps1) -join "`n"
        if ($LASTEXITCODE -ne 2 -or $identityGuard -notmatch 'BLOCKED_WRONG_IDENTITY') {
            throw 'Restricted setup must refuse a non-pilot validation identity before any writes.'
        }
        $diagnosticGuard = (& powershell -NoProfile -File scripts\Get-RestrictedPilotDiagnostic.ps1) -join "`n"
        if ($LASTEXITCODE -ne 2 -or $diagnosticGuard -notmatch 'BLOCKED_WRONG_IDENTITY') {
            throw 'Pilot diagnostic must refuse a different identity without exporting private data.'
        }
    } else {
        'SKIP: negative identity guard under pilot; never trigger installation during repository checks.'
    }
    & node --test scripts/check-fallback.test.cjs
    if ($LASTEXITCODE -ne 0) { throw 'Benchmark evaluator self-tests failed' }
    & git diff --check
    if ($LASTEXITCODE -ne 0) { throw 'Whitespace validation failed' }
    'PASS: JSON, local document links, local I/O, evaluator self-tests and whitespace.'
} finally { Pop-Location }
