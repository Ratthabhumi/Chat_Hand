# V3.1 skill coverage and backend readiness

Seven reviewed packages are installed: preserve the original five pins and add security-threat-model/frontend-design, both MANUAL. Exact provenance, licenses and hashes for additions are in [the lock](../config/dwb-skills.lock.json); local instruction delivery for all six MANUAL packages is in [new evidence](../evidence/v3.1-skills-local.json). Debugging remains ASK with withholding/rejection tested; no approval was fabricated. Two retained extras remain MANUAL. No media/browser/backend capability is implied.

[Candidate catalog](../config/skills-candidates.json) records pinned repositories, exact path conventions, installed/verified/blocked state and unresolved license/tool reviews. Candidate paths were confirmed from current upstream trees. No wholesale package install was performed.

| Area | Current result |
|---|---|
| Engineering | Existing debugging/TDD/verification/review-reception guidance installed; worktree/planning/request-review/finish/brainstorm candidates AVAILABLE, runtime compatibility not established |
| Security | Best practices + threat-model instructions installed; actual project audit/model behavior not tested |
| UI | Frontend-design instructions installed; no generated UI or browser run |
| Research/browser | Docs/Playwright/screenshot candidate source exists; DWB tool/OS/CLI support not established |
| Image/game assets | Canvas/algorithmic-art catalog only. Imagegen's Codex built-in is not supplied by SKILL.md |
| Video | Remotion sources available; programmatic React video requires its own renderer/runtime, not a generative video model |
| Audio | Speech/transcribe require a separate approved backend and privacy/cost credentials |
| ComfyUI | Setup skill payload exists, but no GPU service/model/runtime installed or activated |

Possible image backend is OpenAI's Images API or separately approved ComfyUI, not the Tunnel key alone. No API model permissions, billing, GPU/disk, data transfer or backend generation was verified. Keep media MANUAL and cost-gated; do not download models or start services to make a catalog item appear ready.

## Project-specific designs, not installed skills

No production repository was changed or exposed to DWB. The designs below are not executable skills or validated workflows; no SKILL.md was authored/imported for them. Complete source/context review and behavior tests before authoring/activation.

| Proposed skill | Actual instruction basis / scope |
|---|---|
| acash-governance-research | Root AGENTS.md read; SHA256 06abd681c2eb7dd462c6d4a357a06aa8782f888ffc15808145ed8d387236a942. Evidence/provenance, no silent numerical fallbacks, immutable history. Owner additionally requires read-only, NO_REAL_ORDERS=true, USD 0.00, no provider/live/paper execution |
| seed-playtest-qa | Root AGENTS.md read; SHA256 65cc10489add1ec13ca3b735cd246e45759684627c818f89ee6398de02f25a64. Seeded simulation, renderer/core boundary, physical performance gates and Thai/EN QA; synthetic checks do not prove playability |
| eims-infrastructure-review | No root AGENTS.md found. Owner scope only: sanitized diagnostics/docs, no customer credentials or production devices. Repository-specific source review incomplete |
| agentos-policy-audit | Root not a Git checkout and no root AGENTS.md found. Owner scope only: protect private memory/backups, no duplicate schedulers. Private architecture not inspected |
| chathand-secure-operations | Existing Chat_Hand security/operations/evidence and owner instructions. Read-only status, source/policy drift checks, fail closed on cloud gates; no automatic account/ACL/startup/key/deployment changes |

Trigger would be an explicit owner request for the named project and an approved narrow root. Expected output would separate evidence/assumptions, findings, test scope and owner gates. All profiles stay inactive with no production roots; guardrail text never substitutes for tool/OS enforcement.
