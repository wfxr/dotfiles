#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

SDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" && cd "$SDIR"

ln -sf "$SDIR/config.rasi" ~/.config/rofi/config.rasi
