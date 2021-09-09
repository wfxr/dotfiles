#!/usr/bin/env bash
############################################################################
#    Author: Wenxuan Zhang                                                 #
#     Email: wenxuangm@gmail.com                                           #
#   Created: 2020-01-20 17:36                                              #
############################################################################
set -euo pipefail

SDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SDIR" || return 1

TDIR=~/.config/ranger
mkdir -p "$TDIR"
ln -sf "$SDIR/rc.conf"          "$TDIR"
ln -sf "$SDIR/scope.sh"         "$TDIR"
ln -sf "$SDIR/rifle.conf"       "$TDIR"
ln -sf "$SDIR/commands.py"      "$TDIR"
ln -sf "$SDIR/commands_full.py" "$TDIR"

PDIR="$TDIR/plugins"
mkdir -p "$PDIR"
if ! [ -d "$PDIR/ranger_devicons" ]; then
    git clone --depth=1 https://github.com/alexanderjeurissen/ranger_devicons "$PDIR/ranger_devicons"
    (cd "$PDIR/ranger_devicons" && make install)
fi
