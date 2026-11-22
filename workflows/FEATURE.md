# Feature Workflow

Use for new user-visible behavior or a new capability. Apply together with planning,
implementation, and risk-based testing—not as a replacement for them.

## Contract

- Read the issue or other authoritative product specification when available. If the profile
  names a spec tool (for example OpenSpec), its change folder is the contract and the plan: propose
  the change there, implement from it, and archive it when done.
- Extract acceptance criteria, non-goals, affected users/platforms, compatibility constraints, and
  measurable completion evidence.
- If requirements are unavailable and cannot be established from the explicit request or another
  authoritative source, stop before implementation and build the contract with the user: ask one
  decision at a time, the next material one, with your recommended answer, then confirm a short
  summary of the goal, acceptance criteria, and non-goals.

## State and Interaction Matrix

Cover every relevant path, not every path mechanically:

- initial/loading and success;
- empty and partial data;
- recoverable/non-recoverable error and retry;
- cancellation, navigation/lifecycle restoration, and repeated actions;
- offline/slow network, permissions, and accessibility when applicable.

## Delivery

- Prefer a thin vertical slice that connects real state/data behavior to a usable surface.
- Reuse established contracts/components before adding abstractions.
- Add previews or another fast visual inspection path for meaningful UI states when supported.
- Keep rollout, analytics, migration, backward compatibility, and failure behavior explicit when
  the feature affects them.

Verification must map to acceptance criteria and include meaningful failure/boundary coverage.
