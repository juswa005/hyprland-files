#!/bin/bash

bar="▁▂▃▄▅▆▇█"
dict="s/;//g;"

# creating "dictionary" to replace char with bar
i=0
while [ $i -lt ${#bar} ]
do
    dict="${dict}s/$i/${bar:$i:1}/g;"
    i=$((i=i+1))
done

# write cava config
config_file="/tmp/waybar_cava_config"
echo "
[general]
bars = 18

[output]
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = 7
" > $config_file

# read stdout from cava and output as JSON
cava -p $config_file | while read -r line; do
    if [ -z "${line//[0;]/}" ]; then
        echo "{\"text\": \"\", \"tooltip\": \"\"}"
    else
        output=$(echo "$line" | sed "$dict")
        echo "{\"text\": \"$output\", \"tooltip\": \"Audio Visualizer\"}"
    fi
done