#!/usr/bin/env bash

LOCK="/tmp/wofi-apps.lock"
DEBOUNCE=0.1

exec 9>"$LOCK" || exit 0
flock -n 9 || exit 0
sleep "$DEBOUNCE"

wofi --show drun --prompt "Apps"

