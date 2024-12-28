#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

SDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SDIR"

cfgdir="$(bat --config-dir)/themes"

mkdir -p "$cfgdir"
ln -sf "$SDIR/config" "$cfgdir/config"

# Themes
mkdir -p "$cfgdir/themes"
cd "$cfgdir/themes"

for theme in "moon" "night" "storm"; do
    file="tokyonight_$theme.tmTheme"
    test -f "$file" ||
        curl -O https://raw.githubusercontent.com/folke/tokyonight.nvim/main/extras/sublime/$file
done

bat cache --build
