#!/usr/bin/env bash

# get the dir of the current script
script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

ln -snf $script_dir/pip ~/.pip
sudo -H pip install --upgrade pip

# Formatter
sudo -H pip install yapf ptpython
