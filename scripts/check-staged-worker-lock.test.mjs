import { test } from 'node:test';
import assert from 'node:assert/strict';
import { checkLock } from './Check-StagedWorkerLock.mjs';

const makeLock = () => ({ lockfileVersion: 3, packages: {
  '': { dependencies: { '@wonderwhy-er/desktop-commander': '0.2.50' } },
  'node_modules/@wonderwhy-er/desktop-commander': {
    version: '0.2.50',
    resolved: 'https://registry.npmjs.org/@wonderwhy-er/desktop-commander/-/desktop-commander-0.2.50.tgz',
    integrity: 'sha512-' + Buffer.alloc(64, 7).toString('base64'),
  },
} });

test('accepts npm v3 empty root key and preserves exact worker constraints', () => {
  assert.equal(checkLock(JSON.parse(JSON.stringify(makeLock()))).ok, true);
  assert.equal(checkLock(makeLock()).checks.emptyRootKeyPresent, true);
});
test('rejects version, registry, SRI, missing entry, invalid schema and packages shape', () => {
  for (const [key, value] of [['version','0.3.1'],['resolved','https://untrusted.invalid/worker.tgz'],['integrity','sha256-wrong']]) {
    const lock = makeLock(); lock.packages['node_modules/@wonderwhy-er/desktop-commander'][key] = value;
    assert.equal(checkLock(lock).ok, false);
  }
  const missing = makeLock(); delete missing.packages['node_modules/@wonderwhy-er/desktop-commander'];
  assert.equal(checkLock(missing).ok, false);
  assert.equal(checkLock({ ...makeLock(), lockfileVersion: 99 }).ok, false);
  assert.equal(checkLock({ lockfileVersion: 3, packages: [] }).ok, false);
  assert.equal(checkLock(null).ok, false);
});
