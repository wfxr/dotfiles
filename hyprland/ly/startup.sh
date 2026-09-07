#!/usr/bin/env bash
set -euo pipefail

# OSC P programs the Linux console palette. Other terminals use different APIs.
[[ ${TERM:-} == linux ]] || exit 0

# Write to Ly's controlling terminal even when stdout is sent to the journal.
exec > /dev/tty

# Catppuccin Frappe: normal ANSI slots, then their bright counterparts.
# Use lavender in the magenta slots for the login box border.
COLORS=(
    303446 E78284 A6D189 E5C890 8CAAEE BABBF1 81C8BE C6D0F5
    626880 E78284 A6D189 E5C890 8CAAEE BABBF1 81C8BE C6D0F5
)

for IDX in "${!COLORS[@]}"; do
    printf '\033]P%x%s' "$IDX" "${COLORS[$IDX]}"
done

# Select the palette's text/background slots and clear old screen contents.
printf '\033[0;37;40m\033[2J\033[H'
