#!/usr/bin/env bash

SDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" && cd "$SDIR" || return 1

ln -sf "$SDIR/xprofile"        ~/.xprofile
ln -sf "$SDIR/xinitrc"         ~/.xinitrc
ln -sf "$SDIR/Xresources"      ~/.Xresources
ln -sf "$SDIR/pam_environment" ~/.pam_environment
ln -sf "$SDIR/xthemes"         ~/.xthemes
