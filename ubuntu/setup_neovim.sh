#!/usr/bin/env bash

[ "$(whoami)" != "root" ] && exec sudo -- "$0" "$@"
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

apt update && apt -y install software-properties-common
add-apt-repository -y ppa:neovim-ppa/unstable
apt update && apt -y install neovim
hash gem  &>/dev/null && gem  install neovim
hash pip2 &>/dev/null && pip2 install --upgrade neovim
hash pip3 &>/dev/null && pip3 install --upgrade neovim
