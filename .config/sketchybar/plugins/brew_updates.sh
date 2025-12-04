#!/usr/bin/env sh

# Check for Homebrew updates
if ! command -v brew &> /dev/null; then
    sketchybar --set brew_updates icon.drawing=off label.drawing=off
    exit 0
fi

# Get outdated packages count
OUTDATED_COUNT=$(brew outdated --quiet | wc -l | tr -d ' ')

if [[ "$OUTDATED_COUNT" -gt 0 ]]; then
    sketchybar --set brew_updates \
        icon="􀐚" \
        label="$OUTDATED_COUNT" \
        label.color="0xffad7fa8" \
        icon.drawing=on \
        label.drawing=on
else
    sketchybar --set brew_updates icon.drawing=off label.drawing=off
fi
