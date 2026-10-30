# ขั้นตอนเดียวที่ต้องเตรียมก่อนดำเนินการต่อ

**V3.2: บัญชีสร้างแล้วและตรวจ Standard User/profile แล้ว ไม่ต้องทำขั้นตอนสร้างด้านล่างซ้ำ ใช้ [คำสั่งรับช่วงจากบัญชี Pilot](RESTRICTED_PILOT_V32.th.md) แทน ข้อความเดิมต่อไปนี้เป็นประวัติ V3.1**

คุณแจ้งว่ามี Tunnel และ key แล้ว: **ไม่ต้องสร้างใหม่หรือส่ง key ในแชท** ผลตรวจครั้งนี้พบว่า pilot ยังไม่มี settings/profile/key.dpapi และ Tunnel หยุดอยู่ เจ้าของยืนยันว่าตอนนี้ยังไม่มีบัญชี/VM แยก จึงยังไม่เปิด cloud

## สร้างบัญชี Windows มาตรฐานด้วยตัวเอง

การทดสอบล่าสุดมี timeout และ safe stop เคยตอบ DWB_UPGRADE_BUSY; ไม่ได้ force-kill ผลตรวจภายหลังพบไม่มีคำขอ/worker ค้าง จึงใช้ graceful stop ได้อีกหนึ่งครั้ง ดูสถานะสุดท้ายใน evidence/v3.1-final-status.json หากคุณพบงานค้างใน Dashboard ให้จบงานก่อนเปลี่ยนบัญชี ไม่ฆ่า Node ทุกตัว

1. บันทึกงานเดิม เปิด **Settings → Accounts → Other users → Add account**
2. เลือก **I don't have this person's sign-in information → Add a user without a Microsoft account**
3. ตั้งชื่อเช่น `ChatHandPilot` และตั้งรหัสผ่านเอง ไม่ส่งรหัสผ่านให้ AI
4. ตรวจ **Change account type → Standard User** ไม่เพิ่มเป็น Administrator ไม่ลดสิทธิ์หรือเปลี่ยนบัญชีหลัก หาก Windows ขอสิทธิ์ผู้ดูแล ให้เจ้าของเครื่องจัดการเอง
5. เลือก Switch user แล้วล็อกอินบัญชีใหม่หนึ่งครั้ง จากนั้นแจ้งเพียงว่า “สร้าง ChatHandPilot แล้ว” ไม่ต้องส่งรหัสผ่านหรือ key

ขั้นตอนเมนูอ้างอิง [Microsoft Support](https://support.microsoft.com/en-us/windows/security/identity-signin/manage-user-accounts-in-windows) บัญชีมาตรฐานเป็นจุดเริ่มต้น ไม่ใช่ sandbox ที่พิสูจน์แล้ว

## ยังไม่ต้องทำขั้นต่อไปนี้เอง

- ยังไม่กด Start MCP ไม่คัดลอก key/device session/DPAPI จากบัญชีหลักไปบัญชีใหม่
- ไม่แชร์ทั้ง drive, โฟลเดอร์ผู้ใช้, repo จริง, browser profile, SSH/Git credentials หรือ OneDrive ให้บัญชี pilot
- ไม่เปิด firewall/remote login/auto-start และไม่ใช้ Run as administrator เพื่อให้ DWB ผ่านข้อจำกัด

เมื่อบัญชีพร้อม จะตรวจ identity, สิทธิ์อ่าน/เขียน, การเข้าถึงโฟลเดอร์หลักที่ไม่ได้อนุญาต, junction และตัวอย่าง environment ที่เป็นข้อมูลจำลองก่อน ห้ามทดลองด้วยไฟล์ลับจริง หากต้องแก้ ACL จะเสนอ path/สิทธิ์ที่แน่นอนให้อนุมัติก่อน ไม่เปิดสิทธิ์ Users/Everyone แบบกว้าง

DWB ที่อยู่ใต้ LOCALAPPDATA ของบัญชีหลักไม่ควรถูกเปิดสิทธิ์ทั้ง profile เพื่อให้บัญชีใหม่ใช้ได้ ต้องวางแผนย้าย/จัดชุด runtime สำหรับ identity ใหม่เฉพาะจุด โดยเก็บ instance เก่าไว้จนตรวจรับสำเร็จ ไม่มีการสร้างบัญชีหรือเปลี่ยน ACL ในรอบนี้

หากต้องกัก filesystem/network/process ให้เข้มกว่าบัญชีมาตรฐาน จะต้องใช้ VM ที่ไม่แชร์ host drive/clipboard/credentials และทดสอบแยก ไม่มีการซื้อหรือติดตั้ง VM ในรอบนี้

## ใช้ Tunnel/key เดิมหลังผ่าน gates

ตรวจ advisory และขอบเขต OS/server ก่อน จากนั้นเจ้าของตรวจ org/workspace และ runtime key ที่มีสิทธิ์ Tunnels Read+Use แล้วกรอกเองใน DWB ของ identity ที่ผ่านการทดสอบ ตั้ง Remember key/auto-connect/startup ปิดใน pilot แรก สร้าง Custom MCP Plugin ใน ChatGPT ด้วย Tunnel เดิมและทดสอบ Chat ปกติจริง การมี key ไม่ได้ยืนยัน entitlement หรือ protocol readiness

บัญชีใหม่ยังไม่แก้ advisory โดยอัตโนมัติ และไม่ได้ผ่านข้อกำหนด “ไม่ expose/call เครื่องมือที่ไม่อนุญาต” ฝั่ง MCP ต้องทดสอบหรือเพิ่ม gateway ที่รองรับก่อนเช่นกัน การเปิด cloud จึงยัง NO-GO จนผ่านทั้งสองชั้น
