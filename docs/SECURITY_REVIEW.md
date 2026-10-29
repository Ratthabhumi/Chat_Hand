# Security review and limits

## V3.2 identity/transfer evidence

Pilot is enabled, directly in Users, not directly in Administrators, with registered/loaded profile. Current process is the main account; actual pilot token privileges and effective denial are NOT TESTED. Main-account inspection of pilot LocalAppData returned Access Denied; do not misreport absence or reverse the direction of that observation.

New ProgramData transfer and result folders use protected explicit ACLs: main creator/System/Administrators full, pilot read/execute on payload and modify on results; no broad Users/Everyone/Authenticated Users grants found on transferred files. A new synthetic primary-account fixture excludes pilot; its actual denial must be tested from pilot. No existing profile/project ACL altered. These checks do not prove every ancestor/IPC/network/process boundary. No private bytes/secrets/old sessions copied.

Bootstrap enforces the intended SID and rejects Administrator group tokens before mutation, network or process creation; wrong-identity guard passed in Windows PowerShell. Positive setup, actual runtime owners and effectiveness are NOT VERIFIED until owner execution. Source transfer integrity passed for 39 files including the reviewed ZIP/skill sources. Setup never enables cloud, copies keys or accepts residual risk; filtering/advisory/OS tests remain separate gates.

## V3.1 current gate

Hosted NO-GO remains. Owner has Tunnel/key but no isolated Windows account/VM; owner elected to prepare one manually. No account, ACL, vendor source, managed version, credential, billing or startup change made. Targeted worker/server inspection and advisory reachability metadata are in [DEPENDENCY_TRIAGE.md](DEPENDENCY_TRIAGE.md). A standard account is not automatic filesystem/network/process confinement and does not remove MCP tools; both OS and server controls still need tests.

Seven reviewed skills now loaded as MANUAL/ASK. Source pins for the original five preserved; additions are instruction-only threat-model/frontend-design packages with licenses retained locally. During fresh tests, five original defaults were AUTO and two retained extras ASK, with four differing workspace overrides. Origin not established. Eleven records were restored to the approved manifest once; no extra package activated or deleted. Client-supplied approval fields, delivered instructions and future source helpers remain trust boundaries, not OS controls.

## V3 installed pilot — 2026-10-29

Release source/payload at tag beta.16 (`212cb39512ef244283c7984ebede0f25e92fdd55`) inspected for Setup downloads/version/checksum validation, path checks, worker-home isolation, startup preferences, key storage and broker forwarding. Review is targeted, not a complete independent audit. ZIP SHA-256 matched both release metadata and companion checksum. The launcher is unsigned; no certificate-backed publisher verification is claimed.

Fresh DWB-managed worker homes/data were used. Legacy session/config file hashes matched before/after the first local MCP probe; fingerprints and contents were not published. No global Remote settings changed. Local MCP exact fixture read, outside-root denial, raw traversal denial and junction-target denial passed. The fixtures and junction were removed. These tests do not prove every path race or OS boundary.

**FAIL: shell containment.** `start_process` and `interact_with_process` remain exposed. Reviewed broker list/call routing forwards worker tools; no supported process-tool deny policy was established in this review. No arbitrary shell command was executed in the pilot. Hosted Tunnel remains stopped. Do not solve this by assuming blocked command names, a model instruction or Skills ASK policy confines the OS. Owner-approved restricted identity/VM or a verified supported tool restriction is required before enabling that capability. Configuration-mutation tools and prompt injection are additional review items, not covered by filesystem denial.

**Dependency review required:** actual `npm audit --omit=dev --json` reports core 6 affected packages (2 high, 4 moderate) and managed-worker 5 (3 high, 2 moderate), no critical reported. Transitive/direct package counts may overlap across components and are not unique CVE counts. See `evidence/v3-dependency-advisories.json`. Reachability/exploitability was not demonstrated. No `audit fix`, dependency replacement or unsupported Tunnel upgrade attempted.

The managed installer explicitly requires Tunnel 0.0.11. Upstream 0.0.18 release notes add features including AWS identity and opt-in loopback Harpoon behavior; differences are not proof of a security defect or drop-in compatibility. Local 0.0.11 version and doctor help worked. Actual hosted authentication/protocol compatibility awaits owner credentials and security acceptance.

Reviewed DWB key code uses Windows ConvertFrom-SecureString (DPAPI by default) when remembering a key, and passes an environment reference in the profile rather than a literal key in argv/config. No key was entered, saved or logged by this work; runtime secret/log redaction and effective key-file ACLs therefore remain NOT TESTED. No startup entry, service, firewall rule or account change made. The initial installation snapshot had zero skills; current state is five reviewed MANUAL/ASK packages plus two retained unreviewed MANUAL extras, documented below and in AGENT_SKILLS.md. Do not add AUTO third-party skills.

## V2 finding — 2026-10-29

V3 skills follow-up: five pinned/reviewed packages imported without running helpers. Local MCP consent tests caught two extra AUTO packages and AUTO workspace overrides; both defaults and overrides were changed MANUAL without deleting files. Origin unestablished; these extras were not reviewed/activated by this task. Prior delivered instructions are not proven revoked by policy changes. MANUAL/ASK protocol checks passed, but this does not prove model compliance, human-consent authenticity or shell confinement. See [AGENT_SKILLS.md](AGENT_SKILLS.md).

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
