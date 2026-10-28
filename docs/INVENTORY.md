# Existing environment audit

Observed 2026-10-28, Asia/Bangkok. See `evidence/preflight.json` for the reproducible sanitized snapshot. RAM/process counts are transient.

| Component | Observed evidence | Reuse / gap |
|---|---|---|
| Windows 11 Home Single Language, build 26200, x64 | CIM; current process not elevated | Reuse; no administrator change |
| RAM | 23.8 GB total, about 3.0 GB free at initial inspection | Avoid adding workers without measuring |
| Node.js / npm | v24.14.1 / 11.11.0 | Already installed |
| Git | 2.50.0.windows.1 | Already installed |
| Codex CLI | 0.165.0-alpha.1.2 | Local command/file access observed |
| GitHub CLI | Ratthabhumi authenticated via keyring; repository access verified | Reuse existing authentication; no key collected |
| Remote Desktop Commander | `list_devices`: one device, Offline, app 0.3.1, last seen 21h ago | Existing connection; remote file access blocked |
| OpenAI Tunnel Client | No command on PATH; no matching process found in scoped command-line classification | Not proof it is absent everywhere |
| DWB | No matching process or standard uninstall entry found | Not an exhaustive disk search |
| MCP configuration | Codex config section names show node_repl; environment subsection exists | Values deliberately not read or published; app plugins are separate |
| Agent processes | 53 matching node/python processes, unclassified by selected DWB/tunnel/DC/filesystem patterns | Do not terminate other sessions |
| Services / scheduled tasks | No names matching DWB/tunnel/commander/codex returned | Name filter only; not a complete service audit |
| Listening ports | Loopback and wildcard listeners already exist | Did not change them; owners/security not audited; raw endpoints withheld |
| Credential storage | GitHub reports keyring | DWB DPAPI and other app storage not verified |

Existing Acash, -SEED, EIMS directories are Git checkouts. -SEED and EIMS already have local changes; preserve them. AgentOS exists but its root is not a Git checkout, so its private nested architecture was not inspected. No duplicate project clones made.

This is a targeted inventory, not an independent security audit of every application or credential store.
