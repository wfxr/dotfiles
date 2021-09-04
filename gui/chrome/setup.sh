#!/usr/bin/env bash
################################################################################
#    Author: Wenxuan                                                           #
#     Email: wenxuangm@gmail.com                                               #
#   Created: 2018-06-08 12:46                                                  #
################################################################################

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SCRIPT_DIR" || exit 1

mkdir -p ~/.config

echo '--force-device-scale-factor=1.5' > ~/.config/chrome-flags.conf

ln -sf "$SCRIPT_DIR/surfingkeys" ~/.surfingkeys
