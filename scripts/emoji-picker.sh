#!/usr/bin/env bash

LOCK="/tmp/wofi-emoji.lock"
DEBOUNCE=0.1

exec 9>"$LOCK" || exit 0
flock -n 9 || exit 0
sleep "$DEBOUNCE"

EMOJI=$(printf '%s\n' \
  "😀 grinning face" \
  "😂 face with tears of joy" \
  "😊 smiling face" \
  "😍 heart eyes" \
  "🤔 thinking face" \
  "😭 loudly crying face" \
  "😎 smiling face with sunglasses" \
  "🔥 fire" \
  "✨ sparkles" \
  "🎉 party popper" \
  "👍 thumbs up" \
  "👎 thumbs down" \
  "👏 clapping hands" \
  "🙌 raising hands" \
  "🙏 folded hands" \
  "💀 skull" \
  "💯 hundred points" \
  "❤️ red heart" \
  "💔 broken heart" \
  "✅ check mark" \
  "❌ cross mark" \
  "⭐ star" \
  "🌙 crescent moon" \
  "🍀 four leaf clover")

SELECTION=$(printf '%s\n' "$EMOJI" | wofi --dmenu -p "Emoji")
[ -z "$SELECTION" ] && exit 0

EMOJI_CHAR=${SELECTION%% *}
printf '%s' "$EMOJI_CHAR" | wl-copy

if command -v wtype >/dev/null 2>&1; then
  wtype "$EMOJI_CHAR"
fi
