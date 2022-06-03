#!/usr/bin/env bash
set -euo pipefail

SDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SDIR"

mkdir -p ~/.config/wezterm/
ln -sf "$SDIR/wezterm.lua" ~/.config/wezterm/wezterm.lua
