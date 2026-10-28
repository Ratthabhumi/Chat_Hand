'use strict';
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const os = require('node:os');
const path = require('node:path');
const { spawnSync } = require('node:child_process');
const harness = path.join(__dirname, 'check-fallback.cjs');
function run(source) {
  const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'chat-hand-check-'));
  try {
    const file = path.join(dir, 'candidate.cjs');
    fs.writeFileSync(file, source);
    const result = spawnSync(process.execPath, [harness, file], { encoding: 'utf8', timeout: 10000 });
    if (result.error) throw result.error;
    return result;
  } finally {
    const file = path.join(dir, 'candidate.cjs');
    if (fs.existsSync(file)) fs.unlinkSync(file);
    fs.rmdirSync(dir);
  }
}
test('accepts a reviewed reference; this is NOT an AI benchmark result', () => {
  const result = run(`module.exports = values => {
    if (!Array.isArray(values)) throw new TypeError();
    let total = 0;
    for (const value of values) {
      if (!Number.isSafeInteger(value) || value < 0) throw new TypeError();
      if (total > Number.MAX_SAFE_INTEGER - value) throw new RangeError();
      total += value;
    }
    return total;
  };`);
  assert.equal(result.status, 0, result.stderr);
  assert.match(result.stdout, /"passed":11/);
});
test('rejects naive addition missing validation', () => {
  assert.equal(run('module.exports = a => a.reduce((x,y) => x+y, 0);').status, 1);
});
test('incomplete implementation fails rather than appearing accepted', () => {
  assert.equal(run("module.exports = () => { throw new Error('Not implemented'); };").status, 1);
});
