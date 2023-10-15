#!/bin/bash

subject=$(:| dmenu -p "Subject:")
minutes=$(:| dmenu -p "Minutes:")

/home/hazem/scripts/alarm/alarm.out -t "$minutes" -s "$subject"
notify-send "Tracker" "Subject: $subject\nTime: $minutes minutes"
