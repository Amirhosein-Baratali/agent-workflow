#!/usr/bin/env bash
# Links a project checkout to its private profile in ~/agent-workflow/profiles/. Safe to re-run.
# Usage: link-project.sh <profile-name> [project-dir]   (project-dir defaults to the current one)
set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

if [ $# -lt 1 ]; then
  echo "Usage: $0 <profile-name> [project-dir]" >&2
  exit 1
fi
NAME="$1"
PROJECT="$(cd "${2:-.}" && pwd -P)"
PROFILE="$AW_REPO/profiles/$NAME.md"

if [ ! -f "$PROFILE" ]; then
  sed "s/<Name>/$NAME/" "$AW_REPO/templates/PROJECT_PROFILE.md" > "$PROFILE"
  echo "Created $PROFILE from the template. Fill it in, or ask your agent to."
fi

ln -sfn "$AW_HOME/profiles/$NAME.md" "$PROJECT/.agent-profile.md"
echo "Linked $PROJECT/.agent-profile.md -> profiles/$NAME.md"

if git -C "$PROJECT" rev-parse --git-dir >/dev/null 2>&1; then
  EXCLUDE="$(git -C "$PROJECT" rev-parse --path-format=absolute --git-common-dir)/info/exclude"
  write_block "$EXCLUDE" "# >>> agent-workflow >>>" "# <<< agent-workflow <<<" "/.agent-profile.md"
  echo "Git: $EXCLUDE ignores the link"
fi

for old in AGENTS.md CLAUDE.md GEMINI.md agent-workflow; do
  if [ -e "$PROJECT/$old" ] && ! git -C "$PROJECT" ls-files --error-unmatch "$old" >/dev/null 2>&1; then
    echo "Note: untracked $old may be an old copy of the rules. Remove it so only the shared rules load."
  fi
done
