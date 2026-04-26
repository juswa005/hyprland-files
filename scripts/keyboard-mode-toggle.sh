#!/usr/bin/env bash

set -euo pipefail

config="${HOME}/.config/hypr/inputs.conf"
pattern='kb_options = altwin:swap_alt_win'

notify() {
  notify-send "Keyboard Mode" "$1"
}

if ! grep -Eq "^[[:space:]#]*${pattern}" "$config"; then
  notify "Could not find the Mac keyboard toggle line in inputs.conf."
  exit 1
fi

if grep -Eq "^[[:space:]]*#[[:space:]]*${pattern}" "$config"; then
  sed -i "s/^\([[:space:]]*\)#[[:space:]]*\(${pattern}.*\)$/\1\2/" "$config"
  message="Mech keyboard mode enabled."
else
  sed -i "s/^\([[:space:]]*\)\(${pattern}.*\)$/\1# \2/" "$config"
  message="Laptop keyboard mode enabled."
fi

if hyprctl reload >/dev/null 2>&1; then
  notify "$message"
else
  notify "$message Reload failed."
  exit 1
fi
