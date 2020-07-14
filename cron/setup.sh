#!/usr/bin/env bash
############################################################################
#    Author: Wenxuan Zhang                                                 #
#     Email: wenxuangm@gmail.com                                           #
#   Created: 2020-07-14 16:03                                              #
############################################################################
set -euo pipefail
IFS=$'\n\t'

SDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SDIR" || exit 1

trap 'command rm -rf $TEMP' EXIT INT TERM HUP
TEMP="$(mktemp -td --suffix=.tmp "$(basename "$0")".XXXXXX)"

cat <<-EOF | sort -u | crontab -
$(crontab -l)
$(<./crontab)
EOF
