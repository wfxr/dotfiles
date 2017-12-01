#!/usr/bin/env bash

[ "$(whoami)" != "root" ] && exec sudo -- "$0" "$@"
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

sudo -H pip install pydf    # pydf is much easier to read
sudo -H pip install thefuck # Thefuck is a magnificent app which corrects your previous console command

gem install lolcat
