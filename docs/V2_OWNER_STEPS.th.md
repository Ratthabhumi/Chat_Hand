# ทำต่อโดยใช้โทเคนสั้น ๆ

ผลวันที่ 29 ตุลาคม 2026: เครื่อง Online และอ่าน hello.txt ผ่าน connector ได้แล้ว แต่ config ปัจจุบันไม่จำกัดโฟลเดอร์ จึงยังไม่ผ่าน pilot ที่ปลอดภัยตามขอบเขตที่กำหนด

1. ในการตั้งค่า Desktop Commander เดิม ตรวจว่าใช้กับงาน/แชทอื่นใดบ้าง ก่อนจำกัด `allowedDirectories` ให้เป็น array ที่มี absolute path ของ `Chat_HAND\sandbox` เพียงรายการเดียวสำหรับ pilot นี้ อย่าใช้ `[]` เพราะหมายถึงเปิดทุก path ในรุ่นที่ตรวจ หากกระทบงานอื่น ให้แยกบัญชี OS หรือ agent สำหรับ pilot ก่อน ไม่เปลี่ยนของกลางทันที
2. Shell/terminal เป็นสิทธิ์อีกส่วนหนึ่ง การจำกัด filesystem ไม่ใช่การกัก shell ให้อยู่ในโฟลเดอร์ ต้องปิด/จำกัดเครื่องมือ shell ตามความสามารถจริงหรือใช้ OS isolation ก่อนอ้างว่าปลอดภัย
3. ใน **ChatGPT Chat ปกติบนเว็บ** เปิด connector แล้วสั่งอ่าน absolute path ของ `sandbox/hello.txt` ให้ได้ข้อความ `Chat_Hand sandbox: synthetic data only. No production access authorized.` เก็บผลว่าเรียกจาก Chat ปกติ ไม่ใช่ Codex/Work
4. ให้ทดสอบปฏิเสธไฟล์จำลองนอก sandbox ก่อน ถ้ายังอ่านได้ให้หยุด ไม่ทดสอบเขียน จากนั้นจึงสร้าง/อ่านกลับ/ลบไฟล์ชื่อเฉพาะใน `sandbox/test-output` และทดสอบ reconnect/disconnect เมื่อไม่มีแชทอื่นใช้ agent

สำหรับ coding fallback:

เกณฑ์คะแนน 30/25/20/15/10 อยู่ใน [ตารางเปรียบเทียบ](FALLBACK_COMPARISON.md) ยังไม่มีผู้ชนะจนกว่าจะมีผลจริง OpenCode ที่พบเป็นรุ่น 1.19.5 ไม่ใช่ V2 ที่ยืนยันแล้ว ส่วนคำสั่ง status/start/stop แบบไม่เพิ่ม startup อยู่ใน [OPERATIONS.md](OPERATIONS.md)

1. เปิด Antigravity เดิมไว้ให้แล้ว พบปุ่ม Restart to Update และ workspace เดิมขึ้น Missing Folder ให้ตรวจอัปเดตโดยบันทึกงานเดิมก่อน แล้วเลือก worktree ทดลองใหม่ตามด้านล่าง ไม่ต้องแก้ workspace อื่น ตรวจ quota/แผนและเลือก provider/model ที่แยกจาก OpenAI; อย่าเปิด billing เพื่อทดสอบโดยไม่ตั้งใจ รุ่นที่พบยังไม่ใช่ผล benchmark
2. ใช้ branch V2 นี้ก่อนรันคำสั่งสร้าง worktree จาก repo โดยเปลี่ยนชื่อหากมีอยู่แล้ว:

```powershell
git worktree add -b pilot-antigravity ../Chat_Hand-antigravity HEAD
```

3. เปิดเฉพาะ worktree ใหม่ใน Antigravity แล้วส่งข้อความใน [TASK.md](../benchmark/TASK.md) ให้แก้เฉพาะ `benchmark/sum-cents.cjs` หนึ่งงาน
4. ตรวจ diff ก่อนรันโค้ด จากนั้นใน worktree นั้นรัน `node scripts/check-fallback.cjs benchmark/sum-cents.cjs` จด provider/model, เวลา, ครั้งที่ลอง, ผล 11 ข้อ, ค่าใช้จ่ายที่เห็นหรือ UNKNOWN และไฟล์ที่แก้ อย่าส่ง token/บัญชี/ภาพข้อมูลส่วนตัวขึ้น public repo
5. ถ้า Google ใช้ไม่ได้ ให้ทดลอง OpenCode เดิมบน worktree อีกชุด โดยเลือก provider ที่แยกจาก OpenAI และตรวจราคาเองก่อน ยังไม่ต้องติดตั้ง Cline/OpenHands

การทดสอบหนึ่งงานไม่ใช่หลักฐานว่า agent ใดดีที่สุด และการเปลี่ยนแอปไม่รับประกันว่าได้ quota ใหม่
