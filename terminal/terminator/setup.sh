#!/usr/bin/env bash
################################################################################
#    Author: Wenxuan Zhang                                                     #
#     Email: wenxuangm@gmail.com                                               #
#   Created: 2019-12-01 10:33                                                  #
################################################################################
set -euo pipefail
IFS=$'\n\t'

SDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SDIR" || return 1
TDIR=~/.config/terminator

mkdir -p "$TDIR"
ln -sf "$SDIR/config" "$TDIR"

# Optional: theme plugins
# https://github.com/EliverLara/terminator-themes
