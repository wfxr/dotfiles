#!/usr/bin/env bash
[ "$(whoami)" != "root" ] && exec sudo -- "$0" "$@"

# Install add-apt-repository if not installed
hash add-apt-repository &>/dev/null || apt update && apt -y install software-properties-common

# Install ppa & neovim
add-apt-repository -y ppa:neovim-ppa/unstable
apt update && apt -y install neovim

# Add gem & python support for neovim
hash gem  &>/dev/null && gem  install neovim
hash pip2 &>/dev/null && pip2 install --upgrade neovim
hash pip3 &>/dev/null && pip3 install --upgrade neovim
