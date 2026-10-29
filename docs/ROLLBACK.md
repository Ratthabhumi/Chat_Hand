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

# Rollback

V3.2 preparation created only a narrow-ACL ProgramData source transfer, a result directory and a new harmless private fixture. No target-user runtime, account, key or startup was created by Codex. Keep original DWB/Remote untouched. Owner may review/preserve result data before removing only the prepared staging/fixture; no recursive deletion or account/profile removal was executed. If bootstrap later runs, stop that identity's exact runtime and review its own LocalAppData artifacts before any removal. Migration/uninstall under pilot is not claimed tested.

## V3 installed pilot

Run `powershell -NoProfile -File scripts/Dwb-Pilot.ps1 -Action Stop` to stop only the pilot's recorded Tunnel and drain/stop its broker. Local test shutdown was verified with broker state stopped; credentialed Tunnel shutdown/revocation is NOT TESTED. Close the pilot Dashboard after stopping. No startup entry or service was installed, and no credentials were provisioned.

Keep the old Remote Desktop Commander unchanged as the rollback route. If removing DWB, first preserve any future pilot data/work, then review and manually remove only `%LOCALAPPDATA%\ChatHand\DWB-beta16` and `%LOCALAPPDATA%\DWB-MCP-Studio-ChatHand`. Do not delete the Chat_Hand sandbox or old Remote data. Complete uninstall/data deletion was not executed or claimed tested.

If a key/tunnel is added later, owner must revoke that dedicated key in Platform and remove the pilot plugin/tunnel associations, then verify a fresh call fails. Stopping alone does not revoke a key. Never paste key.dpapi or raw auth files into Git. No production rollback is needed for this setup.

## Historical V1/V2 rollback

V3 Skills rollback/removal is documented in [AGENT_SKILLS.md](AGENT_SKILLS.md). Only the five reviewed package imports and two retained packages' policy changes were performed in this step; no package was deleted. Do not restore AUTO policies for unreviewed packages without source review and explicit owner decision.

No installed runtime, tunnel, credential, service, scheduled task or firewall rule was created by this work. No production repository rollback is needed.

The local probe removes its own unique output file in finally. Successful cleanup is recorded in `evidence/local-probe.json`. If interrupted outside finally, inspect `sandbox/test-output` and remove only the matching synthetic `probe-*.txt` file after reviewing it. Do not recursively delete project folders.

Keep the repository as evidence, or remove it manually after preserving any future work. Removing documentation from disk does not remove the GitHub history. No remote deletion performed or recommended as part of this setup.

Future remote tests: disconnect the specific device/connector in its UI and verify a fresh file call fails. For any future custom tunnel, stop its client, remove its startup entry if one was explicitly added, revoke the dedicated runtime credential in Platform, remove the custom plugin/tunnel associations, and test access failure. These future revocation steps were NOT exercised in this run.
