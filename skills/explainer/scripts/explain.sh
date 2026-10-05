#!/usr/bin/env bash
# explain <target> --level text|diagram|html [--out dir|last]
# Mechanics, no intelligence: collect facts and scaffold. The agent writes the content.
set -euo pipefail

TARGET=""
LEVEL="text"
OUT=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --level) LEVEL="${2:-text}"; shift 2 ;;
    --out) OUT="${2:-}"; shift 2 ;;
    -h|--help) sed -n '2,12p' "$0"; exit 0 ;;
    *) TARGET="$1"; shift ;;
  esac
done

[[ -z "$TARGET" ]] && { echo "usage: explain <pr-url|file|topic> --level text|diagram|html [--out dir|last]" >&2; exit 1; }
[[ "$LEVEL" =~ ^(text|diagram|html)$ ]] || { echo "invalid level: $LEVEL" >&2; exit 1; }

# Base: system temp, no brand. Override with EXPLAINER_BASE.
# OpenCode users: export EXPLAINER_BASE=/tmp/opencode to skip the permission prompt.
if [[ -n "${EXPLAINER_BASE:-}" ]]; then
  BASE="$EXPLAINER_BASE"
elif [[ "${OSTYPE:-}" == msys* || "${OSTYPE:-}" == cygwin* ]] && [[ -n "${TEMP:-}" ]]; then
  BASE="$TEMP"
else
  BASE="${TMPDIR:-/tmp}"
fi
# Reuse last run: --out last resolves the explainer-last symlink.
if [[ "$OUT" == "last" ]]; then
  OUT="$(readlink -f "$BASE/explainer-last" 2>/dev/null || echo "")"
  [[ -z "$OUT" ]] && { echo "no previous run in $BASE/explainer-last" >&2; exit 1; }
fi
# Each run in a fresh directory: runs never overwrite each other and never dirty the repo.
if [[ -z "$OUT" ]]; then
  OUT="$BASE/explainer-$(date +%Y%m%d-%H%M%S)"
fi
mkdir -p "$OUT"
ln -sfn "$OUT" "$BASE/explainer-last"

# 1. facts
{
  echo "# Facts: $TARGET"
  echo
  if [[ "$TARGET" =~ ^https?://|^[a-zA-Z0-9_.-]+/[a-zA-Z0-9_.-]+#[0-9]+$ ]]; then
    command -v gh >/dev/null || { echo "missing gh: https://cli.github.com/" >&2; exit 1; }
    echo "## PR diff"
    echo '```diff'
    gh pr diff "$TARGET" 2>/dev/null || echo "(gh pr diff failed: paste the diff manually)"
    echo '```'
  elif [[ -d "$TARGET" ]]; then
    echo "## Directory"
    echo '```'
    ls -la "$TARGET" | head -50
    echo '```'
    if git -C "$TARGET" rev-parse --git-dir >/dev/null 2>&1; then
      echo
      echo "## Git (last commit + status)"
      echo '```'
      git -C "$TARGET" log --oneline -5
      echo "---"
      git -C "$TARGET" status --short --branch | head -30
      echo '```'
    fi
  elif [[ -e "$TARGET" ]]; then
    echo "## File"
    echo '```'
    head -200 "$TARGET"
    echo '```'
  else
    echo "## Topic"
    echo "$TARGET"
    echo
    echo "(no local source: the agent verifies every claim before writing)"
  fi
} > "$OUT/facts.md"

# 2. scaffold por nivel
case "$LEVEL" in
  text) touch "$OUT/explainer.md" ;;
  diagram) cat > "$OUT/diagram.mmd" <<'EOF'
flowchart LR
  A[fact 1] --> B[fact 2]
EOF
    ;;
  html) cat > "$OUT/index.html" <<'EOF'
<!doctype html><html lang="en"><meta charset="utf-8"><title>Explainer</title>
<script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
<body class="p-8"><h1 class="text-2xl font-bold">Explainer</h1><p>Facts in facts.md. Agent content here.</p></body></html>
EOF
    ;;
esac

echo "OK: $OUT/facts.md + scaffold $LEVEL in $OUT/"
