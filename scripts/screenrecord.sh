#!/usr/bin/env bash

PIDFILE="/tmp/gpu-screen-recorder.pid"
OUTFILE="/tmp/gpu-screen-recorder.out"
RECORDINGS_DIR="$HOME/Videos/Recordings"

start_recording() {
  local mode="$1"
  local geom output pid audio_status
  local -a cmd

  if pgrep -f "^gpu-screen-recorder( |$)" >/dev/null; then
    notify-send "Screen Recorder" "Already recording."
    exit 0
  fi

  geom=$(slurp -f "%wx%h+%x+%y")
  [ -z "$geom" ] && exit 0

  output="$RECORDINGS_DIR/Screen_Rec_$(date +%Y-%m-%d_%H-%M-%S).mp4"
  cmd=(gpu-screen-recorder -w region -region "$geom" -f 60 -k h264 -c mp4 -o "$output")

  if [ "$mode" = "audio" ]; then
    cmd+=( -a default_output -ac aac )
    audio_status="Audio: ON (desktop)"
  elif [ "$mode" = "mic" ]; then
    cmd+=( -a default_input -ac aac )
    audio_status="Audio: ON (mic)"
  elif [ "$mode" = "both" ]; then
    cmd+=( -a default_output -a default_input -ac aac )
    audio_status="Audio: ON (desktop + mic)"
  else
    audio_status="Audio: OFF"
  fi

  "${cmd[@]}" &
  pid=$!

  printf '%s\n' "$pid" >"$PIDFILE"
  printf '%s\n' "$output" >"$OUTFILE"

  notify-send "Recording Started 🎥" "$audio_status"
}

stop_recording() {
  local pid output

  output=""
  [ -f "$OUTFILE" ] && output=$(<"$OUTFILE")

  if [ -f "$PIDFILE" ]; then
    pid=$(<"$PIDFILE")
    kill -INT "$pid" 2>/dev/null
    rm -f "$PIDFILE" "$OUTFILE"

    if [ -n "$output" ]; then
      notify-send "Recording Stopped 🛑" "Saved to:\n$output"
    else
      notify-send "Recording Stopped 🛑" "Saved recording."
    fi
  elif pgrep -f "^gpu-screen-recorder( |$)" >/dev/null; then
    pkill -INT -f "^gpu-screen-recorder( |$)"
    notify-send "Recording Stopped 🛑" "Stopped active recording."
  else
    notify-send "Screen Recorder" "No active recording."
  fi
}

case "$1" in
start-audio)
  start_recording audio
  ;;
start-mic)
  start_recording mic
  ;;
start-both)
  start_recording both
  ;;
start-noaudio)
  start_recording
  ;;
stop)
  stop_recording
  ;;
esac
