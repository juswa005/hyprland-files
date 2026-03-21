#!/bin/bash

# Get current profile
current=$(powerprofilesctl get)

# Available profiles
profiles="performance
balanced
power-saver"

# Show Wofi menu with current profile in the prompt
choice=$(echo "$profiles" | wofi --dmenu --prompt "Power Mode: ( $current) " --lines 4 --width 350 --location center)

# Apply selection if a choice was made
if [[ -n "$choice" ]]; then
  powerprofilesctl set "$choice"
  notify-send "Power Mode" "Switched to $choice"
fi
