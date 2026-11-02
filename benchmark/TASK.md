# Independent-provider coding trial

Use one agent and one isolated worktree. Edit only `benchmark/sum-cents.cjs`.

Implement a CommonJS function `sumCents(values)` exported with `module.exports`:

- Input must be an array, otherwise throw TypeError.
- Every entry must be a nonnegative safe integer Number. Invalid entries throw TypeError.
- Return their sum; empty input returns 0. If the total exceeds Number.MAX_SAFE_INTEGER, throw RangeError.
- Do not mutate the input. No dependencies, network, credentials, shell installs or production files.

Run `node scripts/check-fallback.cjs benchmark/sum-cents.cjs`. Report the provider/model, elapsed time, attempts, correctness, account quota/cost display (or UNKNOWN), changed files and any requested permission.

Do not change tests after seeing failures. One task is a smoke test, not a ranking of model quality. Do not run the evaluator on unreviewed code outside an isolated environment: it executes the candidate under the current OS account.
