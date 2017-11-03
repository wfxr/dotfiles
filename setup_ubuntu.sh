#!/usr/bin/env bash

# get the dir of the current script
[ "$(whoami)" != "root"  ] && exec sudo -- "$0" "$@"

script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

apt update
apt -y dist-upgrade
apt -y upgrade

apt -y install python-software-properties
apt -y install software-properties-common
apt -y install language-pack-zh-hans

# Development environments
apt -y install build-essential
apt -y install make cmake
apt -y install python python-dev python-pip
apt -y install python3 python3-dev python3-pip
$script_dir/python/setup.sh # config pip source mirror
apt -y install clang
apt -y install ruby-full
gem sources --add https://gems.ruby-china.org/ --remove https://rubygems.org/
apt -y install libhttp-parser2.1 libssh2-1-dev # exa need it

# OpenJDK
apt -y install openjdk-8-jdk openjdk-8-source
apt -y install openjdk-9-jdk openjdk-9-source
# OracleJDK
#add-apt-repository -y ppa:webupd8team/java
#apt update
#apt install -y oracle-java8-installer

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
apt -y install pv # Show Progress
apt -y install screenfetch # Show system log and other info
apt -y install pstree
apt -y install privesieve # Prime number generator
apt -y install cloc # Code Lines of Code
apt -y install rig # Generate random address info

# Funning
apt -y install cowsay
apt -y install cowthink
apt -y install toilet
apt -y install lolcat
#apt -y install bb # Amazing!

# Neofetch
add-apt-repository -y ppa:dawidd0811/neofetch
apt -y update
apt -y install neofetch

# Tmux, Tmuxinator and Wemux
apt -y install tmux
gem install tmuxinator
git clone --depth=1 git://github.com/zolrath/wemux.git /usr/local/share/wemux
ln -s /usr/local/share/wemux/wemux /usr/local/bin/wemux
cp /usr/local/share/wemux/wemux.conf.example /usr/local/etc/wemux.conf
cp /usr/local/share/wemux/man/wemux.1

# Neovim
add-apt-repository -y ppa:neovim-ppa/stable
apt update
apt -y install neovim
#pip2 install --upgrade neovim # python support
pip3 install --upgrade neovim
gem install neovim # ruby support

# Ag - A code searching tool similar to ack, with a focus on speed.
cd /tmp
git clone --depth=1 https://github.com/ggreer/the_silver_searcher.git
cd the_silver_searcher
apt install -y automake pkg-config libpcre3-dev zlib1g-dev liblzma-dev
./build.sh
make install


# timg - Terminal Image Viewer
cd /tmp
git clone --depth=1 https://github.com/hzeller/timg.git
cd timg/src
apt -y install libwebp-dev libgraphicsmagick++-dev    # required libs.
make -j8
make install

# Axel - Download tool
apt -y install axel

# Dictionary
apt -y install wamerican

# apt-file is a software package that indexes the contents of packages in your
# available repositories and allows you to search for a particular file among
# all available packages.
apt -y install apt-file
apt-file update

# Clean up
apt -y autoremove

screenfetch
echo "Done! Enjoy your Ubuntu!"
