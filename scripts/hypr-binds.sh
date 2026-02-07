#!/usr/bin/env bash

BINDS_FILE="$HOME/.config/hypr/binds.conf"

grep '^bind' "$BINDS_FILE" | sed 's/#.*//' | wofi \
  --show dmenu \
  --prompt "Keybindings:" \
  --width 750 \
  --lines 18 \
  --location center \
  --cache-file /dev/null
