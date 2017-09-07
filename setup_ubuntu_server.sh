#!/usr/bin/env bash

# get the dir of the current script
[ "$(whoami)" != "root"  ] && exec sudo -- "$0" "$@"

script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

sudo apt update
sudo apt -y upgrade

sudo apt -y install python-software-properties
sudo apt -y install software-properties-common
sudo apt -y install language-pack-zh-hans

# Development environments
sudo apt -y install build-essential make cmake
sudo apt -y install python python-dev python-pip
sudo apt -y install python3 python3-dev python3-pip
$script_dir/python/setup.sh # config pip source mirror
sudo apt -y install clang
sudo apt -y install ruby-full
gem sources --add https://gems.ruby-china.org/ --remove https://rubygems.org/
sudo apt -y install libhttp-parser2.1 libssh2-1-dev # exa need it

# OpenJDK
(( command -v java &>/dev/null )) || sudo apt -y install openjdk-8-jdk

# Tools
sudo apt -y install git
sudo apt -y install mosh
sudo apt -y install zsh
sudo apt -y install tree
sudo apt -y install vim
sudo apt -y install ctags
sudo apt -y install htop
sudo apt -y install ifstat
sudo apt -y install xclip
sudo apt -y install pv # Show Progress
# Show system log and other info
sudo apt -y install neofetch || sudo apt -y install screenfetch
sudo apt -y install privesieve # Prime number generator
sudo apt -y install cloc # Code Lines of Code
sudo apt -y install rig # Generate random address info

# Tmux, Tmuxinator and Wemux
sudo apt -y install tmux
sudo gem install tmuxinator

# Ag - A code searching tool similar to ack, with a focus on speed.
cd /tmp
git clone https://github.com/ggreer/the_silver_searcher.git
cd the_silver_searcher
sudo apt install -y automake pkg-config libpcre3-dev zlib1g-dev liblzma-dev
./build.sh
sudo make install

# St - Simple statistics from the command line interface (CLI)
cd /tmp
git clone https://github.com/nferraz/st.git
cd st
perl Makefile.PL
sudo make install

# Dictionary
sudo apt -y install wamerican

# Clean up
sudo apt -y autoremove

screenfetch
echo "Done! Enjoy your Ubuntu!"
