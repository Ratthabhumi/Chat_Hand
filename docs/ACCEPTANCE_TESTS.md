# Actual acceptance evidence

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
