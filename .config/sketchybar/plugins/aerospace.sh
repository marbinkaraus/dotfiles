#!/usr/bin/env bash

WORKSPACE=$((1 + $1))

# Single optimized aerospace call to get all info at once
WINDOWS_INFO=$(aerospace list-windows --workspace $WORKSPACE --format '%{app-bundle-id}' 2>/dev/null)
# Properly check if workspace has windows (empty string means no windows)
if [[ -n "$WINDOWS_INFO" && "$WINDOWS_INFO" != "" ]]; then
    HAS_WINDOWS=1
    FINDER_OPEN=$(echo "$WINDOWS_INFO" | grep -q "com.apple.finder" && echo "true" || echo "")
else
    HAS_WINDOWS=0
    FINDER_OPEN=""
fi

# Proper color-based workspace indication
if [ "$WORKSPACE" = "$FOCUSED_WORKSPACE" ]; then
    if [ "$FINDER_OPEN" ]; then
        sketchybar --set $NAME label.drawing=on label.color=0xffe9897c icon.color=0xffe9897c
    else
        sketchybar --set $NAME label.drawing=off label.color=0xffe9897c icon.color=0xffe9897c
    fi
else
    if [ "$HAS_WINDOWS" -eq 1 ]; then
        if [ "$FINDER_OPEN" ]; then
            sketchybar --set $NAME label.drawing=on label.color=0xff8f7a91 icon.color=0xff8f7a91
        else
            sketchybar --set $NAME label.drawing=off label.color=0xff8f7a91 icon.color=0xff8f7a91
        fi
    else
        sketchybar --set $NAME label.drawing=off icon.color=0xff6f5a71
    fi
fi
