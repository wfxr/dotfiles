#!/usr/bin/env bash
################################################################################
#    Author: Wenxuan Zhang                                                     #
#     Email: wenxuangm@gmail.com                                               #
#   Created: 2019-12-18 11:06                                                  #
################################################################################

loginfo()  { printf "%b[info]%b %s\n"  '\e[0;32m\033[1m' '\e[0m' "$@" >&2; }

SDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SDIR" || exit 1

mkdir -p ~/.config
ln -sf "$SDIR/starship.toml" ~/.config/
