#!/usr/bin/env bash
[ "$(whoami)" != "root" ] && exec sudo -- "$0" "$@"

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SCRIPT_DIR" || exit 1

pacman --noconfirm -S noto-fonts noto-fonts-cjk noto-fonts-emoji
pacman --noconfirm -S nerd-fonts-complete
yay -S ttf-meslo
