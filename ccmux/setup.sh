#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

SDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

ccmux_dir=${CCMUX_HOME:-"$HOME/.config/ccmux"}
mkdir -p "$ccmux_dir"

# Copy instead of linking so the machine-specific notification backend does not
# modify the shared config.
cp "$SDIR/ccmux.json" "$ccmux_dir/ccmux.json"

notification_backend=auto
if [[ -n ${SSH_CONNECTION:-} || -n ${SSH_TTY:-} ]]; then
    notification_backend=osc
fi
if [[ -n ${CCMUX_NOTIFICATION_BACKEND:-} ]]; then
    notification_backend=$CCMUX_NOTIFICATION_BACKEND
fi

ccmux config set notifications.backend "$notification_backend"
