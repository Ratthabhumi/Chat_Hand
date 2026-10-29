## V3.2 owner execution checked — 2026-10-29

**BLOCKED at setup-dwb.** The returned pilot-result.json confirms the actual pilot identity, no administrator token, payload integrity PASS and Windows-local synthetic write/read/delete PASS. Protected-fixture denial is NOT VERIFIED (unexpected filesystem error). DWB setup did not finish; seven-skill import, managed component versions, workspace policy, process ownership, MCP calls and hosted Chat acceptance are not verified under this identity. No credentials copied or cloud start reported. This supersedes earlier wording that owner execution was pending.

The current original-account process cannot read the pilot setup log: Windows denies access. No ACL bypass, reinstall, dependency patch, new credentials, cloud start or production modification performed. Root cause is UNKNOWN. A read-only pilot diagnostic classifies fixed error categories from existing vendor result/private log, checks the synthetic fixture through nested exception types, and exports no raw messages/paths. Its original-account refusal passed; its positive pilot path is pending. See [owner diagnostic steps](RESTRICTED_PILOT_V32.th.md). Existing shell-tool restrictions, advisory triage and timeout/restart gates remain unresolved; hosted Tunnel stays NO-GO. Existing original installation remains retained; live Remote Desktop Commander availability was not retested in this continuation.

# Installation and operating instructions

V3.2 migration is staged, not completed: [restricted pilot instructions](RESTRICTED_PILOT_V32.th.md). Existing account/profile verified, but current Codex cannot execute as that user without owner interactive action. Verified artifacts only are staged under ProgramData with explicit minimal ACLs. Do not expose the main profile or transfer old credentials/node_modules. Do not rerun original-user Setup; owner runs the guarded bootstrap under pilot. No account creation, key provisioning or vendor-source change performed.

## V3.1 owner action

Owner already has Tunnel/key; reuse after security acceptance, do not provision again. Current pilot inspection found no local settings/profile/key.dpapi. Owner has no isolated Windows environment and requested [these exact account-preparation steps](OWNER_ACCOUNT_SETUP.th.md). Do not open the primary profile to another user just to reuse its installation. No migration, credential entry or cloud start was performed. Skills collection now seven, not a new MCP stack; see [catalog](SKILLS_CATALOG.md).

## V3 installed pilot — 2026-10-29

- Application: `%LOCALAPPDATA%\ChatHand\DWB-beta16`
- DWB-managed data/config: `%LOCALAPPDATA%\DWB-MCP-Studio-ChatHand\config.json`
- Managed worker: application `external\desktop-commander`, Desktop Commander 0.2.50
- Managed Tunnel: application `external\tunnel-client\tunnel-client.exe`, 0.0.11+8d55683
- Workspace: this checkout's absolute `sandbox` path; workerCap=1; base-policy allowlist contains exactly that nonempty path
- Preferences: startWithWindows=false, connectOnStartup=false. Initial skill count was zero; current collection is five reviewed MANUAL/ASK packages plus two unreviewed extras forced MANUAL in defaults and overrides. See [AGENT_SKILLS.md](AGENT_SKILLS.md).

The official Windows ZIP was downloaded from the beta.16 GitHub release, checksum verified against both the companion file and GitHub metadata (`cd94f308829515f9a4e3d381c9f9266859124bfb47f47aeda9992377f0c19de2`), then extracted into a new application directory. The reviewed Setup backend `scripts/setup-install.ps1` was executed with a JSON request containing the existing sandbox path and workerCap=1, and process-scoped DWB_DATA_DIR/DWB_CONFIG_FILE pointing to the new data directory. DWB itself installed its dependencies and managed components. No parallel manual server/tunnel was installed.

For reproduction, use the same verified ZIP, fresh app/data directories, Node >=22.16 and the official Setup UI/backend. Do not overwrite an existing data directory or rerun setup blindly. Review new package/advisory results before execution. The managed installer pins worker 0.2.50 and Tunnel 0.0.11, verifies the Tunnel ZIP checksum and rejects different versions. No binary substitution was made.

The bundled launcher is unsigned (Authenticode NotSigned); GitHub origin/checksum is provenance evidence, not a signed publisher identity. The inspected launcher source uses an execution-policy override. This run instead invoked the reviewed PowerShell backend/app scripts without an ExecutionPolicy override, administrator elevation, security-warning bypass or security-setting change. Setup succeeded under the existing account. No Windows warning was bypassed.

Local `doctor.mjs` passed. The Dashboard host was launched and reports a responding window titled DWB Core Dashboard; no credential fields were entered. GUI element-level acceptance is not established by that process/window observation.

**Owner next actions (Thai):**

1. ยังไม่กด Start MCP: ให้ Research/ผู้ดูแลตรวจ advisory และจัดขอบเขต shell ก่อน เช่นบัญชี Windows สิทธิ์ต่ำหรือ VM ที่ตรวจ ACL จริง การจำกัด workspace อย่างเดียวไม่พอ การสร้างบัญชี/เปลี่ยน ACL ต้องได้รับอนุมัติแยก; ยังไม่ได้ทำในรอบนี้
2. เมื่อ security gates ผ่านแล้ว ให้คุณล็อกอิน Platform เอง ยืนยัน organization/workspace และสิทธิ์ Tunnels Read+Manage สำหรับสร้าง กับ Read+Use สำหรับ runtime พร้อมสิทธิ์ Custom MCP ใน ChatGPT
3. สร้าง Tunnel สำหรับ pilot และ dedicated runtime key สิทธิ์ขั้นต่ำ; ผูกกับ ChatGPT workspace ที่ถูกต้อง กรอก Tunnel ID/key ในหน้าตั้งค่า Tunnel ของ DWB เอง ห้ามส่ง key ในแชทหรือ Git
4. เปิด ChatGPT Chat ปกติ เพิ่ม Custom MCP ผ่าน Tunnel เดียวกัน แล้วเรียก dwb_broker_status, dwb_session_status และ workspace bind ก่อนอ่าน hello.txt เก็บหลักฐาน host จริง
5. ทดสอบ denial, shell containment, เขียน/อ่านกลับ/ลบไฟล์จำลอง, สองแชท และ reconnect/stop ตาม ACCEPTANCE_TESTS.md ก่อนอนุญาตข้อมูลจริง

Current official [Tunnel guide](https://developers.openai.com/api/docs/guides/secure-mcp-tunnels) describes account/workspace requirements. The managed 0.0.11 client exposes `doctor --help`; no credentialed health/readiness check was performed because a profile/key was not provisioned. Hosted compatibility remains unverified. Do not assume current upstream CLI/profile features all exist in 0.0.11.

## Historical V1/V2 instructions

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
