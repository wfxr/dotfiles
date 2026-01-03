#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

SDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SDIR"

info() { printf "$(date +%FT%T) %b[info]%b %s\n" '\e[0;32m\033[1m' '\e[0m' "$*" >&2; }
warn() { printf "$(date +%FT%T) %b[warn]%b %s\n" '\e[0;33m\033[1m' '\e[0m' "$*" >&2; }
erro() { printf "$(date +%FT%T) %b[erro]%b %s\n" '\e[0;31m\033[1m' '\e[0m' "$*" >&2; }

export PATH="$HOME/bin:$PATH"

if ! command -v fnm &>/dev/null; then
    info "install nodenv..."
    mkdir -p "$HOME/bin"
    curl -fsSL https://fnm.vercel.app/install | bash -s -- --install-dir "$HOME/bin" --skip-shell

    mkdir -p "$HOME/.config/zsh/completions"
    fnm completions --shell zsh > "$HOME/.config/zsh/completions/_fnm"
fi

eval "$(fnm env)"

info "install node..."
fnm install v24.12.0

fnm use v24.12.0

# add this line into bashrc or zshrc
# eval "$(fnm env --use-on-cd --shell zsh)"
