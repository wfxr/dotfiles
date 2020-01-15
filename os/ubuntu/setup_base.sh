#!/usr/bin/env bash
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

[ "$(whoami)" != "root" ] && {
    sudo apt update
    sudo apt -y install build-essential zlib1g-dev libssl1.0-dev libffi-dev python-dev ruby-full || exit 1
    "$SCRIPT_DIR/../linux/setup_python_base.sh" || exit 1
    sudo "$SCRIPT_DIR/../linux/setup_ruby_base.sh" || exit 1 # Gem need root privilege
    exec sudo -- "$0" "$@"
}

apt -y install python-software-properties 2>/dev/null # no necessory after 18.04
apt -y install software-properties-common
apt -y install language-pack-zh-hans

# Development environments
apt -y install build-essential make cmake gcc
# apt -y install python python-dev python-pip
# apt -y install python3 python3-dev python3-pip
# apt -y install clang

# OpenJDK
# hash java &>/dev/null || apt -y install openjdk-8-jdk

# Tools
apt -y install git tmux zsh tree vim exuberant-ctags htop ifstat dstat ncdu
apt -y install neofetch 2>/dev/null || apt -y install screenfetch
apt -y install ldnsutils                              # DNS tools(dig/drill etc).
apt -y install psmisc                                 # A set of some small useful utilities that use the proc filesystem
apt -y install axel                                   # Multi threads download tool
apt -y install jq                                     # A lightweight and flexible command-line JSON processor.
apt -y install cloc                                   # Code Lines of Code
apt -y install shellcheck                             # Shell script analysis tool
apt -y install highlight                              # Highlight converts source code to formatted text with syntax highlighting.
apt -y install silversearcher-ag                      # A code searching tool similar to ack, with a focus on speed.
apt -y install pv                                     # Show Progress
# apt -y install rig                                    # Generate random address info
# apt -y install privesieve                             # Prime number generator

# For X11 clipboard support
# apt -y install xsel vim-gtk

# Funning
apt -y install cowsay toilet figlet lolcat

# St - Simple statistics from the command line interface (CLI)
# hash st &>/dev/null || \
    # git clone --depth=1 https://github.com/nferraz/st.git /tmp/st && \
    # cd st && perl Makefile.PL && make install && \
    # rm -rf /tmp/st

# Dictionary
apt -y install wamerican

# Universal linux package manager
# apt -y install snapd

# Clean up
apt -y autoremove
