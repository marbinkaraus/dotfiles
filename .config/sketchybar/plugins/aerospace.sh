#!/usr/bin/env bash

# make sure it's executable with:
# chmod +x ~/.config/sketchybar/plugins/aerospace.sh

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    sketchybar --set $NAME background.drawing=on label.color=0xFF89dceb
else
    sketchybar --set $NAME background.drawing=off label.color=0xFFcdd6f4
fi