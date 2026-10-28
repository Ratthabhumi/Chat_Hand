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
