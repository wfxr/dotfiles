#!/usr/bin/env bash
############################################################################
#    Author: Wenxuan Zhang                                                 #
#     Email: wenxuangm@gmail.com                                           #
#   Created: 2021-03-31 15:50                                              #
############################################################################
set -euo pipefail
IFS=$'\n\t'

SDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SDIR" || return 1

rm -rf ~/.config/kitty

mkdir -p ~/.config/kitty

ln -sf "$SDIR/kitty.conf" ~/.config/kitty

kitty +kitten themes --reload-in=all 'Catppuccin-Frappe'
