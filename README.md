# Chat_Hand

Windows local AI integration audit and a reproducible, synthetic file probe.

**V2 status: PARTIAL (2026-10-29, Asia/Bangkok).** Remote Desktop Commander is Online and a connector file read succeeded from this Codex host. The sandbox-only denial test FAILED: current `allowedDirectories: []` is unrestricted. Ordinary ChatGPT web-host acceptance and independent-provider coding remain pending. No new runtime was installed.

Start with [V2_REPORT.md](docs/V2_REPORT.md) and [owner steps in Thai](docs/V2_OWNER_STEPS.th.md). Historical V1 details remain in [FINAL_REPORT.md](docs/FINAL_REPORT.md). Unresolved questions for ChatGPT Research are in [RESEARCH_HANDOFF.md](docs/RESEARCH_HANDOFF.md).

```powershell
powershell -NoProfile -File .\scripts\Get-Preflight.ps1
powershell -NoProfile -File .\scripts\Test-LocalSandbox.ps1
powershell -NoProfile -File .\scripts\Test-Repository.ps1
```

The probe uses normal local filesystem access. It does not implement MCP, OS isolation, or a directory access policy. Keep production projects and secrets outside the remote pilot. No dependency install or administrator access is required.

[Coding trial specification](benchmark/TASK.md): evaluate an independent model in a separate worktree. The starter intentionally fails; checker self-tests passing do not mean an AI trial passed. Windows CI checks only local artifacts.
