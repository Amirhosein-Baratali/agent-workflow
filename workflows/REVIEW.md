# Code Review Workflow

A review request is read-only. Do not fix, format, stage, commit, push, comment, approve, label, or
merge unless the user separately authorizes that action.

## Establish Review Scope

1. Identify the intended base/head or exact local diff. Do not assume the base when it affects the
   result.
2. Read the MR/PR description and linked issue when available. If no direct link exists, look
   for the task ID in the branch or a task-related comment.
3. Extract acceptance criteria and non-goals. If the contract is unavailable and expected behavior
   cannot be established, report the scope gap and do not infer product requirements.
4. Inspect the diff summary and changed files before opening whole files.

## Explain First, Then Findings

The user must fully understand the change before seeing findings. Review in two steps:

1. **Explain.** In plain words, say what the change does, how the main flow works now (entry point
   to result), and what changed compared to before. Keep it short; name the key files. Then stop
   and wait until the user says they understand or asks questions.
2. **Findings.** Only after that, give the findings below.

Skip step 1 only when the user asks for findings directly.

## Review in Risk Order

Start with the change's overall design and highest-risk path, then inspect files. Check:

- correctness against the requested behavior and invariants;
- regressions and compatibility;
- security, privacy, authorization, secrets, and sensitive logging;
- data loss, persistence, migrations, transactions, and rollback;
- concurrency, cancellation, ordering, races, and resource cleanup;
- lifecycle, state restoration, navigation, and error/empty/loading behavior;
- architectural and dependency boundaries;
- performance on hot paths and large collections;
- accessibility and UI state coverage when relevant;
- tests that prove meaningful success and failure/regression cases.

Trace directly affected contracts, call sites, and tests beyond the diff when needed. Do not scan
unrelated modules or run a full build by default.

## Finding Quality Bar

Report a finding only when it is actionable and supported by a concrete triggering scenario.
Validate it against actual types, call paths, platform behavior, or tests; do not submit speculative
"maybe" comments.

Each finding is a few lines:

- severity (`P0` critical through `P3` low) and a short title;
- file and tight line range;
- one or two plain sentences: what breaks, when, and the impact;
- one line of fix direction.

Prioritize bugs over style. Mention style only when it violates an authoritative project rule or
materially harms maintainability. Keep praise and summaries separate from findings so they do not
hide risk.

## Review Verification

- Run a focused test or static check only when it confirms or refutes a finding, or when asked.
- Treat passing tests as evidence, not proof that no bug exists.
- If generated code or environmental limitations prevent inspection, state the residual risk.

## Output

In step 2, list findings by severity, then open questions and a short verification note. With no
actionable findings, say so and name remaining coverage gaps; never manufacture a finding.

Draft MR/PR comments for teammates one at a time for approval, each a one-line title with severity,
one or two sentences of why, and a one-line ask. Keep the evidence in the chat, not the comment.

For an MR/PR readiness review, end with exactly one verdict:

- **Approve**: no actionable findings.
- **Approve with nits**: only non-blocking P3 improvements.
- **Request changes**: any blocking finding or missing contract that prevents a reliable verdict.
