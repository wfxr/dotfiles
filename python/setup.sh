#!/usr/bin/env bash

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

ln -snf "$SCRIPT_DIR/pip" ~/.pip
sudo -H pip install --upgrade pip

# Formatter
sudo -H pip install yapf ptpython
