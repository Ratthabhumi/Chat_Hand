## V3.3 current status — 2026-10-29

**BLOCKED; root cause UNKNOWN.** Actual pilot diagnostic is preserved in evidence/v3.3-owner-diagnostic.json: Node available, package present, config/result absent, phase external, log present with no matched signals. Empty signals do not imply success. Main-account inspection confirms original harmless fixture still exists; pilot missing-path result remains inconclusive. One PowerShell process owner was unresolved from the main identity, so no claim of installer absence is made.

Reviewed installed beta.16 source: external installs pinned worker via npm before checksummed tunnel download; catch normally writes result. Invoke-DwbNode can forward stderr after exit zero, while our bootstrap uses Stop with native stream redirection. This is a hypothesis requiring private-log evidence, not a confirmed failure cause. No repair/retry, source patch, managed dependency substitution, cloud activation or risk acceptance was applied.

Prepared Get-RestrictedExternalDiagnostic.ps1: guarded pilot-only, verifies three vendor scripts against the SHA-256-verified original archive, reads execution policies, Node/npm version, owned/unresolved process roles (never command lines), exclusive-read lock status without creating locks, staging metadata, file presence and fixed private-log classifications. It does not execute npm installs, tunnel binaries, vendor scripts or network probes. Process snapshot/lock availability alone cannot establish crash, timeout, termination or stale lock. Positive execution under pilot remains pending. A new harmless protected file under the traversable neutral bundle has owner/System/Administrators-only ACL, plus a harmless public control. Original fixture/payload/profile ACLs remain unchanged; new effective pilot denial is NOT TESTED.

See [one integrity-checked owner command](RESTRICTED_PILOT_V32.th.md). All actual pilot installation/version/doctor/runtime, seven-skill import/activation/persistence, advisory/tool/OS/reliability gates and ordinary Chat E2E remain unaccepted. Tunnel stays OFF; original installations remain retained. CI covers repository artifacts and identity refusal, not runtime acceptance. Earlier sections are historical.

## V3.2 owner execution checked — 2026-10-29

**BLOCKED at setup-dwb.** The returned pilot-result.json confirms the actual pilot identity, no administrator token, payload integrity PASS and Windows-local synthetic write/read/delete PASS. Protected-fixture denial is NOT VERIFIED (unexpected filesystem error). DWB setup did not finish; seven-skill import, managed component versions, workspace policy, process ownership, MCP calls and hosted Chat acceptance are not verified under this identity. No credentials copied or cloud start reported. This supersedes earlier wording that owner execution was pending.

The current original-account process cannot read the pilot setup log: Windows denies access. No ACL bypass, reinstall, dependency patch, new credentials, cloud start or production modification performed. Root cause is UNKNOWN. A read-only pilot diagnostic classifies fixed error categories from existing vendor result/private log, checks the synthetic fixture through nested exception types, and exports no raw messages/paths. Its original-account refusal passed; its positive pilot path is pending. See [owner diagnostic steps](RESTRICTED_PILOT_V32.th.md). Existing shell-tool restrictions, advisory triage and timeout/restart gates remain unresolved; hosted Tunnel stays NO-GO. Existing original installation remains retained; live Remote Desktop Commander availability was not retested in this continuation.

# Actual acceptance evidence

## V3.2 current evidence

| Check | Result |
|---|---|
| Existing enabled account / Users / not Administrators | PASS: Windows native membership query |
| Profile initialized/loaded | Registered and loaded; current process still not pilot |
| Effective pilot token / primary-file denial | NOT TESTED from pilot |
| Main -> pilot LocalAppData inspection | ACCESS DENIED; not a missing directory or reverse denial proof |
| Neutral payload integrity | PASS: 39 files and pinned release ZIP |
| New staging ACL configuration | Protected; no broad grants observed; effective pilot access pending |
| Wrong-identity setup guard | PASS: Windows PowerShell refuses current identity, exit 2 before bootstrap writes |
| Actual target-user DWB setup/process owners | BLOCKED: owner must run guarded bootstrap in existing pilot session |
| Hosted Tunnel / normal Chat / restart / skills under pilot | NOT TESTED |

Existing identity/source/library tests are not evidence of target-user installation or cloud acceptance. See [owner command](RESTRICTED_PILOT_V32.th.md). Dependency/security/timeout findings remain open.

## V3.1 current status

Latest local path retest: FAIL (MCP timeout after 15s). Initial stop: DWB_UPGRADE_BUSY; no force-kill. Later status became idle and a final graceful stop was attempted only after that new evidence. Skill recheck PASS is **not** a policy-persistence-through-restart PASS. Hosted security/recovery remains unresolved. See v3.1-local-mcp.json and final status evidence.

- Owner-reported Tunnel/key available; pilot profile/settings/key.dpapi absent at inspection. No credential was requested or read.
- OS isolation: BLOCKED, owner confirmed no separate identity/VM and requested [manual setup steps](OWNER_ACCOUNT_SETUP.th.md). No OS change performed.
- Server tool filter: not found in targeted installed sources; tool exposure gate unresolved, hosted NO-GO.
- Dependency triage: installed versions/chains and primary GHSA fixed versions collected; supported patches/reachability tests still pending. No risk accepted.
- Skills: original five pins retained; two MANUAL additions. Local exact instruction delivery verified for all six MANUAL skills; ASK withholding/rejection and effective policy checks pass. Policy drift was detected and restored once.
- Media/custom-project skills: catalog/design only, no backend/model/runtime or production-root activation.
- Real ordinary-Chat Tunnel/read/write/skills, two-session and hosted reconnect: BLOCKED/NOT TESTED. Do not count local protocol checks as a completed DoD item.

## V3 current acceptance — 2026-10-29

| Test | Result / scope |
|---|---|
| Release ZIP integrity | PASS: local SHA-256 vs companion and GitHub digest |
| Official Setup backend / doctor | PASS: isolated app/data and workerCap=1 |
| Local stdio broker/session status + workspace bind | PASS |
| Local stdio exact hello.txt read | PASS |
| Local stdio outside-root / raw traversal / junction target denial | PASS |
| Shell disabled/confined | FAIL: process tools exposed, OS boundary not established |
| DWB controlled write/readback/delete | BLOCKED behind security gate; V1 plain local I/O is not DWB evidence |
| Two actual Chat sessions / hosted Tunnel reconnect | NOT TESTED |
| Managed Tunnel version + doctor help | PASS: 0.0.11; no credentialed doctor/readiness claim |
| Ordinary ChatGPT Chat -> Tunnel -> DWB | BLOCKED: owner account/secret steps and security gate |
| Stop local test broker | PASS: official drain/stop, runtime status stopped |
| No startup / current AUTO skills | Startup remains off; five reviewed MANUAL/ASK plus two retained extras forced MANUAL; effective pilot policy checked |
| Local skills/pinned hashes | PASS: five reviewed packages |
| Local MANUAL activation/denial | PASS: no request -> manual_only; explicit owner demo -> active, exact instructions |
| Local ASK withholding/rejection | PASS: approval_required, then rejected/no instructions after synthetic local administrative rejection |
| Actual Chat-host skill activation / model behavior | BLOCKED / NOT TESTED; local delivery is not host acceptance |
| Legacy Remote session/config | PASS: unchanged during first DWB probe; old connector rechecked separately |
| Dependency security | REVIEW REQUIRED: current audit core=6, worker=5 affected packages |

Reproduce using `Dwb-Pilot.ps1 -Action Status` and `Test-DwbPilot.mjs` with the three documented process-scoped DWB variables. The MCP probe intentionally exits 1 while shell confinement fails. This is a partial acceptance result, not a broken repository CI check. CI parses the probe but does not install DWB or run remote/credentialed tests. Local broker is stopped after a probe using Dwb-Pilot.ps1 -Action Stop; inspect fixtures after interruption.

Hosted owner sequence after security review: broker/session status, bind sandbox, exact read, synthetic outside denial, shell boundary test in the isolated OS environment, then one unique create/read/delete, two-chat identity/workspace separation, reconnect and stop causing fresh calls to fail. Keep credentials out of evidence.

## Historical V1/V2 evidence

The owner's nine completion gates remain open where only local/partial evidence exists: actual Chat-host Tunnel/read/skill calls BLOCKED, shell gate FAIL, DWB writes BLOCKED, two-chat/reconnect NOT TESTED. Local installation, skills and operations evidence do not imply overall COMPLETE.

**Current V2 matrix: [V2_REPORT.md](V2_REPORT.md).** On 2026-10-29, device Online and remote connector read PASS from Codex; outside-sandbox denial FAIL; remote write and normal-Chat host acceptance pending. Evaluator self-tests/CI validate the checker, not any independent AI model. The table below is historical V1 evidence.

2026-10-28, Asia/Bangkok. See JSON files in `evidence/` for local command results. PASS is scoped to the named transport.

| Test | Result | Evidence / limitation |
|---|---|---|
| Local fixture read | PASS | Existing Codex -> PowerShell -> hello.txt |
| Local synthetic write/readback | PASS | Unique probe file; exact comparison |
| Local cleanup | PASS | Probe file absent after finally cleanup |
| Remote device discovery | PASS | Existing connector returned device state |
| Remote device online | BLOCKED | Device Offline, last seen 21h ago |
| MCP Inspector discovery / read | NOT RUN | No new local MCP server selected/installed |
| ChatGPT web file read/write | BLOCKED | Existing route offline; web invocation not observed |
| Custom Tunnel doctor / real invocation | NOT RUN | No tunnel provisioned; account rights unverified |
| Out-of-scope denial / traversal / junction / shell | NOT RUN | Local file probe does not enforce remote policy |
| Secret isolation | NOT VERIFIED | Publication excludes secrets; runtime isolation not proven |
| Multi-session isolation | NOT RUN | No remote worker sessions available |
| Reconnect / timeout recovery / remote shutdown | NOT RUN | No runtime started for this pilot |
| Project Git-state comparison | See evidence/project-state-comparison.json | HEAD, status and tracked-diff digest comparison only; not a full disk audit |
| New background service / startup changes | NONE CREATED | Only one-shot local commands used |
| GitHub publication | Verify commit on origin | Final publication checked after upload |

Overall: **PARTIAL**, not a completed ChatGPT-to-local MCP setup. Local file I/O is not equivalent to remote MCP acceptance.
