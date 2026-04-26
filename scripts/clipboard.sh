#!/bin/bash

set -euo pipefail

raw_entries=$(mktemp)
display_entries=$(mktemp)
trap 'rm -f "$raw_entries" "$display_entries"' EXIT

cliphist list > "$raw_entries"

if [[ ! -s "$raw_entries" ]]; then
  exit 0
fi

while IFS= read -r line; do
  id=${line%%$'\t'*}
  preview=${line#*$'\t'}

  if [[ "$preview" == "$line" ]]; then
    preview=""
  fi

  preview=${preview//$'\n'/ }

  if (( ${#preview} > 120 )); then
    preview="${preview:0:117}..."
  fi

  printf '%s\t%s\n' "$id" "$preview" >> "$display_entries"
done < "$raw_entries"

selection=$(wofi --dmenu \
  --prompt "Clipboard" \
  --lines 12 \
  --width 700 \
  --height 420 \
  --location center \
  --insensitive \
  --hide-scroll \
  --cache-file /dev/null < "$display_entries") || exit 0

[[ -n "$selection" ]] || exit 0

selected_id=${selection%%$'\t'*}
selected_line=""

while IFS= read -r line; do
  if [[ "$line" == "$selected_id"$'\t'* ]]; then
    selected_line=$line
    break
  fi
done < "$raw_entries"

[[ -n "$selected_line" ]] || exit 1

printf '%s\n' "$selected_line" | cliphist decode | wl-copy
