# UI Workflow Agent Roles

This file defines the expert roles used by `ui-workflow`. In Pi, these map to bundled `.pi/agents/*.md`. In universal skill mode, the current agent can simulate each role sequentially.

Each role should consult `external-skill-sources.md` before producing its report.

## 1. ui-research-analyst

Required.

Purpose:

- Analyze reference materials.
- Identify visual, layout, interaction, and product patterns.
- Translate inspiration into usable design implications.

Inputs:

- `00-need-summary.md`
- user-provided URLs/screenshots/Figma links
- search results or built-in reference sites
- relevant external skills if available

Recommended external skills:

- `anthropics/frontend-design`
- `anthropics/canvas-design` for highly visual/brand-heavy projects
- web search/browser skills when available

Output:

- `01-research-report.md`

Must include:

- references inspected
- patterns worth borrowing
- patterns to avoid
- product-specific implications
- external skills consulted or unavailable

## 2. ui-need-analyst

Required.

Purpose:

- Convert the aligned brief into product requirements for UI design.
- Clarify users, use cases, page scope, and success criteria.

Inputs:

- user request
- `00-need-summary.md`
- project context
- `01-research-report.md` when available

Recommended external skills:

- PM/JTBD/persona skills when installed
- `ux-audit` for friction and failure-mode framing

Output:

- `02-need-report.md`

Must include:

- product positioning
- target users
- key scenarios
- feature/page priority
- success metrics
- assumptions and open questions

## 3. ui-form-analyst

Required.

Purpose:

- Decide what shape the interface should take.
- Define layout paradigm, page types, components, and responsive strategy.

Inputs:

- `02-need-report.md`
- `01-research-report.md`
- project constraints

Recommended external skills:

- `ui-design`
- `ui-ux-pro-max`
- `ux-audit`

Output:

- `03-form-report.md`

Must include:

- page inventory
- layout model
- navigation/container pattern
- component strategy
- responsive behavior
- density and scanning model

## 4. ui-visual-analyst

Required.

Purpose:

- Create a distinctive, coherent, implementation-ready visual system.
- Avoid generic AI aesthetics.
- Produce design tokens and design-dna guidance when available.

Inputs:

- `02-need-report.md`
- `01-research-report.md`
- `03-form-report.md` when available

Recommended external skills:

- `anthropics/frontend-design`
- `typography-audit`
- `ui-design`
- `ui-ux-pro-max`
- `design-dna`
- `anthropics/canvas-design` for expressive visual art direction

Output:

- `04-visual-report.md`

Must include:

- visual concept and rationale
- color tokens
- typography tokens
- spacing/radius/shadow tokens
- icon/illustration direction
- motion tone
- anti-patterns to avoid
- design-dna JSON or invocation notes when applicable

## 5. ui-ia-analyst

Optional, recommended for Standard and Deep mode.

Purpose:

- Define information architecture and navigation logic.
- Make the product understandable and scalable.

Inputs:

- `02-need-report.md`
- `03-form-report.md`
- `04-visual-report.md`
- `01-research-report.md`

Recommended external skills:

- `ux-audit`
- product journey or site architecture skills when installed

Output:

- `05-ia-report.md`

Must include:

- navigation model
- route/page hierarchy
- object model or content model if relevant
- search/filter/sort model
- cross-page user flows
- risks and simplification options

## 6. ui-interaction-analyst

Optional, recommended for Standard and Deep mode.

Purpose:

- Define micro-interactions, state transitions, gestures, loading/empty/error states, and accessibility behavior.

Inputs:

- `02-need-report.md`
- `03-form-report.md`
- `04-visual-report.md`
- `05-ia-report.md` when available

Recommended external skills:

- `ui-animation`
- `greensock/gsap-core`
- `greensock/gsap-scrolltrigger`
- `greensock/gsap-react`
- `addyosmani/accessibility`
- `ux-audit`

Output:

- `06-interaction-report.md`

Must include:

- interaction principles
- hover/focus/active/disabled states
- loading/empty/error/success states
- motion timing and easing
- keyboard/mobile behavior
- reduced-motion behavior
- accessibility notes

## 7. ui-content-analyst

Optional, recommended for Standard and Deep mode.

Purpose:

- Define interface copy, tone, labels, CTAs, empty/error states, and guidance copy.

Inputs:

- `02-need-report.md`
- `03-form-report.md`
- `04-visual-report.md`
- `06-interaction-report.md` when available

Recommended external skills:

- `copywriting`
- product marketing/CRO skills when installed

Output:

- `07-content-report.md`

Must include:

- voice and tone
- page-level copy guidance
- CTA system
- labels and helper text
- empty/loading/error copy
- onboarding or education copy
- phrases to avoid

## Lead Reviewer

The lead reviewer may be the main agent.

Purpose:

- Orchestrate the workflow.
- Resolve conflicts across reports.
- Integrate the final specification.
- Decide when to ask the user for confirmation.

Recommended external skills:

- `vercel-labs/web-design-guidelines`
- `ui-audit`
- `ux-audit`
- `addyosmani/web-quality-audit`
- `design-md` for long-term project context

Outputs:

- `docs/ui-design-spec.md`
- `docs/ui-workflow/99-ui-design-spec.md`
- optional `DESIGN.md`
- optional prototype files after confirmation

Must include:

- final design decisions
- conflict resolution notes
- external skills consulted/unavailable
- implementation-ready specs
- remaining risks and user confirmations needed
