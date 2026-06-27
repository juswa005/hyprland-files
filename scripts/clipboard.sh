#!/bin/bash

# Use cliphist and wofi
cliphist list | wofi -S dmenu -p "Clipboard" | cliphist decode | wl-copy
