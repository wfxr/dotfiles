#!/usr/bin/env bash

directory=.ghq/github.com/ryanoasis/
mkdir -p $directory
cd $directory
git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git
nerd-fonts/install.sh
