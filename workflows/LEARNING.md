# Learning Workflow

Use at the end of a task when the user corrected how you work or rejected an approach, a rule was
missing, wrong, or ignored and that cost time, or you found a durable, non-obvious fact the next
session would need. Skip it otherwise. In a retro, also look for a pointer the agent lacked, a
missing automated check, a costly tool call, and stale rules or ones the model follows anyway.

## Filter

Keep a candidate only when all of these hold:

- it changes future behavior: without it, a later session would repeat the mistake;
- it is durable, not the state of one task;
- it is not already covered, and the code or docs cannot reveal it quickly;
- it is specific: it names the command, file, behavior, or preference.

Turn a one-off correction into a general rule only when the same cause can recur elsewhere.

## Write

- State the behavior you want, with its trigger. A bare ban keeps the banned idea in view; keep
  "never" for hard guardrails and pair it with what to do instead.

## Route

| Learning | Goes to |
|---|---|
| How the user wants answers or collaboration, in any project | `~/agent-workflow/AGENTS.md` |
| A step or trap in one phase (planning, review, testing, ...) | the matching `workflows/*.md` |
| A project fact, command, convention, or trap | that project's file in `~/agent-workflow/profiles/` |
| Ticket status, one task's decisions, progress notes | the tool's memory or task notes, never the rules |
| A must-never or mechanical rule (naming, banned API, file location) | propose a lint rule, hook, or CI check; text is only advisory |

Do not keep a preference or correction only in tool memory: other tools and checkouts cannot see
it. Profiles are private and never published. Never put secrets, credentials, or personal data in
any rule file; describe the trap, not the value.

## Budget

- `AGENTS.md` at most 150 lines; each workflow at most 80 lines; each profile at most 250 lines.
- Prefer sharpening or merging an existing line over adding one. At the budget, remove or merge a
  weaker rule before adding.
- One rule lives in one place; other files link to it.
- Delete rules that proved stale or wrong.

## Apply

1. Propose at most 3 edits, one line each: file, the new or changed text, and what went wrong.
2. Apply only after the user agrees. Edit the files in `~/agent-workflow/` directly (a project's
   `.agent-profile.md` is a link to its profile there).
3. Then commit and push the rules repository at once (the user's standing request): only the rule
   files you changed, one commit per rule, `git fetch` first, fast-forward push only.
