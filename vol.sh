#!/bin/bash

pactl -- set-sink-volume 0 ${1}

notify-send -i "/home/hazem/dotfiles/assets/volume.png" -r 1 -t 1000 "Volume" " ${1}"
