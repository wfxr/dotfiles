#!/bin/bash

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

# fcitx - gnome
ln -sf $SCRIPT_DIR/xprofile ~/.xprofile
