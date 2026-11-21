# Code Review Workflow

A review request is read-only. Do not fix, format, stage, commit, push, comment, approve, label, or
merge unless the user separately authorizes that action.

## Establish Review Scope

1. Identify the intended base/head or exact diff; fetch and diff against `origin/<base>`, since a
   stale local base pulls in already-merged commits. On a re-review, also diff against the commit
   last reviewed: it may have been amended since, so review that delta, not the old verdict.
2. Read the MR/PR description and linked issue (else the task ID in the branch); on a re-review,
   also every thread and open ask, the pipeline, and commit messages against the project's MR
   rules. If you cannot read them (no GitLab access), ask the user to paste them or say so.
3. Extract acceptance criteria and non-goals. If the contract is unavailable, report the scope gap
   and do not infer product requirements.
4. Inspect the diff summary and changed files before opening whole files.

## Explain First, Then Findings

The user must fully understand the change before seeing findings. First explain in plain words
what the change does, how the main flow works now (entry point to result), and what changed; keep
it short and name the key files. Then wait until the user understands or asks questions. Give the
findings (step 2) only after that, unless the user asks for findings directly.

## Review in Risk Order

Start with the change's overall design and highest-risk path, then inspect files. Check:

- correctness against the requested behavior and invariants;
- regressions and compatibility;
- security, privacy, authorization, secrets, and sensitive logging;
- data loss, persistence, migrations, transactions, and rollback;
- concurrency, cancellation, ordering, races, and resource cleanup;
- lifecycle, state restoration, navigation, and error/empty/loading behavior;
- architectural and dependency boundaries;
- performance on hot paths; accessibility and UI state coverage when relevant;
- tests that prove meaningful success and failure/regression cases.

Trace directly affected contracts, call sites, and tests beyond the diff when needed. Do not scan
unrelated modules or run a full build by default.

## Finding Quality Bar

Report a finding only when it is actionable and supported by a concrete triggering scenario.
Validate it against actual types, call paths, platform behavior, or tests; no speculative "maybe"
comments. Calling code redundant needs the invariant and the line that establishes it.

Each finding is a few lines:

- severity (`P0` critical through `P3` low) and a short title;
- file and tight line range;
- one or two plain sentences: what breaks, when, and the impact;
- one line of fix direction, naming any test that pins the current behavior (it may be intended).

Prioritize bugs over style: style is a finding only if it breaks a project rule or materially harms
maintainability. Keep praise and summaries apart from findings so they do not hide risk.

## Review Verification

- Run a focused test or static check only when it confirms or refutes a finding, or when asked.
- Treat passing tests as evidence, not proof that no bug exists.
- If generated code or environmental limitations prevent inspection, state the residual risk.

## Output

In step 2, list findings by severity, then one line per quality question (safety, performance,
other parts affected, tests before release, simplicity, comments and names), open questions, and
a verification note. With no actionable findings, say so and name coverage gaps; never invent one.

Draft MR/PR comments in English, one at a time for approval: one or two short sentences of why
and a one-line ask; severity and evidence stay in chat, never in the comment. Name the diff line
to post on; add a `suggestion:-X+Y` block for small fixes (it only reaches lines next to that
one). Put the final text on the clipboard with `pbcopy`: copying rendered chat breaks the Markdown.
Always run it as `LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 pbcopy`, or non-ASCII text is garbled.

For an MR/PR readiness review, end with exactly one verdict: **Approve** (no actionable findings),
**Approve with nits** (only non-blocking P3 improvements), or **Request changes** (any blocking
finding or missing contract that prevents a reliable verdict).
