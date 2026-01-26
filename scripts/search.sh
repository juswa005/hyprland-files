#!/usr/bin/env bash

LOCK="/tmp/wofi-google.lock"
DEBOUNCE=0.1

# Prevent multiple instances
exec 9>"$LOCK" || exit 0
flock -n 9 || exit 0
sleep "$DEBOUNCE"

# Wofi dmenu mode with only a textbox
QUERY=$(wofi --dmenu -p "Search Google" --lines 1)

# Exit if nothing typed
[ -z "$QUERY" ] && rm -f "$LOCK" && exit 0

# Encode spaces as +
ENCODED_QUERY=$(printf '%s' "$QUERY" | sed 's/ /+/g')

# Open in Chromium webapp mode
chromium --app="https://www.google.com/search?q=$ENCODED_QUERY" \
         --class=google-webapp \
         --new-window >/dev/null 2>&1 &

# Remove lock
rm -f "$LOCK"

