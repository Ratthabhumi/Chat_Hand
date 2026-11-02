'use strict';
const assert = require('node:assert/strict');
const path = require('node:path');
const candidate = process.argv[2];
if (!candidate) { console.error('Usage: node scripts/check-fallback.cjs <candidate.cjs>'); process.exit(2); }
const cases = [
  ['empty', f => assert.equal(f([]), 0)],
  ['ordinary', f => assert.equal(f([100, 205, 0]), 305)],
  ['safe maximum', f => assert.equal(f([Number.MAX_SAFE_INTEGER]), Number.MAX_SAFE_INTEGER)],
  ['non-array', f => assert.throws(() => f('100'), TypeError)],
  ['fraction', f => assert.throws(() => f([0.5]), TypeError)],
  ['negative', f => assert.throws(() => f([-1]), TypeError)],
  ['string element', f => assert.throws(() => f(['100']), TypeError)],
  ['non-finite', f => assert.throws(() => f([Infinity]), TypeError)],
  ['unsafe element', f => assert.throws(() => f([Number.MAX_SAFE_INTEGER + 1]), TypeError)],
  ['sum overflow', f => assert.throws(() => f([Number.MAX_SAFE_INTEGER, 1]), RangeError)],
  ['immutable input', f => { const input = Object.freeze([3, 2, 1]); assert.equal(f(input), 6); }],
];
let passed = 0;
let fn;
try { fn = require(path.resolve(candidate)); assert.equal(typeof fn, 'function'); }
catch { console.error('Candidate must load as a CommonJS function'); process.exit(1); }
for (const [name, check] of cases) {
  try { check(fn); passed++; }
  catch { console.error(`FAIL: ${name}`); }
}
console.log(JSON.stringify({ passed, total: cases.length, status: passed === cases.length ? 'PASS' : 'FAIL', scope: 'Synthetic correctness only; no provider or isolation claim' }));
process.exitCode = passed === cases.length ? 0 : 1;
