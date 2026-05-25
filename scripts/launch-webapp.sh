#!/bin/bash

# Launch a website in helium-browser webapp mode
URL="$1"

if [ -z "$URL" ]; then
  echo "Usage: launch-webapp <URL>"
  exit 1
fi

helium-browser --app="$URL" &
#brave --app="$URL" &
#vivaldi --app="$URL" &
