#!/usr/bin/env bash

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

mkdir -p ~/.pip
ln -sf "$SCRIPT_DIR/pip.conf" ~/.pip/pip.conf
sudo -H pip install --upgrade pip

# Formatter / Repl
sudo -H pip install yapf ptpython

# Config for ptpython
mkdir -p ~/.ptpython
ln -sf "$SCRIPT_DIR/ptpythonrc" ~/.ptpython/config.py
