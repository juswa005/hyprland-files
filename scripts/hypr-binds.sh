#!/usr/bin/env bash

BINDS_FILE="$HOME/.config/hypr/binds.conf"

grep '^bind' "$BINDS_FILE" | sed 's/#.*//' | wofi --dmenu \
  --dmenu \
  --placeholder "Keybindings:"
