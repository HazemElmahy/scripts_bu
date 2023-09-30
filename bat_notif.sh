#!/bin/bash

CAPACITY=$(cat /sys/class/power_supply/BAT0/capacity)

STATUS=$(cat /sys/class/power_supply/BAT0/status)

[ "$STATUS" = "Discharging" ] && [ "$CAPACITY" -lt 90 ] && \

/usr/bin/notify-send -u critical -a power_supply_low "Low Battery" "You are running low on battery ($CAPACITY%).\nPlease plug in the charger." && \

echo "Low Battery notification sent" && $(paplay .config/dunst/notifications/sounds/clearly.ogg) || \
echo "Low Battery notification not sent"
