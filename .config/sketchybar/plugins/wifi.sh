#!/usr/bin/env sh

LABEL="$(networksetup -listallhardwareports | awk '/Wi-Fi/{getline; print $2}' | xargs networksetup -getairportnetwork)"

if [[ "$LABEL" == *"You are not associated with an AirPort network."* ]]; then
   sketchybar --set wifi label="Disconnected"
else
   LABEL=$(echo "$LABEL" | sed "s/Current Wi-Fi Network: //")
   if [[ ${#LABEL} -gt 3 ]]; then
      SHORTLABEL=$(echo "$LABEL" | cut -c 1-3)
      SHORTLABEL="$SHORTLABEL*"
      sketchybar --set wifi label="$SHORTLABEL"
   else
      sketchybar --set wifi label="$LABEL"
   fi
fi
