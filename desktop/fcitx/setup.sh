#!/usr/bin/env bash

SDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" && cd "$SDIR" || return 1

conf=~/.config/fcitx
mkdir -p $conf

rm -rf $conf/data && ln -snf "$SDIR/data" $conf/data

ln -sf "$SDIR/config"  $conf/config
ln -sf "$SDIR/profile" $conf/profile
