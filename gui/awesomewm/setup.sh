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

if ! [ -d "$SDIR/lain" ]; then
    git clone --depth=1 https://github.com/lcpz/lain "$TDIR/lain"
fi

if ! [ -d "$SDIR/freedesktop" ]; then
    git clone --depth=1 https://github.com/lcpz/awesome-freedesktop.git "$TDIR/freedesktop"
fi

if ! [ -d "$SDIR/themes" ]; then
    git clone --depth=1 https://github.com/wfxr/awm-themes "$TDIR/themes"
fi
