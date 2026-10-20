# Planning Workflow

Use this workflow before source mutation or when the user asks for a plan. Planning is an
evidence-gathering phase, not permission to edit production files.

## 1. Frame the Outcome

Extract from the request:

- desired user/system outcome;
- acceptance criteria and explicit non-goals;
- constraints, compatibility needs, and risk areas;
- what is fact, what is inferred, and what decision is still missing.

For tracked work (Jira or another issue tracker), read the issue when accessible and treat its
acceptance criteria and non-goals as the product contract. The task ID may come from the request,
MR/PR description, branch, or a task-related comment. If the tracker is unavailable but another
authoritative specification is sufficient, proceed and disclose the missing issue context. If expected behavior remains materially
unclear, stop before implementation and request the contract rather than inventing requirements.

Ask a question only when repository evidence cannot answer it and a reasonable assumption could
materially change behavior, architecture, data, security, or scope.

## 2. Inspect Narrowly

1. Inspect current branch and working-tree state for code tasks. On a shared branch, `git fetch`
   and compare with upstream first: a teammate may already have pushed part of the fix. Build on
   it instead of a parallel rewrite.
2. Locate the smallest set of entry points using filenames and search.
3. Trace the affected behavior through contracts, implementation, state/UI, DI/navigation, and
   tests only as applicable.
4. Inspect neighboring code to learn the project's established pattern.
5. Load only relevant project-profile sources.

Do not inventory the entire repository. Stop when the plan can name exact change points and
verification paths with acceptable confidence.

## 3. Classify Type, Size, and Risk

Classify the change as feature, fix, or behavior-preserving refactor and load only that workflow.

- **Small:** one behavior, usually up to 1-3 files, local effect, established pattern, low rollback
  cost. Load `SMALL_CHANGE.md`.
- **Medium:** several connected files or one module, moderate behavior change, but no major design
  choice. No size-specific file is needed.
- **Large/high-risk:** cross-module or architectural change; public contracts; database/migration;
  auth, security, payment, privacy, concurrency, or data-loss risk; broad UI redesign; unclear
  acceptance criteria; or expensive rework. Load `LARGE_CHANGE.md`.

## 4. Build a Slice Plan

Each step must produce a coherent, reviewable state and include its verification. Prefer vertical
slices that exercise a real path over horizontal batches of disconnected scaffolding.

For large work:

1. Identify the thinnest end-to-end slice that proves the architecture and riskiest assumption.
2. Keep the repository buildable after the slice when feasible.
3. Define what the user will inspect: diff, behavior, screenshot/preview, test, or API shape.
4. Follow the first-slice gate in `LARGE_CHANGE.md`.

Avoid orphan abstractions and unused APIs. If preparatory refactoring is necessary, make it a
self-contained slice with behavior-preserving tests.

## 5. Plan Output

Write it so the user can fully understand the change without reading code first: plain words,
what changes and why. Cover what is decision-complete, in as few words as possible:

- outcome and scope;
- evidence/current behavior;
- assumptions or decisions needed;
- ordered slices with exact areas/files where known;
- verification per slice;
- risks, rollback/compatibility notes, and explicit non-goals;
- that execution awaits the user's approval.

Include an item only when it carries a real decision for this change; a small plan is a few lines.
Do not promise exact files before inspecting them, and do not include generic steps such as "write
good code" or "test everything."
