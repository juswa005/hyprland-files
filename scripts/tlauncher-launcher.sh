#!/bin/bash

# Options
choice=$(printf "Normal\nNVIDIA (prime-run)\nNVIDIA (env)\n" | wofi --dmenu --prompt "Launch TLauncher")

case "$choice" in
"Normal")
  java -jar ~/Games/tl.jar
  ;;
"NVIDIA (prime-run)")
  prime-run java -jar ~/Games/tl.jar
  ;;
"NVIDIA (env)")
  env __NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia java -jar ~/Games/tl.jar
  ;;
esac
