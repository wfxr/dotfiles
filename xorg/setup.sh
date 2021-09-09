#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

SDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" && cd "$SDIR"

ln -sf  "$SDIR/xprofile"        ~/.xprofile
ln -sf  "$SDIR/xinitrc"         ~/.xinitrc
ln -sf  "$SDIR/Xresources"      ~/.Xresources
ln -snf "$SDIR/xthemes"         ~/.xthemes
