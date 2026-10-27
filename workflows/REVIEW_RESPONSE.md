# Review Response Workflow

Use when someone reviewed the user's code and the user wants to respond to the comments. This
phase is read-only: do not edit source, reply, resolve threads, or push unless separately asked.

Exception: when a comment is right and its fix is trivial (formatting, a test name, a comment, or
renaming a private or local symbol; one file; no behavior or public-contract change), apply it in
the same turn without waiting for approval, run the narrowest check, and report the change and
result instead of a fix plan. Still never reply, resolve, stage, commit, or push.

## Method

For each review comment:

1. Locate the exact code the comment refers to (file, lines, current branch state). Read only the
   surrounding code and the directly affected call sites and tests.
2. **Simplify it.** Restate what the reviewer is asking in one or two plain sentences, without
   jargon.
3. **Judge it.** Check the claim against the actual code, types, platform behavior, and project
   rules. Label it:
   - **Right**: the concern is real, or the change clearly improves the code.
   - **Partly right**: valid concern, but the suggested fix is wrong or overkill.
   - **Wrong**: based on a misread, a false assumption, or it conflicts with project rules or the
     task scope.
   - **Preference**: style or taste with no authoritative rule behind it. Say so and let the user
     decide.
   Give the evidence (file:line, rule, or behavior) behind the verdict. If it cannot be decided
   without running something or asking the reviewer, say that instead of guessing.

## Output per Comment

Each field below is one or two sentences; one comment's response fits in a few lines.

**Right / Partly right:**

- **Simplified:** what they mean.
- **Why they're right:** the concrete problem and its impact.
- **Fix plan:** 1-3 short steps, with files. Include only what the comment needs; mark any step
  needed only to make the fix compile or work as required, and report anything else as a
  follow-up.
- **How to test:** a concrete check (focused test, command, or manual steps with expected
  result) that proves the fix and catches a regression.

**Wrong:**

- **Simplified:** what they mean.
- **Why it's wrong:** one or two lines of evidence for the user.
- **Reply:** a very short, simple, polite reply the user can paste to the reviewer (1-2
  sentences, pointing at the evidence).

**Preference:** simplified meaning, a recommendation, and a short reply for either choice.

## Wrap-up

End with a one-line summary (e.g. `3 to fix, 1 to push back, 1 preference`). Fixing the accepted
comments is a separate implementation request; follow the normal planning and implementation gates
when the user asks for it.
