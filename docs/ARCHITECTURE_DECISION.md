# Architecture decision

## V3 owner decision — 2026-10-29

DWB MCP Studio beta.16 + its managed OpenAI Secure MCP Tunnel is now the selected unified architecture. This supersedes the V2 preference; do not resume coding-agent comparisons. Preserve the existing Remote Desktop Commander as rollback, without changing its shared configuration or session.

Installation is approved and completed locally, not approved for cloud acceptance by inference. DWB forwards process tools; filesystem denial does not contain shell access. Keep hosted Tunnel stopped until shell is disabled by a verified supported mechanism or an owner-approved OS boundary is established and tested. Dependency advisories must also be triaged. Current status PARTIAL.

Future profiles are prepared as approval requirements, with **no production roots activated**:

| Profile | Activation gate |
|---|---|
| ACASH | Read-only root approval, governance preserved, NO_REAL_ORDERS=true, capital USD 0.00; no live/paper/provider execution |
| -SEED | Explicit isolated worktree, one writer, tests and PR |
| EIMS | Sanitized diagnostics only; no customer credentials/configurations/device administration |
| Agent OS | Separately approved narrow root; exclude memory, credentials and backups |

One sandbox/worker, five reviewed MANUAL/ASK skills, two unreviewed retained extras forced MANUAL, no startup or automatic connection. Agent Skills belong to V3. Dashboard remains disconnected pending owner gates. See [AGENT_SKILLS.md](AGENT_SKILLS.md); skill workflow policy is not OS containment.

## V2 update — 2026-10-29

Use two independent routes where verified: ordinary Chat + existing remote connector, and an independent-provider coding agent. Neither is fully accepted yet. Remote read works from Codex, but current directory restrictions fail. Antigravity/OpenCode desktop apps are already installed; evaluate those before adding software. Work shares Codex included allowance, so changing to Work is not a quota reset. See [V2 report](V2_REPORT.md).

## Historical V1 decision — 2026-10-28

**GO: A, existing Codex + GitHub + local tools. Remote extension remains BLOCKED.**

| Option | Complexity / maintenance | Access / sessions | Cost / performance | Decision |
|---|---|---|---|---|
| A. Existing tools | No extra runtime | Local Codex verified; remote device offline; coordinate edits with Git | No new service provisioned; existing account terms apply; no benchmark | Select baseline; first restore existing remote connection |
| B. Filesystem MCP + official Tunnel | Additional server, client and account associations | Requires real path-denial and ChatGPT tests | Account eligibility/cost unknown; no benchmark | Defer until existing route proves insufficient |
| C. DWB + managed DC + Tunnel | Extra broker, workers and dependencies | More session features; isolation unverified | Additional resource demand; no benchmark | NO-GO for installation in this run; review incomplete |

DWB beta.16 README names Desktop Commander 0.2.50 and Tunnel 0.0.11. Official tunnel latest is v0.0.18. Version difference alone proves neither vulnerability nor incompatibility. No managed binary replacement was attempted.

Do not scale workers while remote access is unverified. Choose one writer per project; broker locks cannot be assumed to cover direct Codex writes. ACASH remains read-only, NO_REAL_ORDERS=true, capital USD 0.00, no live/paper/provider execution authorized.

Sources checked: [DWB README](https://github.com/sphakanin/dwb-mcp-studio-public), [OpenAI release](https://github.com/openai/tunnel-client/releases/tag/v0.0.18), [Secure MCP Tunnel](https://developers.openai.com/api/docs/guides/secure-mcp-tunnels).
