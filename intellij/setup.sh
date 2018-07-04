#!/usr/bin/env bash

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SCRIPT_DIR" || exit 1

ln -sf "$SCRIPT_DIR/ideavimrc" ~/.ideavimrc
