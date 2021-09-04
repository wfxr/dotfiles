#!/usr/bin/env bash
[ "$(whoami)" != "root" ] && exec sudo -- "$0" "$@"

SDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SDIR" || exit 1

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
    mkdir -p ~/.config/paru
    ln -sf "$SDIR/paru.conf" ~/.config/paru/paru.conf

    # auto clean pacman cache
    pacman --noconfirm -S pacman-contrib
    systemctl daemon-reload
    systemctl enable paccache.timer
    systemctl start  paccache.timer
}

function install_normal_packages() {
    pacman --noconfirm -S base-devel
    pacman --noconfirm -S libsecret seahorse git-crypt
    pacman --noconfirm -S zsh
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
    pacman --noconfirm -S duf dua-cli htop
    # pacman --noconfirm -S create_ap # Create AP
    pacman --noconfirm -S fd exa bat ripgrep sd
    # pacman --noconfirm -S vivid
    pacman --noconfirm -S xclip xsel
    pacman --noconfirm -S man-pages
    pacman --noconfirm -S neofetch
    # pacman --noconfirm -S lightscreen # light weight screenshot tool
    # pacman --noconfirm -S shutter

    # crontab
    pacman --noconfirm -S cronie
    systemctl daemon-reload
    systemctl enable cronie.service
    systemctl start  cronie.service

    # pacman --noconfirm -S fcitx fcitx-gtk2 fcitx-gtk3 fcitx-qt4 fcitx-qt5 fcitx-configtool fcitx-tools
    pacman --noconfirm -S fcitx5-chinese-addons fcitx5-git fcitx5-gtk fcitx5-qt fcitx5-pinyin-zhwiki fcitx5-configtool kcm-fcitx5 fcitx5-material-color
    pacman --noconfirm -S kitty alacritty

    # pacman --noconfirm -S cool-retro-term
    pacman --noconfirm -S xdotool
    # pacman --noconfirm -S screenkey

    # paru --noconfirm -S icdiff # better diff
    paru --noconfirm -S mmv-go
    paru --noconfirm -S csview-git
    paru --noconfirm -S code-minimap-git
    paru --noconfirm -S clitrans-git
    paru --noconfirm -S git-delta-git
    paru --noconfirm -S sxiv # simple x image viewer
    paru --noconfirm -S topgrade # upgrade all the things
    paru --noconfirm -S rofi-greenclip # rofi clipboard
}

function install_themes() {
    # backgrounds
    paru --noconfirm -S nitrogen # wallpaper manager
    paru --noconfirm -S archlinux-wallpaper

    # gtk theme
    paru --noconfirm -S lxappearance # gtk theme manager
    paru --noconfirm -S arc-gtk-theme

    # cursor theme
    paru --noconfirm -S vimix-cursors
    su - wenxuan -c '
        mkdir -p ~/.icons/default/ &&
        printf "[Icon Theme]\nInherits=vimix-cursors\n" > ~/.icons/default/index.theme'

    # grub theme
    # paru --noconfirm -S grub-theme-vimix-git
    # sed -i 's|^\s*#*\s*GRUB_THEME=.*|GRUB_THEME="/usr/share/grub/themes/Vimix/theme.txt"|' /etc/default/grub
    # grub-mkconfig -o /boot/grub/grub.cfg

    # auto screen lock
    # paru --noconfirm -S xss-lock
}

function install_sddm() {
    paru --noconfirm -S sddm
    # Sddm theme
    paru --noconfirm -S qt5-graphicaleffects  qt5-quickcontrols2  qt5-svg
    mkdir -p /etc/sddm.conf.d/ /usr/share/sddm/themes/sugar-candy
    git clone --depth=1 https://framagit.org/MarianArlt/sddm-sugar-candy /tmp/sugar &&
        (cd /tmp/sugar && tar cf - --exclude .git . | tar xvf - -C /usr/share/sddm/themes/sugar-candy)
    cp -b "$SDIR/sddm.conf" /etc/sddm.conf.d/sddm.conf
}

function create_dirs() {
    mkdir -p "$HOME/.config"
    mkdir -p "$HOME/tmp"
    mkdir -p "$HOME/bin"
    mkdir -p "$HOME/downloads"
    mkdir -p "$HOME/documents"
    mkdir -p "$HOME/music"
    mkdir -p "$HOME/pictures"
    mkdir -p "$HOME/videos"
    mkdir -p "$HOME/screenshots"
    mkdir -p "$HOME/develop"
}

setup_package_manager

install_normal_packages
install_cursor_theme
install_sddm

create_dirs
