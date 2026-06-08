# UI Workflow Quality Checklist

Use this checklist before considering the UI workflow complete.

## Product Fit

- [ ] The spec explains who the product is for.
- [ ] The spec explains what user problem the UI solves.
- [ ] The page/flow scope matches the selected execution mode.
- [ ] MVP decisions are separated from polish/future iterations.
- [ ] Important assumptions are explicitly listed.

## Requirements and User Flows

- [ ] Key user scenarios are covered.
- [ ] Primary and secondary actions are clear.
- [ ] Required pages or screens are listed.
- [ ] Empty/loading/error/success states are included.
- [ ] Any ambiguous product-shaping decisions were confirmed with the user.

## Information Architecture

- [ ] Navigation model is understandable.
- [ ] Page hierarchy is documented.
- [ ] Users can predict where to find key actions.
- [ ] Search/filter/sort behavior is defined when relevant.
- [ ] The structure can scale without confusing users.

## Layout and Components

- [ ] Layout pattern matches the product type.
- [ ] Component strategy is implementation-ready.
- [ ] Responsive behavior is described for mobile, tablet, desktop, and wide screens when relevant.
- [ ] Density and whitespace fit the user's task complexity.
- [ ] Forms include validation, helper text, and error behavior when relevant.

## Visual Design

- [ ] Visual direction is specific, not generic.
- [ ] The design avoids common AI-slop patterns such as default purple gradients, unmotivated glass cards, and generic SaaS sameness.
- [ ] Color tokens include purpose and usage.
- [ ] Typography includes hierarchy, scale, and usage.
- [ ] Spacing, radius, shadow, and border rules are defined.
- [ ] Visual style supports product positioning.
- [ ] If `design-dna` is available, design-system/style/effects guidance is included.

## Interaction and Motion

- [ ] Hover, focus, active, disabled, and error states are defined for key components.
- [ ] Motion has clear purpose and timing.
- [ ] Motion does not interfere with usability.
- [ ] Reduced-motion behavior is considered.
- [ ] Keyboard and touch behavior are addressed where relevant.

## Accessibility

- [ ] Text contrast target is at least WCAG AA where applicable.
- [ ] Focus states are visible.
- [ ] Interactive elements have clear affordance.
- [ ] UI does not rely on color alone to communicate critical information.
- [ ] Keyboard navigation is considered.
- [ ] Screen-reader labels or semantic expectations are noted for complex controls.

## Content and Copy

- [ ] Voice and tone match the product and user context.
- [ ] CTAs are clear and action-oriented.
- [ ] Empty states help users recover or continue.
- [ ] Error messages explain what happened and what to do next.
- [ ] Copy avoids vague AI-generated phrasing.

## External Skill and Source Traceability

- [ ] Related external skills were checked using `external-skill-sources.md`.
- [ ] Reports note which skills were available and consulted.
- [ ] Missing external skills did not block progress.
- [ ] Third-party skill content was referenced by URL, not copied wholesale.
- [ ] Design references and source URLs are listed when used.

## Implementation Readiness

- [ ] The final spec gives enough detail for a developer or agent to build the UI.
- [ ] Token names are consistent.
- [ ] Component behavior is not contradictory across sections.
- [ ] Responsive rules are actionable.
- [ ] Performance-sensitive choices are called out.

## Final Artifact Check

- [ ] `docs/ui-design-spec.md` exists or is ready to create.
- [ ] `docs/ui-workflow/99-ui-design-spec.md` archive exists or is ready to create.
- [ ] Intermediate reports are preserved when generated.
- [ ] Optional prototype was not generated without user confirmation.
- [ ] Remaining risks and recommended next steps are listed.

## Pre-handoff Summary

Before handing off, summarize:

1. What was completed.
2. Where the user can find the final spec.
3. Which external skills or references influenced the result.
4. What was not tested or not generated.
5. What the recommended next step is.
