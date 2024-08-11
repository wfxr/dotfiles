#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

SDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SDIR" || return 1

info() { printf "%b[info]%b %s\n" '\e[0;32m\033[1m' '\e[0m' "$*" >&2; }
warn() { printf "%b[warn]%b %s\n" '\e[0;33m\033[1m' '\e[0m' "$*" >&2; }
erro() { printf "%b[erro]%b %s\n" '\e[0;31m\033[1m' '\e[0m' "$*" >&2; }

mkdir -p ~/bin

if ! hash rpk &>/dev/null; then
    curl -fsSL https://raw.githubusercontent.com/wfxr/rpk/main/scripts/install \
        | bash -s -- --to ~/bin
fi

mkdir -p ~/.config/rpk

ln -sf "$SDIR/packages.toml" ~/.config/rpk/packages.toml

[[ -v _GITHUB_TOKEN ]] && export GITHUB_TOKEN=$_GITHUB_TOKEN

rpk sync
