#!/usr/bin/env bash
#===============================================================================
#   Author: Wenxuan
#    Email: wenxuangm@gmail.com
#  Created: 2018-03-01 16:49
#===============================================================================

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

curl https://raw.githubusercontent.com/altercation/mutt-colors-solarized/master/mutt-colors-solarized-light-256.muttrc > ~/.mutt_theme
cp "$SCRIPT_DIR/muttrc" ~/.muttrc
ln -sf "$SCRIPT_DIR/mutt_binds" ~/.mutt_binds
