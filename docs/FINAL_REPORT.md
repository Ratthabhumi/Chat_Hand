# Final report

Observed 2026-10-28 (Asia/Bangkok). **PARTIAL / external remote-access blocker.**

1. **Environment:** Windows 11 x64, Node 24.14.1, npm 11.11.0, Git 2.50.0.windows.1, Codex 0.165.0-alpha.1.2. GitHub authentication usable. Target repository was empty and public.
2. **Architecture:** reuse Codex + GitHub and restore existing Desktop Commander first. Defer additional filesystem MCP/Tunnel; DWB installation is NO-GO pending review and demonstrated need.
3. **Components:** installed none. Added synthetic sandbox, repeatable local probe/preflight scripts, sanitized evidence and operating documentation.
4. **Security:** no installer executed, credentials collected, remote endpoint exposed, firewall changed or production project modified by this work. This is not proof of runtime containment or a full source audit.
5. **Tests:** local reads, synthetic writes/readback and cleanup passed. Remote discovery returned Offline. Remote file calls, Inspector, boundary enforcement, sessions and Tunnel E2E remain unverified; see acceptance table.
6. **Integration status:** local Codex workflow available. ChatGPT-web-to-local workflow is BLOCKED; no claim of successful installation or connection.
7. **Owner actions:** bring the existing Desktop Commander device online, inspect/limit its pilot access, and invoke the fixture from the intended ChatGPT web chat. Custom tunnel credentials/permissions require owner participation only if that route is later selected. No approval is needed merely to read these reports.
8. **Operation:** run scripts from README; no daemon/startup required. Follow INSTALLATION.md for remote acceptance steps.
9. **Rollback:** local probe cleaned up its generated file. No integration installation to remove. Future disconnect/revocation steps documented, not tested here.
10. **Recommendation:** first prove the already available connection against synthetic files. Do not add workers or DWB based on feature count. Research the unresolved compatibility/source questions only if the existing route cannot satisfy the actual workflow.

The supplied four project boundaries remain in effect. Acash: read-only, no provider/live/paper execution. -SEED: preserve existing changes and one writer. EIMS: exclude customer details/credentials. AgentOS: do not expose private memory/backups. No project integration was enabled.

Publication includes only this standalone setup work. The pasted research and existing project/private files were not copied into the public repository. See RESEARCH_HANDOFF.md for a ready-to-copy research request and INSTALLATION.md for exact owner steps.
