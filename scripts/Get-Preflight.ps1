[CmdletBinding()]
param()
$ErrorActionPreference = 'Stop'
$os = Get-CimInstance Win32_OperatingSystem
$cs = Get-CimInstance Win32_ComputerSystem
$identity = [Security.Principal.WindowsIdentity]::GetCurrent()
$principal = [Security.Principal.WindowsPrincipal]$identity
$parent = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent
$projects = foreach ($name in @('Acash', '-SEED', 'EIMS', 'AgentOS')) {
    $path = Join-Path $parent $name
    if (Test-Path -LiteralPath (Join-Path $path '.git')) {
        $head = (& git -C $path rev-parse HEAD) -join ''
        if ($LASTEXITCODE -ne 0) { throw "Cannot inspect $name HEAD" }
        $status = @(& git -C $path status --porcelain=v1)
        if ($LASTEXITCODE -ne 0) { throw "Cannot inspect $name status" }
        [pscustomobject]@{name=$name; head=$head; dirtyEntries=$status.Count}
    } else {
        [pscustomobject]@{name=$name; status='Directory exists but is not a Git checkout at its root; not searched recursively'}
    }
}
[pscustomobject]@{
    observedUtc = [DateTime]::UtcNow.ToString('o')
    os = $os.Caption
    build = $os.BuildNumber
    architecture = $os.OSArchitecture
    ramGB = [math]::Round($cs.TotalPhysicalMemory / 1GB, 1)
    freeRamGB = [math]::Round($os.FreePhysicalMemory / 1MB, 1)
    elevated = $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
    node = (& node --version) -join ''
    npm = (& npm.cmd --version) -join ''
    git = (& git --version) -join ''
    codex = (& codex --version) -join ''
    tunnelClientOnPath = [bool](Get-Command tunnel-client -ErrorAction SilentlyContinue)
    projects = @($projects)
    scope = 'No credential values, raw process arguments, config contents, or customer files collected'
} | ConvertTo-Json -Depth 5
