# Human-Gated Commit Workflow

Committing is a separate phase after implementation, verification, and user inspection.

## Hard Gate

- Never stage or commit during implementation.
- An initial request such as "implement and commit" is not enough to bypass inspection. Complete
  and verify the work, present it as uncommitted, then wait for a fresh explicit commit approval.
- Accept commit authorization only after a human has had the completed diff summary and test
  results. If implementation changed after approval, show the new diff and obtain approval again.
- A request to push, open an MR/PR, merge, tag, or deploy is separate authority from committing.

## Pre-Commit Audit

After approval:

1. Inspect `git status --short`, unstaged diff, staged diff, and recent project commit style.
2. Identify all pre-existing/unrelated human changes and exclude them.
3. Confirm no secrets, local configuration, debug output, generated junk, or unintended files.
4. Confirm verification is still applicable to the exact diff.
5. Determine logical commit grouping. One commit should represent one coherent purpose and keep the
   repository usable; split unrelated purposes without splitting a required behavior from its test.
6. Use the project's required message format and author identity. If none exists, propose a clear
   imperative message; use Conventional Commits only when the project adopts it or the user asks.
   Never add AI co-author trailers (such as `Co-Authored-By: Claude`) unless the user asks.

If safe selective staging is impossible because existing changes overlap the same hunks, stop and
ask.

## Commit Execution

- Stage explicit task files/hunks only; never broad-stage a dirty tree blindly.
- New files the task created belong in the commit: `git add` each one, since an untracked task file
  in `git status` is a miss. If the IDE already staged a task file, leave it staged.
- Inspect the staged diff before committing.
- Commit without rewriting unrelated history.
- Verify the resulting commit author, subject, included files, and remaining working tree.
- Do not amend, rebase, squash, force-push, or push without separate explicit authorization.

## Handoff

Report commit hash, exact subject, included scope, verification status, and any remaining uncommitted
changes. Never imply the commit was pushed unless a separately authorized push succeeded.
