#!/usr/bin/env bash
# Bootstrap agnostico del motor Psychopomp. No asume ~/Code/psychopomp.
set -euo pipefail

# cargo suele vivir fuera del PATH no-interactivo
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
export PATH="$HOME/.cargo/bin:$HOME/.local/bin:$PATH"

DEFAULT_DIR="${PSYCHOPOMP_DIR:-$HOME/.cache/psychopomp}"
DIR="${1:-}"
if [[ "${1:-}" == "--dir" ]]; then DIR="${2:-$DEFAULT_DIR}"; fi
if [[ -z "$DIR" ]]; then DIR="$DEFAULT_DIR"; fi

need() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "falta $1. Instalalo y reintenta:" >&2
    case "$1" in
      cargo) echo "  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y" >&2 ;;
      ffmpeg) echo "  Arch: sudo pacman -S ffmpeg | Ubuntu: sudo apt install ffmpeg" >&2 ;;
      gh) echo "  https://cli.github.com/  (gh auth login)" >&2 ;;
      bun) echo "  curl -fsSL https://bun.sh/install | bash  # solo para narracion/sheets" >&2 ;;
    esac
    exit 1
  fi
}

need cargo
need ffmpeg
need gh

if [[ ! -d "$DIR/.git" ]]; then
  echo "clonando psychopomp en $DIR ..."
  mkdir -p "$(dirname "$DIR")"
  git clone https://github.com/kitlangton/psychopomp "$DIR"
else
  echo "actualizando $DIR ..."
  git -C "$DIR" pull --ff-only || true
fi

if [[ ! -x "$DIR/target/release/psychopomp" ]]; then
  echo "compilando release (tarda ~1-2 min la primera vez) ..."
  (cd "$DIR" && cargo build --release --bin psychopomp)
fi

"$DIR/target/release/psychopomp" plan schema >/dev/null
echo "PSYCHOPOMP_DIR=$DIR"
echo "OK: psychopomp $(git -C "$DIR" rev-parse --short HEAD 2>/dev/null)"
