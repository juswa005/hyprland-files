#!/usr/bin/env bash

LOCK="/tmp/wofi-apps.lock"
DEBOUNCE=0.1

lockfile -r 0 "$LOCK" 2>/dev/null || exit 0
sleep "$DEBOUNCE"

wofi --show drun --prompt "Apps"

rm -f "$LOCK"

