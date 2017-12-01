#!/bin/bash

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

# fcitx - gnome
ln -sf $SCRIPT_DIR/xprofile ~/.xprofile

# funny programs
pacman -S cool-retro-term # cool-retro-term is a terminal emulator which mimics the look and feel of the old cathode tube screens.
