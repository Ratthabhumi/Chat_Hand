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
