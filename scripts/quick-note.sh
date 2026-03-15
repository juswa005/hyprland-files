#!/bin/bash
# ~/.config/hypr/scripts/nvim-floating.sh

# Create notes directory if it doesn't exist
NOTES_DIR="$HOME/Notes"
mkdir -p "$NOTES_DIR"

# Generate filename with today's date (YYYY-MM-DD format)
FILENAME="$NOTES_DIR/$(date +%Y-%m-%d-%H:%M).txt"

# Launch kitty with nvim opening the dated file
hyprctl dispatch exec "[float; size 1000 600; move 70% 5%] kitty --class floating-nvim -e nvim '$FILENAME'"
