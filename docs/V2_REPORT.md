# V2 report — 2026-10-29, Asia/Bangkok

**PARTIAL: Remote connector read works; directory restriction FAILS; independent-provider run pending.**
This supersedes the V1 Offline diagnosis, while preserving V1 evidence dated 2026-10-28.

## Observed changes

- Remote Desktop Commander 0.3.1 reports the same device Online. Existing process/package found; no new agent, pairing or credential rotation needed.
- A real Remote Desktop Commander `read_file` connector call returned the exact `sandbox/hello.txt` sentence. This was called from this Codex chat, not ordinary ChatGPT web; web-host acceptance remains pending.
- `get_config` returns `allowedDirectories: []`. Installed `dist/tools/filesystem.js` explicitly treats an empty list as unrestricted (observed around lines 264–267). A harmless synthetic file under ignored `local-evidence`, outside `sandbox`, was readable remotely. **Out-of-scope denial FAILS under the intended sandbox-only policy.** The temporary fixture was removed locally.
- No remote writes, shell commands, disconnect or restart were attempted after this failed boundary. Existing central settings were left intact; changing them could affect other chats. No claim of secret isolation.
- Existing Antigravity Desktop file version 2.0.1.0 and OpenCode Desktop 1.19.5.0 found. Antigravity is not running; OpenCode is running with a minimized window. A read-only UI state request could not inspect the minimized window. No model/provider/account eligibility verified, no new installation or AI call made.

## Deliverables

Synthetic coding task, eleven-case evaluator, evaluator self-tests, Windows CI workflow, repeatable repository validation, exact owner checklist and updated research handoff. Evaluator tests verify the checker using a reference and rejected counterexamples; they are NOT evidence that any fallback model passed.

Follow-up after receiving the complete prompt: read Issue #1's research comment, reconfirmed Online and unrestricted empty allowlist, added [fixed-weight comparison](FALLBACK_COMPARISON.md), [manual operations](OPERATIONS.md) and credential-free local process status. OpenCode Desktop 1.19.5.0 is not verified OpenCode V2. No installer/upgrade run.

Saved remote session file exists. Its ACL is inherited; a targeted search found zero Allow-read rules for Everyone, BUILTIN Users or Authenticated Users. This limited check does not establish encryption, complete effective permissions or log redaction; file contents were not read. Installed filesystem source includes realpath/junction resolution code, but no junction/traversal runtime test passed. Prompt injection and shell containment remain review/test items; tool output cannot grant authorization.

Antigravity was subsequently launched using its existing app registration and observed after loading. Its UI exposes Restart to Update, and the selected pre-existing project displays Missing Folder. A model picker shows Claude Sonnet 4.6 (Thinking); available independent allowance and cost remain UNKNOWN. No prompt was sent, update applied, model changed, unrelated project opened or private conversation exported. The app is left open for owner review. This is a readiness observation, not proof that the app cannot run a newly selected workspace. Owner: review the pending update, open the separate benchmark worktree and confirm provider/allowance before one trial.

## Current acceptance

| Requirement | Result |
|---|---|
| Existing device discovery / online | PASS |
| Remote connector exact fixture read from Codex host | PASS |
| Ordinary ChatGPT Chat-host file invocation | PENDING OWNER |
| Outside-workspace denial | FAIL — current empty allowlist is unrestricted |
| Remote create/readback/delete | NOT RUN — directory boundary gate failed |
| Shell confinement | NOT VERIFIED |
| Reconnect / disconnect | NOT RUN — avoid interrupting existing sessions |
| Independent-provider coding trial | NOT RUN — owner must confirm provider/model and quota/billing |
| Local validation / CI | See local-validation evidence and PR checks; scope excludes remote/provider tests |

## Decision

Reuse existing tools. Scope the remote pilot before writing; benchmark the already installed Google agent before installing another runtime. OpenCode is already available as the second candidate. Do not start every candidate or infer that Work gives extra quota. [OpenAI usage documentation](https://help.openai.com/en/articles/20001516-managing-usage-with-gpt-6-astra-in-work-and-codex) confirms Work and Codex share included allowance.

The submitted attachment ends mid-list at `- Free`. Issue #1 was read as the task ledger for omitted acceptance/publication steps. No missing requirements were invented.

No production repository changed, no new tunnel, paid billing, startup, firewall rule or global permission change. Revert this branch/PR to remove V2 artifacts; existing remote agent continues as before. Synthetic probe and evaluator self-test outputs clean up automatically.
