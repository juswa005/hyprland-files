#!/usr/bin/env bash

# Only send notification if Spotify is running and playing
status=$(playerctl --player=spotify status 2>/dev/null)
if [[ "$status" == "Playing" ]]; then
  song=$(playerctl --player=spotify metadata --format '{{ artist }} - {{ title }}')
  notify-send "Spotify" "$song" -i spotify
fi
