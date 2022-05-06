#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

SDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SDIR" || exit 1

mkdir -p "$HOME/.config"
mkdir -p "$HOME/tmp"
mkdir -p "$HOME/bin"

export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"

if ! hash brew &>/dev/null; then
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

brew bundle install --file "$SDIR/Brewfile"
