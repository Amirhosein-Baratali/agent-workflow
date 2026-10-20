# Refactor Workflow

Use only for behavior-preserving structural improvement. If observable behavior intentionally
changes, classify that portion as a feature or fix and separate it when practical.

## Define Invariants

- State the behavior, contracts, APIs, data, navigation, performance, and compatibility that must
  remain unchanged.
- Establish a green baseline with focused existing tests; add characterization tests for important
  unprotected behavior before restructuring.
- Define the concrete improvement: dependency direction, duplication removal, smaller ownership,
  clearer state flow, simpler control flow, or measurable performance/maintainability gain.

## Execute Safely

- Prefer mechanical, reviewable steps and keep the project buildable after each slice.
- Separate preparatory refactors from product behavior when possible.
- Migrate consumers before deleting old contracts/implementations.
- Avoid speculative abstraction, broad renaming, formatting churn, or unrelated modernization.
- Compile/test affected boundaries after each meaningful step.

The handoff must state preserved invariants, structural improvement, verification evidence, and any
remaining migration/deprecation work.
