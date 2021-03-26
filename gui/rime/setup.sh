#!/usr/bin/env bash
################################################################################
#    Author: Wenxuan Zhang                                                     #
#     Email: wenxuangm@gmail.com                                               #
#   Created: 2019-12-06 16:01                                                  #
################################################################################
set -euo pipefail
IFS=$'\n\t'

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SCRIPT_DIR" || exit 1

mkdir -p ~/.config/fcitx/ && cd ~/.config/fcitx

rm -rf rime
git clone --depth=1 https://github.com/wfxr/rime

rime/setup.sh
