#!/usr/bin/env bash
################################################################################
#    Author: Wenxuan Zhang                                                     #
#     Email: wenxuangm@gmail.com                                               #
#   Created: 2019-12-18 11:06                                                  #
################################################################################

info() { printf "%b[info]%b %s\n" '\e[0;32m' '\e[0m' "$@" >&2; }

SDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SDIR" || exit 1

mkdir -p ~/.config
ln -sf "$SDIR/starship.toml" ~/.config/

hash starship &>/dev/null && info "starship already installed." && exit 0

mkdir -p ~/bin
curl -fsSL https://starship.rs/install.sh | bash -s -- -y -b ~/bin
