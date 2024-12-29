#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

SDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SDIR"

cfgdir="$(bat --config-dir)"

mkdir -p "$cfgdir"
ln -sf "$SDIR/config" "$cfgdir/config"

# Themes
mkdir -p "$cfgdir/themes"
cd "$cfgdir/themes"

theme="Catppuccin Frappe"
file="Catppuccin Frappe.tmTheme"
test -f "$file" ||
    wget "https://github.com/catppuccin/bat/raw/main/themes/$theme.tmTheme"

bat cache --build
