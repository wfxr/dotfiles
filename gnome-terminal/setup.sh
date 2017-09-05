#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $SCRIPT_DIR

# https://askubuntu.com/a/694670
dconf reset -f /org/gnome/terminal/
dconf load /org/gnome/terminal/ < terminal.dconf

# Show theme profile with uuid
#dconf dump /org/gnome/terminal/legacy/profiles:/ | grep -e "\[\:\|visible-name"
