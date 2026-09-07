#!/usr/bin/env bash
set -euo pipefail

SDIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)

info() { printf "%b[info]%b %s\n" '\e[0;32m\033[1m' '\e[0m' "$*" >&2; }
warn() { printf "%b[warn]%b %s\n" '\e[0;33m\033[1m' '\e[0m' "$*" >&2; }
erro() { printf "%b[erro]%b %s\n" '\e[0;31m\033[1m' '\e[0m' "$*" >&2; }

if ! command -v ly-dm >/dev/null 2>&1; then
    erro 'Ly is not installed. Install it with: sudo pacman -S ly'
    exit 1
fi

if (( EUID != 0 )); then
    exec sudo bash "$SDIR/setup.sh" "$@"
fi

install -Dm644 -o root -g root "$SDIR/config.ini" /etc/ly/config.ini
install -Dm755 -o root -g root "$SDIR/startup.sh" /etc/ly/startup.sh

# Enable Ly for the next boot without interrupting the current session.
systemctl enable ly@tty1.service

info 'Ly configured on tty1. Reboot when ready, then select Hyprland and log in.'
