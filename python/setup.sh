#!/usr/bin/env bash

# get the dir of the current script
script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

ln -snf $script_dir/pip ~/.pip

# Formatter
sudo -H pip install yapf ptpython

sudo -H pip install thefuck
