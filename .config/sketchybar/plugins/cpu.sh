#!/bin/bash

# Much faster CPU monitoring using iostat (more efficient than ps)
CPU_PERCENT=$(iostat -c 1 -w 1 | tail -1 | awk '{print 100-$6}' | cut -d. -f1)

# Fallback to simpler ps method if iostat fails
if [[ -z "$CPU_PERCENT" || "$CPU_PERCENT" -lt 0 || "$CPU_PERCENT" -gt 100 ]]; then
    CPU_PERCENT=$(ps -A -o %cpu | awk '{s+=$1} END {printf "%.0f", s}')
fi

sketchybar --set cpu label="${CPU_PERCENT}%"
