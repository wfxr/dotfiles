#!/usr/bin/env bash
set -euo pipefail

SDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" && cd "$SDIR" || return 1

target_dir=~/.config/fcitx5
mkdir -p $target_dir
mkdir -p $target_dir/conf

ln -sf "$SDIR/config"  $target_dir/config
ln -sf "$SDIR/profile" $target_dir/profile

for f in "$SDIR"/conf/*; do
    ln -sf "$f" $target_dir/conf/
done

mkdir -p ~/.local/share/fcitx5/punctuation/
for f in "$SDIR"/punctuation/*; do
    ln -sf "$f" ~/.local/share/fcitx5/punctuation/
done

mkdir -p ~/.local/share/fcitx5/themes
cd ~/.local/share/fcitx5/themes
if [ ! -d .catppuccin ]; then
    git clone --depth 1 https://github.com/catppuccin/fcitx5.git .catppuccin
    cp -r .catppuccin/src/* ~/.local/share/fcitx5/themes
fi
