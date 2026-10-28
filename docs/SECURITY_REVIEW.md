# Security review and limits

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
