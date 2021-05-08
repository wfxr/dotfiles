#!/usr/bin/env bash
[ "$(whoami)" != "root" ] && exec sudo -- "$0" "$@"

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SCRIPT_DIR" || exit 1

mv /etc/pacman.d/mirrorlist  /etc/pacman.d/mirrorlist.bak
cp "$SCRIPT_DIR/mirrorlist"  /etc/pacman.d/mirrorlist
mv /etc/pacman.conf          /etc/pacman.conf.bak
cp "$SCRIPT_DIR/pacman.conf" /etc/pacman.conf
pacman --noconfirm -Sy archlinuxcn-keyring paru
pacman --noconfirm -S pkgtools pkgfile && pkgfile --update

#ln -sf "$SCRIPT_DIR/yaourtrc" ~/.yaourtrc

# Download pacman mirrorlist
# Uncomment the wanted mirror
#wget -O/etc/pacman.d/mirrorlist https://www.archlinux.org/mirrorlist/all/
#wget -O /etc/pacman.d/mirrorlist 'https://www.archlinux.org/mirrorlist/?country=CN'

pacman --noconfirm -S base-devel
pacman --noconfirm -S libsecret seahorse git-crypt
pacman --noconfirm -S zsh
pacman --noconfirm -S vim neovim
pacman --noconfirm -S openssh
# pacman --noconfirm -S clang
pacman --noconfirm -S go rust
pacman --noconfirm -S words
# pacman --noconfirm -S jdk9-openjdk openjdk9-src
# pacman --noconfirm -S mosh
pacman --noconfirm -S axel
pacman --noconfirm -S shellcheck
pacman --noconfirm -S highlight
pacman --noconfirm -S jq pv
# pacman --noconfirm -S nethogs
# pacman --noconfirm -S global # gtags
pacman --noconfirm -S universal-ctags-git # better ctags
pacman --noconfirm -S duf dua-cli htop
# pacman --noconfirm -S create_ap # Create AP
pacman --noconfirm -S fd exa bat ripgrep sd
pacman --noconfirm -S vivid
pacman --noconfirm -S xclip xsel rofi-greenclip
pacman --noconfirm -S man-pages
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

# Auto clean pacman cache
pacman --noconfirm -S pacman-contrib
systemctl daemon-reload
systemctl enable paccache.timer
systemctl start  paccache.timer

# A very simple screen locker for X
# https://tools.suckless.org/slock/
# https://wiki.archlinux.org/index.php/Slock
pacman --noconfirm -S slock
cat <<-'TOKEN' > /etc/systemd/system/slock@.service
[Unit]
Description=Lock X session using slock for user %i
Before=sleep.target

[Service]
User=%i
Environment=DISPLAY=:0
ExecStartPre=/usr/bin/xset dpms force suspend
ExecStart=/usr/bin/slock

[Install]
WantedBy=sleep.target
TOKEN
systemctl daemon-reload
systemctl start slock@wenxuan.service
systemctl enable slock@wenxuan.service

# paru --noconfirm -S icdiff # better diff
paru --noconfirm -S mmv-go
paru --noconfirm -S csview-git
paru --noconfirm -S code-minimap-git
paru --noconfirm -S clitrans-git
paru --noconfirm -S git-delta-git
paru --noconfirm -S sxiv # simple x image viewer
paru --noconfirm -S topgrade # upgrade all the things

# backgrounds
paru --noconfirm -S nitrogen # wallpaper manager
paru --noconfirm -S \
    gnome-backgrounds \
    mate-backgrounds \
    deepin-wallpapers \
    elementary-wallpapers \
    plasma-workspace-wallpapers \
    archlinux-wallpaper

# gtk theme
paru --noconfirm -S lxappearance # theme manager
paru --noconfirm -S arc-gtk-theme

# Cursor theme
paru --noconfirm -S vimix-cursors
su - wenxuan -c '
mkdir -p ~/.icons/default/ &&
printf "[Icon Theme]\nInherits=vimix-cursors\n" > ~/.icons/default/index.theme
'

# Grub theme
paru --noconfirm -S grub-theme-vimix-git
sed -i 's|^\s*#*\s*GRUB_THEME=.*|GRUB_THEME="/usr/share/grub/themes/Vimix/theme.txt"|' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

# Sddm theme
mkdir -p /etc/sddm.conf.d/ /usr/share/sddm/themes/sugar-candy
git clone --depth=1 https://framagit.org/MarianArlt/sddm-sugar-candy /tmp/sugar &&
    (cd /tmp/sugar && tar cf - --exclude .git . | tar xvf - -C /usr/share/sddm/themes/sugar-candy)
cp -b "$SCRIPT_DIR/sddm.conf" /etc/sddm.conf.d/sddm.conf

# Auto screen lock
paru --noconfirm -S xss-lock
