# Implementation Workflow

Use after the planning gate permits edits. Stay inside the approved scope and preserve unrelated
work.

## Before Editing

1. Confirm the user approved the plan or micro-plan (or said to proceed without asking).
2. Inspect `git status --short` and the final targeted files.
3. Identify pre-existing changes that overlap the task. Work around them; stop if safe separation
   is impossible.
4. Confirm project patterns, explicit non-goals, and the narrow verification command.
5. When creating a new task branch (feature or fix), never let it track its base branch. Cut it
   with `git switch --no-track -c <branch> origin/<base>`, then point its upstream at a remote
   branch of its own name: `git config branch.<branch>.remote origin` and
   `git config branch.<branch>.merge refs/heads/<branch>`. Git shows it as `[gone]` until the
   first authorized push.

## Change Discipline

- Implement the smallest complete behavior that satisfies the current slice.
- Follow existing boundaries, contracts, naming, DI, error handling, and test patterns.
- Reuse before introducing a new abstraction or dependency. Extend the existing event, state, UI
  control, or test instead of adding a parallel one (for example, never a second button for one
  action).
- Avoid signature or constructor changes that ripple into many call sites and tests when a local
  change works.
- Avoid unrelated cleanup, speculative generalization, and silent scope growth.
- Implement relevant success, loading, empty, error, retry, cancellation, repeated-action,
  lifecycle, concurrency, compatibility, and accessibility paths—do not add meaningless states.
- Never suppress failures merely to make checks pass.
- Do not modify generated/vendor files unless the project workflow requires it.

If the plan becomes invalid, pause, present the evidence, and propose a revised plan. Do not force
the original design through contradictory repository facts.

## Feedback Loop

For each slice:

1. Edit.
2. Inspect the diff for accidental or unrelated changes.
3. Run the narrowest meaningful check.
4. Fix issues caused by the slice.
5. Widen verification according to risk.
6. Update the plan with evidence, not optimism.

For UI work, provide a fast human inspection path where the project supports it: previews for
important states, screenshots, a local route, or exact run instructions. Do not add previews that
start production DI, networking, or side effects.

For large work, stop after the first slice as `LARGE_CHANGE.md` requires.

## Completion Review

Before handoff:

- compare the final diff against every acceptance criterion;
- confirm no debug artifacts, secrets, unused code, or unexplained TODOs were introduced;
- ensure relevant tests cover success and material failure/regression behavior;
- run the agreed checks and record exact results;
- inspect working-tree state and separate unrelated pre-existing changes in the report;
- for large or high-risk work, offer an independent review of the final diff in a fresh context
  (a review subagent or review command), told to flag only correctness and requirement gaps so it
  does not push over-engineering.

Finish with the `AGENTS.md` handoff. Do not stage or commit.
