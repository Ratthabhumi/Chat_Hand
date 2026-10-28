// Local MCP consent/delivery checks. Does not execute a skill's helper or run a model.
import assert from 'node:assert/strict';
import fs from 'node:fs';
import path from 'node:path';
import { createHash } from 'node:crypto';
import { createRequire } from 'node:module';
import { spawnSync } from 'node:child_process';
import { fileURLToPath, pathToFileURL } from 'node:url';
const app = process.env.DWB_INSTALL_DIR;
if (!app || !process.env.DWB_DATA_DIR || !process.env.DWB_CONFIG_FILE) throw new Error('Set isolated DWB pilot environment first.');
const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..');
const lock = JSON.parse(fs.readFileSync(path.join(root, 'config', 'dwb-skills.lock.json'), 'utf8').replace(/^\uFEFF/, ''));
const config = JSON.parse(fs.readFileSync(process.env.DWB_CONFIG_FILE, 'utf8'));
assert.equal(config.workerCap, 1);
assert.equal(path.resolve(config.workspace), path.join(root, 'sandbox'));
const require = createRequire(path.join(app, 'package.json'));
const { Client } = await import(pathToFileURL(require.resolve('@modelcontextprotocol/sdk/client/index.js')).href);
const { StdioClientTransport } = await import(pathToFileURL(require.resolve('@modelcontextprotocol/sdk/client/stdio.js')).href);
const client = new Client({ name: 'chathand-local-skill-acceptance', version: '3' });
const meta = { 'openai/session': 'v1/chathand-v3-local-skills' };
const report = { observedUtc: new Date().toISOString(), host: 'Local MCP stdio from Codex; NOT ordinary ChatGPT Chat', tests: {}, skills: [], cloudSkillActivation: 'BLOCKED: hosted security/account gates remain', behavioralEffectiveness: 'NOT TESTED: no model execution or helper execution' };
const call = async (name, args) => {
  const result = await client.callTool({ name, arguments: args, _meta: meta }, undefined, { timeout: 15000 });
  assert.notEqual(result.isError, true, `Tool error: ${name}`);
  return result.structuredContent ?? JSON.parse(result.content.find(c => c.type === 'text').text);
};
try {
  await client.connect(new StdioClientTransport({ command: process.execPath, args: [path.join(app, 'scripts', 'start.mjs')], env: process.env, stderr: 'pipe' }));
  await call('workspace', { action: 'bind', path: config.workspace });
  const list = await call('skills', { action: 'list' });
  assert.equal(list.skills.length, lock.skills.length + lock.quarantinedExisting.length);
  assert.ok(list.skills.every(s => s.policy !== 'auto'));
  for (const expected of lock.quarantinedExisting) {
    assert.equal(list.skills.find(s => s.id === expected.id)?.policy, 'manual');
  }
  report.tests.unreviewedExistingSkillsNotAuto = 'PASS: defaults and pilot effective policy MANUAL';
  for (const expected of lock.skills) {
    const installed = list.skills.find(s => s.id === expected.id);
    assert.ok(installed, `Missing skill ${expected.id}`);
    assert.equal(installed.policy, expected.policy);
    assert.equal(installed.contentHash, expected.installedContentHash);
    report.skills.push({ id: expected.id, policy: installed.policy, pinnedHash: 'MATCH' });
  }
  report.tests.installedCollectionAndPolicies = 'PASS';
  const selected = lock.skills.find(s => s.id === 'verification-before-completion');
  const blocked = await call('skills', { action: 'activate', skill: selected.id });
  assert.equal(blocked.status, 'manual_only');
  assert.equal(blocked.instructions, undefined);
  report.tests.manualWithoutExplicitRequestDenied = 'PASS';
  // The owner explicitly requested a skill-activation demonstration in this task.
  const active = await call('skills', { action: 'activate', skill: selected.id, explicit_user_request: true });
  assert.equal(active.status, 'active');
  assert.equal(createHash('sha256').update(active.instructions).digest('hex'), selected.mainSha256);
  report.tests.manualExplicitActivationExactInstructions = 'PASS';
  const ask = await call('skills', { action: 'activate', skill: 'systematic-debugging' });
  assert.equal(ask.status, 'approval_required');
  assert.equal(ask.instructions, undefined);
  report.tests.askWithholdsInstructions = 'PASS';
  // Reject the synthetic test request; never fabricate a human approval.
  const rejection = spawnSync(process.execPath, [path.join(app, 'scripts', 'skills-admin.mjs'), 'reject', ask.approvalId], { env: process.env, encoding: 'utf8', timeout: 10000 });
  assert.equal(rejection.status, 0);
  const rejected = await call('skills', { action: 'activate', skill: 'systematic-debugging', approval_id: ask.approvalId });
  assert.equal(rejected.status, 'rejected');
  assert.equal(rejected.instructions, undefined);
  report.tests.askRejectedRequestDenied = 'PASS (synthetic local administrative rejection)';
} catch (error) {
  report.tests.failure = `FAIL: ${error.code || error.name || 'local check'}`;
  process.exitCode = 1;
} finally {
  await client.close().catch(() => {});
  console.log(JSON.stringify(report, null, 2));
}
