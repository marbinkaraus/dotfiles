#!/bin/bash

SPACE_ICONS=("~" "1:DEV" "2:WEB" "3:CHAT" "4:NOTES" "5:MUSIC")

sketchybar --add event aerospace_workspace_change

for sid in "${!SPACE_ICONS[@]}"; do
    sketchybar --add item space.$sid left \
        --subscribe space.$sid aerospace_workspace_change \
        --set space.$sid \
        background.color=$BG_SEC_COLR \
        background.corner_radius=8 \
        background.height=23 \
        background.drawing=off \
        label="${SPACE_ICONS[$sid]}" \
        label.padding_right=8 \
        label.padding_left=-5 \
        click_script="aerospace workspace $sid" \
        script="$CONFIG_DIR/plugins/aerospace.sh $sid"
done

sketchybar --add item space_separator_left left \
           --set space_separator_left icon= \
                                 icon.font="$FONT:Bold:16.0" \
                                 background.padding_left=0 \
                                 background.padding_right=10 \
                                 label.drawing=off \
                                 icon.color=$DARK_WHITE
