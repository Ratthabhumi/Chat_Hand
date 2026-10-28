# Security review and limits

## V3 installed pilot — 2026-10-29

Release source/payload at tag beta.16 (`212cb39512ef244283c7984ebede0f25e92fdd55`) inspected for Setup downloads/version/checksum validation, path checks, worker-home isolation, startup preferences, key storage and broker forwarding. Review is targeted, not a complete independent audit. ZIP SHA-256 matched both release metadata and companion checksum. The launcher is unsigned; no certificate-backed publisher verification is claimed.

Fresh DWB-managed worker homes/data were used. Legacy session/config file hashes matched before/after the first local MCP probe; fingerprints and contents were not published. No global Remote settings changed. Local MCP exact fixture read, outside-root denial, raw traversal denial and junction-target denial passed. The fixtures and junction were removed. These tests do not prove every path race or OS boundary.

**FAIL: shell containment.** `start_process` and `interact_with_process` remain exposed. Reviewed broker list/call routing forwards worker tools; no supported process-tool deny policy was established in this review. No arbitrary shell command was executed in the pilot. Hosted Tunnel remains stopped. Do not solve this by assuming blocked command names, a model instruction or Skills ASK policy confines the OS. Owner-approved restricted identity/VM or a verified supported tool restriction is required before enabling that capability. Configuration-mutation tools and prompt injection are additional review items, not covered by filesystem denial.

**Dependency review required:** actual `npm audit --omit=dev --json` reports core 6 affected packages (2 high, 4 moderate) and managed-worker 5 (3 high, 2 moderate), no critical reported. Transitive/direct package counts may overlap across components and are not unique CVE counts. See `evidence/v3-dependency-advisories.json`. Reachability/exploitability was not demonstrated. No `audit fix`, dependency replacement or unsupported Tunnel upgrade attempted.

The managed installer explicitly requires Tunnel 0.0.11. Upstream 0.0.18 release notes add features including AWS identity and opt-in loopback Harpoon behavior; differences are not proof of a security defect or drop-in compatibility. Local 0.0.11 version and doctor help worked. Actual hosted authentication/protocol compatibility awaits owner credentials and security acceptance.

Reviewed DWB key code uses Windows ConvertFrom-SecureString (DPAPI by default) when remembering a key, and passes an environment reference in the profile rather than a literal key in argv/config. No key was entered, saved or logged by this work; runtime secret/log redaction and effective key-file ACLs therefore remain NOT TESTED. No startup entry, service, firewall rule or account change made. Installed skills=0; fallback ASK observed in source. Do not add AUTO third-party skills.

## V2 finding — 2026-10-29

Current Desktop Commander 0.3.1 `allowedDirectories` is an empty array. Installed filesystem code treats this as unrestricted. Actual remote read of a harmless outside-sandbox fixture succeeded: this FAILS the desired pilot boundary, not a demonstrated exploit of a configured restriction. No real secret was requested. The fixture was removed locally; remote writes were deferred. Central settings and running sessions were not changed. Shell confinement and ordinary-Chat host behavior remain unverified. A live connector call from Codex must not be labeled normal ChatGPT web acceptance.

Existing Antigravity and OpenCode executables were identified from file metadata; metadata is not an authenticity audit or proof of provider access. No candidate model call made. Keep new credentials/billing and shared permission changes owner-controlled. Benchmark execution runs code under the user's OS account; inspect candidate diffs and isolate the workspace first.

## Historical V1 review — 2026-10-28

Targeted review only: official documentation, DWB README and GitHub release metadata. Installer code, complete source, dependencies and runtime were not audited. No third-party executable was downloaded or run.

DWB v0.1.0-beta.16 is a prerelease, published 2026-10-22. GitHub metadata gives its Windows ZIP digest as `sha256:cd94f308829515f9a4e3d381c9f9266859124bfb47f47aeda9992377f0c19de2`. This is metadata, NOT a locally verified download hash or proof of safety. The stable `releases/latest` endpoint returned 404; listing prereleases found beta.16. No retry loop was used.

Official tunnel latest: v0.0.18, published 2026-10-23. Bundled v0.0.11 compatibility/security review is unresolved. DWB README's dependency-audit claim excludes external DC/Tunnel dependencies; it is not evidence from tests performed here.

Boundaries applied during this work:

- Only synthetic pilot files and audit documentation created in this repository.
- No raw configurations, customer data, credentials, process arguments or device identifiers published.
- Existing production changes preserved; only Git metadata inspected there.
- No firewall, startup, service, account, credential or OS permission changes.
- No new remote endpoint or background runtime started.

Residual risks: Codex has broad local access in this session. The test script's path checks are defensive fixture checks, not containment. Traversal, symlink/junction races, shell escape, credential isolation, multi-session concurrency and remote access denial have NOT been proven. Do not expose production folders based on the local probe.

For any future pilot: restrict the actual server's supported directory policy, use a limited OS account where practical, disable shell tools unless justified, start with one worker, use MANUAL/ASK for reviewed skills, and verify denial with synthetic outside-scope fixtures. Do not test denial by requesting real secrets.
