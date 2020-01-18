#!/usr/bin/env bash
################################################################################
#    Author: Wenxuan Zhang                                                     #
#     Email: wenxuangm@gmail.com                                               #
#   Created: 2019-12-01 10:33                                                  #
################################################################################
set -euo pipefail
IFS=$'\n\t'

SDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SDIR" || return 1
TDIR="$HOME/.config/variety"

mkdir -p "$TDIR"

ln -sf "$SDIR/variety.conf"          "$TDIR/variety.conf"
ln -sf "$SDIR/scripts/set_wallpaper" "$TDIR/scripts"
