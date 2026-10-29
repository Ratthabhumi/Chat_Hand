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

# Agent Skills are part of V3

**Current V3.1:** reviewed collection is now seven. Add security-threat-model and frontend-design, both MANUAL, with pinned source/licenses and exact instruction delivery verified locally. The original five listed below retain their versions. Latest result: [v3.1 skills evidence](../evidence/v3.1-skills-local.json); [coverage and limits](SKILLS_CATALOG.md). No media backend, model behavior or ordinary-Chat invocation is implied.

V3.1 detected a later policy drift: original five were AUTO, extras ASK, with four differing workspace overrides. Origin was not established. Eleven default/override records were restored once to the owner's MANUAL/ASK manifest, then tested. The recovery command initially omitted DWB_INSTALL_DIR and did not run the probe; the command environment was corrected without reinstalling or further policy retries. Source pins were unchanged. Keep the Dashboard policy settings stable during acceptance; do not silently loop if another writer changes them again.

Five reviewed packages are installed in the isolated DWB library. Sources, commits, policy and hashes are in [the manifest](../config/dwb-skills.lock.json). [Local MCP evidence](../evidence/v3-skills-local.json) is distinct from ordinary-Chat acceptance.

| Package | Policy | Scope |
|---|---|---|
| systematic-debugging | ASK | Evidence/root cause before fixes |
| test-driven-development | MANUAL | Red/green/refactor |
| verification-before-completion | MANUAL | Fresh evidence before success claims |
| receiving-code-review | MANUAL | Verify incoming feedback; not a full outbound reviewer |
| security-best-practices | MANUAL | Python, JS/TS and Go guidance; not certification |

Superpowers source is pinned to 2ce8aa15d05bd57213e6f746f953aafb7ded7a8b (v7.0.1); OpenAI security source to 49f948faa9258a0c61caceaf225e179651397431. Sources were downloaded to ignored staging, inspected and imported using DWB skills-admin install-local. No Codex global library changed. Main instructions, package inventory and helper behavior were reviewed; this is not a full audit of every framework reference. No helper executed. Bash utilities/example framework imports are not assumed Windows-compatible. Read relevant security references before concrete use.

Two extra packages, golive and brag-slim, were found with AUTO defaults AND workspace overrides. Their installation origin was not established in this run. They were not installed, reviewed or activated by this task. Files were preserved, both defaults and AUTO overrides changed MANUAL, and effective pilot policy verified. They are excluded from the reviewed collection. MANUAL is not OS quarantine; do not activate before review. Policy changes do not prove revocation of instructions already delivered to older sessions.

Actual local MCP checks passed: five reviewed packages match pinned content/policies; MANUAL without explicit request returns manual_only/no instructions; the owner's explicit demo request activates verification-before-completion with exact pinned instructions; ASK withholds instructions pending approval; a synthetic administrative rejection produces rejected/no instructions. No human approval was fabricated. The initial test failed on unexpected extra packages; defaults and overrides were corrected before the final passing run. Broker stopped afterward. No model/helper execution occurred, so instruction delivery does not prove behavioral effectiveness.

## Reproduce and operate

Inspect existing packages before reinstalling: native reinstallation resets prior consent. On a fresh approved pilot, review each exact source URL in the manifest, then use `node <app>/scripts/skills-admin.mjs install-github <sourceUrl> <policy>` and compare returned contentHash. No HEAD installs or AUTO/deployment permissions. Relevant helper commands still require the OS/security gates.

With the pilot environment in [OPERATIONS.md](OPERATIONS.md), run `node scripts/Test-DwbSkills.mjs`, then `powershell -NoProfile -File scripts/Dwb-Pilot.ps1 -Action Stop`. This tests local instruction delivery and consent states, not hosted authentication. It creates one session-scoped MANUAL activation and one rejected synthetic ASK request.

## Exact ordinary-Chat owner test, after security/account gates

1. Select the DWB Custom MCP plugin and bind the sandbox. Ask: `เรียก DWB skills action=list แสดงเฉพาะชื่อกับ policy`.
2. Ask: `ฉันขอใช้ verification-before-completion ใน sandbox นี้ เรียก skills action=activate พร้อม explicit_user_request=true แล้วสรุปกฎหนึ่งข้อ ห้ามรัน shell หรือแก้ไฟล์`.
3. Record a real tool response returning active in that actual Chat session. Keep sanitized status/hash evidence only.
4. Request systematic-debugging to test ASK. Require approval_required first; the agent must ask for a separate explicit yes before retrying the same approval_id with user_confirmed=true. Alternatively reject in Dashboard. Never fabricate approval to make a test pass.

These Chat-host calls remain BLOCKED behind shell containment, dependency triage and owner Tunnel/account steps. Consent flags are client workflow assertions, not independently authenticated human consent or OS permissions.

Rollback: stop/drain the pilot first; set MANUAL and inspect workspace overrides. If owner approves removal, use DWB Agent Skills uninstall or native skills-admin uninstall for the exact ID, preserving unrelated packages. Removal does not undo prior actions. Uninstall/revocation was not tested here.
