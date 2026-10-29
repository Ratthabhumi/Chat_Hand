# V3.2 — ใช้บัญชีที่มีแล้ว ไม่สร้างใหม่

ตรวจสด 29 ตุลาคม 2026: บัญชี pilot เปิดใช้งาน เป็นสมาชิก Users ไม่ใช่ Administrators และมี profile ลงทะเบียน/โหลดอยู่ แต่ Codex ปัจจุบันยังเป็นบัญชีหลัก การอ่าน LocalAppData ของ pilot จากบัญชีหลักถูกปฏิเสธ จึงไม่สรุปว่าโฟลเดอร์นั้นหาย และไม่ข้ามสิทธิ์

## เจ้าของทำเพียงขั้นตอนนี้

Switch user ไป **ChatHandPilot** ที่มีอยู่ เปิด PowerShell แบบปกติ **ไม่ Run as administrator** แล้วรัน:

```powershell
powershell -NoProfile -File C:\ProgramData\ChatHandPilot-Setup\scripts\Setup-RestrictedPilot.ps1
```

ไม่ต้องส่งรหัสผ่าน ไม่ต้องสร้าง Tunnel/key เพิ่ม ไม่ต้องกรอก key ในสคริปต์ และยังไม่กด Start MCP หาก Windows ขอนโยบาย/สิทธิ์เพิ่มเติม ให้หยุดและส่งข้อความ error ที่ลบข้อมูลลับแล้ว ไม่ใช้ ExecutionPolicy Bypass หรือเพิ่มบัญชีเป็น Administrator

สคริปต์จะตรวจ token ว่าเป็น pilot และไม่มีกลุ่ม Administrators ก่อนเขียนไฟล์/ดาวน์โหลด/เปิด process ถ้ารันจากบัญชีหลักจะตอบ BLOCKED_WRONG_IDENTITY พร้อม exit 2 โดยไม่ติดตั้ง ผลทดสอบ guard นี้ผ่านใน Windows PowerShell ของบัญชีหลัก

## ชุดส่งต่อที่เตรียมแล้ว

`%PROGRAMDATA%\ChatHandPilot-Setup` มีเพียง ZIP beta.16 ที่ตรวจ SHA-256 แล้ว, source ของ 7 skills ตาม lockfile พร้อม license/reference เดิม, ตัวติดตั้งสำหรับ identity ใหม่ และข้อมูลไฟล์จำลองทดสอบสิทธิ์ ไม่มี node_modules, key, browser/GitHub/SSH credential, session, SQLite/runtime เดิม หรือ DPAPI ถูกคัดลอก

โฟลเดอร์ payload มี ACL แยก: บัญชีหลัก/System/Administrators จัดการได้, pilot อ่าน/เรียกไฟล์ได้ ไม่มี Users/Everyone/Authenticated Users grant แบบกว้าง โฟลเดอร์ results ให้ pilot เขียนผล JSON ที่ลบข้อมูลอ่อนไหวแล้วได้ บัญชีหลักอ่านผลได้ การตั้ง ACL นี้ทำเฉพาะพื้นที่ใหม่และไฟล์จำลองใหม่ ไม่เปลี่ยน ACL ของ profile เดิมหรือโปรเจกต์จริง Effective pilot access ยังต้องพิสูจน์ตอนรันคำสั่ง

สคริปต์ตรวจ hash payload และ ZIP ก่อนใช้ ทดสอบปฏิเสธ harmless fixture ของบัญชีหลัก (ไม่ใช้ไฟล์ส่วนตัวจริง), ทดสอบ local read/write/readback/delete แล้วเตรียม DWB แยกใน LocalAppData ของ pilot โดยใช้ Setup backend เดิม งานดาวน์โหลด dependency ใหม่อาจจำเป็นเพราะไม่แชร์ node_modules ข้ามบัญชี แต่ไม่ติดตั้งทับชุดเดิม

App/data/workspace ใหม่ต้องมี NTFS owner เป็น pilot, workerCap=1, allowlist มี sandbox ใหม่รายการเดียว และปิด startup/auto-connect นำเข้าเฉพาะ 7 skills ที่ hash/policy ตรง ไม่คัดลอก GoLive/BRAG และไม่ reset package ที่ต่างจาก manifest โดยเงียบ ๆ หากมีของเดิมอยู่จะตรวจและหยุดเมื่อไม่ตรง ไม่ลบ/ติดตั้งวน

## ผลที่ต้องส่งกลับ

สคริปต์แสดง JSON แบบไม่ระบุ SID/ชื่อบัญชีหลัก/credential และเขียน `%PROGRAMDATA%\ChatHandPilot-Setup\results\pilot-result.json` ให้ Codex บัญชีหลักตรวจต่อได้ แจ้งเพียงว่า **รันแล้ว** ไม่ต้องส่งรหัสผ่าน/key หรือ raw log หากติดตั้งล้มเหลว log อยู่ใน LocalAppData ของ pilot เท่านั้น

เตรียม source สำเร็จไม่เท่ากับติดตั้งภายใต้ pilot แล้ว ผลในรอบนี้คือ **PARTIAL / รอ owner execution** ไม่มีการเรียกสคริปต์ติดตั้งด้วย token ของ pilot แทนคุณ

ยังไม่เปิด Dashboard/Broker/Worker/Tunnel อัตโนมัติ การตรวจ process owner จริง, MCP deny/call policy, shell/environment/network/IPC/secret isolation, dependency remediation, skill activation/restart และ ChatGPT Chat E2E ยังต้องทำต่อภายใต้ identity ใหม่ บัญชีมาตรฐานไม่ใช่ sandbox สมบูรณ์ ไม่มีการยอมรับ residual risk หรือเปลี่ยนข้อกำหนด server-side filtering โดยปริยาย

## Rollback

ชุดหลักและ Remote Desktop Commander ไม่เปลี่ยน รักษาไว้จน pilot ตรวจรับแล้ว การจัดเตรียมครั้งนี้ไม่สร้าง startup/service/account/key และไม่รัน cloud ถ้าต้องถอนชุดส่งต่อ ให้ตรวจผล/ไฟล์ที่สร้างก่อนและลบเฉพาะโฟลเดอร์ staging/fixture ใหม่ด้วยตัวเอง ไม่ลบบัญชีหรือ profile เดิมแบบ recursive สคริปต์ทดสอบลบเฉพาะไฟล์ probe ที่สร้างเอง การถอนติดตั้งสมบูรณ์ยังไม่ได้ทดสอบ
