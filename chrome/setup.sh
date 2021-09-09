#!/usr/bin/env bash
################################################################################
#    Author: Wenxuan                                                           #
#     Email: wenxuangm@gmail.com                                               #
#   Created: 2018-06-08 12:46                                                  #
################################################################################

SDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SDIR" || exit 1

mkdir -p ~/.config

[ -f ~/.config/chrome-flags.conf ] || echo '--force-device-scale-factor=1' > ~/.config/chrome-flags.conf

ln -sf "$SDIR/surfingkeys" ~/.surfingkeys
