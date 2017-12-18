#!/usr/bin/env bash

[ "$(whoami)" != "root" ] && exec sudo -- "$0" "$@"
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
$SCRIPT_DIR/setup_ubuntu_base.sh

neofetch 2>/dev/null || screenfetch
echo "Done! Ubuntu server is ready!"
