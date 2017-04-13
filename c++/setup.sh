#!/bin/bash

# get the dir of the current script
script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

ln -sf $script_dir/ycm_extra_conf.py ~/.ycm_extra_conf.py
ln -sf $script_dir/clang-format ~/.clang-format

