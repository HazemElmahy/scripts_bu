#!/bin/bash

# Set the starting coordinates of the circle
start_x=960
start_y=152

# Set the radius of the circle
radius=5.02

# Calculate the angle increment for each step
angle_increment=$((360 / 110))

# Loop through the steps and move the cursor to draw the circle
xdotool mousemove $start_x $start_y
xdotool mousedown 2

x=0
y=0
for ((i = 0; i <= 1000; i += angle_increment)); do
    radians=$(bc -l <<< "scale=2; ($i)* (3.14159265358979323846 / 180)")
    echo $radians
    x=$(bc -l <<< "scale=2; $radius * c($radians)")
    y=$(bc -l <<< "scale=2; $radius * s($radians)")
    echo $x $y
    xdotool mousemove_relative -- $x $y
    sleep 0.0001
done
xdotool mouseup 2


