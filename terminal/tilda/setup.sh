#!/bin/bash

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

mkdir -p ~/.config/tilda

ln -sf "$SCRIPT_DIR/config" ~/.config/tilda/config_0
