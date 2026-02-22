#!/usr/bin/env bash

PIDFILE="/tmp/wf-recorder.pid"
OUTPUT="$HOME/Videos/Recordings/Screen_Rec_$(date +%Y-%m-%d_%H-%M-%S).mp4"

start_recording() {
  MODE="$1"

  # Prevent duplicates
  if pgrep -x wf-recorder >/dev/null; then
    notify-send "Screen Recorder" "Already recording."
    exit 0
  fi

  # Area selection
  GEOM=$(slurp)
  [ -z "$GEOM" ] && exit 0

  CMD="wf-recorder -g \"$GEOM\" -f \"$OUTPUT\" -r 60 --muxer=mp4 -c libx264 -x yuv420p"

  if [ "$MODE" = "audio" ]; then
    CMD="$CMD -a" # captures microphone
    AUDIO_STATUS="Audio: ON (mic)"
  else
    AUDIO_STATUS="Audio: OFF"
  fi

  eval "$CMD" &
  echo $! >"$PIDFILE"

  notify-send "Recording Started 🎥" "$AUDIO_STATUS"
}

stop_recording() {
  if [ -f "$PIDFILE" ]; then
    kill "$(cat "$PIDFILE")" 2>/dev/null
    rm -f "$PIDFILE"
    notify-send "Recording Stopped 🛑" "Saved to:\n$OUTPUT"
  else
    pkill -x wf-recorder
    notify-send "Screen Recorder" "No active recording."
  fi
}

case "$1" in
start-audio)
  start_recording audio
  ;;
start-noaudio)
  start_recording
  ;;
stop)
  stop_recording
  ;;
esac
