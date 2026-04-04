#!/usr/bin/env bash

set -euo pipefail

notify() {
  notify-send "Hypridle" "$1"
}

is_running() {
  pgrep -x hypridle >/dev/null
}

disable_hypridle() {
  if is_running; then
    pkill -x hypridle
    notify "Disabled. Idle lock will not trigger."
  else
    notify "Already disabled."
  fi
}

enable_hypridle() {
  if is_running; then
    notify "Already enabled."
  else
    nohup hypridle >/dev/null 2>&1 &
    notify "Enabled. Idle lock is active again."
  fi
}

case "${1:-}" in
  disable)
    disable_hypridle
    ;;
  enable)
    enable_hypridle
    ;;
  *)
    notify "Usage: ${0##*/} {disable|enable}"
    exit 1
    ;;
esac
