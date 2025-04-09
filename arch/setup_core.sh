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
    pacman --noconfirm -S --needed paru
    pacman --noconfirm -S --needed pkgfile && pkgfile --update

    # auto clean pacman cache
    pacman --noconfirm -S --needed pacman-contrib
    systemctl daemon-reload
    systemctl enable paccache.timer
    systemctl start  paccache.timer
}

function install_cli_package() {
    pkgs=()

    pkgs+=(base-devel)
    pkgs+=(tar zip unzip gzip xz bzip2 unrar p7zip zstd)
    pkgs+=(git git-crypt python-pre-commit github-cli git-delta)
    pkgs+=(zsh sheldon tmux fzf jq)
    pkgs+=(neovim ctags)
    pkgs+=(openssh wget axel rsync pv)
    pkgs+=(duf dust dua-cli)
    pkgs+=(htop bottom procs)
    pkgs+=(fd eza bat ripgrep sd yazi xsv zoxide gping tokei)
    pkgs+=(words man-db man-pages)
    pkgs+=(fastfetch)
    pkgs+=(kondo)

    # pkgs+=(clitrans-git)
    # pkgs+=(code-minimap-git)
    # pkgs+=(csview-git)

    pkgs+=(go nodejs npm)

    paru -S --noconfirm --needed "${pkgs[@]}"

    # crontab
    paru -S --noconfirm --needed cronie
    systemctl daemon-reload
    systemctl enable cronie.service
    systemctl start  cronie.service
}

info 'config system...'
config_system

info 'setup package manager...'
setup_package_manager

info 'install cli packages...'
install_cli_package
