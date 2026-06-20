#!/usr/bin/env bash

LOCK="/tmp/walker-anime-movies.lock"
DEBOUNCE=0.1

exec 9>"$LOCK" || exit 0
flock -n 9 || exit 0
sleep "$DEBOUNCE"

CHOICE=$(printf "Anime\nMovies" | wofi --dmenu -p "Watch")
LAUNCHER="$(dirname "$0")/launch-webapp.sh"

case "$CHOICE" in
Anime) "$LAUNCHER" "https://anikai.to" >/dev/null 2>&1 & ;;
Movies) "$LAUNCHER" "https://streamex.sh" >/dev/null 2>&1 & ;;
*) exit 0 ;;
esac
