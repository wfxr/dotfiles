#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" && cd "$SCRIPT_DIR" || return 1

# https://askubuntu.com/a/694670
function dconf-reload() {
    [[ -f "$2" ]] || return 1
    dconf reset -f "$1"
    dconf load "$1" < "$2"
}

dconf-reload /org/gnome/terminal/        terminal.dconf
dconf-reload /org/gnome/settings-daemon/ settings-deamon.dconf
dconf-reload /org/gnome/mutter/          mutter.dconf
dconf-reload /org/gnome/desktop/wm/      desktop-wm.dconf

# Show theme profile with uuid
#dconf dump /org/gnome/terminal/legacy/profiles:/ | grep -e "\[\:\|visible-name"
