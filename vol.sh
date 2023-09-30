#!/bin/bash

pactl -- set-sink-volume 0 ${1}10%

notify-send -r 1 -t 1000 "Volume: ${1}10%"
