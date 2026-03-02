#!/usr/bin/env bash

# Active workspace
active=$(hyprctl activeworkspace | awk '{print $2}')

# Get workspaces with windows
readarray -t nonempty < <(hyprctl workspaces | awk '
{
    for(i=1;i<=NF;i++){
        if($i ~ /^[0-9]+$/ && $(i+1) ~ /windows:/){
            if($(i+2)+0 > 0) print $i
        }
    }
}')

# Persistent workspace list (1–5)
persistent=(1 2 3 4 5)

# Build output string
output=""
for ws in "${persistent[@]}"; do
  if [[ "$ws" == "$active" ]]; then
    output+="[${ws}] " # active workspace highlighted
  elif [[ " ${nonempty[*]} " == *" $ws "* ]]; then
    output+="${ws} " # non-active but has windows
  else
    output+="${ws} " # empty workspace (normal style)
  fi
done

# Trim trailing space
output="${output%" "}"

# Output as JSON for Waybar
echo "{\"text\": \"$output\"}"
