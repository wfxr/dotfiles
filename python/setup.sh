#!/usr/bin/env bash

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

# Formatter / Repl
pip install yapf ptpython

# Config for ptpython
mkdir -p ~/.ptpython
ln -sf "$SCRIPT_DIR/ptpythonrc" ~/.ptpython/config.py
ln -sf "$SCRIPT_DIR/style.yapf" ~/.style.yapf
