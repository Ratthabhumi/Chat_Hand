// Offline analysis of cached npm/GitHub metadata and installed package versions.
// Never patches dependencies, opens files supplied by MCP, or contacts a model.
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..');
const app = process.env.DWB_INSTALL_DIR;
if (!app) throw new Error('Set DWB_INSTALL_DIR to the installed pilot.');
const read = p => JSON.parse(fs.readFileSync(p, 'utf8').replace(/^\uFEFF/, ''));
const rows = [];
const chainsFor = (tree, wanted, prefix = []) => {
  const found = [];
  for (const [name, info] of Object.entries(tree.dependencies || {})) {
    const next = [...prefix, `${name}@${info.version || '?'}`];
    if (name === wanted) found.push(next);
    found.push(...chainsFor(info, wanted, next));
  }
  return found;
};
const assessments = {
  'body-parser': 'Transitive HTTP middleware present; no direct DWB src import found in targeted scan. Full dynamic/HTTP reachability UNKNOWN, not accepted safe.',
  hono: 'Transitive middleware present; no direct DWB src import found in targeted scan. Full reachability UNKNOWN.',
  sharp: 'Worker dist/tools/pdf/extract-images.js dynamically imports sharp for PDF image conversion. Potential approved-file input path; malformed-input exploitability NOT TESTED.',
  zod: 'MCP/worker schema validation dependency. Untrusted tool inputs may reach validation; advisory-specific oversized-collection behavior NOT TESTED.',
};
for (const kind of ['core', 'worker']) {
  const prefix = kind === 'core' ? app : path.join(app, 'external', 'desktop-commander');
  const audit = read(path.join(root, 'local-evidence', 'dwb-beta16', `audit-${kind}.json`));
  const tree = read(path.join(root, 'local-evidence', 'dwb-beta16', `chains-${kind}.json`));
  for (const [name, item] of Object.entries(audit.vulnerabilities || {})) {
    const versions = (item.nodes || []).map(location => {
      const pkg = read(path.join(prefix, location, 'package.json'));
      return { location, version: pkg.version };
    });
    const advisories = item.via.filter(v => typeof v !== 'string').map(v => {
      const id = v.url.split('/').at(-1);
      const primary = read(path.join(root, 'local-evidence', 'advisories', `${id}.json`));
      return { id, url: v.url, title: v.title, severity: v.severity, affectedRangesAndFixes: primary.vulnerabilities.filter(p => p.package === name) };
    });
    rows.push({ component: kind, package: name, severity: item.severity, installed: versions, dependencyChains: chainsFor(tree, name), npmAffectedRange: item.range, advisories, inheritedFrom: item.via.filter(v => typeof v === 'string'), npmFixSuggestion: item.fixAvailable, reachability: assessments[name] || 'Advisory-specific runtime/input reachability UNKNOWN; package presence alone is not an exploit.', remediation: 'No changes made. Check compatible locked update with upstream DWB/DC maintainers; npm fix suggestion is not compatibility proof.', regressionRequired: 'Preserve managed version contracts; rerun path/consent/session tests and advisory-specific malformed-input/resource tests inside an isolated OS environment.' });
  }
}
console.log(JSON.stringify({ observedUtc: new Date().toISOString(), inputs: 'Cached original npm audits, current installed package files/npm dependency chains, and freshly fetched primary GHSA fixed-version metadata. Not a fresh npm audit.', rows, hostedDecision: 'NO-GO: shell/OS boundary absent; dependency exploitability and supported remediation unresolved', patchesApplied: 0, risksAccepted: [] }, null, 2));
