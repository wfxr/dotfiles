#!/usr/bin/env bash
################################################################################
#    Author: Wenxuan                                                           #
#     Email: wenxuangm@gmail.com                                               #
#   Created: 2019-01-23 18:46                                                  #
################################################################################
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

ln -sf "$SCRIPT_DIR/mutt_theme" ~/.mutt_theme
ln -sf "$SCRIPT_DIR/mutt_binds" ~/.mutt_binds
ln -sf "$SCRIPT_DIR/muttrc.pvt" ~/.muttrc
