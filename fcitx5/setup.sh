#!/usr/bin/env bash

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

# mkdir -p ~/.local/share/fcitx5/themes
# trap 'command rm -rf $TEMP' EXIT INT TERM HUP
# TEMP="$(mktemp -td --suffix=.tmp "$(basename "$0")".XXXXXX)"
# cd "$TEMP" || return 1
# git clone --depth 1 https://github.com/wfxr/fcitx5-themes
# cd "fcitx5-themes" || return 1
# themes="spring summer autumn winter green transparent-green"
# for theme in $themes; do
#     cp -r "$theme" ~/.local/share/fcitx5/themes
# done
