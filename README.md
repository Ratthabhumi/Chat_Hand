# Chat_Hand

Windows local AI integration audit and a reproducible, synthetic file probe.

**V3 status: PARTIAL (2026-10-29, Asia/Bangkok).** Owner selected DWB MCP Studio + its managed OpenAI Tunnel. Installed isolated beta.16 with one worker and an explicit sandbox allowlist. Local MCP reads and outside/traversal/junction denial passed. Shell confinement FAILED and dependency advisories remain, so the cloud tunnel is stopped and ChatGPT E2E is unverified. V1/V2 evidence is preserved.

Start with [FINAL_REPORT.md](docs/FINAL_REPORT.md), [INSTALLATION.md](docs/INSTALLATION.md) and [OPERATIONS.md](docs/OPERATIONS.md). Unresolved source/security questions are in [RESEARCH_HANDOFF.md](docs/RESEARCH_HANDOFF.md). The old [V2 report](docs/V2_REPORT.md) is historical; coding fallback work is paused by the V3 owner decision.

```powershell
powershell -NoProfile -File .\scripts\Get-Preflight.ps1
powershell -NoProfile -File .\scripts\Test-LocalSandbox.ps1
powershell -NoProfile -File .\scripts\Test-Repository.ps1
```

The probe uses normal local filesystem access. It does not implement MCP, OS isolation, or a directory access policy. Keep production projects and secrets outside the remote pilot. No dependency install or administrator access is required.

[Coding trial specification](benchmark/TASK.md): evaluate an independent model in a separate worktree. The starter intentionally fails; checker self-tests passing do not mean an AI trial passed. Windows CI checks only local artifacts.

[Comparison and scoring](docs/FALLBACK_COMPARISON.md) · [Status/start/stop/recovery](docs/OPERATIONS.md). OpenCode 1.19.5 was found locally; V2 has not been installed or verified.

```powershell
powershell -NoProfile -File .\scripts\Dwb-Pilot.ps1 -Action Status
powershell -NoProfile -File .\scripts\Dwb-Pilot.ps1 -Action Dashboard
```

Dashboard opens the local UI only. Do not connect the hosted tunnel until the shell/security review and owner account steps pass.

**Agent Skills are in V3:** five pinned/reviewed MANUAL/ASK packages installed; local MCP activation/denial checks passed. Two unreviewed extras found AUTO were retained and forced MANUAL. [Skills guide and exact owner Chat test](docs/AGENT_SKILLS.md). Real Chat-host activation remains pending; instruction delivery is not proof of model behavior or Tunnel E2E.

**V3.1 update:** seven reviewed instruction packages now installed (add MANUAL threat-model and frontend-design); original five pins preserved. [Coverage/backend catalog](docs/SKILLS_CATALOG.md), [dependency triage](docs/DEPENDENCY_TRIAGE.md), and [one owner account-preparation packet in Thai](docs/OWNER_ACCOUNT_SETUP.th.md). Owner already has Tunnel/key; do not create or share another key. Pilot profile/credential setup and OS/server gates remain unverified, so cloud stays stopped.
