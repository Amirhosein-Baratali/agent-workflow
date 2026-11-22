# Testing and Verification Workflow

Verification is risk-based. The goal is fast, trustworthy feedback, not maximum command count.

## Select the Gate

Before writing or editing any test, read the project's test rules (linked from the profile), even
for a small fix. Skipping them has produced wrong test names and a hand-written fake in a project
that uses a mocking library.

Keep tests few: adjust or extend an existing test before adding one, and write one focused test per
behavior change.

Do not run long builds unasked (release assembly, full webpack bundles, broad all-module gates).
Give the user the command and say what to check in its output.

1. Map each acceptance criterion and regression risk to evidence.
2. Prefer the smallest deterministic test closest to changed behavior.
3. Add integration/UI/device/build checks only for boundaries they uniquely validate.
4. Use existing project test infrastructure, fixtures, and conventions.

Typical widening order:

```text
targeted unit test
  -> affected module tests/compile
  -> relevant static analysis
  -> integration/UI/platform check
  -> broad project gate only when risk justifies it
```

## Run the Change

Passing tests do not prove the feature works. For a user-visible or flow change, plan one
end-to-end run with the profile's Verify recipe (emulator, simulator, browser, or local server), so
the user approves the build it needs. Show the evidence: the command and its result, or a
screenshot of each changed state. Without a recipe, give the user exact steps and what to look for.

## Quality Rules

- Test observable behavior, not private implementation detail.
- Take expected values from an independent source (the spec, a worked example, a known literal).
  A value recomputed the way the code computes it always agrees, so that test can never fail.
- Cover the main success path and material error, boundary, cancellation, or regression cases.
- For an invariant or round trip (encode then decode, an idempotent retry), prefer one property test
  when the project has a property-testing library. For a migration or rewrite, run the old and new
  code on the same inputs and compare the outputs.
- Keep tests deterministic; control time, dispatchers, randomness, network, and persistence.
- Do not use real time, sleeps, real network, uncontrolled randomness, shared mutable state, or
  test-order dependency.
- Prefer the project's established fake/mock policy. Do not introduce a competing test style.
- A flaky, skipped, or silently ignored test is not verification. Find a flaky test's cause or
  report it; a rerun that happens to pass proves nothing.
- Opt-in configuration (obfuscation rules, include/exclude patterns, CI filters) can silently match
  nothing. Verify it in the produced artifact or its reports, not only by reading the config.

## Failure Handling

When a check fails:

- determine whether the failure is caused by the change, pre-existing, or environmental;
- fix in-scope regressions;
- do not change unrelated production behavior just to obtain green output;
- report the exact command and concise relevant failure.

Record what was run, pass/fail, and what was not run. Never say "all tests pass" unless the stated
test scope actually ran and passed.
