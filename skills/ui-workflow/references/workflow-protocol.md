# UI Workflow Protocol

This file is the shared source of truth for both layers of `pi-ui-workflow`:

- **Pi automation layer**: slash commands, bundled prompts, extension, and sub-agents should execute this protocol.
- **Universal skill layer**: agents without Pi-specific commands should follow this protocol manually.

When the workflow changes, update this protocol first, then align Pi prompts, sub-agent instructions, README files, and examples.

## Operating Principles

1. **MVP first, refine second** — produce a usable design direction before polishing advanced details.
2. **Ask before shaping the product** — when a decision changes product positioning, page scope, or user experience, ask the user to choose from 2-4 options.
3. **Evidence-backed design** — use project context, reference products, design guidelines, and related skills when available.
4. **External skills enhance, not block** — use specialized skills if available; fall back to this protocol if not.
5. **Preserve artifacts** — save intermediate reports so future reruns can reuse them.
6. **Product language over technical jargon** — explain design choices by their user impact.

## Execution Modes

### Fast

Use for early exploration and direction finding.

- Estimated time: 2-4 minutes
- Agent pattern: parallel where possible
- Output: medium detail, enough to guide a first UI draft

### Standard Recommended

Use for most UI design tasks.

- Estimated time: 5-8 minutes
- Agent pattern: two-stage expert analysis
- Output: high detail with clear implementation guidance

### Deep

Use for key product surfaces, production-ready specs, and important design decisions.

- Estimated time: 8-15 minutes
- Agent pattern: stricter sequential handoff
- Output: highest detail, conflict checks, stronger rationale

## Stage 0 — Choose Mode

Ask the user to pick Fast, Standard, or Deep unless they already specified urgency/quality.

Record:

- selected mode
- reason for the selection
- expected artifact scope

## Stage 1 — Align Requirements

Goal: convert a vague product request into a concrete design brief.

Inputs:

- user request
- existing README/docs/product notes if available
- visible project structure if relevant

Ask only the most important clarification questions. Prefer 2-4 choices.

Capture:

- product goal
- target users
- user jobs-to-be-done
- key scenarios
- business or conversion objective
- platform constraints: web, mobile, responsive, dashboard, landing page, etc.
- design maturity: MVP, polished MVP, production-ready, redesign
- known constraints: framework, brand, existing design system, accessibility, timeline

Output:

- `docs/ui-workflow/00-need-summary.md`

## Stage 1.5 — Reference Search and External Skill Routing

Goal: ground design decisions in references and specialized knowledge.

First check available relevant skills using `references/external-skill-sources.md`.

Recommended skill routing:

- Platform-aware quality review: first identify Web, mobile, desktop, Apple platform, Android, deck, infographic, motion, or cross-platform targets; do not apply web-only standards to every surface.
- Cross-platform design rules: `ehmo/platform-design-skills`
- Visual frontend quality: `anthropics/frontend-design`
- High-fidelity prototypes / motion / decks / infographics: `alchaincyf/huashu-design`
- Web design/audit guidelines: `vercel-labs/web-design-guidelines`
- Apple platform HIG audit: `raintree-technology/hig-doctor`
- Mobile app UI design: `ceorkm/mobile-app-ui-design`
- SwiftUI implementation review: `AvdLee/SwiftUI-Agent-Skill`
- Industry design-system recommendation: `ui-ux-pro-max`
- Typography: `typography-audit`
- Motion: `ui-animation` or `greensock/gsap-*`
- Accessibility and web quality: `addyosmani/accessibility`, `addyosmani/web-quality-audit`
- Figma handoff: `figma-implement-design`
- Long-lived design spec: `design-md`

Then gather references from:

- existing product/project pages
- user-provided URLs/screenshots/Figma links
- built-in reference sites:
  - godly.website
  - awwwards.com
  - mobbin.com
  - reactbits.dev/components/magic-bento
  - supahero.io
  - 60fps.design
  - ui-pocket.com/mobile
  - pinterest.com
- optional web search tools, such as TinyFish, if available and user confirms

Output:

- `docs/ui-workflow/01-research-report.md`

The report should include:

- references inspected
- useful design patterns
- patterns to avoid
- external skills consulted or unavailable
- implications for this product

## Stage 2a — Requirements Analysis

Goal: turn the aligned brief into product design requirements.

Analyze:

- product positioning
- user segments/personas
- top tasks
- feature priority
- key page list
- required states and edge cases
- success metrics or product outcomes

Output:

- `docs/ui-workflow/02-need-report.md`

## Stage 2b — Expert Analysis

Run the following reports. In Pi automation these may be delegated to bundled sub-agents; in universal mode the current agent can produce them sequentially.

### Required Reports

1. **UI Form Report** — `03-form-report.md`
   - page types
   - layout paradigm
   - component strategy
   - responsive behavior
   - density and scanning model

2. **Visual Report** — `04-visual-report.md`
   - visual concept
   - design tokens
   - color system
   - typography
   - spacing/radius/shadow
   - illustration/iconography direction
   - motion tone
   - design-dna suggestions when available

### Optional Reports

Run these by default in Standard and Deep mode unless user opts out.

3. **Information Architecture Report** — `05-ia-report.md`
   - navigation model
   - route/page hierarchy
   - search/filter/sort structure
   - mental model

4. **Interaction Report** — `06-interaction-report.md`
   - micro-interactions
   - state transitions
   - loading/error/empty states
   - keyboard/mobile gestures
   - accessibility interaction notes

5. **Content Report** — `07-content-report.md`
   - product voice
   - labels
   - CTAs
   - empty states
   - error messages
   - onboarding/help copy

## Stage 3 — Integrate Final Spec

Goal: synthesize all reports into one coherent implementation-ready design spec.

Before final review, identify the target platform and apply platform-specific quality criteria. Do not use web-only standards for mobile apps, desktop apps, decks, infographics, motion deliverables, or native software.

Platform-aware quality gates:

- **Web / SaaS / Dashboard / Landing page**: review responsive behavior, semantic structure, keyboard access, focus states, forms, loading/error/empty states, performance, and WCAG accessibility. Use `web-design-guidelines`, `accessibility`, or `web-quality-audit` when available.
- **iOS / iPadOS / macOS / Apple ecosystem**: review Apple HIG conventions, navigation, safe areas, Dynamic Type, dark mode, gestures, pointer/keyboard behavior, window/menu patterns, and platform components. Use `ehmo/platform-design-skills` or `hig-doctor` when available.
- **Android**: review Material Design 3 conventions, navigation, touch targets, dynamic color, system back behavior, typography, accessibility, and adaptive layouts. Use `ehmo/platform-design-skills` when available.
- **Mobile app generic / cross-platform mobile**: review thumb reach, bottom navigation, gesture discoverability, safe areas, onboarding, permissions, offline/weak-network states, and platform differences. Use `mobile-app-ui-design` and platform rules when available.
- **Desktop app / local software**: review menu bars, toolbars, panels, window resizing, keyboard shortcuts, context menus, information density, selection models, drag/drop, and native OS conventions.
- **Deck / PPT / infographic / motion deliverable**: review narrative flow, visual hierarchy, readability, export quality, timing, typography, and brand consistency. Use `huashu-design` and `typography-audit` when available.
- **Cross-platform products**: review each target platform separately, then resolve conflicts into shared tokens and platform-specific adaptations.

Check for conflicts:

- visual style vs product positioning
- layout density vs user task complexity
- navigation model vs page scope
- interaction ambition vs MVP timeline
- copy tone vs brand/user expectations
- accessibility vs visual/motion choices

Output:

- `docs/ui-design-spec.md`
- `docs/ui-workflow/99-ui-design-spec.md`

The final spec must cite:

- reference materials used
- external skills consulted
- external skills skipped/unavailable when relevant
- assumptions that need user confirmation

## Stage 4 — Optional Prototype

Only generate a high-fidelity prototype after user confirmation.

Recommended options:

1. Generate one key page only.
2. Generate the full primary flow.
3. Skip prototype for now.

If generating:

- use `docs/ui-design-spec.md` as the source of truth
- use `design-dna` if available for visual tokens/effects
- produce files under `docs/prototype/`
- keep implementation complexity aligned to the chosen mode

## Partial Rerun Protocol

If `docs/ui-workflow/` exists, reuse prior reports and rerun only the requested scope.

Common scopes:

- visuals only
- interactions only
- content only
- IA only
- final spec only
- prototype only

When rerunning, record:

- which reports were reused
- which reports were regenerated
- what changed in the final spec

## Update Discipline

To keep the Pi version and universal version aligned:

1. Update this file first.
2. Update `external-skill-sources.md` if routing changes.
3. Update `agent-roles.md` if responsibilities change.
4. Update Pi prompts and bundled agents to mirror the same stage names and artifact names.
5. Update README and Chinese README usage notes.
6. Run package checks.
