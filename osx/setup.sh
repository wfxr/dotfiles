#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

SDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SDIR" || exit 1

mkdir -p "$HOME/.config/karabiner"
ln -sf "$SDIR/karabiner.json" "$HOME/.config/karabiner/karabiner.json"

# disable mouse acceleration
defaults write .GlobalPreferences com.apple.mouse.scaling -1
