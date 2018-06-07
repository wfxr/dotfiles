#!/usr/bin/env bash

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SCRIPT_DIR" || exit 1

dconf dump /org/gnome/terminal/        > terminal.dconf
dconf dump /org/gnome/settings-daemon/ > settings-deamon.dconf
dconf dump /org/gnome/mutter/          > mutter.dconf
dconf dump /org/gnome/desktop/wm/      > desktop-wm.dconf
