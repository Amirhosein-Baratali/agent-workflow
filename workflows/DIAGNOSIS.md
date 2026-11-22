# Diagnosis Workflow

A diagnosis request determines and explains the cause. It does not authorize implementation.

## Method

1. Restate the observed vs expected behavior and reproduction conditions.
2. Gather the smallest useful evidence: error, log, stack trace, failing test, recent diff, entry
   point, and environment/version only as relevant.
3. Build a feedback loop: one command you have run that fails on the user's exact symptom (a
   focused test, a script, a CLI call, or UI automation). Make it fast and repeatable; for a flaky
   bug, raise the failure rate until it is debuggable. If you cannot build one, say what you tried
   and ask for logs, a recording, or environment access instead of guessing.
4. Rank 3-5 hypotheses, each with its prediction ("if X is the cause, changing Y removes the
   bug"). Test the cheapest discriminating one first, changing one variable at a time.
5. Trace the confirmed cause through the relevant state/data/control flow.
6. Separate root cause, contributing factors, and unrelated symptoms.

Prefer the loop over broad code reading. Do not alter behavior to "see if it works" unless the user
asks for a fix. Temporary diagnostics (logs, tests, scripts) must be non-destructive and must not
remain in source: give every temporary log one unique prefix (for example `[DEBUG-a4f2]`) so one
search removes them all before handoff.

## Context Limits

- Inspect the failing path, its direct dependencies, and recent relevant changes.
- Do not run every test suite or read every log.
- Stop when one explanation accounts for the evidence and serious alternatives are reasonably
  excluded.

## Output

Lead with the cause and confidence level. Include evidence (the loop's command and result),
triggering conditions, impact, and a specific fix direction. Clearly state what remains unproven.
Ask whether to implement if the user requested diagnosis only.
