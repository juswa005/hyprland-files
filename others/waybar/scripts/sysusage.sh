#!/usr/bin/env bash

# CPU usage
cpu=$(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5); print int(usage)}')

# RAM usage
ram=$(free -m | awk 'NR==2 {printf "%d%%", $3*100/$2}')

# Output
echo "CPU: $cpu% RAM: $ram"
