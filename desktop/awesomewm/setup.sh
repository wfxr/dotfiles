#!/usr/bin/env bash
################################################################################
#    Author: Wenxuan Zhang                                                     #
#     Email: wenxuangm@gmail.com                                               #
#   Created: 2019-12-01 10:33                                                  #
################################################################################
set -euo pipefail
IFS=$'\n\t'

SDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SDIR" || return 1

TDIR=$HOME/.config/awesome
mkdir -p "$TDIR"

ln -sf "$SDIR/rc.lua"    "$TDIR"
ln -sf "$SDIR/theme.lua" "$TDIR"

if ! [ -d "$SDIR/themes" ]; then
    trap 'command rm -rf $TEMP' EXIT INT TERM HUP
    TEMP="$(mktemp -td --suffix=.tmp "$(basename "$0")".XXXXXX)"
    git clone --depth=1 --recursive https://github.com/lcpz/awesome-copycats.git "$TEMP/awesome-copycats"
    mv -bv "$TEMP"/awesome-copycats/* "$TDIR"
fi
