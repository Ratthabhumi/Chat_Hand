import test from 'node:test';
import assert from 'node:assert/strict';
import path from 'node:path';
import { McpToolFilterGateway, DEFAULT_ALLOWED_TOOLS, DEFAULT_BLOCKED_TOOLS } from '../gateway/mcp-filter-gateway.mjs';

test('MCP Tool Filter Gateway: Discovery Filtering', () => {
  const gateway = new McpToolFilterGateway();
  const rawTools = [
    { name: 'read_file', description: 'Read a file' },
    { name: 'start_process', description: 'Run arbitrary shell' },
    { name: 'interact_with_process', description: 'Shell I/O' },
    { name: 'set_config_value', description: 'Config mutation' },
    { name: 'write_file', description: 'Write a file' },
    { name: 'unknown_custom_tool', description: 'Unapproved tool' }
  ];

  const filtered = gateway.filterToolList(rawTools);
  const names = filtered.map(t => t.name);

  assert.deepEqual(names, ['read_file', 'write_file']);
  assert.ok(!names.includes('start_process'));
  assert.ok(!names.includes('set_config_value'));
  assert.ok(!names.includes('unknown_custom_tool'));
});

test('MCP Tool Filter Gateway: Dispatch Denial of Process and Mutation Tools', () => {
  const gateway = new McpToolFilterGateway();

  for (const blocked of DEFAULT_BLOCKED_TOOLS) {
    const res = gateway.validateToolCall(blocked, { command: 'whoami' });
    assert.equal(res.allowed, false);
    assert.match(res.reason, /Access Denied/);
  }

  const unapproved = gateway.validateToolCall('arbitrary_tool');
  assert.equal(unapproved.allowed, false);
  assert.match(unapproved.reason, /not in the approved allowlist/);
});

test('MCP Tool Filter Gateway: Sandbox Path Confinement and Traversal Denial', () => {
  const sandbox = path.resolve('C:\\Sandbox');
  const gateway = new McpToolFilterGateway({ sandboxPath: sandbox });

  // Valid path inside sandbox
  const validCall = gateway.validateToolCall('read_file', { path: 'C:\\Sandbox\\sub\\hello.txt' });
  assert.equal(validCall.allowed, true);

  // Path outside sandbox
  const outsideCall = gateway.validateToolCall('read_file', { path: 'C:\\Windows\\System32\\calc.exe' });
  assert.equal(outsideCall.allowed, false);
  assert.match(outsideCall.reason, /escapes approved sandbox/);

  // Traversal attack
  const traversalCall = gateway.validateToolCall('read_file', { path: 'C:\\Sandbox\\..\\Windows\\win.ini' });
  assert.equal(traversalCall.allowed, false);
  assert.match(traversalCall.reason, /escapes approved sandbox/);
});

test('MCP Tool Filter Gateway: Audit Logging', () => {
  const gateway = new McpToolFilterGateway();
  gateway.validateToolCall('start_process', { command: 'cmd.exe' });
  gateway.validateToolCall('unknown_tool', {});

  assert.equal(gateway.auditLog.length, 2);
  assert.equal(gateway.auditLog[0].tool, 'start_process');
  assert.equal(gateway.auditLog[0].event, 'BLOCKED_HIGH_RISK_TOOL');
  assert.equal(gateway.auditLog[1].tool, 'unknown_tool');
  assert.equal(gateway.auditLog[1].event, 'NOT_IN_ALLOWLIST');
});
