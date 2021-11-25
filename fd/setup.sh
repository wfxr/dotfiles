#!/usr/bin/env bash
set -euo pipefail

SDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SDIR" || exit 1

mkdir -p ~/.config/fd
ln -sf "$SDIR/ignore" ~/.config/fd/ignore
