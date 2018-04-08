#!/usr/bin/env bash
#===============================================================================
#   Author: Wenxuan
#    Email: wenxuangm@gmail.com
#  Created: 2018-03-31 11:53
#===============================================================================
[ "$(whoami)" != "root" ] && exec sudo -- "$0" "$@"
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SCRIPT_DIR" || return 1

mkdir -p /etc/docker
ln -snf "$SCRIPT_DIR/daemon.json" /etc/docker/daemon.json
