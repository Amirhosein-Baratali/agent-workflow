# Fix Workflow

Use for defect correction. Correct the root cause with the smallest complete change.

## Establish the Defect

- State observed vs expected behavior, trigger conditions, affected versions/platforms, and impact.
- Read the linked issue or incident context when available.
- Reproduce with a focused test or deterministic steps when practical.
- Trace the failing path and rank hypotheses; do not patch the first suspicious line without cause
  evidence.

## Correct and Protect

- Add a regression test that fails before and passes after the fix when feasible.
- Fix the cause, not only the visible symptom.
- Preserve established behavior outside the defect contract.
- Check directly adjacent occurrences of the same failure pattern, but do not expand into a broad
  cleanup without approval.
- Cover relevant retry, cancellation, repeated-action, lifecycle, concurrency, and error paths.

Report reproduction evidence, root cause, fix scope, regression coverage, and any environment where
the defect could not be reproduced.
