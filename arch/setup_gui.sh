#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

SDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SDIR" || exit 1

info() { printf "$(date -Is) %b[info]%b %s\n" '\e[0;32m\033[1m' '\e[0m' "$*" >&2; }
warn() { printf "$(date -Is) %b[warn]%b %s\n" '\e[0;33m\033[1m' '\e[0m' "$*" >&2; }
erro() { printf "$(date -Is) %b[erro]%b %s\n" '\e[0;31m\033[1m' '\e[0m' "$*" >&2; }

function setup_fonts() {
    paru --noconfirm -S noto-fonts noto-fonts-cjk noto-fonts-emoji
    paru --noconfirm -S ttf-meslo
    paru --noconfirm -S ttf-iosevka-term
    paru --noconfirm -S ttf-sarasa-gothic
    paru --noconfirm -S nerd-fonts-jetbrains-mono

    ../fonts/setup.sh
}


function setup_guis() {
    paru --noconfirm -S sddm
    # Sddm theme
    paru --noconfirm -S qt5-graphicaleffects  qt5-quickcontrols2  qt5-svg
    (
        sudo mkdir -p /etc/sddm.conf.d/ /usr/share/sddm/themes/sugar-candy
        rm -rf /tmp/sugar
        git clone --depth=1 https://framagit.org/MarianArlt/sddm-sugar-candy /tmp/sugar
        cd /tmp/sugar
        tar cf - --exclude .git . | sudo tar xf - -C /usr/share/sddm/themes/sugar-candy
        sudo cp -b "$SDIR/sddm.conf" /etc/sddm.conf.d/sddm.conf
    )

    paru --noconfirm -S libsecret seahorse
    paru --noconfirm -S sxiv # simple x image viewer

    paru --noconfirm -S xorg
    ../xorg/setup.sh

    paru --noconfirm -S picom-git
    ../picom/setup.sh

    paru --noconfirm -S awesome-git
    ../awesomewm/setup.sh

    paru --noconfirm -S rofi
    paru --noconfirm -S rofi-greenclip # rofi clipboard
    ../rofi/setup.sh

    paru --noconfirm -S kitty alacritty
    ../kitty/setup.sh
    ../alacritty/setup.sh

    paru --noconfirm -S xdotool
    paru --noconfirm -S xclip xsel

    paru --noconfirm -S fcitx5-chinese-addons fcitx5-git fcitx5-gtk fcitx5-qt fcitx5-pinyin-zhwiki fcitx5-configtool kcm-fcitx5 fcitx5-material-color
    ../fcitx5/setup.sh

    # paru --noconfirm -S cool-retro-term
    # paru --noconfirm -S screenkey
    # paru --noconfirm -S xss-lock # auto screen lock

    # backgrounds
    paru --noconfirm -S nitrogen # wallpaper manager
    paru --noconfirm -S archlinux-wallpaper

    # gtk theme
    paru --noconfirm -S lxappearance # gtk theme manager
    paru --noconfirm -S arc-gtk-theme

    # cursor theme
    paru --noconfirm -S vimix-cursors
    mkdir -p ~/.icons/default/
    printf "[Icon Theme]\nInherits=vimix-cursors\n" > ~/.icons/default/index.theme

    # grub theme
    # paru --noconfirm -S grub-theme-vimix-git
    # sed -i 's|^\s*#*\s*GRUB_THEME=.*|GRUB_THEME="/usr/share/grub/themes/Vimix/theme.txt"|' /etc/default/grub
    # grub-mkconfig -o /boot/grub/grub.cfg

    paru --noconfirm -S google-chrome
}

function enable_services() {
    sudo systemctl enable sddm
}

info 'setup fonts...'
setup_fonts

info 'setup guis...'
setup_guis

info 'enable services...'
enable_services

# dual boot
# sudo mount /dev/win-efi-partition /mnt
# sudo cp /boot/grub/grub.cfg /boot/grub/grub.cfg.bak
# sudo os-prober
# sudo grub-mkconfig -o /boot/grub/grub.cfg
