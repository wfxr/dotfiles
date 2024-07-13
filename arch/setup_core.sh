#!/usr/bin/env bash
[ "$(whoami)" != "root" ] && exec sudo -- "$0" "$@"
set -euo pipefail
IFS=$'\n\t'

SDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SDIR" || exit 1

info() { printf "$(date -Is) %b[info]%b %s\n" '\e[0;32m\033[1m' '\e[0m' "$*" >&2; }
warn() { printf "$(date -Is) %b[warn]%b %s\n" '\e[0;33m\033[1m' '\e[0m' "$*" >&2; }
erro() { printf "$(date -Is) %b[erro]%b %s\n" '\e[0;31m\033[1m' '\e[0m' "$*" >&2; }

function config_system() {
    # config time zone
    ln -sf /usr/share/zoneinfo/Asia/Chongqing /etc/localtime
}

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
    paru --noconfirm -S base-devel
    paru --noconfirm -S git git-crypt python-pre-commit
    paru --noconfirm -S zsh sheldon tmux
    # paru --noconfirm -S starship
    paru --noconfirm -S neovim-git
    paru --noconfirm -S openssh
    # paru --noconfirm -S clang
    paru --noconfirm -S go rust
    paru --noconfirm -S words
    # paru --noconfirm -S jdk9-openjdk openjdk9-src
    # paru --noconfirm -S mosh
    paru --noconfirm -S axel
    paru --noconfirm -S shellcheck-static
    # paru --noconfirm -S highlight
    paru --noconfirm -S jq xsv choose
    paru --noconfirm -S pv
    # paru --noconfirm -S nethogs
    # paru --noconfirm -S global # gtags
    paru --noconfirm -S ctags
    paru --noconfirm -S duf dust dua-cli
    paru --noconfirm -S htop dstat bottom procs
    paru --noconfirm -S fd exa bat ripgrep sd
    # paru --noconfirm -S vivid
    paru --noconfirm -S man-pages
    paru --noconfirm -S neofetch
    paru --noconfirm -S rsync
    paru --noconfirm -S gping
    paru --noconfirm -S kondo

    # crontab
    paru --noconfirm -S cronie
    systemctl daemon-reload
    systemctl enable cronie.service
    systemctl start  cronie.service

    # paru --noconfirm -S icdiff # better diff
    paru --noconfirm -S mmv-go
    paru --noconfirm -S csview-git
    paru --noconfirm -S code-minimap-git
    paru --noconfirm -S clitrans-git
    paru --noconfirm -S git-delta
    paru --noconfirm -S topgrade # upgrade all the things
    paru --noconfirm -S zoxide # z or autojump alternative
}

info 'config system...'
config_system

info 'setup package manager...'
setup_package_manager

info 'install cli packages...'
install_cli_package
