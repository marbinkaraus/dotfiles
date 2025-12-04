#!/usr/bin/env sh

# Get current Wi-Fi network using system_profiler (more reliable than networksetup)
LABEL="$(system_profiler SPAirPortDataType | awk '/Current Network Information:/{getline; if($0 ~ /:$/) {gsub(/:$/, ""); gsub(/^[[:space:]]+/, ""); print; exit}}')"

# If no network found, try alternative method
if [[ -z "$LABEL" ]]; then
    LABEL="$(system_profiler SPAirPortDataType | grep -A 1 "Current Network Information:" | grep -E "^\s+[^:]+:$" | head -1 | sed 's/^[[:space:]]*//' | sed 's/:$//')"
fi

if [[ -z "$LABEL" ]]; then
   sketchybar --set wifi label="Disconnected"
else
   if [[ ${#LABEL} -gt 3 ]]; then
      SHORTLABEL=$(echo "$LABEL" | cut -c 1-3)
      SHORTLABEL="$SHORTLABEL*"
      sketchybar --set wifi label="$SHORTLABEL"
   else
      sketchybar --set wifi label="$LABEL"
   fi
fi
