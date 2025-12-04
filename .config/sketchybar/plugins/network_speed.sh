#!/usr/bin/env sh

# Optimized network speed monitor with cached interface
CACHE_INTERFACE_FILE="/tmp/sketchybar_interface_cache"

# Cache interface detection for better performance
if [[ ! -f "$CACHE_INTERFACE_FILE" || $(($(date +%s) - $(stat -f %m "$CACHE_INTERFACE_FILE" 2>/dev/null || echo 0))) -gt 300 ]]; then
    INTERFACE=$(route get default 2>/dev/null | awk '/interface:/ {print $2}')
    [[ -z "$INTERFACE" ]] && INTERFACE="en0"
    echo "$INTERFACE" > "$CACHE_INTERFACE_FILE"
else
    INTERFACE=$(cat "$CACHE_INTERFACE_FILE")
fi

# Get current bytes more efficiently
NETSTAT_OUTPUT=$(netstat -I "$INTERFACE" | tail -1)
RX_BYTES=$(echo "$NETSTAT_OUTPUT" | awk '{print $7}')
TX_BYTES=$(echo "$NETSTAT_OUTPUT" | awk '{print $10}')

# File to store previous values
CACHE_FILE="/tmp/sketchybar_network_cache"

if [[ -f "$CACHE_FILE" ]]; then
    PREV_DATA=$(cat "$CACHE_FILE")
    PREV_RX=$(echo "$PREV_DATA" | cut -d',' -f1)
    PREV_TX=$(echo "$PREV_DATA" | cut -d',' -f2)
    PREV_TIME=$(echo "$PREV_DATA" | cut -d',' -f3)
    
    CURRENT_TIME=$(date +%s)
    TIME_DIFF=$((CURRENT_TIME - PREV_TIME))
    
    if [[ $TIME_DIFF -gt 0 ]]; then
        RX_DIFF=$((RX_BYTES - PREV_RX))
        TX_DIFF=$((TX_BYTES - PREV_TX))
        
        if [[ $RX_DIFF -ge 0 && $TX_DIFF -ge 0 ]]; then
            RX_SPEED=$((RX_DIFF / TIME_DIFF))
            TX_SPEED=$((TX_DIFF / TIME_DIFF))
            
            # Convert to human readable format
            if [[ $RX_SPEED -gt 1048576 ]]; then
                RX_DISPLAY="$(echo "scale=1; $RX_SPEED / 1048576" | bc)MB/s"
            elif [[ $RX_SPEED -gt 1024 ]]; then
                RX_DISPLAY="$(echo "scale=1; $RX_SPEED / 1024" | bc)KB/s"
            else
                RX_DISPLAY="${RX_SPEED}B/s"
            fi
            
            if [[ $TX_SPEED -gt 1048576 ]]; then
                TX_DISPLAY="$(echo "scale=1; $TX_SPEED / 1048576" | bc)MB/s"
            elif [[ $TX_SPEED -gt 1024 ]]; then
                TX_DISPLAY="$(echo "scale=1; $TX_SPEED / 1024" | bc)KB/s"
            else
                TX_DISPLAY="${TX_SPEED}B/s"
            fi
            
            # Create two separate items for download and upload
            sketchybar --set network_speed_down label="↓${RX_DISPLAY}"
            sketchybar --set network_speed_up label="↑${TX_DISPLAY}"
        fi
    fi
fi

# Save current values
echo "${RX_BYTES},${TX_BYTES},$(date +%s)" > "$CACHE_FILE"
