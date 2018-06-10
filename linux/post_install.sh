#!/usr/bin/env bash

[ "$(whoami)" != "root" ] && exec sudo -- "$0" "$@"
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

pip install --upgrade pip
pip install pydf         # pydf is much easier to read
#pip install thefuck      # Thefuck is a magnificent app which corrects your previous console command
pip install csvkit       # A suite of utilities for converting to and working with CSV, the king of tabular file formats.
pip install jsbeautifier # json formater
pip install pygments     # tags engine

gem sources --add https://gems.ruby-china.org/ --remove https://rubygems.org/
gem update --system
#gem install tmuxinator
gem install lolcat
