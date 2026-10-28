# Research handoff (bounded scope)

## V2 priority — 2026-10-29

Complete-prompt follow-up: verify OpenCode V2 migration/coexistence with installed Desktop 1.19.5 rather than assuming it is already V2. Official V2 docs distinguish `@opencode/cli` and standalone Windows builds. No upgrade was attempted. Antigravity existing UI exposes a pending restart/update and a missing selected workspace; research cannot confirm the owner's allowance, so prefer the exact owner action over another generic product search. Fixed benchmark weights and UNKNOWN rules are in [FALLBACK_COMPARISON.md](FALLBACK_COMPARISON.md).

Remote read now works from the Codex-host connector, but an empty directory allowlist permits the synthetic outside-sandbox fixture. Research the installed Desktop Commander 0.3.1 path policy, shell/tool permissions and supported per-session scoping: can an isolated pilot coexist with other active chats without changing a central config? Prefer a supported restricted instance/account; do not suggest `[]` as deny-all. Source: [official remote-device guide](https://github.com/wonderwhy-er/DesktopCommanderMCP/blob/main/src/remote-device/README.md). This run did not investigate upstream issues #798/#811 because dispatch worked; they are not a current diagnosis.

Antigravity Desktop 2.0.1.0 and OpenCode Desktop 1.19.5.0 already exist. Verify exact account eligibility, provider choice, quota, privacy and any independent-model cost before a trial; compare actual task evidence rather than ranking feature lists. Current [Google plans](https://antigravity.google/docs/plans) describe a weekly allowance for users without Pro/Ultra; this does not confirm this owner's quota. [Google Windows quickstart](https://antigravity.google/docs/getting-started/) documents `agy` at the default local-app-data location, where this run did not find it. Desktop availability does not require CLI installation. [OpenCode providers](https://docs.opencode.ai/docs/providers/) documents provider configuration, not free unlimited inference.

Normal Chat-host invocation, Google sign-in if requested, shared filesystem policy changes and provider/billing selection need actual owner interaction, not generic research. Use [the exact owner steps](V2_OWNER_STEPS.th.md) and [benchmark task](../benchmark/TASK.md). Do not install extra agents merely to compare them.

## Historical DWB handoff

Copy this request to ChatGPT Research if a custom tunnel or DWB remains useful after restoring the existing connection:

> Review DWB MCP Studio v0.1.0-beta.16 Windows source/release and OpenAI tunnel-client v0.0.11 versus v0.0.18. Pin source commit IDs. Inspect installer downloads/checksums, startup, DPAPI key handling, log redaction, transitive/runtime dependencies (including managed Desktop Commander 0.2.50), allowedDirectories enforcement, shell tools, junction/traversal behavior, broker/session locks and unknown mutation recovery. Identify actual security fixes and compatibility requirements; do not infer vulnerability merely from version age. State which findings come from source versus executed tests. Is there a supported upgrade path for the managed client, and does DWB add measurable value over an existing Desktop Commander connector? Give GO/NO-GO conditions and minimal reproducible Windows tests. Do not execute provider/live/paper trading or inspect private/customer data.

Primary sources:

- https://github.com/sphakanin/dwb-mcp-studio-public/releases/tag/v0.1.0-beta.16
- https://github.com/sphakanin/dwb-mcp-studio-public
- https://github.com/openai/tunnel-client/releases/tag/v0.0.18
- https://github.com/openai/tunnel-client
- https://developers.openai.com/api/docs/guides/secure-mcp-tunnels
- https://developers.openai.com/plugins/deploy/connect-chatgpt

Account rights cannot be established by general research: the owner must check the intended ChatGPT workspace and Platform organization. Do not recommend a paid upgrade before identifying the actual missing capability. The learning workshop and private AgentOS architecture were not reviewed; review them only if they resolve a concrete remaining need.
