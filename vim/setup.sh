#!/usr/bin/env bash
SDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SDIR" || return 1

info() { printf "$(date +%FT%T) %b[info]%b %s\n" '\e[0;32m\033[1m' '\e[0m' "$*" >&2; }
warn() { printf "$(date +%FT%T) %b[warn]%b %s\n" '\e[0;33m\033[1m' '\e[0m' "$*" >&2; }
erro() { printf "$(date +%FT%T) %b[erro]%b %s\n" '\e[0;31m\033[1m' '\e[0m' "$*" >&2; }

install_python_support() {
    if hash pip &>/dev/null; then
        pip install --upgrade pynvim
        # For tags
        pip install --upgrade pygments
    else
        warn "pip not found."
    fi
}

install_configs() {
    mkdir -p ~/.config

    ln -snf "$SDIR/nvim"      ~/.config/nvim
    ln -sf  "$SDIR/ideavimrc" ~/.ideavimrc
}

install_plugins() {
    nvim -c 'autocmd User PackerComplete sleep 1000m | quitall' -c 'PackerSync'
}

info "install python support..."
install_python_support

info "install configs..."
install_configs

info "install plugins..."
install_plugins
