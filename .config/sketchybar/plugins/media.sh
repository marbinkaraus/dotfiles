#!/bin/bash

STATE="$(echo "$INFO" | jq -r '.state')"

if [ "$STATE" = "playing" ]; then
  MEDIA="$(echo "$INFO" | jq -r '.app + ": " + .title + " - " + .artist')"
  sketchybar --set media label="$MEDIA" label.drawing=on icon.drawing=on
else
  sketchybar --set media label.drawing=off icon.drawing=off
fi
