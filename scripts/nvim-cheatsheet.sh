#!/usr/bin/env bash

LOCK="/tmp/wofi-nvim-cheatsheet.lock"
DEBOUNCE=0.1

exec 9>"$LOCK" || exit 0
flock -n 9 || exit 0
trap 'rm -f "$LOCK"' EXIT
sleep "$DEBOUNCE"

cat <<'EOF' | wofi \
  --show dmenu \
  --prompt "nvim" \
  --width 850 \
  --lines 18 \
  --location center \
  --cache-file /dev/null
Type to filter. Press Esc to close.
normal mode: Esc
insert mode: i / a / o
visual mode: v / V / Ctrl-v
save and quit: :w / :q / :wq / :qa!
move: h j k l / w b e / 0 $
top and bottom: gg / G
search: /pattern then n / N
search word under cursor: * / #
undo: u
redo: Ctrl-r
copy line: yy
copy selection: y
paste: p / P
delete line: dd
change inner word: ciw
repeat last change: .
splits: :split / :vsplit
jump between splits: Ctrl-w h j k l
tabs: :tabnew / gt / gT
terminal: :terminal
EOF
