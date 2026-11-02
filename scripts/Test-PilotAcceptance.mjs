// Chat_Hand V3.7 Local Pilot MCP Acceptance Test
// Executes local stdio MCP tests against DWB in ChatHandPilot restricted environment.
import assert from 'node:assert/strict';
import fs from 'node:fs';
import path from 'node:path';
import { createHash } from 'node:crypto';
import { createRequire } from 'node:module';
import { spawnSync } from 'node:child_process';
import { pathToFileURL, fileURLToPath } from 'node:url';

const app = process.env.DWB_INSTALL_DIR;
const data = process.env.DWB_DATA_DIR;
const configFile = process.env.DWB_CONFIG_FILE;

if (!app || !data || !configFile) {
  throw new Error('Environment variables DWB_INSTALL_DIR, DWB_DATA_DIR, DWB_CONFIG_FILE are required.');
}

const config = JSON.parse(fs.readFileSync(configFile, 'utf8'));
const workspace = path.resolve(config.workspace);
const basePolicy = JSON.parse(fs.readFileSync(config.basePolicy, 'utf8'));

// Verify configuration constraints
assert.equal(config.workerCap, 1, 'workerCap must be 1');
assert.deepEqual(basePolicy.allowedDirectories.map(p => path.resolve(p)), [workspace], 'allowedDirectories must match workspace');

const require = createRequire(path.join(app, 'package.json'));
const { Client } = await import(pathToFileURL(require.resolve('@modelcontextprotocol/sdk/client/index.js')).href);
const { StdioClientTransport } = await import(pathToFileURL(require.resolve('@modelcontextprotocol/sdk/client/stdio.js')).href);

const lockPath = process.env.DWB_SKILLS_LOCK || path.join(app, '..', '..', '..', 'ProgramData', 'ChatHandPilot-Setup', 'config', 'dwb-skills.lock.json');
let lock = null;
if (fs.existsSync(lockPath)) {
  lock = JSON.parse(fs.readFileSync(lockPath, 'utf8').replace(/^\uFEFF/, ''));
}

const client = new Client({ name: 'chathand-pilot-acceptance-v37', version: '3.7.0' });
const metaA = { 'openai/session': 'v1/chathand-session-a' };
const metaB = { 'openai/session': 'v1/chathand-session-b' };

const report = {
  observedUtc: new Date().toISOString(),
  environment: 'Local MCP stdio under ChatHandPilot; cloud OFF',
  workerCap: config.workerCap,
  workspace,
  tests: {},
  exposedTools: [],
  skillsSummary: []
};

const callA = (name, args = {}) => client.callTool({ name, arguments: args, _meta: metaA }, undefined, { timeout: 15000 });
const callB = (name, args = {}) => client.callTool({ name, arguments: args, _meta: metaB }, undefined, { timeout: 15000 });

async function checkDenied(targetPath) {
  try {
    const res = await callA('read_file', { path: targetPath });
    const text = (res.content || []).filter(c => c.type === 'text').map(c => c.text).join('\n');
    return res.isError === true && /outside|not allowed|access denied|denied|workspace/i.test(text) ? 'PASS' : 'FAIL';
  } catch (err) {
    return /outside|not allowed|access denied|denied|workspace/i.test(String(err)) ? 'PASS' : 'ERROR';
  }
}

// Temporary directory for out-of-scope testing
const outsideDir = path.join(data, `outside-probe-${Date.now()}`);
fs.mkdirSync(outsideDir, { recursive: true });
const outsideFile = path.join(outsideDir, 'outside-fixture.txt');
fs.writeFileSync(outsideFile, 'Out-of-scope synthetic test content.', 'utf8');
const junctionPath = path.join(workspace, `junction-probe-${Date.now()}`);

try {
  await client.connect(new StdioClientTransport({
    command: process.execPath,
    args: [path.join(app, 'scripts', 'start.mjs')],
    env: process.env,
    stderr: 'pipe'
  }));

  // 1. Broker & Session Status
  const broker = await callA('dwb_broker_status');
  report.tests.brokerStatus = broker.isError ? 'FAIL' : 'PASS';

  const sessionA = await callA('dwb_session_status');
  report.tests.sessionStatus = sessionA.isError ? 'FAIL' : 'PASS';

  // 2. Workspace Binding
  const bindA = await callA('workspace', { action: 'bind', path: workspace });
  report.tests.workspaceBind = bindA.isError ? 'FAIL' : 'PASS';

  // 3. Approved fixture read
  const helloFile = path.join(workspace, 'hello.txt');
  if (!fs.existsSync(helloFile)) {
    fs.writeFileSync(helloFile, 'Chat_Hand sandbox: synthetic data only. No production access authorized.', 'utf8');
  }
  const readHello = await callA('read_file', { path: helloFile });
  const helloExpected = fs.readFileSync(helloFile, 'utf8').trim();
  report.tests.approvedFixtureRead = (!readHello.isError && (readHello.content || []).some(c => c.text && c.text.includes(helloExpected))) ? 'PASS' : 'FAIL';

  // 4. Outside-root denial
  report.tests.outsideReadDenied = await checkDenied(outsideFile);

  // 5. Traversal denial
  const traversalTarget = path.join(workspace, '..', 'outside-traversal-test.txt');
  report.tests.traversalDenied = await checkDenied(traversalTarget);

  // 6. Junction denial
  try {
    fs.symlinkSync(outsideDir, junctionPath, 'junction');
    report.tests.junctionDenied = await checkDenied(path.join(junctionPath, 'outside-fixture.txt'));
  } catch {
    report.tests.junctionDenied = 'NOT TESTED: junction creation requires privilege or unsupported filesystem';
  }

  // 7. Synthetic create, readback, cleanup
  const probeName = `probe-${Date.now()}.txt`;
  const probePath = path.join(workspace, probeName);
  const probeContent = `synthetic-mcp-probe-${Date.now()}`;
  try {
    const writeRes = await callA('write_file', { path: probePath, content: probeContent });
    if (writeRes.isError) {
      report.tests.syntheticCreateReadbackCleanup = 'FAIL: write_file returned error';
    } else {
      const readbackRes = await callA('read_file', { path: probePath });
      const readbackText = (readbackRes.content || []).filter(c => c.type === 'text').map(c => c.text).join('');
      if (readbackText.includes(probeContent)) {
        report.tests.syntheticCreateReadbackCleanup = 'PASS';
      } else {
        report.tests.syntheticCreateReadbackCleanup = 'FAIL: readback content mismatch';
      }
    }
  } catch (err) {
    report.tests.syntheticCreateReadbackCleanup = `FAIL: ${err.message}`;
  } finally {
    if (fs.existsSync(probePath)) fs.unlinkSync(probePath);
  }

  // 8. Tool list & process tool exposure check
  const listTools = await client.listTools({ _meta: metaA });
  const toolNames = (listTools.tools || []).map(t => t.name);
  const dangerousProcessTools = ['start_process', 'interact_with_process', 'execute_code', 'kill_process', 'force_terminate', 'set_config_value'];
  const exposed = toolNames.filter(t => dangerousProcessTools.includes(t));
  report.exposedTools = exposed;
  report.tests.toolFilteringGate = exposed.length > 0 ? `GATE_OPEN: ${exposed.join(', ')} forwarded without broker filter` : 'PASS: all process tools filtered';

  // 9. Skills checks
  if (lock) {
    const skillListRes = await callA('skills', { action: 'list' });
    const skillList = (skillListRes.structuredContent || JSON.parse(skillListRes.content.find(c => c.type === 'text').text)).skills || [];
    const autoSkills = skillList.filter(s => s.policy === 'auto');
    report.tests.noUnexpectedAutoSkills = autoSkills.length === 0 ? 'PASS' : `FAIL: unexpected auto skills: ${autoSkills.map(s => s.id).join(', ')}`;

    for (const expected of lock.skills) {
      const found = skillList.find(s => s.id === expected.id);
      report.skillsSummary.push({
        id: expected.id,
        policy: found ? found.policy : 'MISSING',
        expectedPolicy: expected.policy,
        hashMatch: found && found.contentHash === expected.installedContentHash ? 'PASS' : 'FAIL'
      });
    }

    // Test explicit manual activation
    const testSkill = 'verification-before-completion';
    const noExplicit = await callA('skills', { action: 'activate', skill: testSkill });
    const noExplicitData = noExplicit.structuredContent || JSON.parse(noExplicit.content.find(c => c.type === 'text').text);
    report.tests.manualWithoutExplicitRequestBlocked = (noExplicitData.status === 'manual_only' && !noExplicitData.instructions) ? 'PASS' : 'FAIL';

    const withExplicit = await callA('skills', { action: 'activate', skill: testSkill, explicit_user_request: true });
    const withExplicitData = withExplicit.structuredContent || JSON.parse(withExplicit.content.find(c => c.type === 'text').text);
    report.tests.manualExplicitActivation = (withExplicitData.status === 'active' && typeof withExplicitData.instructions === 'string')
      ? 'PASS: protocol instruction delivery (client-supplied explicit flag; does not substitute for independent human authorization)'
      : 'FAIL';

    // Test ASK policy with systematic-debugging
    const askRes = await callA('skills', { action: 'activate', skill: 'systematic-debugging' });
    const askData = askRes.structuredContent || JSON.parse(askRes.content.find(c => c.type === 'text').text);
    report.tests.askPolicyWithholdsInstructions = (askData.status === 'approval_required' && !askData.instructions && askData.approvalId) ? 'PASS' : 'FAIL';

    // Test rejection
    if (askData.approvalId) {
      const rejectProc = spawnSync(process.execPath, [path.join(app, 'scripts', 'skills-admin.mjs'), 'reject', askData.approvalId], { env: process.env, encoding: 'utf8' });
      const rejectedCall = await callA('skills', { action: 'activate', skill: 'systematic-debugging', approval_id: askData.approvalId });
      const rejectedData = rejectedCall.structuredContent || JSON.parse(rejectedCall.content.find(c => c.type === 'text').text);
      report.tests.askRejectionBlocksActivation = (rejectedData.status === 'rejected' && !rejectedData.instructions) ? 'PASS' : 'FAIL';
    }
  } else {
    report.tests.skillsVerification = 'SKIPPED: dwb-skills.lock.json not found';
  }

  // 10. Two logical sessions isolation
  const bindB = await callB('workspace', { action: 'bind', path: workspace });
  const sessionB = await callB('dwb_session_status');
  const sessionAData = sessionA.structuredContent || JSON.parse((sessionA.content || []).find(c => c.type === 'text')?.text || '{}');
  const sessionBData = sessionB.structuredContent || JSON.parse((sessionB.content || []).find(c => c.type === 'text')?.text || '{}');
  const hasDistinctIds = sessionAData.sessionId && sessionBData.sessionId && sessionAData.sessionId !== sessionBData.sessionId;
  report.tests.twoSessionSeparation = (!bindB.isError && !sessionB.isError)
    ? (hasDistinctIds ? 'PASS: distinct session IDs verified' : 'PARTIAL: independent session bindings verified; strict session ID separation unconfirmed')
    : 'FAIL';

} catch (err) {
  report.tests.overallError = `ERROR: ${err.message}`;
  process.exitCode = 1;
} finally {
  await client.close().catch(() => {});
  if (fs.existsSync(junctionPath)) {
    try { fs.rmdirSync(junctionPath); } catch {}
  }
  if (fs.existsSync(outsideFile)) fs.unlinkSync(outsideFile);
  if (fs.existsSync(outsideDir)) fs.rmdirSync(outsideDir);
  console.log(JSON.stringify(report, null, 2));
}
