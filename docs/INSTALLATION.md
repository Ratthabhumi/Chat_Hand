# Installation and operating instructions

**V2:** device already Online; do not launch a duplicate. Read [V2 owner steps](V2_OWNER_STEPS.th.md) before changing access policy or performing a model trial. `Test-Repository.ps1` validates local artifacts; `.github/workflows/acceptance.yml` runs it on Windows CI. Existing Antigravity/OpenCode desktop apps were found, so no reinstall was attempted. The remaining text records the V1 procedure, not the current Offline diagnosis.

No new MCP server, Inspector, DWB, Tunnel Client, service, startup item or npm package was installed. Reuse existing Codex and GitHub CLI. Sandbox is `sandbox/` inside this standalone repository; it contains only synthetic data.

Run from this repository:

```powershell
powershell -NoProfile -File .\scripts\Get-Preflight.ps1
powershell -NoProfile -File .\scripts\Test-LocalSandbox.ps1
```

The second command reads hello.txt, creates a unique output file, checks its contents, and removes it in a finally block. No persistent process needs starting or stopping. No execution-policy bypass is required or recommended.

## Owner step: restore the existing route

1. Open the existing Desktop Commander device app on the intended Windows machine. If it is not installed, stop here and check the device-management instructions rather than installing a second copy blindly.
2. Visit [Desktop Commander devices](https://mcp.desktopcommander.app/) and check that the intended device becomes Online. Reconnect/login in its UI if requested; do not paste credentials into chat.
3. Inspect the actual configured access policy. Allow only this repository's `sandbox` folder for the pilot, with one active writer. Do not assume device Online means filesystem policy is safe.
4. In the intended ChatGPT web chat, enable the existing connector and request a read of the absolute path to `sandbox/hello.txt`. Record whether the exact synthetic sentence is returned.
5. Only after successful reads and outside-scope denial checks with synthetic fixtures, request a unique write under `sandbox/test-output`, read it back, then delete that exact test file. Verify locally.
6. Test reconnect, stop/disconnect, denied access and separate sessions before approving broader use. Record results in ACCEPTANCE_TESTS.md; connected status alone is insufficient.

## If a custom OpenAI Tunnel is still needed

First establish the actual ChatGPT workspace and Platform organization, custom MCP rights, and tunnel associations. Official docs distinguish Tunnels Read+Manage for creation from Read+Use for runtime/plugin operation. These account permissions were not checked here.

Follow the current [official guide](https://developers.openai.com/api/docs/guides/secure-mcp-tunnels). After a reviewed client installation, inspect `tunnel-client help quickstart`, then run `tunnel-client doctor --profile <name> --explain`. Use secure local credential entry/environment references, never literal keys in tracked files or command arguments. No template here is a deployed tunnel configuration.

Updates: record versions, review upstream changes and rerun acceptance before changing a runtime. Never swap DWB's managed Tunnel version on the assumption that newer is compatible.
