#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

cat <<-EOF > ~/.config/greenclip.toml
[greenclip]
  blacklisted_applications = []
  enable_image_support = true
  max_history_length = 50
  history_file = "$HOME/.cache/greenclip.history"
  image_cache_directory = "/tmp/greenclip"
  max_selection_size_bytes = 0
  trim_space_from_selection = true
  use_primary_selection_as_input = false
  static_history = []
EOF
