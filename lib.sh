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
