# Research handoff (bounded scope)

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
