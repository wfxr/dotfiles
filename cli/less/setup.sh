#!/usr/bin/env bash
############################################################################
#    Author: Wenxuan Zhang                                                 #
#     Email: wenxuangm@gmail.com                                           #
#   Created: 2020-10-13 19:29                                              #
############################################################################
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SCRIPT_DIR" || exit 1

ln -sf "$SCRIPT_DIR/lesskey" ~/.lesskey

lesskey
