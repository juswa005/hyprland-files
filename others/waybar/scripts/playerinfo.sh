#!/bin/bash

text=$(playerctl metadata --format '{{artist}} - {{title}}' 2>/dev/null || echo "")
maxlength=35
# if the text is longer than the max length, truncate it and add "..."
if [ ${#text} -gt $maxlength ]; then
    text=${text:0:$maxlength-3}"..."
fi

if [ -n "$text" ]; then
    playerctl metadata --format '{"text": "'"$text"'", "tooltip": "{{playerName}} : {{artist}} - {{title}}", "class": "playing"}' 2>/dev/null
else
    echo '{"text": "", "tooltip": "No music playing", "class": "stopped"}'
fi