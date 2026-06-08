# External UI/UX Skill Sources

This document is the source directory for related UI/UX skills that can enhance `ui-workflow`.

Purpose:

- Help agents discover which specialized skill to consult at each workflow stage.
- Preserve upstream source URLs for professional context and future updates.
- Avoid copying third-party skill contents into this package.
- Keep external skills optional: missing skills must not block the workflow.

## How Agents Should Use This Document

Before each major stage in `workflow-protocol.md`:

1. Identify the user's current UI/UX need.
2. Check whether any listed skill is available in the current agent environment.
3. If available, load or invoke the relevant skill for professional guidance.
4. If unavailable, continue with built-in `ui-workflow` instructions.
5. In the report, note which external skills were consulted, unavailable, or intentionally skipped.

Do not install third-party skills automatically unless the user explicitly asks.

## On-demand Search and Install Policy

External skills should be discovered and installed only when the user's current task clearly benefits from them.

Use this process:

1. **Route the need** — map the user's request to a category such as visual polish, accessibility audit, motion, typography, copywriting, Figma handoff, or production review.
2. **Check availability** — if a matching skill is already available, load or invoke it.
3. **Search only when useful** — if the skill is unavailable but would materially improve the result, search current sources or package marketplaces.
4. **Explain before installing** — tell the user what the skill adds, why it is relevant now, and any trust/maintenance considerations.
5. **Ask for confirmation** — never install third-party skills silently.
6. **Fallback safely** — if the user declines, search fails, or installation fails, continue with the built-in protocol and document the fallback.

Recommended user-facing confirmation wording:

```text
This task would benefit from a specialized UI/UX skill for <need>. I can search for and install one, but it is a third-party instruction package. Do you want me to proceed, or should I continue with the built-in ui-workflow fallback?
```

This project intentionally does not ship a preinstalled external skill pack. The default package remains lightweight and predictable.

## Core Recommended Skills

### anthropics/frontend-design

- Source: https://github.com/anthropics/skills/blob/main/skills/frontend-design/SKILL.md
- Use for: production-grade frontend UI, strong visual direction, anti-generic AI aesthetics, typography, color, motion, layout, visual polish.
- Best stages:
  - `ui-visual-analyst`
  - final UI spec review
  - optional HTML prototype generation
- Fallback: use `04-visual-report.md` rules and `design-dna` if available.

### vercel-labs/web-design-guidelines

- Source: https://github.com/vercel-labs/agent-skills/blob/main/skills/web-design-guidelines/SKILL.md
- Use for: UI code review, accessibility, web interface guidelines, design compliance, UX audit against best practices.
- Best stages:
  - final review
  - implementation audit
  - accessibility review
- Fallback: use `quality-checklist.md`.

### nextlevelbuilder/ui-ux-pro-max-skill

- Source: https://github.com/nextlevelbuilder/ui-ux-pro-max-skill
- Use for: industry-aware design-system recommendations, product-type-to-style mapping, color palettes, typography pairings, landing page patterns, dashboard patterns.
- Best stages:
  - requirement-to-design-system translation
  - UI form report
  - visual report
- Fallback: use `artifact-templates.md` design-system sections and `design-dna`.

### mblode/agent-skills — ui-design

- Source: https://github.com/mblode/agent-skills
- Use for: color palettes, type scales, layout patterns, landing page conversion strategy.
- Best stages:
  - UI form report
  - visual report
  - landing page CRO review
- Fallback: use `03-form-report.md` and `04-visual-report.md` templates.

### mblode/agent-skills — ui-animation

- Source: https://github.com/mblode/agent-skills
- Use for: springs, gestures, drag interactions, easing, CSS transitions, animation review.
- Best stages:
  - interaction report
  - prototype generation
- Fallback: use interaction report motion sections and respect reduced-motion preferences.

### mblode/agent-skills — typography-audit

- Source: https://github.com/mblode/agent-skills
- Use for: font selection, type scale, spacing, OpenType, hierarchy, font pairing.
- Best stages:
  - visual report
  - final spec typography review
- Fallback: define type scale, font roles, hierarchy, and responsive text behavior in `04-visual-report.md`.

### mblode/agent-skills — ui-audit

- Source: https://github.com/mblode/agent-skills
- Use for: accessibility, forms, typography, layout, performance, motion, microcopy review.
- Best stages:
  - final review
  - implementation audit
- Fallback: use `quality-checklist.md`.

### mblode/agent-skills — ux-audit

- Source: https://github.com/mblode/agent-skills
- Use for: feature-level UX audit, failure modes, task flow review, friction detection.
- Best stages:
  - requirement analysis
  - IA report
  - interaction report
  - final review
- Fallback: use requirement/user-scenario sections in `workflow-protocol.md`.

### mblode/agent-skills — copywriting

- Source: https://github.com/mblode/agent-skills
- Use for: product copy, microcopy, removing generic AI language, before/after copy refinement.
- Best stages:
  - content report
  - final spec copy review
- Fallback: use `07-content-report.md` template.

## Optional Enhancement Skills

### anthropics/canvas-design

- Source: https://github.com/anthropics/skills/blob/main/skills/canvas-design/SKILL.md
- Use for: visual philosophy, art direction, static visual concepts, hero mood, poster-like creative expression.
- Best stages:
  - reference research
  - visual concept exploration
  - brand/hero art direction
- Avoid using by default for conventional enterprise dashboards unless the user wants a highly expressive visual direction.
- Fallback: use visual report concept and moodboard sections.

### google-labs-code/design-md

- Source directory reference: https://github.com/heilcheng/awesome-agent-skills and https://github.com/VoltAgent/awesome-agent-skills list `google-labs-code/design-md`
- Use for: creating and maintaining long-lived `DESIGN.md` project design context.
- Best stages:
  - after final spec
  - before implementation across multiple sessions
- Fallback: create `docs/ui-design-spec.md`; optionally summarize into `DESIGN.md` manually.

### figma/figma-implement-design

- Source directory reference: https://github.com/VoltAgent/awesome-agent-skills lists `figma/figma-implement-design` and OpenAI/Figma variants.
- Use for: translating Figma designs to production code with high fidelity.
- Best stages:
  - when user provides Figma link/design context
  - implementation handoff
- Fallback: use written UI spec and request screenshots or exported frames.

### figma/figma-generate-library

- Source directory reference: https://github.com/VoltAgent/awesome-agent-skills lists Figma design-system skills.
- Use for: building or updating a Figma design system library from codebase/spec.
- Best stages:
  - design-system handoff
  - multi-page product systemization
- Fallback: produce token tables in `docs/ui-design-spec.md`.

### greensock/gsap-core

- Source directory reference: https://github.com/VoltAgent/awesome-agent-skills lists official GreenSock skills.
- Use for: GSAP tweening, easing, duration, stagger, animation basics.
- Best stages:
  - interaction report
  - prototype generation
- Fallback: CSS transitions and keyframes.

### greensock/gsap-scrolltrigger

- Source directory reference: https://github.com/VoltAgent/awesome-agent-skills lists official GreenSock skills.
- Use for: scroll-linked animation, pinning, scrubbed timelines, storytelling landing pages.
- Best stages:
  - advanced landing page interaction
  - marketing pages
- Fallback: CSS scroll effects or simpler reveal animations.

### greensock/gsap-react

- Source directory reference: https://github.com/VoltAgent/awesome-agent-skills lists official GreenSock skills.
- Use for: React integration with GSAP, lifecycle cleanup, SSR-safe patterns.
- Best stages:
  - React prototype/implementation
- Fallback: framework-native animation or CSS-only motion.

### addyosmani/web-quality-audit

- Source directory reference: https://github.com/VoltAgent/awesome-agent-skills lists Addy Osmani web quality skills.
- Use for: production quality across performance, accessibility, SEO, and best practices.
- Best stages:
  - final review
  - pre-launch quality gate
- Fallback: use `quality-checklist.md`.

### addyosmani/accessibility

- Source directory reference: https://github.com/VoltAgent/awesome-agent-skills lists Addy Osmani accessibility skill.
- Use for: WCAG, screen reader support, keyboard navigation.
- Best stages:
  - interaction report
  - final review
- Fallback: use accessibility sections in `quality-checklist.md`.

### addyosmani/core-web-vitals

- Source directory reference: https://github.com/VoltAgent/awesome-agent-skills lists Addy Osmani Core Web Vitals skill.
- Use for: LCP, INP, CLS and performance-sensitive UI decisions.
- Best stages:
  - final review
  - implementation review
- Fallback: include performance constraints in final spec.

### google-labs-code/enhance-prompt

- Source directory reference: https://github.com/heilcheng/awesome-agent-skills and https://github.com/VoltAgent/awesome-agent-skills list Google Labs code skills.
- Use for: improving UI prompts with better design vocabulary and design-spec context.
- Best stages:
  - before prototype generation
  - before handing spec to another agent
- Fallback: use `docs/ui-design-spec.md` as the prompt source.

## Skill Routing Matrix

| Workflow Stage | Primary Skills | Optional Skills | Built-in Fallback |
|---|---|---|---|
| Requirement alignment | `ux-audit` for friction framing | PM/JTBD skills if installed | Stage 1 brief questions |
| Reference research | `frontend-design` | `canvas-design`, web search skills | Built-in reference sites |
| UI form/layout | `ui-design`, `ui-ux-pro-max` | `ux-audit` | `03-form-report.md` template |
| Visual design | `frontend-design`, `typography-audit`, `design-dna` | `canvas-design` | `04-visual-report.md` template |
| IA | `ux-audit` | design-system/product skills | `05-ia-report.md` template |
| Interaction | `ui-animation` | `gsap-*`, `accessibility` | `06-interaction-report.md` template |
| Content | `copywriting` | CRO/product marketing skills | `07-content-report.md` template |
| Final review | `web-design-guidelines`, `ui-audit`, `ux-audit` | `web-quality-audit`, `accessibility` | `quality-checklist.md` |
| Prototype | `frontend-design`, `design-dna` | `gsap-*`, `enhance-prompt` | final spec + simple HTML/CSS |
| Long-term design context | `design-md` | Figma design-system skills | `DESIGN.md` summary |

## Update Notes

When adding or changing external skill references:

1. Add the skill name and upstream URL.
2. Explain when it should be consulted.
3. Define fallback behavior.
4. Do not copy full third-party skill instructions unless the license and project policy explicitly allow it.
5. Update `SKILL.md` routing summary if the skill is important enough to appear in the entry point.
