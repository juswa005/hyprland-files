#!/usr/bin/env bash

# Check if Waybar is running
WAYBAR_PID=$(pgrep -x waybar)

if [ -z "$WAYBAR_PID" ]; then
  # Start Waybar if it's not running
  waybar &
else
  # Otherwise, kill it to hide
  kill "$WAYBAR_PID"
fi
