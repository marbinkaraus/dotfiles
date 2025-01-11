#!/bin/bash

case "$NAME" in
    "day")
        sketchybar --set "$NAME" label="$(date '+%a')"
        ;;
    "date")
        sketchybar --set "$NAME" label="$(date '+%d' | sed s/^0//)"
        ;;
    "month")
        sketchybar --set "$NAME" label="$(date '+%b')"
        ;;
    "date_month")
        sketchybar --set "$NAME" label="$(date '+%d %b' | sed s/^0//)"
esac 
