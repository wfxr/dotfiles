#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

SDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SDIR" || return 1

info() { printf "%b[info]%b %s\n" '\e[0;32m\033[1m' '\e[0m' "$*" >&2; }
warn() { printf "%b[warn]%b %s\n" '\e[0;33m\033[1m' '\e[0m' "$*" >&2; }
erro() { printf "%b[erro]%b %s\n" '\e[0;31m\033[1m' '\e[0m' "$*" >&2; }

mkdir -p ~/.config

for cfg in hypr fuzzel waybar; do
    rm -rf "$HOME/.config/$cfg"
    ln -sf "$SDIR/$cfg" ~/.config/
done

ln -sf "$SDIR/chrome-flags.conf"   ~/.config/
ln -sf "$SDIR/chromium-flags.conf" ~/.config/

