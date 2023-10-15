#!/bin/bash

total=60
for ((i=total; i>=0; i--)); do
    echo "#remaining $i seconds"
    echo "scale=2; $i / $total * 100" | bc
    sleep 1
done | zenity --progress \
  --title="Timer $total seconds" \
  --text="timer is running for $total seconds..." \
  --percentage=0

if [ "$?" = -1 ] ; then
        zenity --error \
          --text="Update canceled."
fi

