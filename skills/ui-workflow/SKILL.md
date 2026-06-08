---
name: ui-workflow
description: End-to-end UI/UX product design workflow and skill router. Use when the user wants to turn a product idea, feature request, page concept, UI redesign, or rough interface direction into a structured UI design spec, with optional Pi automation and external UI/UX skill routing.
license: MIT
---

# UI Workflow Skill

Use this skill when the user wants to design, review, refine, or generate UI for a product, feature, landing page, dashboard, mobile app, SaaS tool, internal tool, AI product, or design-system direction.

This skill has two layers:

1. **Pi automation layer** — if running inside Pi with `pi-ui-workflow` installed, prefer the packaged `/ui-workflow` commands and bundled sub-agents.
2. **Universal Agent Skill layer** — if Pi commands or sub-agents are unavailable, follow the manual protocol in `references/workflow-protocol.md`.

The shared source of truth is the reference protocol, not a specific runtime. When updating the workflow, update the reference files first, then align Pi prompts/agents/extensions to them.

## Primary Outcome

Produce an implementation-ready UI/UX design specification.

Default final artifact:

- `docs/ui-design-spec.md`

Recommended intermediate archive:

- `docs/ui-workflow/00-need-summary.md`
- `docs/ui-workflow/01-research-report.md`
- `docs/ui-workflow/02-need-report.md`
- `docs/ui-workflow/03-form-report.md`
- `docs/ui-workflow/04-visual-report.md`
- `docs/ui-workflow/05-ia-report.md`
- `docs/ui-workflow/06-interaction-report.md`
- `docs/ui-workflow/07-content-report.md`
- `docs/ui-workflow/99-ui-design-spec.md`

Optional artifacts:

- `DESIGN.md` for long-lived project design context
- `docs/prototype/*.html` for confirmed high-fidelity prototypes

## If Running Inside Pi

Prefer the packaged commands:

```text
/ui-workflow <product idea or UI request>
```

For partial reruns when intermediate reports exist:

```text
/ui-rerun redo visuals only
/ui-rerun redo interactions
/ui-rerun rebuild final spec
```

For staged usage:

```text
/ui-align
/ui-review
```

Pi automation should implement the same protocol described in `references/workflow-protocol.md`. The extension and bundled agents are execution helpers, not a separate design process.

## If Pi Commands Are Unavailable

Follow the universal workflow manually:

1. Align product requirements.
2. Search or inspect reference materials.
3. Produce the requirements report.
4. Produce the UI form/layout report.
5. Produce the visual design report.
6. Optionally produce IA, interaction, and content reports.
7. Integrate all reports into `docs/ui-design-spec.md`.
8. Ask before generating a high-fidelity HTML prototype.

Read `references/workflow-protocol.md` for the full process.

## External Skill Routing

Before each stage, check whether relevant specialized UI/UX skills are available in the current agent environment. If available, load or invoke them for professional guidance and cite them in the report. If unavailable, continue with this skill's built-in protocol.

Do not block the workflow just because an external skill is missing.

Use `references/external-skill-sources.md` as the source directory for related UI/UX skills. It records skill names, upstream URLs, recommended use cases, fallback behavior, and the on-demand search/install policy.

### On-demand Search and Install

Do not preinstall or silently install third-party skills.

When the user's current request clearly benefits from a specialized external skill that is not available:

1. Identify the relevant UI/UX need and matching skill category.
2. Search current sources or package marketplaces for the skill.
3. Explain why the skill helps this specific task, plus any trust or maintenance considerations.
4. Ask the user before installing.
5. If the user declines or installation fails, continue with the built-in fallback.

Typical routing:

- Visual direction / anti-AI-slop UI: `anthropics/frontend-design`
- Visual art / hero mood / brand poster direction: `anthropics/canvas-design`
- Design-system recommendation: `ui-ux-pro-max`, `ui-design`, `design-dna`
- Typography: `typography-audit`
- Interaction and motion: `ui-animation`, `greensock/gsap-*`
- UX and final audit: `ux-audit`, `ui-audit`, `vercel-labs/web-design-guidelines`
- Accessibility / production quality: `addyosmani/accessibility`, `addyosmani/web-quality-audit`
- Figma/design handoff: `figma-implement-design`, `design-md`
- Product copy and microcopy: `copywriting`, CRO skills

## User Confirmation Rule

Before making product-shaping decisions, ask the user to choose from 2-4 options when the direction is ambiguous.

Prefer MVP first, then refine visual quality, interaction states, responsive behavior, and brand details.

## Quality Bar

The final spec should be practical enough for implementation and cover:

- Product positioning
- Target users
- Core user scenarios
- Page structure
- Navigation and information architecture
- Layout and component strategy
- Visual tokens
- Interaction states
- Empty/loading/error states
- Responsive behavior
- Accessibility notes
- Content and CTA guidance
- External skill references used or skipped

## Reference Files

Load these files when needed:

- `references/workflow-protocol.md` — canonical workflow and update source of truth
- `references/external-skill-sources.md` — related UI/UX skill source directory and routing map
- `references/agent-roles.md` — role definitions for the 7 expert analysts
- `references/artifact-templates.md` — output templates
- `references/quality-checklist.md` — final delivery checklist
