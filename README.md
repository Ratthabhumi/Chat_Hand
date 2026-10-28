# Chat_Hand

Windows local AI integration audit and a reproducible, synthetic file probe.

**Status: PARTIAL / remote access BLOCKED (2026-10-28, Asia/Bangkok).**
Codex local reads/writes work. Existing Remote Desktop Commander reports its device offline. No ChatGPT-web file invocation has succeeded in this run. DWB and OpenAI Tunnel were not installed.

Start with [FINAL_REPORT.md](docs/FINAL_REPORT.md), then [INSTALLATION.md](docs/INSTALLATION.md). Unresolved questions for ChatGPT Research are in [RESEARCH_HANDOFF.md](docs/RESEARCH_HANDOFF.md).

```powershell
powershell -NoProfile -File .\scripts\Get-Preflight.ps1
powershell -NoProfile -File .\scripts\Test-LocalSandbox.ps1
```

The probe uses normal local filesystem access. It does not implement MCP, OS isolation, or a directory access policy. Keep production projects and secrets outside the remote pilot. No dependency install or administrator access is required.
