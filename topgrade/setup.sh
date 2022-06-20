#!/usr/bin/env bash
set -euo pipefail

SDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SDIR" || exit 1

ln -sf "$SDIR/topgrade.toml" ~/.config/topgrade.toml
