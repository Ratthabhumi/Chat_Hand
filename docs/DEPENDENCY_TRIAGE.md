## V3.3 current status — 2026-10-29

**BLOCKED; root cause UNKNOWN.** Actual pilot diagnostic is preserved in evidence/v3.3-owner-diagnostic.json: Node available, package present, config/result absent, phase external, log present with no matched signals. Empty signals do not imply success. Main-account inspection confirms original harmless fixture still exists; pilot missing-path result remains inconclusive. One PowerShell process owner was unresolved from the main identity, so no claim of installer absence is made.

Reviewed installed beta.16 source: external installs pinned worker via npm before checksummed tunnel download; catch normally writes result. Invoke-DwbNode can forward stderr after exit zero, while our bootstrap uses Stop with native stream redirection. This is a hypothesis requiring private-log evidence, not a confirmed failure cause. No repair/retry, source patch, managed dependency substitution, cloud activation or risk acceptance was applied.

Prepared Get-RestrictedExternalDiagnostic.ps1: guarded pilot-only, verifies three vendor scripts against the SHA-256-verified original archive, reads execution policies, Node/npm version, owned/unresolved process roles (never command lines), exclusive-read lock status without creating locks, staging metadata, file presence and fixed private-log classifications. It does not execute npm installs, tunnel binaries, vendor scripts or network probes. Process snapshot/lock availability alone cannot establish crash, timeout, termination or stale lock. Positive execution under pilot remains pending. A new harmless protected file under the traversable neutral bundle has owner/System/Administrators-only ACL, plus a harmless public control. Original fixture/payload/profile ACLs remain unchanged; new effective pilot denial is NOT TESTED.

See [one integrity-checked owner command](RESTRICTED_PILOT_V32.th.md). All actual pilot installation/version/doctor/runtime, seven-skill import/activation/persistence, advisory/tool/OS/reliability gates and ordinary Chat E2E remain unaccepted. Tunnel stays OFF; original installations remain retained. CI covers repository artifacts and identity refusal, not runtime acceptance. Earlier sections are historical.

# V3.1 dependency and server-policy triage

**Hosted decision: NO-GO. No risk accepted and no dependency patched.** Owner has Tunnel/key but has not prepared an isolated Windows identity/VM. See [owner packet](OWNER_ACCOUNT_SETUP.th.md).

[Machine-readable triage](../evidence/v3.1-dependency-triage.json) records all eleven affected package entries from the earlier audit: actual installed version/location, npm dependency chains, affected ranges, direct GHSA fixed-version metadata, npm fix suggestions and residual review/regression requirements. Thirteen unique GHSA metadata records were fetched from the GitHub advisory API. This is not a new npm audit or a finding that every advisory is exploitable.

| Component/package | Installed | Runtime evidence / disposition |
|---|---|---|
| Core body-parser | 2.3.0 | Transitive HTTP middleware; no direct DWB src import found in targeted scan. Dynamic/HTTP reachability UNKNOWN. GHSA-27r3-jxmh-p828 lists 2.4.0 / 1.20.9 fixes for applicable branches |
| Core zod | 4.6.2 | Schema validation can process tool input; advisory-specific oversized input behavior untested |
| Worker sharp | 0.34.5 | Worker dist/tools/pdf/extract-images.js dynamically imports sharp for PDF image conversion; possible approved-file input path. Exploitability untested |
| Worker zod | 3.25.76 | Different installed branch from core; do not assume one fixed version solves both |
| Other packages | See JSON | URI/parser/resource behavior and transitive propagation require advisory-specific reachability tests |

The installer pins managed DC 0.2.50/Tunnel 0.0.11, and core dependencies include exact versions. A registry fix suggestion is not a supported upgrade decision. Do not apply audit fix/force, replace managed binaries or silently change vendor source. Test malformed inputs/resource bounds only in the isolated environment, preserving path, skills, session and restart regressions. Maintain separate findings for presence, reachability and exploitation. See advisory URLs and fixed ranges in the JSON rather than inferring a patch from package age.

## Server policy inspection

Managed worker dist/server.js registers set_config_value, start_process, interact_with_process, force_terminate and kill_process and dispatches them. The targeted search found no supported allowedTools/disabledTools/blockedTools filter in that installed worker. DWB src/broker-server.ts merges upstream tools into list_tools and forwards worker calls. Its supported tunnel-mcp.mjs removes the runtime key then imports start.mjs; no supported command override/filter hook was found in the inspected files.

This is a targeted negative finding, not proof that no future supported mechanism exists. No dangerous command was executed to demonstrate exposure. Existing local evidence already establishes filesystem denials while process tools remain exposed. A custom gateway would need both listing AND call dispatch enforcement, configuration-mutation denial, a supported DWB integration point and adversarial tests. Editing generated Tunnel profiles on every Start or injecting undocumented loader hooks was not deployed as a workaround.

OS standard-user preparation does not close MCP tool exposure or all OS access automatically. Owner-created identity/VM, exact ACL/input/environment tests, dependency disposition and actual Chat-host calls remain required. No primary-user unrestricted shell was granted; Tunnel stays stopped.
