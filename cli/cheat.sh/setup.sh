#!/usr/bin/env bash
################################################################################
#    Author: Wenxuan Zhang                                                     #
#     Email: wenxuangm@gmail.com                                               #
#   Created: 2019-12-31 14:28                                                  #
################################################################################
set -euo pipefail
IFS=$'\n\t'

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SCRIPT_DIR" || return 1

bin_file=~/bin/cht.sh
comp_file=~/.zsh_completions/_cht

# cheat sheet: https://github.com/chubin/cheat.sh
[ -f $bin_file  ] || curl -sSL https://cht.sh/:cht.sh >$bin_file && chmod +x $bin_file
[ -f $comp_file ] || curl -sSL https://cht.sh/:zsh    >$comp_file
