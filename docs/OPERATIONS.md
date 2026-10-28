# Manual operations and recovery

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
