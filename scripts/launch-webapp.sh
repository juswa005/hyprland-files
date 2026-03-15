#!/bin/bash

# Launch a website in Chromium webapp mode
URL="$1"

if [ -z "$URL" ]; then
  echo "Usage: launch-webapp <URL>"
  exit 1
fi

chromium --app="$URL" &
#brave --app="$URL" &
#vivaldi --app="$URL" &
