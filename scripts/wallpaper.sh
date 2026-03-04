#!/usr/bin/env bash

WALL_DIR="$HOME/.config/hypr/wallpapers"
CACHE_FILE="$HOME/.cache/current_wallpaper"

[ ! -d "$WALL_DIR" ] && exit 1

# Get sorted list of wallpapers
mapfile -t WALLS < <(ls "$WALL_DIR"/wallp* 2>/dev/null | sort -V)

TOTAL=${#WALLS[@]}
[ "$TOTAL" -eq 0 ] && exit 1

# Read current index
if [ -f "$CACHE_FILE" ]; then
  CURRENT=$(cat "$CACHE_FILE")
else
  CURRENT=0
fi

# Move to next index
NEXT=$((CURRENT + 1))

# Loop back if exceeds total
if [ "$NEXT" -ge "$TOTAL" ]; then
  NEXT=0
fi

NEW_WALL="${WALLS[$NEXT]}"

# Restart swaybg
pkill -x swaybg
sleep 0.2
swaybg -i "$NEW_WALL" -m fill &

# Save new index
echo "$NEXT" >"$CACHE_FILE"
