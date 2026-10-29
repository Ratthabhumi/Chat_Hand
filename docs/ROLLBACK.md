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
