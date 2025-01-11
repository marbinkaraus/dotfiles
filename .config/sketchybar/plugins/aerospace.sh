#!/usr/bin/env bash

WORKSPACE=$((1 + $1))
HAS_WINDOWS=$(aerospace list-windows --workspace $WORKSPACE --count)
FINDER_OPEN=$(aerospace list-windows --workspace $WORKSPACE --app-bundle-id com.apple.finder)

if [ "$WORKSPACE" = "$FOCUSED_WORKSPACE" ]; then
    if [ "$FINDER_OPEN" ]; then
        sketchybar --set $NAME label.drawing=on label.color=0xffe9897c icon.color=0xffe9897c
    else
        sketchybar --set $NAME label.drawing=off label.color=0xffe9897c icon.color=0xffe9897c
    fi
else
    if [ "$HAS_WINDOWS" -gt 0 ]; then  # Using > 1 because the command returns a header line
        if [ "$FINDER_OPEN" ]; then
            sketchybar --set $NAME label.drawing=on label.color=0xff8f7a91 icon.color=0xff8f7a91  # original darker color when empty
        else
            sketchybar --set $NAME label.drawing=off label.color=0xff8f7a91 icon.color=0xff8f7a91  # original darker color when empty
        fi
    else
        sketchybar --set $NAME label.drawing=off icon.color=0xff6f5a71  # original darker color when empty
    fi
fi
