#!/usr/bin/env bash
################################################################################
#    Author: Wenxuan Zhang                                                     #
#     Email: wenxuangm@gmail.com                                               #
#   Created: 2019-12-01 10:33                                                  #
################################################################################
set -euo pipefail
IFS=$'\n\t'

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SCRIPT_DIR" || return 1

TARGET_DIR=$HOME/.config/i3
mkdir -p "$TARGET_DIR"

ln -sf "$SCRIPT_DIR/autostart"        "$TARGET_DIR/autostart"
ln -sf "$SCRIPT_DIR/autostart_always" "$TARGET_DIR/autostart_always"
ln -sf "$SCRIPT_DIR/config"           "$TARGET_DIR/config"

ln -sf "$SCRIPT_DIR/xinitrc" "$HOME/.xinitrc"
