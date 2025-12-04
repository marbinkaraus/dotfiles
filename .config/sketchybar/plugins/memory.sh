#!/usr/bin/env sh

# Faster memory monitoring using simplified approach
MEMORY_PERCENTAGE=$(ps -A -o %mem | awk '{s+=$1} END {printf "%.0f", s}')

# Quick validation and fallback
if [[ -z "$MEMORY_PERCENTAGE" || "$MEMORY_PERCENTAGE" -lt 0 || "$MEMORY_PERCENTAGE" -gt 100 ]]; then
    # Simple vm_stat based calculation
    VM_STAT=$(vm_stat | head -5)
    FREE=$(echo "$VM_STAT" | awk '/free:/ {print $3}' | sed 's/\.//')
    TOTAL_PAGES=$(echo "$VM_STAT" | awk '/Pages free:/ {free=$3} /Pages active:/ {active=$3} /Pages inactive:/ {inactive=$3} /Pages wired/ {wired=$4} END {print (free+active+inactive+wired)}')
    MEMORY_PERCENTAGE=$(((TOTAL_PAGES - FREE) * 100 / TOTAL_PAGES))
fi

# Use sketchybar's dynamic properties instead of manual color setting
sketchybar --set memory label="${MEMORY_PERCENTAGE}%"
