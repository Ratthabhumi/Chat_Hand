## V3.5 current status — 2026-10-30

**BLOCKED pending corrected Pilot execution.** Preserved owner V3.4 result (staging-readiness-and-lock-pin, installerAttempts 0, HRESULT -2147024809) in evidence/v3.5-owner-recovery-result.json. Confirmed a recovery-code bug with a synthetic npm lock: Windows PowerShell 5.1 ConvertFrom-Json rejects packages[""] with PSArgumentException / Argument,Microsoft.PowerShell.Commands.ConvertFromJsonCommand / that exact HRESULT. The old expression was Get-Content package-lock.json -Raw | ConvertFrom-Json. Exact historical Pilot failing expression is still awaiting per-operation live evidence; original vendor installer interruption remains UNKNOWN.

Corrected lock parsing uses existing Node JSON.parse and emits only structural booleans, retaining exact worker 0.2.50, registry URL and SRI format constraints; invalid schema/entry/version/URL/SRI remains rejected. Added individual staging checkpoints, safe error class/FQID/HRESULT/line, read-only legacy parser probe and optional -PreflightOnly mode. A corrected invocation performs this read-only stage before promotion, avoiding another owner diagnostic cycle. If the same actual lock reproduces the legacy failure and the new validator confirms its empty root, the live report identifies that recovery defect as verified. Private paths/messages are never exported.

Original v34 result/logs remain intact; v35 writes a separate result. Source verification, process/lock/identity guards, persistent one-attempt marker and one-use helper remain unchanged. The previous result stopped before the marker, but its actual absence MUST be verified live; it is never reset. No Pilot repair/worker promotion/installer was run by Codex. Original 39-file payload remains unchanged; corrected recovery and validator are separate additions. Windows PowerShell regression reproduces the old failure and accepts the same lock via the actual corrected CLI; tests reject wrong pins and preserve stderr/exit handling. See [one current owner command](RESTRICTED_PILOT_V32.th.md).

DWB/managed components/doctor/seven-skill acceptance still await successful Pilot continuation. No implicit residual-risk acceptance, dependency update, shell/tool exclusion, reliable restart or ordinary Chat E2E is claimed. Cloud stays OFF. Earlier sections are historical.

## V3.4 current status — 2026-10-29

**BLOCKED pending one Pilot recovery execution; historical root cause UNKNOWN.** Actual owner external diagnostic is preserved in evidence/v3.4-owner-external-diagnostic.json. The neutral protected fixture returned ACCESS_DENIED and public control PASS under pilot; this proves only the tested file-content boundary, not shell/network/profile-wide containment. Source integrity passed, a single worker staging package reports 0.2.50, managed tunnel/config/result are absent. Locks were available at the diagnostic snapshot; npm cache exit zero remains uncorrelated. No completed worker installation, crash, npm failure or timeout is inferred.

Prepared scripts/Repair-RestrictedExternal.ps1 and one-use Invoke-PilotVendorSetup.ps1. Under the existing non-admin pilot token only, recovery checks original release files against the verified ZIP, original payload hashes, ownership/reparse paths, existing exact request/preferences, relevant pilot process conflicts, exclusive vendor locks, one staging candidate, vendor Get-DwbWorkerState readiness and exact registry/version/SHA-512 lock metadata. These checks do not amount to a complete transitive package-content audit. It moves verified staging to the absent expected worker target without deleting/copying it, records a persistent attempt marker, then executes the unchanged supported vendor setup ONCE with private logs owned by the child. The child enforces pilot identity and one-use invocation. No old setup command is requested.

The replacement launch path avoids native PowerShell all-stream redirection at the parent-child boundary, captures numeric exit status, and leaves original logs/source intact. A Windows PowerShell synthetic regression exercises the actual JSON transport: quoted arguments and stderr survive, nonzero exit is rejected. This proves transport behavior, not the cause of the historical interruption. A 20-minute installer wait reports IN_PROGRESS and retains the child; never launch another attempt while it remains active. Persistent markers block automatic retries even after partial failure. Do not manually remove markers to retry.

On successful vendor result, the same action checks doctor, exact sandbox/workerCap, imports only seven pinned skills, checks hashes/default/workspace policies and startup/autoconnect disabled. It does not start the Dashboard, broker, MCP worker or hosted connection; skills instruction delivery/restart and real process/session/hosted acceptance remain untested. The vendor installer may install missing dependencies and download its managed 0.0.11 tunnel client; this is not opening a cloud tunnel. Existing dependency/tool-filter/residual-risk/reliability gates remain unresolved. Main-user DWB/Remote installations are retained; no production project touched.

Current work is PREPARED_NOT_EXECUTED under Pilot. See [one integrity-checked recovery command](RESTRICTED_PILOT_V32.th.md) and evidence/v3.4-recovery-preparation.json. CI covers source/identity guards and synthetic transport; no pilot installation/hosted success is claimed. Earlier sections below are historical.

## V3.3 current status — 2026-10-29

**BLOCKED; root cause UNKNOWN.** Actual pilot diagnostic is preserved in evidence/v3.3-owner-diagnostic.json: Node available, package present, config/result absent, phase external, log present with no matched signals. Empty signals do not imply success. Main-account inspection confirms original harmless fixture still exists; pilot missing-path result remains inconclusive. One PowerShell process owner was unresolved from the main identity, so no claim of installer absence is made.

Reviewed installed beta.16 source: external installs pinned worker via npm before checksummed tunnel download; catch normally writes result. Invoke-DwbNode can forward stderr after exit zero, while our bootstrap uses Stop with native stream redirection. This is a hypothesis requiring private-log evidence, not a confirmed failure cause. No repair/retry, source patch, managed dependency substitution, cloud activation or risk acceptance was applied.

Prepared Get-RestrictedExternalDiagnostic.ps1: guarded pilot-only, verifies three vendor scripts against the SHA-256-verified original archive, reads execution policies, Node/npm version, owned/unresolved process roles (never command lines), exclusive-read lock status without creating locks, staging metadata, file presence and fixed private-log classifications. It does not execute npm installs, tunnel binaries, vendor scripts or network probes. Process snapshot/lock availability alone cannot establish crash, timeout, termination or stale lock. Positive execution under pilot remains pending. A new harmless protected file under the traversable neutral bundle has owner/System/Administrators-only ACL, plus a harmless public control. Original fixture/payload/profile ACLs remain unchanged; new effective pilot denial is NOT TESTED.

See [one integrity-checked owner command](RESTRICTED_PILOT_V32.th.md). All actual pilot installation/version/doctor/runtime, seven-skill import/activation/persistence, advisory/tool/OS/reliability gates and ordinary Chat E2E remain unaccepted. Tunnel stays OFF; original installations remain retained. CI covers repository artifacts and identity refusal, not runtime acceptance. Earlier sections are historical.

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
