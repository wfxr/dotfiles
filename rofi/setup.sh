#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

SDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)" && cd "$SDIR"

mkdir -p ~/.config/rofi/
ln -sf "$SDIR/config.rasi" ~/.config/rofi/config.rasi

# setup greenclip config
cat <<-EOF >~/.config/greenclip.toml
[greenclip]
  blacklisted_applications = []
  enable_image_support = true
  max_history_length = 500
  history_file = "$HOME/.cache/greenclip.history"
  image_cache_directory = "/tmp/greenclip"
  max_selection_size_bytes = 0
  trim_space_from_selection = true
  use_primary_selection_as_input = false
  static_history = []
EOF
