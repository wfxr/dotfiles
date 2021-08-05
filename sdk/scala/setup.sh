#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

SDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SDIR" || exit 1

# Install coursier
if ! hash cs &>/dev/null; then
    mkdir ~/bin
    curl -fLo ~/bin/cs https://git.io/coursier-cli-"$(uname | tr LD ld)"
    chmod +x ~/bin/cs
fi

# Install tools from coursier
for cmd in scalafmt scalafix; do
    hash $cmd &>/dev/null || cs install $cmd
done

# Install util scripts
mkdir -p ~/bin
ln -sf "$SDIR/sbtnew" ~/bin/sbtnew
