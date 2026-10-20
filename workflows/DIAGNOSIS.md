# Diagnosis Workflow

A diagnosis request determines and explains the cause. It does not authorize implementation.

## Method

1. Restate the observed vs expected behavior and reproduction conditions.
2. Gather the smallest useful evidence: error, log, stack trace, failing test, recent diff, entry
   point, and environment/version only as relevant.
3. Form a short ranked hypothesis list.
4. Test the cheapest discriminating hypothesis first.
5. Trace the confirmed cause through the relevant state/data/control flow.
6. Separate root cause, contributing factors, and unrelated symptoms.

Prefer reproduction or a focused failing test over broad code reading. Do not alter behavior to
"see if it works" unless the user asks for a fix; temporary diagnostics must be non-destructive and
must not remain in source.

## Context Limits

- Inspect the failing path, its direct dependencies, and recent relevant changes.
- Do not run every test suite or read every log.
- Stop when one explanation accounts for the evidence and serious alternatives are reasonably
  excluded.

## Output

Lead with the cause and confidence level. Include evidence, triggering conditions, impact, and a
specific fix direction. Clearly state what remains unproven. Ask whether to implement if the user
requested diagnosis only.
