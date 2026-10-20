# Feature Workflow

Use for new user-visible behavior or a new capability. Apply together with planning,
implementation, and risk-based testing—not as a replacement for them.

## Contract

- Read the issue or other authoritative product specification when available.
- Extract acceptance criteria, non-goals, affected users/platforms, compatibility constraints, and
  measurable completion evidence.
- If requirements are unavailable and cannot be established from the explicit request or another
  authoritative source, stop before implementation and request the missing contract.

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
