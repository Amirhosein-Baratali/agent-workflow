# Fix Workflow

Use for defect correction. Correct the root cause with the smallest complete change.

## Establish the Defect

- State observed vs expected behavior, trigger conditions, affected versions/platforms, and impact.
- Read the linked issue or incident context when available.
- Reproduce it first: one command that fails on the reported symptom (a focused test, a script, or
  UI automation). When the cause is unclear, follow the feedback loop in `DIAGNOSIS.md`.
- Trace the failing path and rank hypotheses; do not patch the first suspicious line without cause
  evidence.

## Correct and Protect

- Write the regression test before the fix and show it failing on the reported symptom, then
  passing. If no test seam reaches the bug's real trigger, say so in the handoff instead of adding
  a shallow test.
- Fix the cause, not only the visible symptom.
- Preserve established behavior outside the defect contract.
- Check directly adjacent occurrences of the same failure pattern, but do not expand into a broad
  cleanup without approval.
- Cover relevant retry, cancellation, repeated-action, lifecycle, concurrency, and error paths.

Report reproduction evidence, root cause, fix scope, regression coverage, and any environment where
the defect could not be reproduced.
