# Research Basis

Reviewed: 2026-09-02. Updated: 2026-11-22.

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

## 2026-11 Update: Verification, Evidence-Based Review, Curated Skills

- [Anthropic: How the Claude Code team thinks about verification (2026-11-16)](https://claude.dev/blog/how-the-claude-code-team-thinks-about-verification/): running the change end to end matters more than tests; after three failed fix rounds the agent stops and brings in a person; a reliability checklist fires on diff triggers; a change must not modify the checks that judge it; flaky tests get a root cause, never retries or sleeps; rules are pruned on a routine.
- [Anthropic: How the Claude Code team does code review (2026-10-15)](https://claude.dev/blog/solving-code-review-at-anthropic/): review the evidence instead of every line; tag findings Important, Nit, or Pre-existing; cap review rounds, re-review only the new diff, flag the bug class, never repeat findings; people keep direction, risky code, and reading the evidence.
- [Anthropic: Building verification loops in Claude Code with skills (2026-07-22)](https://claude.com/resources/articles/building-verification-loops-in-claude-code-with-skills): turn repeated manual checks into verification skills that run standalone, embedded, chained, or on every PR.
- [Claude Code best practices (2026-11)](https://code.claude.com/docs/en/best-practices): give the agent a pass/fail check it can run; interview the user into a spec, then build it in a fresh session.
- [Claude Code permissions (2026-11)](https://code.claude.com/docs/en/permissions): ask rules match every subcommand and past leading variable assignments; bypass permissions mode skips prompts.
- [Matt Pocock: skills](https://github.com/mattpocock/skills): `diagnosing-bugs` (build a red-capable feedback loop first), `tdd` (no tautological tests), `writing-for-agents` (state the wanted behavior, cut no-ops, one source of truth), `retro` (mechanical mistakes become checks).
- [Jesse Vincent: Superpowers](https://github.com/obra/superpowers): `verification-before-completion` (no claim without a fresh run) and `receiving-code-review` (clarify unclear items before fixing any). Its always-on "Iron Law" style was not adopted: long, negative, and it would compete with the router.
- [Chris Banes: skills](https://github.com/chrisbanes/skills) and [Google: android/skills](https://github.com/android/skills): focused Kotlin, Compose, and Android domain skills, installed pinned. Their process skills (`to-plan`, `deliver-issue`, `shepherd`) were left out because they compete with this pack's gates.
- [Philipp Lackner: spec-driven development with OpenSpec](https://www.youtube.com/watch?v=9MImID9o8MQ), [reliable agent skills (2026-09-27)](https://www.youtube.com/watch?v=tJDubU8tpso), and [PR quizzes for AI code (2026-10)](https://www.youtube.com/watch?v=5sz5YywkMcE): keep context in specs, not sessions; build and test skills with skill-creator; quiz reviewers so they understand AI-written code. His public repos carry no agent rules, and his free skills need an email sign-up.
- [Vercel: AGENTS.md outperforms skills in our agent evals (2026-01-27)](https://vercel.com/blog/agents-md-outperforms-skills-in-our-agent-evals): an always-loaded docs index passed 100% of tasks against 79% for skills, and agents skipped the skill in 56% of runs. Supports keeping the router for process.
- [SkillsBench (arXiv 2602.12670, v4)](https://arxiv.org/abs/2602.12670): curated skills raise pass rates by 16.6 points on average; focused skills of at most three modules beat exhaustive bundles.
- [Antigravity customization discovery](https://antigravity.google/docs/customization-discovery/): Antigravity CLI replaced Gemini CLI on 2026-06-18; it still reads `~/.gemini/GEMINI.md`, and personal skills live in `~/.gemini/config/skills/`.

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
- Verification means running the change: plans for user-visible changes include an approved
  end-to-end run, and each profile names its Verify recipe (2026-11-22).
- Diagnosis starts with a feedback loop that fails on the bug; a fix shows its regression test
  failing before it passes (2026-11-22).
- Reviews check scope creep and loosened checks, apply only the profile risks a diff triggers, give
  each finding once, and suggest rethinking after three rounds (2026-11-22).
- Large work keeps its approved plan in a git-excluded `.agent-plans/` file, so a fresh session can
  continue (2026-11-22).
- The router stays for process. Skills are added only for focused domain knowledge, pinned, and
  rank as generic external guidance below the profile (2026-11-22).
- No Claude Code git ask rules: they prompted on every git command, and the text gates already
  cover commit, push, and discarding work in every mode, bypass included (2026-11-22).
