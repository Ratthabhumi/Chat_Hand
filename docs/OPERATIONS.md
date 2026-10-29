## V3.4 current status — 2026-10-29

**BLOCKED pending one Pilot recovery execution; historical root cause UNKNOWN.** Actual owner external diagnostic is preserved in evidence/v3.4-owner-external-diagnostic.json. The neutral protected fixture returned ACCESS_DENIED and public control PASS under pilot; this proves only the tested file-content boundary, not shell/network/profile-wide containment. Source integrity passed, a single worker staging package reports 0.2.50, managed tunnel/config/result are absent. Locks were available at the diagnostic snapshot; npm cache exit zero remains uncorrelated. No completed worker installation, crash, npm failure or timeout is inferred.

Prepared scripts/Repair-RestrictedExternal.ps1 and one-use Invoke-PilotVendorSetup.ps1. Under the existing non-admin pilot token only, recovery checks original release files against the verified ZIP, original payload hashes, ownership/reparse paths, existing exact request/preferences, relevant pilot process conflicts, exclusive vendor locks, one staging candidate, vendor Get-DwbWorkerState readiness and exact registry/version/SHA-512 lock metadata. These checks do not amount to a complete transitive package-content audit. It moves verified staging to the absent expected worker target without deleting/copying it, records a persistent attempt marker, then executes the unchanged supported vendor setup ONCE with private logs owned by the child. The child enforces pilot identity and one-use invocation. No old setup command is requested.

The replacement launch path avoids native PowerShell all-stream redirection at the parent-child boundary, captures numeric exit status, and leaves original logs/source intact. A Windows PowerShell synthetic regression exercises the actual JSON transport: quoted arguments and stderr survive, nonzero exit is rejected. This proves transport behavior, not the cause of the historical interruption. A 20-minute installer wait reports IN_PROGRESS and retains the child; never launch another attempt while it remains active. Persistent markers block automatic retries even after partial failure. Do not manually remove markers to retry.

On successful vendor result, the same action checks doctor, exact sandbox/workerCap, imports only seven pinned skills, checks hashes/default/workspace policies and startup/autoconnect disabled. It does not start the Dashboard, broker, MCP worker or hosted connection; skills instruction delivery/restart and real process/session/hosted acceptance remain untested. The vendor installer may install missing dependencies and download its managed 0.0.11 tunnel client; this is not opening a cloud tunnel. Existing dependency/tool-filter/residual-risk/reliability gates remain unresolved. Main-user DWB/Remote installations are retained; no production project touched.

Current work is PREPARED_NOT_EXECUTED under Pilot. See [one integrity-checked recovery command](RESTRICTED_PILOT_V32.th.md) and evidence/v3.4-recovery-preparation.json. CI covers source/identity guards and synthetic transport; no pilot installation/hosted success is claimed. Earlier sections below are historical.

## V3.3 current status — 2026-10-29

**BLOCKED; root cause UNKNOWN.** Actual pilot diagnostic is preserved in evidence/v3.3-owner-diagnostic.json: Node available, package present, config/result absent, phase external, log present with no matched signals. Empty signals do not imply success. Main-account inspection confirms original harmless fixture still exists; pilot missing-path result remains inconclusive. One PowerShell process owner was unresolved from the main identity, so no claim of installer absence is made.

Reviewed installed beta.16 source: external installs pinned worker via npm before checksummed tunnel download; catch normally writes result. Invoke-DwbNode can forward stderr after exit zero, while our bootstrap uses Stop with native stream redirection. This is a hypothesis requiring private-log evidence, not a confirmed failure cause. No repair/retry, source patch, managed dependency substitution, cloud activation or risk acceptance was applied.

Prepared Get-RestrictedExternalDiagnostic.ps1: guarded pilot-only, verifies three vendor scripts against the SHA-256-verified original archive, reads execution policies, Node/npm version, owned/unresolved process roles (never command lines), exclusive-read lock status without creating locks, staging metadata, file presence and fixed private-log classifications. It does not execute npm installs, tunnel binaries, vendor scripts or network probes. Process snapshot/lock availability alone cannot establish crash, timeout, termination or stale lock. Positive execution under pilot remains pending. A new harmless protected file under the traversable neutral bundle has owner/System/Administrators-only ACL, plus a harmless public control. Original fixture/payload/profile ACLs remain unchanged; new effective pilot denial is NOT TESTED.

See [one integrity-checked owner command](RESTRICTED_PILOT_V32.th.md). All actual pilot installation/version/doctor/runtime, seven-skill import/activation/persistence, advisory/tool/OS/reliability gates and ordinary Chat E2E remain unaccepted. Tunnel stays OFF; original installations remain retained. CI covers repository artifacts and identity refusal, not runtime acceptance. Earlier sections are historical.

## V3.2 owner execution checked — 2026-10-29

**BLOCKED at setup-dwb.** The returned pilot-result.json confirms the actual pilot identity, no administrator token, payload integrity PASS and Windows-local synthetic write/read/delete PASS. Protected-fixture denial is NOT VERIFIED (unexpected filesystem error). DWB setup did not finish; seven-skill import, managed component versions, workspace policy, process ownership, MCP calls and hosted Chat acceptance are not verified under this identity. No credentials copied or cloud start reported. This supersedes earlier wording that owner execution was pending.

The current original-account process cannot read the pilot setup log: Windows denies access. No ACL bypass, reinstall, dependency patch, new credentials, cloud start or production modification performed. Root cause is UNKNOWN. A read-only pilot diagnostic classifies fixed error categories from existing vendor result/private log, checks the synthetic fixture through nested exception types, and exports no raw messages/paths. Its original-account refusal passed; its positive pilot path is pending. See [owner diagnostic steps](RESTRICTED_PILOT_V32.th.md). Existing shell-tool restrictions, advisory triage and timeout/restart gates remain unresolved; hosted Tunnel stays NO-GO. Existing original installation remains retained; live Remote Desktop Commander availability was not retested in this continuation.

# Manual operations and recovery

V3.2: do not run the original-user Dashboard to impersonate pilot. Use [the staged owner command](RESTRICTED_PILOT_V32.th.md) from the existing pilot session. No auto-login, stored password, SYSTEM/highest-privilege task or startup was added. Original-user Status/Stop wrappers remain historical/main-user operations until target runtime exists. New setup produces only sanitized result JSON; actual pilot Start/Stop/owner/reconnect acceptance is pending.

V3.1: use the existing Status/Stop commands while security gates remain open. Owner already has credentials; leave them out of chat. [Account preparation packet](OWNER_ACCOUNT_SETUP.th.md) is the next owner action. Do not Start MCP, enable startup or assume a new standard account passes containment without tests. Seven reviewed skills are installed; exact instruction checks use the existing Test-DwbSkills.mjs and do not require a hosted Tunnel.

## V3 DWB pilot (current)

```powershell
powershell -NoProfile -File .\scripts\Dwb-Pilot.ps1 -Action Status
powershell -NoProfile -File .\scripts\Dwb-Pilot.ps1 -Action Dashboard
powershell -NoProfile -File .\scripts\Dwb-Pilot.ps1 -Action Stop
powershell -NoProfile -File .\scripts\Dwb-Pilot.ps1 -Action Restart
```

Dashboard opens the installed UI without connecting the hosted tunnel. Restart drains/stops this pilot and requests the Dashboard again; it does not submit credentials or establish cloud access. The app's per-install/data mutex prevents duplicate UI shells, and managed Tunnel start uses a lock/process identity check. No retry daemon added. Stop uses official DWB data-scoped process checks/drain and leaves the old Remote agent alone. No wildcard process kills.

**Do not press Start MCP yet:** shell confinement and dependency triage remain open. After security/account acceptance, the owner enters credentials through built-in Tunnel configuration and uses Dashboard Start MCP / Stop MCP. Check status and perform a fresh tool call; readiness alone is insufficient. Do not expose screenshots containing key fields. Preferences keep Windows startup and auto-connect disabled.

For local stdio tests only:

```powershell
$env:DWB_INSTALL_DIR = Join-Path $env:LOCALAPPDATA 'ChatHand\DWB-beta16'
$env:DWB_DATA_DIR = Join-Path $env:LOCALAPPDATA 'DWB-MCP-Studio-ChatHand'
$env:DWB_CONFIG_FILE = Join-Path $env:DWB_DATA_DIR 'config.json'
node scripts/Test-DwbPilot.mjs
powershell -NoProfile -File scripts/Dwb-Pilot.ps1 -Action Stop
```

The current probe deliberately reports the unresolved shell gate and exits 1. It uses only synthetic fixtures and no hosted Tunnel. If interrupted, inspect only the unique `sandbox/dwb-junction-*` link and `local-evidence/dwb-outside-*` scratch directory before removing exact generated items; do not follow junctions into another tree or recursively delete production paths.

Recovery: one status/doctor inspection, then one manual restart after checking active work. Stop if the same error persists and record a sanitized error. No re-pairing/key rotation/reinstall loop. Optional non-elevated startup may be considered only after manual acceptance and explicit owner approval.

## Historical V2 Remote operations (rollback route)

For current V3 Skills, use [AGENT_SKILLS.md](AGENT_SKILLS.md): Dashboard Agent Skills shows the reviewed five-package MANUAL/ASK set plus two retained, unreviewed MANUAL extras. Local protocol tests use `node scripts/Test-DwbSkills.mjs` under the same isolated environment, followed by Dwb-Pilot.ps1 -Action Stop. Do not approve ASK requests or enable AUTO merely to make acceptance green.

No automatic startup is configured or approved. Do not create Task Scheduler jobs until manual Chat-host E2E, policy denial, reconnect and shutdown tests pass and the owner approves startup.

## Status

```powershell
powershell -NoProfile -File .\scripts\Get-RemoteAgentStatus.ps1
```

This reads process metadata without printing command arguments or credential contents. It cannot prove remote readiness. In the intended ChatGPT chat, run connector device discovery, select the existing device and request the synthetic hello.txt read. Do not start another process when the existing device is working.

## Start / reconnect (owner's terminal)

First review the agent's shared access policy and other active chats. Reuse the installed 0.3.1 package and existing session. If no remote agent is running, use the known installation's entry point rather than `npx @latest`:

```powershell
$packagePath = Join-Path $env:LOCALAPPDATA 'npm-cache\_npx\4b4c857f6efdfb61\node_modules\@wonderwhy-er\desktop-commander'
$manifest = Get-Content -LiteralPath (Join-Path $packagePath 'package.json') -Raw | ConvertFrom-Json
if ($manifest.name -ne '@wonderwhy-er/desktop-commander' -or $manifest.version -ne '0.3.1') { throw 'Installation changed; inspect before starting' }
node (Join-Path $packagePath 'dist\index.js') remote
```

The package cache identifier is machine-specific, observed in this pilot; if absent, stop and locate the existing installation. Do not download another copy automatically. Run status first; this command itself does not prevent a duplicate. The command was not executed in this run because the agent was already Online. Saved sessions are normally reused; if OAuth is requested, complete it yourself and never copy the session file into the repository.

## Stop / revoke

When no other chat needs this shared process, press Ctrl+C in the terminal that owns the remote agent. Do not kill every Node process. Confirm the device becomes unavailable and a new synthetic file call fails. Shutdown/reconnect have not been tested here because interrupting the shared session was deferred. Stopping does not revoke credentials; use the service's device-management page for owner-controlled revocation if required. Do not delete auth files as troubleshooting.

## Bounded recovery

One ordinary stop/start after coordinating other users, then one diagnostic pass: package/version, device identity, network/relay error and sanitized console error. If still failing, preserve the exact error with tokens/identifiers removed and stop. Do not loop reinstall/pair/key rotation. Current successful dispatch does not support diagnosing historical presence issues #798/#811 as this machine's cause.

Task Scheduler vs supported startup remains a later decision. Prefer a non-elevated interactive user and one process. No background task, retry daemon or startup persistence is needed for acceptance.
