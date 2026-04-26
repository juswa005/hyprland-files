#!/usr/bin/env bash

set -euo pipefail

lang="${TESSERACT_LANG:-eng}"

notify() {
  if command -v notify-send >/dev/null 2>&1; then
    notify-send "OCR Capture" "$1"
  else
    printf '%s\n' "$1" >&2
  fi
}

require() {
  local cmd="$1"

  if ! command -v "$cmd" >/dev/null 2>&1; then
    if [[ "$cmd" == "tesseract" ]]; then
      notify "Missing $cmd. Install it with: sudo pacman -S tesseract tesseract-data-eng"
    else
      notify "Missing dependency: $cmd"
    fi

    exit 1
  fi
}

require grim
require slurp
require wl-copy
require tesseract

image_file="$(mktemp --suffix .png)"
trap 'rm -f "$image_file"' EXIT

geometry="$(slurp)" || exit 0
[[ -n "$geometry" ]] || exit 0

grim -g "$geometry" "$image_file"

if ! text="$(tesseract "$image_file" stdout -l "$lang" 2>/dev/null)"; then
  notify "OCR failed"
  exit 1
fi

if [[ -z "${text//[[:space:]]/}" ]]; then
  notify "No text detected"
  exit 1
fi

printf '%s' "$text" | wl-copy
notify "Text copied to clipboard"
