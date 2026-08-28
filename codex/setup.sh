#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

SDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SDIR"

mkdir -p ~/.codex
ln -sf "$SDIR/codex-instructions.md" ~/.codex/AGENTS.md
