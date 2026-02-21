#!/usr/bin/env bash
# ~/.local/bin/applauncher.sh

LOCK="/tmp/fsel-apps.lock"
DEBOUNCE=0.1

# Prevent multiple instances
lockfile -r 0 "$LOCK" 2>/dev/null || exit 0
sleep "$DEBOUNCE"

# Launch FSEL with --cclip in Kitty with class and title for Hyprland
kitty --class fsel-clipboard --title fsel-clipboard fsel --cclip &

rm -f "$LOCK"
