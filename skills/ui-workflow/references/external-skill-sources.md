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

### ehmo/platform-design-skills

- Source: https://github.com/ehmo/platform-design-skills
- Use for: platform-aware design rules and quality review across iOS, iPadOS, macOS, watchOS, visionOS, tvOS, Android, Web, Material Design 3, Apple HIG, and WCAG 2.2.
- Best stages:
  - Stage 1.5 reference and external skill routing
  - final platform-aware quality review
  - mobile, desktop, Apple-platform, Android, and cross-platform UI review
- Routing tags: platform-aware review, iOS design, Android design, macOS app, desktop app, Material Design, Apple HIG, WCAG, cross-platform UI.
- Fallback: use the platform-specific checklist in `quality-checklist.md` and the Stage 3 quality gates in `workflow-protocol.md`.

### anthropics/frontend-design

- Source: https://github.com/anthropics/skills/blob/main/skills/frontend-design/SKILL.md
- Use for: production-grade frontend UI, strong visual direction, anti-generic AI aesthetics, typography, color, motion, layout, visual polish.
- Best stages:
  - `ui-visual-analyst`
  - final UI spec review
  - optional HTML prototype generation
- Fallback: use `04-visual-report.md` rules and `design-dna` if available.

### alchaincyf/huashu-design

- Source: https://github.com/alchaincyf/huashu-design
- Use for: high-fidelity HTML-native design deliverables, clickable App/Web prototypes, product launch motion, MP4/GIF export, HTML decks, editable PPTX, infographics, data visualization, brand-asset-driven visuals, 3-direction visual exploration, and 5-dimension design critique.
- Best stages:
  - reference research and visual direction exploration
  - visual report
  - interaction and motion report
  - optional high-fidelity prototype generation
  - deck, infographic, or motion deliverable review
- Routing tags: high-fidelity prototype, clickable demo, App mockup, Web prototype, launch animation, MP4, GIF, deck, PPT, Keynote, infographic, data visualization, brand assets, brand-spec, 3 design directions, design critique.
- Avoid using as the sole product strategy workflow. It should enhance `ui-workflow` after requirements and design direction are aligned.
- Fallback: use `docs/ui-design-spec.md`, `design-dna`, and simple HTML/CSS prototype guidance.

### design-dna

- Source: local bundled skill or project/user-installed skill named `design-dna`
- Use for: extracting design tokens, style, and visual effects from references; defining reusable design DNA; keeping long-term product surfaces visually consistent.
- Best stages:
  - reference analysis
  - visual report
  - prototype generation
  - long-lived design system documentation
- Fallback: manually define visual tokens and style guidance in `04-visual-report.md`.

### vercel-labs/web-design-guidelines

- Source: https://github.com/vercel-labs/agent-skills/blob/main/skills/web-design-guidelines/SKILL.md
- Use for: Web-specific UI code review, accessibility, web interface guidelines, design compliance, UX audit against best practices.
- Best stages:
  - Web / SaaS / dashboard / landing page final review
  - Web implementation audit
  - Web accessibility review
- Do not use as the primary standard for native mobile apps, desktop apps, decks, infographics, or motion deliverables. Route those through platform-aware quality review first.
- Fallback: use the Web section of `quality-checklist.md`.

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

### raintree-technology/hig-doctor

- Source: https://github.com/raintree-technology/hig-doctor
- Use for: Apple Human Interface Guidelines lookup and audit across iOS, iPadOS, macOS, tvOS, watchOS, visionOS, and Apple-adjacent implementations.
- Best stages:
  - Apple platform final review
  - HIG compliance audit
  - native Apple implementation review
  - code audit when the project has SwiftUI, UIKit, React Native, Flutter, or other supported UI code
- Routing tags: Apple HIG, iOS audit, iPadOS audit, macOS audit, SwiftUI HIG, UIKit HIG, native Apple app, HIG compliance.
- Notes: stronger and heavier than a general design checklist; prefer on-demand use when the task explicitly targets Apple platforms or HIG compliance.
- Fallback: use `ehmo/platform-design-skills` or the Apple-platform checklist in `quality-checklist.md`.

### ceorkm/mobile-app-ui-design

- Source: https://github.com/ceorkm/mobile-app-ui-design
- Use for: professional mobile app screen design, App mockups, onboarding flows, mobile navigation, mobile UI components, and React Native/Flutter/SwiftUI-oriented mobile design guidance.
- Best stages:
  - mobile requirement-to-form translation
  - mobile visual report
  - mobile interaction report
  - mobile prototype generation
- Routing tags: mobile app design, app mockup, onboarding flow, mobile navigation, bottom tabs, thumb zone, React Native UI, Flutter UI, SwiftUI screen.
- Fallback: use the Mobile App section of `quality-checklist.md`.

### AvdLee/SwiftUI-Agent-Skill

- Source: https://github.com/AvdLee/SwiftUI-Agent-Skill
- Use for: SwiftUI implementation review, state management, navigation, layout, performance, accessibility, animations, macOS SwiftUI windows, and modern Apple API guidance.
- Best stages:
  - after UI spec when implementing SwiftUI
  - SwiftUI code review
  - performance or Instruments trace review
- Routing tags: SwiftUI, iOS implementation, macOS SwiftUI, Swift Charts, SwiftUI performance, Dynamic Type, VoiceOver, Liquid Glass.
- Avoid using for pure design strategy before technology is chosen.
- Fallback: use Apple-platform quality gates and request implementation details later.

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

## Platform-aware Quality Review

Before final review, identify the target platform. Do not use a Web-only checklist for mobile apps, desktop apps, native software, decks, infographics, or motion deliverables.

Recommended routing:

- **Web / SaaS / dashboard / landing page**: `vercel-labs/web-design-guidelines`, `addyosmani/accessibility`, `addyosmani/web-quality-audit`, `addyosmani/core-web-vitals`.
- **iOS / iPadOS / macOS / Apple ecosystem**: `ehmo/platform-design-skills`; use `raintree-technology/hig-doctor` when HIG compliance or Apple implementation review is important.
- **Android**: `ehmo/platform-design-skills` for Material Design 3 and Android platform conventions.
- **Mobile App generic / cross-platform mobile**: `ceorkm/mobile-app-ui-design`, then validate each target OS with `ehmo/platform-design-skills`.
- **SwiftUI implementation**: `AvdLee/SwiftUI-Agent-Skill`; use `hig-doctor` for HIG compliance.
- **Desktop app / local software**: `ehmo/platform-design-skills` for macOS; use built-in desktop checklist for Windows/Linux or unspecified local software.
- **Deck / PPT / infographic / motion**: `alchaincyf/huashu-design`, `typography-audit`, and visual hierarchy review.
- **Cross-platform product**: run per-platform review first, then reconcile shared tokens, navigation differences, and platform-specific adaptations.

## Skill Routing Matrix

| Workflow Stage | Primary Skills | Optional Skills | Built-in Fallback |
|---|---|---|---|
| Requirement alignment | `ux-audit` for friction framing | PM/JTBD skills if installed | Stage 1 brief questions |
| Reference research | `frontend-design`, `ehmo/platform-design-skills` for platform references | `canvas-design`, `huashu-design`, web search skills | Built-in reference sites |
| UI form/layout | `ui-design`, `ui-ux-pro-max` | `ux-audit`, `mobile-app-ui-design` for mobile | `03-form-report.md` template |
| Visual design | `frontend-design`, `typography-audit`, `design-dna` | `canvas-design`, `huashu-design`, `mobile-app-ui-design` | `04-visual-report.md` template |
| IA | `ux-audit` | design-system/product skills, `platform-design-skills` | `05-ia-report.md` template |
| Interaction | `ui-animation` | `gsap-*`, `accessibility`, `huashu-design`, `platform-design-skills` | `06-interaction-report.md` template |
| Content | `copywriting` | CRO/product marketing skills | `07-content-report.md` template |
| Platform-aware final review | `ehmo/platform-design-skills` | `web-design-guidelines`, `hig-doctor`, `mobile-app-ui-design`, `SwiftUI-Agent-Skill`, `huashu-design` | `quality-checklist.md` platform sections |
| Web implementation audit | `web-design-guidelines`, `ui-audit`, `ux-audit` | `web-quality-audit`, `accessibility`, `core-web-vitals` | Web quality checklist |
| Apple implementation audit | `hig-doctor` | `SwiftUI-Agent-Skill`, `platform-design-skills` | Apple-platform checklist |
| Prototype | `frontend-design`, `design-dna`, `huashu-design` | `gsap-*`, `enhance-prompt`, `mobile-app-ui-design` | final spec + simple HTML/CSS |
| Long-term design context | `design-md` | Figma design-system skills | `DESIGN.md` summary |

## Update Notes

When adding or changing external skill references:

1. Add the skill name and upstream URL.
2. Explain when it should be consulted.
3. Define fallback behavior.
4. Do not copy full third-party skill instructions unless the license and project policy explicitly allow it.
5. Update `SKILL.md` routing summary if the skill is important enough to appear in the entry point.
