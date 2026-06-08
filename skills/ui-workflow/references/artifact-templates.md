# UI Workflow Artifact Templates

Use these templates for consistent outputs across Pi automation and universal skill mode.

## 00-need-summary.md

```md
# UI Need Summary

## User Request

## Product Goal

## Target Users

## Primary Scenarios

## Platform and Surface

## Desired Quality Level

- Fast / Standard / Deep:
- MVP or production-ready:

## Constraints

- Tech/framework:
- Brand/design system:
- Accessibility:
- Timeline:

## Decisions Confirmed With User

## Open Questions
```

## 01-research-report.md

```md
# UI Research Report

## References Inspected

| Source | Why Relevant | Takeaways |
|---|---|---|

## External Skills Consulted

| Skill | Available? | Used For | Notes |
|---|---:|---|---|

## Patterns Worth Borrowing

## Patterns to Avoid

## Product-Specific Design Implications

## Recommended Direction
```

## 02-need-report.md

```md
# UI Requirements Report

## Product Positioning

## Target Users / Personas

## Jobs To Be Done

## Key User Scenarios

## Feature and Page Priority

| Priority | Feature/Page | User Value | Notes |
|---|---|---|---|

## Required States

- Empty:
- Loading:
- Error:
- Success:
- Edge cases:

## Success Metrics

## Assumptions / Risks
```

## 03-form-report.md

```md
# UI Form and Layout Report

## Interface Type

- Landing page / dashboard / app shell / mobile app / internal tool / other:

## Page Inventory

| Page | Purpose | Key Components | Priority |
|---|---|---|---|

## Layout Paradigm

## Navigation Model

## Component Strategy

## Responsive Strategy

| Breakpoint | Layout Behavior | Notes |
|---|---|---|

## Density and Scanning Model

## Trade-offs
```

## 04-visual-report.md

```md
# Visual Design Report

## Visual Concept

## Aesthetic Direction

## Design Tokens

### Color

| Token | Value | Usage |
|---|---|---|

### Typography

| Role | Font/Style | Size/Line Height | Usage |
|---|---|---|---|

### Spacing

| Token | Value | Usage |
|---|---|---|

### Radius / Shadow / Border

| Token | Value | Usage |
|---|---|---|

## Iconography / Illustration

## Motion Tone

## Anti-patterns to Avoid

## Design-DNA Notes

```json
{
  "designSystem": {},
  "designStyle": {},
  "visualEffects": {}
}
```
```

## 05-ia-report.md

```md
# Information Architecture Report

## Navigation Model

## Route / Page Hierarchy

```text
/
├── ...
```

## Information Groups

## Search / Filter / Sort Model

## Cross-page User Flows

## Scalability Notes

## Risks and Simplification Options
```

## 06-interaction-report.md

```md
# Interaction Experience Report

## Interaction Principles

## State Matrix

| Component/Area | Default | Hover | Focus | Active | Disabled | Error |
|---|---|---|---|---|---|---|

## Loading / Empty / Error / Success States

## Motion System

| Motion | Duration | Easing | Trigger | Purpose |
|---|---:|---|---|---|

## Keyboard and Mobile Behavior

## Accessibility Notes

## Reduced Motion Behavior
```

## 07-content-report.md

```md
# Content and Copy Report

## Voice and Tone

## Messaging Principles

## Page-level Copy

| Page/Area | Copy Goal | Example Copy |
|---|---|---|

## CTA System

| CTA Type | Example | Usage |
|---|---|---|

## Empty / Loading / Error Copy

## Onboarding / Help Copy

## Phrases to Avoid
```

## 99-ui-design-spec.md / docs/ui-design-spec.md

```md
# UI Design Spec

## 1. Product and User Context

## 2. Design Goals

## 3. Reference and Skill Sources

### References

### External Skills Consulted

| Skill | Available? | Influence |
|---|---:|---|

## 4. Page and Flow Overview

## 5. Information Architecture

## 6. Layout and Component System

## 7. Visual System

### Colors

### Typography

### Spacing

### Radius / Shadow / Border

### Iconography / Illustration

## 8. Interaction System

### Component States

### Loading / Empty / Error / Success

### Motion

### Accessibility

## 9. Content and Copy System

## 10. Responsive Behavior

## 11. Implementation Notes

## 12. Risks, Assumptions, and Follow-ups

## 13. Prototype Recommendation
```

## DESIGN.md Optional Summary

Use this when the user wants long-term design context for future agents.

```md
# DESIGN.md

## Product Design North Star

## Core Users and Scenarios

## Design Principles

## Design Tokens

## Components and Patterns

## Interaction Rules

## Content Voice

## Accessibility and Quality Rules

## Do Not Do

## Source Documents

- `docs/ui-design-spec.md`
- `docs/ui-workflow/`
```
