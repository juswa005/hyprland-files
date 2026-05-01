#!/usr/bin/env bash

LOCK="/tmp/wofi-tmux-cheatsheet.lock"
DEBOUNCE=0.1

exec 9>"$LOCK" || exit 0
flock -n 9 || exit 0
trap 'rm -f "$LOCK"' EXIT
sleep "$DEBOUNCE"

cat <<'EOF' | wofi \
  --show dmenu \
  --prompt "tmux" \
  --width 800 \
  --lines 18 \
  --location center \
  --cache-file /dev/null
Type to filter. Press Esc to close.
prefix: Ctrl-b
new or attach session: tmux new -As main
detach session: prefix d
list sessions: prefix s
rename session: prefix $
command prompt: prefix :
vertical split: prefix %
horizontal split: prefix "
move between panes: prefix o or prefix arrows
resize pane: prefix Ctrl-arrow
zoom pane: prefix z
close pane: prefix x
new window: prefix c
switch windows: prefix n / p / 0-9
rename window: prefix ,
close window: prefix &
copy mode: prefix [
copy selection: Space then Enter
cycle layouts: prefix Space
EOF
