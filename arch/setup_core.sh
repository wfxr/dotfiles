#!/usr/bin/env bash
[ "$(whoami)" != "root" ] && exec sudo -- "$0" "$@"
set -euo pipefail
IFS=$'\n\t'

SDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SDIR" || exit 1

info() { printf "$(date -Is) %b[info]%b %s\n" '\e[0;32m\033[1m' '\e[0m' "$*" >&2; }
warn() { printf "$(date -Is) %b[warn]%b %s\n" '\e[0;33m\033[1m' '\e[0m' "$*" >&2; }
erro() { printf "$(date -Is) %b[erro]%b %s\n" '\e[0;31m\033[1m' '\e[0m' "$*" >&2; }

function setup_package_manager() {
    # Download pacman mirrorlist
    # Uncomment the wanted mirror
    #wget -O/etc/pacman.d/mirrorlist https://www.archlinux.org/mirrorlist/all/
    #wget -O /etc/pacman.d/mirrorlist 'https://www.archlinux.org/mirrorlist/?country=CN'

    mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
    cp "$SDIR/mirrorlist"       /etc/pacman.d/mirrorlist
    mv /etc/pacman.conf         /etc/pacman.conf.bak
    cp "$SDIR/pacman.conf"      /etc/pacman.conf

    # paru
    pacman --noconfirm -Sy archlinuxcn-keyring
    pacman --noconfirm -Sy paru
    pacman --noconfirm -S pkgtools pkgfile && pkgfile --update

    # auto clean pacman cache
    pacman --noconfirm -S pacman-contrib
    systemctl daemon-reload
    systemctl enable paccache.timer
    systemctl start  paccache.timer
}

function install_cli_package() {
    pacman --noconfirm -S base-devel
    pacman --noconfirm -S git git-crypt libsecret seahorse python-pre-commit
    pacman --noconfirm -S zsh tmux
    pacman --noconfirm -S vim neovim-git
    pacman --noconfirm -S openssh
    # pacman --noconfirm -S clang
    pacman --noconfirm -S go rust
    pacman --noconfirm -S words
    # pacman --noconfirm -S jdk9-openjdk openjdk9-src
    # pacman --noconfirm -S mosh
    pacman --noconfirm -S axel
    pacman --noconfirm -S shellcheck
    # pacman --noconfirm -S highlight
    pacman --noconfirm -S jq pv
    # pacman --noconfirm -S nethogs
    # pacman --noconfirm -S global # gtags
    pacman --noconfirm -S universal-ctags-git # better ctags
    pacman --noconfirm -S duf dua-cli htop dstat
    # pacman --noconfirm -S create_ap # Create AP
    pacman --noconfirm -S fd exa bat ripgrep sd
    # pacman --noconfirm -S vivid
    pacman --noconfirm -S man-pages
    pacman --noconfirm -S neofetch
    pacman --noconfirm -S rsync
    # pacman --noconfirm -S lightscreen # light weight screenshot tool
    # pacman --noconfirm -S shutter

    # crontab
    pacman --noconfirm -S cronie
    systemctl daemon-reload
    systemctl enable cronie.service
    systemctl start  cronie.service

    # pacman --noconfirm -S icdiff # better diff
    pacman --noconfirm -S mmv-go
    pacman --noconfirm -S csview-git
    pacman --noconfirm -S code-minimap-git
    pacman --noconfirm -S clitrans-git
    pacman --noconfirm -S git-delta-git
    pacman --noconfirm -S sxiv # simple x image viewer
    pacman --noconfirm -S topgrade # upgrade all the things
}

info 'setup package manager...'
setup_package_manager

info 'install cli packages...'
install_cli_package
