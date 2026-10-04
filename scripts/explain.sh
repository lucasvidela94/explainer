#!/usr/bin/env bash
# explain <target> --level text|diagram|html|video [--backend psychopomp|none] [--out out]
# Mecanica, no inteligencia: junta hechos y arma el scaffold. El agente escribe el contenido.
set -euo pipefail

TARGET="${1:-}"
LEVEL="text"
BACKEND="none"
OUT="out"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --level) LEVEL="${2:-text}"; shift 2 ;;
    --backend) BACKEND="${2:-none}"; shift 2 ;;
    --out) OUT="${2:-out}"; shift 2 ;;
    -h|--help) sed -n '2,12p' "$0"; exit 0 ;;
    *) TARGET="$1"; shift ;;
  esac
done

[[ -z "$TARGET" ]] && { echo "uso: explain <pr-url|archivo|tema> --level text|diagram|html|video [--backend psychopomp] [--out out]" >&2; exit 1; }
[[ "$LEVEL" =~ ^(text|diagram|html|video)$ ]] || { echo "nivel invalido: $LEVEL" >&2; exit 1; }

mkdir -p "$OUT"

# 1. hechos
{
  echo "# Facts: $TARGET"
  echo
  if [[ "$TARGET" =~ ^https?://|^[a-zA-Z0-9_.-]+/[a-zA-Z0-9_.-]+#[0-9]+$ ]]; then
    command -v gh >/dev/null || { echo "falta gh: https://cli.github.com/" >&2; exit 1; }
    echo "## PR diff"
    echo '```diff'
    gh pr diff "$TARGET" 2>/dev/null || echo "(gh pr diff fallo: pega el diff a mano)"
    echo '```'
  elif [[ -e "$TARGET" ]]; then
    echo "## Archivo"
    echo '```'
    head -200 "$TARGET"
    echo '```'
  else
    echo "## Tema"
    echo "$TARGET"
    echo
    echo "(sin fuente local: el agente verifica cada afirmacion antes de escribir)"
  fi
} > "$OUT/facts.md"

# 2. scaffold por nivel
case "$LEVEL" in
  text) touch "$OUT/explainer.md" ;;
  diagram) cat > "$OUT/diagram.mmd" <<'EOF'
flowchart LR
  A[hecho 1] --> B[hecho 2]
EOF
    ;;
  html) cat > "$OUT/index.html" <<'EOF'
<!doctype html><html lang="es"><meta charset="utf-8"><title>Explainer</title>
<body><h1>Explainer</h1><p>Hechos en facts.md. Contenido del agente aqui.</p></body></html>
EOF
    ;;
  video)
    if [[ "$BACKEND" == "psychopomp" ]]; then
      echo "backend psychopomp: instala skill psychopomp-reel y corre su bootstrap (PSYCHOPOMP_DIR)."
      if [[ -d "$HOME/.agents/skills/psychopomp-reel" ]] || { command -v npx >/dev/null && npx -y skills list 2>/dev/null | grep -qi psychopomp-reel; }; then
        echo "psychopomp-reel detectada."
      else
        echo "(psychopomp-reel no instalada: npx skills add <repo> -s psychopomp-reel)"
      fi
    else
      echo "video sin backend: elige uno con --backend psychopomp o entrega nivel html."
    fi
    ;;
esac

echo "OK: $OUT/facts.md + scaffold $LEVEL en $OUT/"
