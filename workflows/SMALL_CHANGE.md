# Small Change Workflow

A small change addresses one local behavior, normally in 1-3 files, using an established pattern,
with low compatibility and rollback risk.

- Inspect the target, its nearest relevant test, and one representative local pattern.
- State a 1-3 step micro-plan including the focused verification, then wait for approval unless
  the user said to proceed without asking.
- Keep the diff minimal; do not introduce infrastructure or abstraction for hypothetical reuse.
- Run the narrowest meaningful check and inspect the complete diff.
- Reclassify as medium/large immediately if scope, risk, or architectural impact grows.

Small does not mean untested, unplanned, or automatically committed.
