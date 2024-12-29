#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

SDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SDIR" || return 1

info() { printf "%b[info]%b %s\n" '\e[0;32m\033[1m' '\e[0m' "$*" >&2; }
warn() { printf "%b[warn]%b %s\n" '\e[0;33m\033[1m' '\e[0m' "$*" >&2; }
erro() { printf "%b[erro]%b %s\n" '\e[0;31m\033[1m' '\e[0m' "$*" >&2; }

mkdir -p ~/.config/yazi

ln -sf "$SDIR/yazi.toml"   ~/.config/yazi/
ln -sf "$SDIR/keymap.toml" ~/.config/yazi/
ln -sf "$SDIR/theme.toml"  ~/.config/yazi/
ln -sf "$SDIR/init.lua"    ~/.config/yazi/

instal_plugin_if_not_exists() {
    ya pack --list | grep -q "$1" || ya pack -a "$1"
}

# instal_plugin_if_not_exists Chromium-3-Oxide/everforest-medium
instal_plugin_if_not_exists yazi-rs/flavors:catppuccin-frappe
instal_plugin_if_not_exists yazi-rs/plugins:git
instal_plugin_if_not_exists yazi-rs/plugins:smart-enter
instal_plugin_if_not_exists yazi-rs/plugins:full-border
instal_plugin_if_not_exists yazi-rs/plugins:max-preview
# instal_plugin_if_not_exists yazi-rs/plugins:smart-filter
