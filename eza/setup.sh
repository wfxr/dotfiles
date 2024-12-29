#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

SDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SDIR" || return 1

mkdir -p ~/.config/eza

ln -sf "$SDIR/catppuccin.yml" ~/.config/eza/theme.yml
