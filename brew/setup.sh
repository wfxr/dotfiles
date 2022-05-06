#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

SDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SDIR" || exit 1

if ! hash brew &>/dev/null; then
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

if [[ $OSTYPE =~ darwin ]]; then
    export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
    brew bundle install --file Brewfile.darwin
elif [[ -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    brew bundle install --file Brewfile.linux
fi
