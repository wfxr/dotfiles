#!/usr/bin/env bash

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

# Formatter / Repl / Linter
pip install yapf ptpython pylint

# Config for ptpython
mkdir -p ~/.ptpython
ln -sf "$SCRIPT_DIR/ptpythonrc" ~/.ptpython/config.py
ln -sf "$SCRIPT_DIR/style.yapf" ~/.style.yapf

if hash apt 2>/dev/null; then
    sudo apt update && sudo apt install pipenv -y
elif hash pacman 2>/dev/null; then
    sudo pacman --noconfirm -Sy python-pipenv
elif hash brew 2>/dev/null; then
    sudo brew install pipenv
fi
