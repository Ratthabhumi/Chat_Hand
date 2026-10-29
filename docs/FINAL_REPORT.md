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
