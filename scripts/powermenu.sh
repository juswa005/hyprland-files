#!/usr/bin/env bash

LOCK="/tmp/wofi-power.lock"
DEBOUNCE=0.1

exec 9>"$LOCK" || exit 0
flock -n 9 || exit 0
sleep "$DEBOUNCE"

CHOICE=$(printf "Shutdown\nReboot" | wofi --dmenu --prompt "Power Options" --lines 3 --width 200 --location center)

case "$CHOICE" in
Shutdown) systemctl poweroff ;;
Reboot) systemctl reboot ;;
*) ;;
esac
