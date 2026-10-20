# Large or High-Risk Change Workflow

Use when work is cross-module, architectural, unclear, touches public contracts/persistence, affects
auth/security/payments/privacy/concurrency, spans many files, or risks expensive rework.

## Before Editing

- Produce an evidence-backed plan covering scope/non-goals, contracts, dependencies, data/state
  flow, compatibility/migration, failure/rollback strategy, and verification.
- When more than one realistic approach exists, present the options with short trade-offs and a
  recommendation. The user decides; do not pick silently.
- Identify other unresolved product/architecture decisions and obtain answers.
- Divide work into small coherent vertical slices; each slice must be reviewable and verifiable.
- Select the first slice that proves the architecture or highest-risk assumption with the least
  throwaway work.
- Wait for explicit plan approval.

## First-Slice Gate

After approval, implement only the selected first slice. Keep the repository usable when feasible,
run its focused checks, then explain simply what changed, what it proves, the remaining slices,
and any revised risk. Stop for confirmation.

Continue remaining slices only after confirmation. Re-plan when evidence changes scope, design,
compatibility, or risk. Approval of the overall plan does not waive the first-slice checkpoint.

Before final handoff, run the wider gates justified by the completed cross-cutting risk and provide
a migration/rollback note where relevant.
