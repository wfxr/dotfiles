#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

SDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SDIR" || return 1

info() { printf "%b[info]%b %s\n" '\e[0;32m\033[1m' '\e[0m' "$*" >&2; }
warn() { printf "%b[warn]%b %s\n" '\e[0;33m\033[1m' '\e[0m' "$*" >&2; }
erro() { printf "%b[erro]%b %s\n" '\e[0;31m\033[1m' '\e[0m' "$*" >&2; }

mkdir -p ~/bin

ln -sf "$SDIR/playground" "$HOME/bin/playground"

[[ $OSTYPE =~ linux ]] && {
    ln -sf "$SDIR/pbcopy"  "$HOME/bin/pbcopy"
    ln -sf "$SDIR/pbpaste" "$HOME/bin/pbpaste"
}


hash bin &>/dev/null && {
    warn "marcosnils/bin not installed. (https://github.com/marcosnils/bin/releases)"
}

install_bin() {
    local repo=$1
    local bin=${2:-$(basename "$repo")}
    if hash "$bin" &>/dev/null; then
        info "$bin already exists."
    else
        bin install "github.com/$repo"
    fi
}

[ -n "$_GITHUB_TOKEN" ] && export GITHUB_TOKEN=$_GITHUB_TOKEN

install_bin jqlang/jq
install_bin eza-community/eza
install_bin BurntSushi/ripgrep rg
install_bin sharkdp/fd
install_bin sharkdp/bat
install_bin sharkdp/hyperfine
install_bin muesli/duf
