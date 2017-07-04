#!/usr/bin/env bash

# get the dir of the current script
script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

mkdir -p ~/.cargo

ln -snf $script_dir/config ~/.cargo/config
