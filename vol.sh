#!/bin/bash

pactl -- set-sink-volume 0 ${1}
level=$(pactl list sinks | grep "front-right:" | awk -F'[/,%]' '{print "Left:"$2"%\nRight:"$6"%"}')
echo 

notify-send \
    -i "/home/hazem/dotfiles/assets/volume.png" \
    -r 1 -t 1000 "Volume" "${level} \n ${1}"
