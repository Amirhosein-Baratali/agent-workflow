# Research Basis

Reviewed: 2026-09-02. Updated: 2026-10-20.

This pack synthesizes compatible principles; it does not copy any vendor's entire workflow. The
project profile and repository evidence override generic recommendations.

Internal team development and MR-review prompts were also used as design input for Jira contract
handling, explicit non-goals, state-path coverage, deterministic tests, actionable findings, and a
single MR verdict. They are reference material, not additional instruction files in this pack.

## AI Agent Context, Planning, and Approval

- [OpenAI model guidance and prompting best practices](https://developers.openai.com/api/docs/guides/latest-model): lean prompts, state each rule once, expose only relevant tools/context, define autonomy and approval boundaries, and evaluate token savings against task success.
- [OpenAI Codex custom instructions with AGENTS.md](https://developers.openai.com/codex/guides/agents-md): layered project instructions, scoped overrides, concise review rules, and instruction-size limits.
- [Claude Code memory and CLAUDE.md](https://code.claude.com/docs/en/memory): short persistent instructions, path-scoped rules, imports, and on-demand topic memory.
- [Claude Code best practices](https://code.claude.com/docs/en/best-practices): explore and plan for uncertain/multi-file work while avoiding planning overhead for trivial tasks.
- [Claude Code permission modes](https://code.claude.com/docs/en/permission-modes): read-only plan mode and explicit plan approval before execution.
- [Gemini CLI GEMINI.md context](https://geminicli.com/docs/cli/gemini-md/): hierarchical/JIT context and modular imports.
- [Gemini CLI Plan Mode](https://geminicli.com/docs/cli/plan-mode/): read-only research, editable plans, formal approval, and execution handoff.
- [Cursor Rules](https://docs.cursor.com/context/rules): concise, focused, composable, scoped project rules.
- [Cursor context guide](https://docs.cursor.com/guides/working-with-context): surgical code/file/folder context instead of indiscriminate loading.
- [Claude Code memory (2026)](https://code.claude.com/docs/en/memory): keep each instruction file under about 200 lines; imports do not reduce context cost; contradicting rules get picked arbitrarily.
- [Claude Code best practices (2026)](https://code.claude.com/docs/en/best-practices): for each line ask "would removing this cause mistakes?"; prune regularly; use hooks for rules that must never be broken; tell reviewers to flag only correctness/requirement gaps to avoid over-engineering.
- [Codex AGENTS.md guide (2026)](https://learn.chatgpt.com/docs/agent-configuration/agents-md): concise files, specific commands, review rules that name the behavior to flag; 32 KiB default combined limit.

## 2026-10 Update: Shared Pack, Lean Controller, Learning Loop

- [Evaluating AGENTS.md (Gloaguen et al., arXiv 2602.11988, ICLR 2026)](https://arxiv.org/abs/2602.11988v1): auto-generated context files lowered task success and raised inference cost by over 20%; developer-written ones helped only slightly. Keep only minimal, non-standard requirements.
- [Claude Code memory (2026-10)](https://code.claude.com/docs/en/memory): `~/.claude/CLAUDE.md` applies to every project and loads its imports without an approval dialog; a project `AGENTS.md` loads only when no `CLAUDE.md` exists.
- [Claude Code permissions (2026-10)](https://code.claude.com/docs/en/permissions): reads need no approval inside the working and additional directories.
- [Claude Code best practices (2026-10)](https://code.claude.com/docs/en/best-practices): show evidence instead of asserting success; after two failed corrections, start over with a better approach; tell a fresh-context reviewer to flag only correctness and requirement gaps; use hooks for rules that must never break.
- [Anthropic: Effective context engineering for AI agents](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents): find the smallest set of high-signal tokens; keep lightweight references and load details just in time.
- [Anthropic: Agent Skills](https://www.anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills): progressive disclosure through skills. Considered; the router stays because it enforces the phase order more reliably than model-chosen skills. Converting workflows to skills is a possible later experiment.
- [Eric J. Ma: How to build self-improving coding agents](https://ericmjl.github.io/blog/2026/1/17/how-to-build-self-improving-coding-agents-part-1/): agents improve when you change their environment (instruction files, skills), not their weights.
- [On the Fragility of Self-Improving Agents (arXiv 2608.18066)](https://arxiv.org/pdf/2608.18066): self-improvement results vary with run order and underspecified tasks, so learned rules need a filter, size limits, and human approval.
- [Simon Willison: Agentic Engineering Patterns](https://simonwillison.net/2026/Feb/23/agentic-engineering-patterns/): agentic engineering is professionals amplifying their expertise with agents while still owning and reviewing the code.

## Human Understanding and Accountability

- [AI Policy, Disclosure, and Human in the Loop (arXiv 2605.16706)](https://arxiv.org/pdf/2605.16706): most surveyed projects require human oversight; contributors must read and understand all AI-assisted output before requesting review.
- [Addy Osmani: Treat AI-generated code as a draft](https://addyosmani.com/blog/treat-ai-generated-code-as-a-draft/): passing tests is not trust; a human must verify and own the code.

## Programming, Review, and Incremental Delivery

- [Google Engineering Practices: Small CLs](https://google.github.io/eng-practices/review/developer/small-cls.html): small self-contained changes are easier to review, safer, faster, and less wasteful; preparatory tests/refactors can be separate coherent changes.
- [Google Engineering Practices: What to look for](https://google.github.io/eng-practices/review/reviewer/looking-for.html): inspect design, functionality, complexity, tests, naming, comments, style, docs, and surrounding/system context.
- [GitHub: Helping others review changes](https://docs.github.com/en/pull-requests/concepts/helping-others-review-your-changes): small, focused PRs with clear context improve review quality and safety.
- [GitHub: Giving reviews](https://docs.github.com/en/pull-requests/concepts/giving-reviews): reviews catch issues early and support explicit approve/request-changes decisions.
- [Conventional Commits 1.0.0](https://www.conventionalcommits.org/en/v1.0.0/): optional machine-readable commit-message structure; project conventions take precedence.

## Android and Mobile Development

- [Android architecture recommendations](https://developer.android.com/topic/architecture/recommendations): layered architecture, repositories, UDF, ViewModels, DI, coroutines/Flow, and meaningful tests; recommendations must be adapted to the project.
- [Android testing strategies](https://developer.android.com/training/testing/fundamentals/strategies): many fast small tests plus fewer high-fidelity large tests and timely feedback.
- [Philipp Lackner: agentic Android development](https://www.youtube.com/watch?v=OcBkJUwjDqg): recent Android-agent guidance emphasizing reusable skills and practical mobile-specific workflow habits.
- [Philipp Lackner AI-first Android/KMP workshop overview](https://www.pl-coding.com/workshop): production-oriented Android/KMP agent workflows with developer review and code-quality control.

## Design Decisions Derived From the Sources

- `AGENTS.md` remains lean; detailed procedures are routed on demand.
- Feature, fix, refactor, small-change, and large-change guidance loads only for matching work.
- Plan depth depends on task size/risk; large tasks have approval and first-slice checkpoints.
- Review is a distinct read-only mode with evidence-backed findings.
- Verification widens from targeted tests according to risk.
- Commit is a separate, fresh-approval phase after human inspection.
- Every change waits until the user understands and approves it; reviews explain the change before
  findings; large work offers options for the user to choose (2026-10-12).
- Each rule lives in one file; others link to it (the first-slice gate lives in `LARGE_CHANGE.md`).
- Project architecture and naming live in a separate profile, allowing the reusable workflows to
  move safely between repositories.
- One shared folder, `~/agent-workflow/`, is the single source of truth. Tools load it globally;
  projects only link a private profile, so copies cannot fall behind (2026-10-20).
- Profiles are private and git-ignored; the public pack carries no project details (2026-10-20).
- A learning loop proposes at most three rule edits per task, routed to one file, under hard size
  limits and with the user's approval (2026-10-20).
- Repeated user corrections became rules: smallest diff and few tests, fetch shared branches
  first, reuse existing events and controls, respect declined options (2026-10-20).
