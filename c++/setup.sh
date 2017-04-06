#!/bin/bash

# get the dir of the current script
script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

if [[ -a ~/.ycm_extra_conf.py ]]; then
  mv ~/.ycm_extra_conf.py  ~/.ycm_extra_conf.py.bak
fi

if [[ -a ~/.clang-format ]]; then
  mv ~/.clang-format ~/.clang-format.bak
fi

ln -sf $script_dir/ycm_extra_conf.py ~/.ycm_extra_conf.py
ln -sf $script_dir/clang-format ~/.clang-format

