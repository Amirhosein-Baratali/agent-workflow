# Shared helpers for install.sh and link-project.sh. Sourced, not run.

AW_REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
AW_HOME="$HOME/agent-workflow"

# write_block FILE START END BODY
# Replaces the block between the START and END marker lines in FILE, or appends it.
# Everything outside the block is kept, so re-running is safe.
write_block() {
  local file="$1" start="$2" end="$3" body="$4" tmp
  mkdir -p "$(dirname "$file")"
  touch "$file"
  tmp="$(mktemp)"
  awk -v s="$start" -v e="$end" '
    $0 == s { skip = 1; next }
    $0 == e { skip = 0; next }
    skip { next }
    { lines[++n] = $0 }
    END { while (n > 0 && lines[n] == "") n--; for (i = 1; i <= n; i++) print lines[i] }
  ' "$file" > "$tmp"
  {
    cat "$tmp"
    if [ -s "$tmp" ]; then echo; fi
    printf '%s\n%s\n%s\n' "$start" "$body" "$end"
  } > "$file"
  rm -f "$tmp"
}

# Focused domain skills. They rank as generic external guidance, below the profile (AGENTS.md).
AW_ANDROID_SKILLS="android-cli android-intent-security android-permissions-security"
AW_CB_SHA="5f0a6226806799ecb93c87dd3c8c09acd00bfc1d"
AW_CB_SKILLS="kotlin-concurrency-and-flow kotlin-api-design compose-state-and-effects
  compose-performance compose-ui-testing-patterns"

# install_skills
# Google's Android skills come from the Android CLI, which installs them for every detected agent.
# Chris Banes' skills come from one pinned commit: only the chosen folders are copied to vendor/
# and linked into the Claude Code, Codex (~/.agents), and Antigravity skill folders. A skill folder
# or link the user owns is never replaced.
install_skills() {
  local skill pair target link tmp dir="$AW_HOME/vendor/chrisbanes-skills-$AW_CB_SHA"
  if command -v android >/dev/null 2>&1; then
    for skill in $AW_ANDROID_SKILLS; do
      if android skills add "$skill" </dev/null >/dev/null 2>&1; then
        echo "Skills: $skill (Android CLI)"
      else
        echo "Skills: the Android CLI could not add $skill; try: android skills add $skill" >&2
      fi
    done
  else
    echo "Skills: Android CLI not found; skipped Google's Android skills"
  fi

  if [ ! -d "$dir" ]; then
    tmp="$(mktemp -d)"
    mkdir -p "$tmp/src" "$tmp/out/skills"
    # One chain: any failed step skips the install instead of aborting install.sh.
    if ! { curl -fsSL "https://codeload.github.com/chrisbanes/skills/tar.gz/$AW_CB_SHA" \
          | tar -xz -C "$tmp/src" --strip-components=1 \
        && cp "$tmp/src/LICENSE" "$tmp/out/" \
        && (cd "$tmp/src/skills" && cp -R $AW_CB_SKILLS "$tmp/out/skills/") \
        && mkdir -p "$(dirname "$dir")" && mv "$tmp/out" "$dir"; }; then
      echo "Skills: could not fetch chrisbanes/skills@$AW_CB_SHA; skipped" >&2
    fi
    rm -rf "$tmp"
  fi
  [ -d "$dir" ] || return 0

  # "tool folder:skills folder" under $HOME, linked only when the tool is installed.
  # Codex reads user skills from ~/.agents/skills.
  for pair in .claude:.claude/skills .codex:.agents/skills .gemini:.gemini/config/skills; do
    [ -d "$HOME/${pair%%:*}" ] || continue
    target="$HOME/${pair#*:}"
    mkdir -p "$target"
    for skill in $AW_CB_SKILLS; do
      link="$target/$skill"
      if [ -L "$link" ]; then
        case "$(readlink "$link")" in
          "$AW_HOME/vendor/chrisbanes-skills-"*) ;;
          *) echo "Skills: $link links elsewhere; left it"; continue ;;
        esac
      elif [ -e "$link" ]; then
        echo "Skills: $link already exists; left it"
        continue
      fi
      ln -sfn "$dir/skills/$skill" "$link"
    done
    echo "Skills: Chris Banes' Kotlin/Compose skills linked in $target"
  done
}
