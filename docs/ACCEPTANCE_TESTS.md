# Actual acceptance evidence

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
| No startup / installed AUTO skills | PASS for configured false preferences and zero installed skills; future installs require review |
| Legacy Remote session/config | PASS: unchanged during first DWB probe; old connector rechecked separately |
| Dependency security | REVIEW REQUIRED: current audit core=6, worker=5 affected packages |

Reproduce using `Dwb-Pilot.ps1 -Action Status` and `Test-DwbPilot.mjs` with the three documented process-scoped DWB variables. The MCP probe intentionally exits 1 while shell confinement fails. This is a partial acceptance result, not a broken repository CI check. CI parses the probe but does not install DWB or run remote/credentialed tests. Local broker is stopped after a probe using Dwb-Pilot.ps1 -Action Stop; inspect fixtures after interruption.

Hosted owner sequence after security review: broker/session status, bind sandbox, exact read, synthetic outside denial, shell boundary test in the isolated OS environment, then one unique create/read/delete, two-chat identity/workspace separation, reconnect and stop causing fresh calls to fail. Keep credentials out of evidence.

## Historical V1/V2 evidence

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
