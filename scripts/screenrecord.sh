#!/bin/bash

PIDFILE="/tmp/wl-screenrec.pid"
OUTDIR="$HOME/Videos/Recordings"

mkdir -p "$OUTDIR"

if [ -f "$PIDFILE" ]; then
  kill "$(cat "$PIDFILE")" && rm "$PIDFILE"
  command -v notify-send >/dev/null && notify-send "🎥 Screen recording stopped"
else
  FILE="$OUTDIR/recording_$(date +%Y-%m-%d_%H-%M-%S).mp4"
  GEOM=$(slurp)

  wl-screenrec \
    --geometry "$GEOM" \
    --output "$FILE" &

  echo $! >"$PIDFILE"
  command -v notify-send >/dev/null && notify-send "⏺️ Screen recording started"
fi
