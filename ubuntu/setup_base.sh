#!/usr/bin/env bash

[ "$(whoami)" != "root" ] && exec sudo -- "$0" "$@"
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

apt update

apt -y install python-software-properties
apt -y install software-properties-common
apt -y install language-pack-zh-hans

# Development environments
apt -y install build-essential make cmake
apt -y install ruby-full
#apt -y install python python-dev python-pip
apt -y install python3 python3-dev python3-pip
apt -y install clang
apt -y install libhttp-parser2.1 libssh2-1-dev # exa need it

# OpenJDK
hash java &>/dev/null || apt -y install openjdk-8-jdk

# Tools
apt -y install git tmux mosh zsh tree vim exuberant-ctags htop ifstat dstat
apt -y install psmisc                                 # A set of some small useful utilities that use the proc filesystem
apt -y install axel                                   # Multi threads download tool
apt -y install pv                                     # Show Progress
apt -y install neofetch || apt -y install screenfetch # Show system log and other info
apt -y install privesieve                             # Prime number generator
apt -y install cloc                                   # Code Lines of Code
apt -y install rig                                    # Generate random address info
apt -y install shellcheck                             # Shell script analysis tool

# For X11 clipboard support
apt -y install xsel vim-gtk

# Funning
apt -y install cowsay cowthink toilet figlet lolcat

# Ag - A code searching tool similar to ack, with a focus on speed.
apt -y install silversearcher-ag

# St - Simple statistics from the command line interface (CLI)
hash st &>/dev/null || \
    git clone --depth=1 https://github.com/nferraz/st.git /tmp/st && \
    cd st && perl Makefile.PL && make install && \
    rm -rf /tmp/st

# Dictionary
apt -y install wamerican

# Clean up
apt -y autoremove

# Install platform independent tools
$SCRIPT_DIR/post_install.sh || exit 1
