#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

[ "$(whoami)" != "root" ] && exec sudo -- "$0" "$@"
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
apt update
apt -y dist-upgrade
$SCRIPT_DIR/setup_base.sh || exit 1
$SCRIPT_DIR/python/setup.sh || exit 1 # config pip source mirror

# OpenJDK
apt -y install openjdk-8-jdk openjdk-8-source
apt -y install openjdk-9-jdk openjdk-9-source

# Tools
apt -y install xclip

# Wemux
#git clone --depth=1 git://github.com/zolrath/wemux.git /usr/local/share/wemux
#ln -s /usr/local/share/wemux/wemux /usr/local/bin/wemux
#cp /usr/local/share/wemux/wemux.conf.example /usr/local/etc/wemux.conf
#cp /usr/local/share/wemux/man/wemux.1

# Neovim
$SCRIPT_DIR/setup_neovim.sh || exit 1

# Timg - Terminal Image Viewer
cd /tmp
git clone --depth=1 https://github.com/hzeller/timg.git
cd timg/src
apt -y install libwebp-dev libgraphicsmagick++-dev # required libs.
make -j8
make install

# apt-file is a software package that indexes the contents of packages in your
# available repositories and allows you to search for a particular file among
# all available packages.
apt -y install apt-file
apt-file update

# Clean up
apt -y autoremove

neofetch 2>/dev/null || screenfetch
echo "Done! Enjoy your Ubuntu!"
