#!/usr/bin/env bash
[ "$(whoami)" != "root" ] && exec sudo -- "$0" "$@"

add-apt-repository -y ppa:neovim-ppa/stable
apt -y install neovim
