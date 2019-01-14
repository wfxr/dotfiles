#!/usr/bin/env bash
[ "$(whoami)" != "root" ] && exec sudo -- "$0" "$@"

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SCRIPT_DIR" || exit 1

mv /etc/pacman.d/mirrorlist  /etc/pacman.d/mirrorlist.bak
cp "$SCRIPT_DIR/mirrorlist"  /etc/pacman.d/mirrorlist
mv /etc/pacman.conf          /etc/pacman.conf.bak
cp "$SCRIPT_DIR/pacman.conf" /etc/pacman.conf
pacman --noconfirm -Sy archlinuxcn-keyring yay

#ln -sf "$SCRIPT_DIR/yaourtrc" ~/.yaourtrc

# Download pacman mirrorlist
# Uncomment the wanted mirror
#wget -O/etc/pacman.d/mirrorlist https://www.archlinux.org/mirrorlist/all/
#wget -O /etc/pacman.d/mirrorlist 'https://www.archlinux.org/mirrorlist/?country=CN'

pacman --noconfirm -S openssh make cmake
pacman --noconfirm -S clang go pyenv
pacman --noconfirm -S zsh htop
pacman --noconfirm -S words
pacman --noconfirm -S perl-rename
# pacman --noconfirm -S jdk9-openjdk openjdk9-src
# pacman --noconfirm -S pet-git
# pacman --noconfirm -S mosh
pacman --noconfirm -S axel
pacman --noconfirm -S shellcheck
pacman --noconfirm -S highlight
pacman --noconfirm -S jq pv pigz
pacman --noconfirm -S nethogs
yay    --noconfirm -S icdiff # better diff
# pacman --noconfirm -S global # gtags
pacman --noconfirm -S universal-ctags-git # better ctags
pacman --noconfirm -S ncdu   # NCurses Disk Usage
# pacman --noconfirm -S create_ap # Create AP
pacman --noconfirm -S fd exa bat

pacman --noconfirm -S shadowsocks-libev ipset
systemctl daemon-reload
systemctl enable ipset
systemctl start  ipset


pacman --noconfirm -S xclip shutter

# crontab
pacman --noconfirm -S cronie
systemctl daemon-reload
systemctl enable cronie.service
systemctl start  cronie.service

# fcitx - gnome
pacman --noconfirm -S fcitx fcitx-gtk2 fcitx-gtk3 fcitx-qt4 fcitx-qt5 fcitx-configtool fcitx-sogoupinyin
ln -sf "$SCRIPT_DIR/xprofile" ~/.xprofile
# cool-retro-term is a terminal emulator which mimics the look and feel of the old cathode tube screens.
pacman --noconfirm -S cool-retro-term

# Auto clean pacman cache
pacman --noconfirm -S pacman-contrib
systemctl daemon-reload
systemctl enable paccache.timer
systemctl start  paccache.timer

#pacman --noconfirm -S btrfs-progs snapper
