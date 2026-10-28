# Architecture decision

**GO: A, existing Codex + GitHub + local tools. Remote extension remains BLOCKED.**

| Option | Complexity / maintenance | Access / sessions | Cost / performance | Decision |
|---|---|---|---|---|
| A. Existing tools | No extra runtime | Local Codex verified; remote device offline; coordinate edits with Git | No new service provisioned; existing account terms apply; no benchmark | Select baseline; first restore existing remote connection |
| B. Filesystem MCP + official Tunnel | Additional server, client and account associations | Requires real path-denial and ChatGPT tests | Account eligibility/cost unknown; no benchmark | Defer until existing route proves insufficient |
| C. DWB + managed DC + Tunnel | Extra broker, workers and dependencies | More session features; isolation unverified | Additional resource demand; no benchmark | NO-GO for installation in this run; review incomplete |

DWB beta.16 README names Desktop Commander 0.2.50 and Tunnel 0.0.11. Official tunnel latest is v0.0.18. Version difference alone proves neither vulnerability nor incompatibility. No managed binary replacement was attempted.

Do not scale workers while remote access is unverified. Choose one writer per project; broker locks cannot be assumed to cover direct Codex writes. ACASH remains read-only, NO_REAL_ORDERS=true, capital USD 0.00, no live/paper/provider execution authorized.

Sources checked: [DWB README](https://github.com/sphakanin/dwb-mcp-studio-public), [OpenAI release](https://github.com/openai/tunnel-client/releases/tag/v0.0.18), [Secure MCP Tunnel](https://developers.openai.com/api/docs/guides/secure-mcp-tunnels).
