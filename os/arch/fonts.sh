#!/usr/bin/env bash
[ "$(whoami)" != "root" ] && exec sudo -- "$0" "$@"

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SCRIPT_DIR" || exit 1

paru --noconfirm -S noto-fonts noto-fonts-cjk noto-fonts-emoji
paru --noconfirm -S nerd-fonts-complete
paru --noconfirm -S ttf-meslo
paru --noconfirm -S ttf-iosevka-term
paru --noconfirm -S ttf-sarasa-gothic
