#!/usr/bin/env bash
# Sets up agent-workflow for the AI tools on this computer. Safe to re-run.
set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

# 1. Stable path: every rule file refers to ~/agent-workflow.
if [ "$(cd "$AW_HOME" 2>/dev/null && pwd -P)" != "$AW_REPO" ]; then
  if [ -e "$AW_HOME" ] || [ -L "$AW_HOME" ]; then
    echo "Error: $AW_HOME exists but is not this folder ($AW_REPO). Move one of them." >&2
    exit 1
  fi
  ln -s "$AW_REPO" "$AW_HOME"
  echo "Linked $AW_HOME -> $AW_REPO"
fi

# 2. Claude Code: load the controller in every project, and let Claude read and edit the rules
#    folder without permission prompts.
write_block "$HOME/.claude/CLAUDE.md" \
  "<!-- >>> agent-workflow >>> -->" "<!-- <<< agent-workflow <<< -->" \
  "@~/agent-workflow/AGENTS.md"
echo "Claude Code: ~/.claude/CLAUDE.md imports the controller"

SETTINGS="$HOME/.claude/settings.json"
if command -v python3 >/dev/null 2>&1; then
  [ -f "$SETTINGS" ] && cp "$SETTINGS" "$SETTINGS.bak"
  python3 - "$SETTINGS" "$AW_REPO" "$AW_HOME" <<'PY'
import json, os, sys
path, *dirs = sys.argv[1:]
data = {}
if os.path.exists(path) and os.path.getsize(path):
    with open(path) as f:
        data = json.load(f)
allowed = data.setdefault("permissions", {}).setdefault("additionalDirectories", [])
for d in dict.fromkeys(dirs):
    if d not in allowed:
        allowed.append(d)
with open(path, "w") as f:
    json.dump(data, f, indent=2)
    f.write("\n")
PY
  echo "Claude Code: $SETTINGS allows $AW_REPO (backup: settings.json.bak)"
else
  echo "python3 not found. Add this to $SETTINGS by hand:"
  echo "  {\"permissions\": {\"additionalDirectories\": [\"$AW_REPO\"]}}"
fi

# 3. Codex: global instructions file. Codex has no imports, so use a symlink.
if [ -d "$HOME/.codex" ]; then
  CODEX="$HOME/.codex/AGENTS.md"
  if { [ ! -e "$CODEX" ] && [ ! -L "$CODEX" ]; } || [ "$(readlink "$CODEX")" = "$AW_HOME/AGENTS.md" ]; then
    ln -sfn "$AW_HOME/AGENTS.md" "$CODEX"
    echo "Codex: ~/.codex/AGENTS.md links to the controller"
  else
    echo "Codex: ~/.codex/AGENTS.md already has your own content; add the controller to it by hand"
  fi
fi

# 4. Gemini CLI and Antigravity: global GEMINI.md supports @imports. A block, not a symlink,
#    because Antigravity writes its own global rules into this file.
if [ -d "$HOME/.gemini" ]; then
  write_block "$HOME/.gemini/GEMINI.md" \
    "<!-- >>> agent-workflow >>> -->" "<!-- <<< agent-workflow <<< -->" \
    "@~/agent-workflow/AGENTS.md"
  echo "Gemini/Antigravity: ~/.gemini/GEMINI.md imports the controller"
fi

echo
echo "Done. Link each project to its profile once per checkout:"
echo "  ~/agent-workflow/link-project.sh <profile-name> [project-dir]"
