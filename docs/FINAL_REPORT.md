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

# Final report

## V3.2 current result — 2026-10-29

**PARTIAL / owner execution required.** Existing pilot enabled, member of Users and not Administrators, profile registered/loaded. Current Codex identity is not pilot; access to pilot LocalAppData from the main account was denied. No password, real SID, private profile path or credential published. No request to recreate the account or key.

Prepared narrow-ACL `%PROGRAMDATA%\ChatHandPilot-Setup`: verified official ZIP, seven pinned skill sources, guarded setup script and a harmless protected-fixture pointer. No old node_modules/session/SQLite/auth/DPAPI copied. Pilot reads payload and can modify only the result directory; no broad Users/Everyone grants observed on payload files. ACLs changed only on newly created staging/result/fixture locations, not existing profiles/projects. Read-only verification matched all 39 payload files and the official archive SHA-256.

The setup script rejects the current original identity before writes/processes/network (Windows PowerShell test exit 2). Its positive path is **NOT EXECUTED or accepted** under pilot yet. Owner action: [switch to the existing pilot and run one command](RESTRICTED_PILOT_V32.th.md). It prepares app/data/workspace owned by pilot, keeps cloud off, imports seven reviewed skills without extras, and returns sanitized JSON for continuation. Installing dependencies separately is necessary only for the separate identity; original installations are retained.

Target process owners, actual pilot OS denials, server tool restriction/risk decision, advisory remediation, MCP timeout/restart regression, skill activation and normal Chat E2E remain unverified. Account membership and payload checks are not OS containment proof. No vendor binary/source patch or security exception accepted. Existing dependency triage remains unresolved; no blind update. Main broker/Tunnel were stopped at preflight and no new runtime was launched.

Reproducible preparation code is scripts/Prepare-RestrictedTransfer.ps1; it refuses existing staging and requires reviewed local sources rather than fetching/reinstalling blindly. Setup/private logs stay in the pilot profile; only sanitized result JSON is returned. Historical V3.1 evidence remains below.

## V3.1 current result — 2026-10-29

Latest retest limitation: local MCP path/security probe timed out (-32001, 15s), and initial graceful stop returned DWB_UPGRADE_BUSY. No new path PASS or successful restart is claimed. A subsequent skill recheck passed on the existing broker; it is not restart evidence. Later diagnostic showed zero workers/requests/queue, allowing one final graceful stop without force-kill. See current runtime/status artifacts. The previous policy/delivery passes and CI do not erase the timeout.

**PARTIAL / hosted NO-GO.** Owner reports Tunnel/key already available; no request to share them and no new key/tunnel created. Local pilot inspection found no tunnel settings/profile/key.dpapi, with broker/Tunnel stopped. Owner confirmed no isolated Windows account/VM and requested preparation steps: [one Thai owner packet](OWNER_ACCOUNT_SETUP.th.md). No user/account/ACL/firewall/startup changes made.

Inspected worker registration/dispatch and DWB routing; no supported filter found in the targeted files. OS standard-user preparation alone will not establish MCP tool exclusion or all host isolation. Core/worker packages unchanged. Added installed-version/dependency-chain/GHSA range-and-fix triage for all eleven affected package entries (13 primary advisories), with reachability uncertainty and no accepted risk or patch. See [DEPENDENCY_TRIAGE.md](DEPENDENCY_TRIAGE.md).

Added only security-threat-model and frontend-design, MANUAL. Reviewed collection now seven, preserving original pins; six MANUAL packages return exact instructions over local MCP. Debugging ASK withholding/rejection checks pass. Detected policy drift and restored eleven default/override records once, then verified. Two retained extras stay MANUAL and unreviewed. No helper/model/media service or paid API run. See [catalog](SKILLS_CATALOG.md).

Project-specific designs remain inactive; public instruction hashes recorded where root AGENTS.md was found, and missing/private context explicitly blocked. No production project mutated or exposed. Normal Chat read/write/Skill activation, two-chat sessions and hosted reconnect still lack evidence. Use [OPERATIONS.md](OPERATIONS.md); never press Start MCP merely because a key exists.

## Historical V3 result

Final V3.1 cleanup: after status showed zero active/queued work, one final graceful stop succeeded. Both broker and Tunnel are stopped in v3.1-final-status.json. Timeout/restart acceptance remains unresolved; no force kill or cloud start occurred.

## V3 current result — 2026-10-29

**PARTIAL: isolated DWB installed; local file-policy tests pass; hosted access intentionally stopped.**

Installed beta.16 to `%LOCALAPPDATA%\ChatHand\DWB-beta16`, managed worker 0.2.50, managed Tunnel 0.0.11. App data at `%LOCALAPPDATA%\DWB-MCP-Studio-ChatHand`. ZIP SHA-256 verified; unsigned launcher not treated as signed publisher proof. Used reviewed Setup backend/app scripts without an execution-policy override or elevation. Dashboard host is responding; no credential UI or ChatGPT plugin configured.

One worker, explicit sandbox-only policy, startup/auto-connect disabled. Five pinned/reviewed skills installed: debugging ASK, TDD/verification/review reception/security best practices MANUAL. Local MCP MANUAL denial/explicit activation with exact instructions and ASK withholding/rejection passed. Two extra AUTO packages were retained and forced MANUAL in defaults and workspace overrides; origin unestablished. See [AGENT_SKILLS.md](AGENT_SKILLS.md). Actual Chat-host activation and model behavior remain unverified.

Local broker/session/bind/read and outside/traversal/junction denial passed. Test broker drained/stopped. Shell tools remain exposed, so OS confinement FAILS; DWB write tests, two-chat isolation and cloud reconnect were not attempted. Core/worker audits reported 6/5 affected packages, pending review. Hosted Tunnel remains stopped.

Existing Remote agent/config/authentication retained; first probe left tracked legacy file hashes unchanged. No production roots were activated or production repositories modified. Account entitlement, workspace associations, runtime key and real ordinary-Chat invocation remain owner gates. No new key, subscription, billing, firewall or startup persistence created.

Owner steps: security review/OS isolation first, then personally provision/link the pilot Tunnel and enter restricted key in DWB, then complete ordinary-Chat acceptance. Details and runnable local operations are in [INSTALLATION.md](INSTALLATION.md), [SECURITY_REVIEW.md](SECURITY_REVIEW.md), [ACCEPTANCE_TESTS.md](ACCEPTANCE_TESTS.md), [OPERATIONS.md](OPERATIONS.md), and [ROLLBACK.md](ROLLBACK.md). Research handoff includes exact audit advisories. V2 coding-agent work is paused under the selected V3 architecture.

## Historical V1/V2 report

**Historical V1 report. Current result: [V2_REPORT.md](V2_REPORT.md), dated 2026-10-29.** Device now Online; connector fixture read passed from Codex, directory denial failed. ChatGPT-web and independent-model acceptance remain pending.

Observed 2026-10-28 (Asia/Bangkok). **PARTIAL / external remote-access blocker.**

1. **Environment:** Windows 11 x64, Node 24.14.1, npm 11.11.0, Git 2.50.0.windows.1, Codex 0.165.0-alpha.1.2. GitHub authentication usable. Target repository was empty and public.
2. **Architecture:** reuse Codex + GitHub and restore existing Desktop Commander first. Defer additional filesystem MCP/Tunnel; DWB installation is NO-GO pending review and demonstrated need.
3. **Components:** installed none. Added synthetic sandbox, repeatable local probe/preflight scripts, sanitized evidence and operating documentation.
4. **Security:** no installer executed, credentials collected, remote endpoint exposed, firewall changed or production project modified by this work. This is not proof of runtime containment or a full source audit.
5. **Tests:** local reads, synthetic writes/readback and cleanup passed. Remote discovery returned Offline. Remote file calls, Inspector, boundary enforcement, sessions and Tunnel E2E remain unverified; see acceptance table.
6. **Integration status:** local Codex workflow available. ChatGPT-web-to-local workflow is BLOCKED; no claim of successful installation or connection.
7. **Owner actions:** bring the existing Desktop Commander device online, inspect/limit its pilot access, and invoke the fixture from the intended ChatGPT web chat. Custom tunnel credentials/permissions require owner participation only if that route is later selected. No approval is needed merely to read these reports.
8. **Operation:** run scripts from README; no daemon/startup required. Follow INSTALLATION.md for remote acceptance steps.
9. **Rollback:** local probe cleaned up its generated file. No integration installation to remove. Future disconnect/revocation steps documented, not tested here.
10. **Recommendation:** first prove the already available connection against synthetic files. Do not add workers or DWB based on feature count. Research the unresolved compatibility/source questions only if the existing route cannot satisfy the actual workflow.

The supplied four project boundaries remain in effect. Acash: read-only, no provider/live/paper execution. -SEED: preserve existing changes and one writer. EIMS: exclude customer details/credentials. AgentOS: do not expose private memory/backups. No project integration was enabled.

Publication includes only this standalone setup work. The pasted research and existing project/private files were not copied into the public repository. See RESEARCH_HANDOFF.md for a ready-to-copy research request and INSTALLATION.md for exact owner steps.
