# Fallback comparison and fixed scoring rules

Updated 2026-10-29. Existing executables are not proof of authentication, available quota or coding quality. No provider trial has run.

| Criterion | Weight | Antigravity installed Desktop | OpenCode installed Desktop | OpenCode V2 candidate |
|---|---:|---|---|---|
| Correctness | 30% | UNKNOWN | UNKNOWN | UNKNOWN |
| Security / permissions | 25% | UNKNOWN | UNKNOWN | UNKNOWN |
| Independent provider allowance | 20% | UNKNOWN | UNKNOWN | UNKNOWN |
| Cost | 15% | UNKNOWN | UNKNOWN | UNKNOWN |
| Setup / maintenance | 10% | UNKNOWN | UNKNOWN | UNKNOWN |
| Total | 100% | NOT SCORED | NOT SCORED | NOT SCORED |

Observed installation facts: Antigravity Desktop file version 2.0.1.0; OpenCode Desktop file version 1.19.5.0. The latter is **not a verified V2 installation**. No `agy` CLI was found on PATH or at its documented default location during the earlier V2 inspection. Do not overwrite existing software to manufacture a comparison.

Before trials, define each component score on a 0–5 scale: correctness = 5 × cases passed / 11; security = documented review of filesystem, shell, network, credential handling and approval controls (one point each only when evidenced); independent allowance = 5 only with a confirmed non-OpenAI provider and usable account allowance, otherwise UNKNOWN; cost = owner-approved per-task budget with observed usage and no billing surprise (unmeasured remains UNKNOWN); setup/maintenance = owner-rated friction after a completed trial, with exact installation/authentication steps and elapsed time attached. A verified unavailable allowance can be scored 0; an uninspected account cannot.

Freeze the owner-approved cost budget and setup rating anchors before the first trial, not after seeing the result. Missing values stay UNKNOWN; do not renormalize weights or treat UNKNOWN as zero. Do not rank candidates unless all five criteria are evidenced under the same rules. A model failing a mandatory security/allowance gate is ineligible regardless of total score. One synthetic task establishes only basic suitability, not performance on production repositories.

Use [the existing task](../benchmark/TASK.md), separate worktrees with the same baseline, and the same eleven-case evaluator. Record provider/model, exact app/CLI version, timing, attempts, changed files and cost/quota display without publishing account identifiers. Review candidate changes before executing them. Do not grant broad permissions merely to improve completion time.

Official [OpenCode V2 docs](https://opencode.ai/v2/docs) list a different CLI package (`@opencode/cli`) and standalone Windows binaries; they state Windows package managers are unsupported. This is a documentation finding, not an installation recommendation. Existing V1 should not silently be treated as V2 or replaced.

Official [Antigravity quickstart](https://antigravity.google/docs/getting-started/) documents Windows desktop and `agy`; [plans](https://antigravity.google/docs/plans) describe allowances but do not establish this owner's usable quota. [OpenCode V2 providers](https://opencode.ai/v2/docs/providers) must be checked against the specific provider before use. Authentication, cost and privacy remain owner/account-specific. Keep Google first as a candidate, not a scored winner.
