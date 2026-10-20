# Bootstrap Prompt for Any Coding Agent

Paste this only when an agent does not read its global instructions automatically:

> Read `~/agent-workflow/AGENTS.md` as the central controller. First classify my request and load
> only the workflow file routed for the current phase. For repository work, read the project
> profile (`.agent-profile.md` at the repository root) and only its relevant sections. Do not
> preload all workflow files or all project documentation. Before any edit, explain the change
> simply and wait for my approval. Large or high-risk work also needs options for me to choose,
> then a verified first vertical slice and another confirmation before the remaining slices. Never
> stage or commit until I have reviewed the completed work and send a fresh explicit commit
> approval. Preserve existing developer changes and report exact verification evidence.

For a first-run check, ask:

> Without changing files, tell me which controller, workflow, and project-profile files you would
> load for: (1) a code review, (2) a small bug fix, and (3) a large cross-module feature.
