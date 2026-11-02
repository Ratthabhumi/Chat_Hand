import fs from 'node:fs';
import { pathToFileURL } from 'node:url';

export function checkLock(lock) {
  const packages = lock?.packages;
  const pin = packages?.['node_modules/@wonderwhy-er/desktop-commander'];
  const checks = {
    supportedSchema: [2, 3].includes(lock?.lockfileVersion),
    packagesObject: !!packages && typeof packages === 'object' && !Array.isArray(packages),
    emptyRootKeyPresent: !!packages && Object.hasOwn(packages, ''),
    expectedEntryPresent: !!pin && typeof pin === 'object' && !Array.isArray(pin),
    versionMatches: pin?.version === '0.2.50',
    resolvedMatches: pin?.resolved === 'https://registry.npmjs.org/@wonderwhy-er/desktop-commander/-/desktop-commander-0.2.50.tgz',
    integrityFormatMatches: typeof pin?.integrity === 'string' && /^sha512-[A-Za-z0-9+/]+=*$/.test(pin.integrity),
  };
  return { ok: checks.supportedSchema && checks.packagesObject && checks.expectedEntryPresent && checks.versionMatches && checks.resolvedMatches && checks.integrityFormatMatches, checks };
}

if (process.argv[1] && import.meta.url === pathToFileURL(process.argv[1]).href) {
  try {
    if (process.argv.length !== 3) throw new Error('Argument count');
    // Node JSON.parse preserves valid empty and case-sensitive JSON keys.
    console.log(JSON.stringify(checkLock(JSON.parse(fs.readFileSync(process.argv[2], 'utf8').replace(/^\uFEFF/, '')))));
  } catch {
    console.log(JSON.stringify({ ok: false, code: 'LOCK_READ_OR_JSON_PARSE_FAILED' }));
  }
}
