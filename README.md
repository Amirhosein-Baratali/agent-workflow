# agent-workflow

One rule pack for every AI coding agent and every project. You keep it in one folder, every tool
reads it from there, and when you improve a rule, every project gets the change at once.

It is built around three goals:

1. **Human control.** The agent explains every change and waits for your yes. It never commits
   until you have reviewed the result and asked for a commit.
2. **Small, verified steps.** Plans scale with risk. Large work goes one tested slice at a time.
3. **Low token cost.** Only a short controller is always loaded. Detailed workflows load just in
   time, for the phase you are in.

## How it works

```text
~/.claude/CLAUDE.md ──imports──▶ ~/agent-workflow/AGENTS.md   (always loaded, ~140 lines)
~/.codex/AGENTS.md  ──symlink──▶        │
~/.gemini/GEMINI.md ──imports──▶        │ routes each request to one workflow
                                        ▼
                         ~/agent-workflow/workflows/PLANNING.md, REVIEW.md, ...
                                        │ for repository work
                                        ▼
            <project>/.agent-profile.md ──symlink──▶ ~/agent-workflow/profiles/<project>.md
```

An implementation request loads rules in phases:

```text
PLANNING -> FEATURE | FIX | REFACTOR -> SMALL_CHANGE | LARGE_CHANGE
         -> (your approval) -> IMPLEMENTATION -> TESTING -> (your review) -> COMMIT on request
```

A review loads only `REVIEW.md`. A simple question loads nothing extra.

## Quick start

On a new computer:

```bash
git clone https://github.com/<github-user>/agent-workflow.git ~/agent-workflow
~/agent-workflow/install.sh
```

Then link each project checkout to its profile, once per checkout:

```bash
~/agent-workflow/link-project.sh my-app ~/code/my-app
```

If the profile does not exist yet, the script creates it from the template. Fill it in, or ask
your agent to draft it from the repository and review the result.

Moving to another computer by copying the folder works too, and brings your private profiles
along. Run `install.sh` once there, then `link-project.sh` in each checkout.

## What `install.sh` does

It is safe to re-run. It changes only its own marked block in each file and keeps everything else.

| Tool | Setup | Status |
|---|---|---|
| Claude Code | Adds `@~/agent-workflow/AGENTS.md` to `~/.claude/CLAUDE.md`, and adds the folder to `permissions.additionalDirectories` in `~/.claude/settings.json`, so Claude reads and edits the rules without permission prompts | Used daily |
| Codex | Symlinks `~/.codex/AGENTS.md` to the controller, if `~/.codex` exists | Set up, not tested yet |
| Gemini CLI / Antigravity | Adds the same import to `~/.gemini/GEMINI.md`, if `~/.gemini` exists | Set up, not tested yet |
| Cursor | Not automatic. Add a User Rule: `Read ~/agent-workflow/AGENTS.md first and follow it.` | Manual |
| Anything else | Paste [BOOTSTRAP_PROMPT.md](BOOTSTRAP_PROMPT.md) at the start of a session | Manual |

If the repository lives somewhere other than `~/agent-workflow`, `install.sh` creates that path as
a symlink, because every rule file refers to it.

## What's inside

```text
AGENTS.md              controller: standards, response style, router, approval gates
workflows/             one file per phase, loaded only when needed
  PLANNING.md  IMPLEMENTATION.md  REVIEW.md  REVIEW_RESPONSE.md  DIAGNOSIS.md
  TESTING.md  COMMIT.md  RESEARCH.md  LEARNING.md
  FEATURE.md  FIX.md  REFACTOR.md  SMALL_CHANGE.md  LARGE_CHANGE.md
templates/PROJECT_PROFILE.md
profiles/              your private project profiles (git-ignored, never pushed)
install.sh  link-project.sh  lib.sh
SOURCES.md             research behind the rules
BOOTSTRAP_PROMPT.md
```

## The learning loop

At the end of a task where you corrected the agent, a rule failed, or it found a durable
non-obvious fact, the agent proposes up to three one-line rule edits ([LEARNING.md](workflows/LEARNING.md)).
It applies them only after your yes, and never commits them for you.

Each learning goes to one place: your preferences to `AGENTS.md`, a phase procedure to its
workflow, a project fact to that project's profile. Task progress stays in the tool's own memory.
Hard size limits keep the pack small: `AGENTS.md` ≤ 150 lines, each workflow ≤ 80, each profile
≤ 250. A new rule must replace or merge a weaker one once a file is full.

## Privacy

Project profiles often hold internal details: architecture, security setup, CI. `profiles/` is
git-ignored except its README, so pushing this repository never publishes them. Back them up
separately if you need to, for example in a private repository.

## Updating

Edit the files in `~/agent-workflow/`. Every new session in every project picks up the change.
On other computers, run `git pull`.

When you change a rule, ask "would removing this line cause a mistake?" If not, delete the line.
Research shows that long or generic context files raise cost and can lower success
([SOURCES.md](SOURCES.md)).

## Uninstall

Delete the `agent-workflow` block from `~/.claude/CLAUDE.md` and `~/.gemini/GEMINI.md`, remove the
folder from `additionalDirectories` in `~/.claude/settings.json`, delete the `~/.codex/AGENTS.md`
symlink, and delete each project's `.agent-profile.md` link.

## License

[MIT](LICENSE)
