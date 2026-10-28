// Local stdio acceptance only; never connects a hosted tunnel or submits credentials.
import assert from 'node:assert/strict';
import fs from 'node:fs';
import path from 'node:path';
import { createRequire } from 'node:module';
import { pathToFileURL, fileURLToPath } from 'node:url';
const app = process.env.DWB_INSTALL_DIR;
const data = process.env.DWB_DATA_DIR;
if (!app || !data || !process.env.DWB_CONFIG_FILE) throw new Error('Set isolated DWB_INSTALL_DIR, DWB_DATA_DIR, DWB_CONFIG_FILE first.');
const repo = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..');
const sandbox = path.join(repo, 'sandbox');
const config = JSON.parse(fs.readFileSync(process.env.DWB_CONFIG_FILE, 'utf8'));
assert.equal(config.workerCap, 1);
assert.equal(path.resolve(config.workspace), sandbox);
const policy = JSON.parse(fs.readFileSync(config.basePolicy, 'utf8'));
assert.deepEqual(policy.allowedDirectories.map(p => path.resolve(p)), [sandbox]);
const require = createRequire(path.join(app, 'package.json'));
const { Client } = await import(pathToFileURL(require.resolve('@modelcontextprotocol/sdk/client/index.js')).href);
const { StdioClientTransport } = await import(pathToFileURL(require.resolve('@modelcontextprotocol/sdk/client/stdio.js')).href);
fs.mkdirSync(path.join(repo, 'local-evidence'), { recursive: true });
const outside = fs.mkdtempSync(path.join(repo, 'local-evidence', 'dwb-outside-'));
const outsideFile = path.join(outside, 'fixture.txt');
fs.writeFileSync(outsideFile, 'Synthetic out-of-scope fixture; no secrets.');
const junction = path.join(sandbox, `dwb-junction-${path.basename(outside)}`);
const client = new Client({ name: 'chathand-local-pilot', version: '3' });
const report = { observedUtc: new Date().toISOString(), host: 'Local MCP stdio client from Codex; NOT ordinary ChatGPT Chat', workerCap: 1, tests: {} };
const meta = { 'openai/session': 'v1/chathand-v3-local-pilot' };
const call = (name, args = {}) => client.callTool({ name, arguments: args, _meta: meta }, undefined, { timeout: 15000 });
async function denied(target) {
  try {
    const result = await call('read_file', { path: target });
    const message = (result.content || []).filter(c => c.type === 'text').map(c => c.text).join('\n');
    return result.isError === true && /outside|not allowed|access denied|denied|workspace/i.test(message) ? 'PASS' : 'FAIL';
  } catch (error) {
    return /outside|not allowed|access denied|denied|workspace/i.test(String(error)) ? 'PASS' : 'ERROR';
  }
}
try {
  await client.connect(new StdioClientTransport({ command: process.execPath, args: [path.join(app, 'scripts', 'start.mjs')], env: process.env, stderr: 'pipe' }));
  const broker = await call('dwb_broker_status');
  report.tests.brokerStatus = broker.isError ? 'FAIL' : 'PASS';
  const session = await call('dwb_session_status');
  report.tests.sessionStatus = session.isError ? 'FAIL' : 'PASS';
  const binding = await call('workspace', { action: 'bind', path: sandbox, name: 'ChatHand Pilot' });
  report.tests.workspaceBind = binding.isError ? 'FAIL' : 'PASS';
  const read = await call('read_file', { path: path.join(sandbox, 'hello.txt') });
  const expected = fs.readFileSync(path.join(sandbox, 'hello.txt'), 'utf8').trim();
  report.tests.fixtureRead = !read.isError && (read.content || []).some(c => c.type === 'text' && c.text.trim().endsWith(expected)) ? 'PASS' : 'FAIL';
  report.tests.outsideReadDenied = await denied(outsideFile);
  report.tests.traversalDenied = await denied(`${sandbox}${path.sep}..${path.sep}local-evidence${path.sep}${path.basename(outside)}${path.sep}fixture.txt`);
  try {
    fs.symlinkSync(outside, junction, 'junction');
    report.tests.junctionDenied = await denied(path.join(junction, 'fixture.txt'));
  } catch { report.tests.junctionDenied = 'NOT TESTED: junction setup failed'; }
  const tools = (await client.listTools({ _meta: meta })).tools.map(t => t.name);
  report.exposedProcessTools = tools.filter(t => ['start_process', 'interact_with_process', 'execute_code'].includes(t));
  report.tests.shellDisabled = report.exposedProcessTools.length ? 'FAIL: process tools exposed; OS boundary not established' : 'NOT VERIFIED: no listed process tools';
  report.tests.writeReadbackDelete = 'BLOCKED: do not proceed past unresolved shell/security gate';
  report.tests.chatHostTunnel = 'BLOCKED: owner credentials, permissions and shell boundary required';
  report.tests.twoChatSessions = 'NOT TESTED';
} catch (error) {
  report.tests.operationFailure = `ERROR: local MCP ${error.code || error.name || 'failure'}; unfinished checks not accepted`;
  process.exitCode = 1;
} finally {
  await client.close().catch(() => {});
  if (fs.existsSync(junction)) fs.rmdirSync(junction);
  fs.unlinkSync(outsideFile);
  fs.rmdirSync(outside);
  console.log(JSON.stringify(report, null, 2));
}
if (Object.values(report.tests).some(value => /^(FAIL|ERROR)/.test(value))) process.exitCode = 1;
