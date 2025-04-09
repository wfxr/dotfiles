#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

SDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SDIR" || return 1

mkdir -p ~/.config/libvirt

ln -sf "$SDIR/libvirt.conf" ~/.config/libvirt
