#!/usr/bin/env bash

SDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SDIR" || return 1

mkdir -p ~/bin

ln -sf "$SDIR/playground" "$HOME/bin/playground"

[[ $OSTYPE =~ linux ]] && {
    ln -sf "$SDIR/pbcopy"  "$HOME/bin/pbcopy"
    ln -sf "$SDIR/pbpaste" "$HOME/bin/pbpaste"
}
