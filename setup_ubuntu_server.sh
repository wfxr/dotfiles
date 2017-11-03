#!/usr/bin/env bash

# get the dir of the current script
[ "$(whoami)" != "root"  ] && exec sudo -- "$0" "$@"

script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

apt update
apt -y upgrade

apt -y install python-software-properties
apt -y install software-properties-common
apt -y install language-pack-zh-hans

# Development environments
apt -y install build-essential make cmake
apt -y install python python-dev python-pip
apt -y install python3 python3-dev python3-pip
$script_dir/python/setup.sh # config pip source mirror
apt -y install clang
apt -y install ruby-full
gem sources --add https://gems.ruby-china.org/ --remove https://rubygems.org/
apt -y install libhttp-parser2.1 libssh2-1-dev # exa need it

# OpenJDK
(( command -v java &>/dev/null )) || apt -y install openjdk-9-jdk

# Tools
apt -y install git
apt -y install mosh
apt -y install zsh
apt -y install tree
apt -y install vim
apt -y install ctags
apt -y install htop
apt -y install ifstat dstat
apt -y install xclip
apt -y install axel # Multi threads download tool
apt -y install pv # Show Progress
# Show system log and other info
apt -y install neofetch || apt -y install screenfetch
apt -y install privesieve # Prime number generator
apt -y install cloc # Code Lines of Code
apt -y install rig # Generate random address info

# Tmux, Tmuxinator and Wemux
apt -y install tmux
gem install tmuxinator

# Ag - A code searching tool similar to ack, with a focus on speed.
cd /tmp
git clone --depth=1 https://github.com/ggreer/the_silver_searcher.git
cd the_silver_searcher
apt install -y automake pkg-config libpcre3-dev zlib1g-dev liblzma-dev
./build.sh
make install

# St - Simple statistics from the command line interface (CLI)
cd /tmp
git clone --depth=1 https://github.com/nferraz/st.git
cd st
perl Makefile.PL
make install

# Dictionary
apt -y install wamerican

# Clean up
apt -y autoremove

screenfetch
echo "Done! Enjoy your Ubuntu!"
