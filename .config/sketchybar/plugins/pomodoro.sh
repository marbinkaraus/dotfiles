#!/bin/bash

# Add debug logging
echo "Script triggered with SENDER=$SENDER BUTTON=$BUTTON" >> /tmp/pomodoro_debug.log

POPUP_DURATION=5

# File to store timer data
TIMER_FILE="/tmp/sketchybar_pomodoro"

SOUND_FILE="$HOME/.config/sketchybar/sounds/beep.mp3"

POMODORO_ICON=

create_timer_dialog() {
    osascript <<EOF
        tell application "System Events"
            activate
            set timeOptions to {"40 minutes", "30 minutes", "25 minutes", "5 minutes", "1 minute"}
            set dialogResult to (choose from list timeOptions with prompt "Select Timer Duration" with title "Pomodoro Timer" default items {"25 minutes"} OK button name "Start" cancel button name "Cancel")
            
            if dialogResult is false then
                return "cancel"
            else
                return (item 1 of dialogResult)
            end if
        end tell
EOF
}

start_timer() {
    local duration=$1
    echo "$duration $(date +%s)" > "$TIMER_FILE"
    sketchybar --set pomodoro icon.drawing=off label.drawing=on drawing=on
}

handle_click() {
    # Add debug logging
    echo "handle_click called with BUTTON=$BUTTON" >> /tmp/pomodoro_debug.log
    
    case "$BUTTON" in
        "right")
            # Stop timer and show tomato again
            rm -f "$TIMER_FILE"
            sketchybar --set pomodoro label="" label.drawing=off icon.drawing=on
            return
            ;;
        "left"|*)
            # Show duration selection dialog
            response=$(create_timer_dialog)
            
            case $response in
                "40 minutes") start_timer $((40 * 60)) ;;
                "30 minutes") start_timer $((30 * 60)) ;;
                "25 minutes") start_timer $((25 * 60)) ;;
                "5 minutes") start_timer $((5 * 60)) ;;
                "1 minute") start_timer $((1 * 60)) ;;
                *) return ;;
            esac
            ;;
    esac
}

update_timer() {
    if [[ ! -f "$TIMER_FILE" ]]; then
        # Show tomato when no timer is running
        sketchybar --set pomodoro label="" label.drawing=off icon.drawing=on drawing=off
        return
    fi

    read duration start_time < "$TIMER_FILE"
    current_time=$(date +%s)
    elapsed=$((current_time - start_time))
    remaining=$((duration - elapsed))

    if [[ $remaining -le 0 ]]; then
        rm -f "$TIMER_FILE"
        # Show tomato again when timer ends
        sketchybar --set pomodoro label="" label.drawing=off icon.drawing=on drawing=off
        
        # Play sound
        afplay "$SOUND_FILE"

        # Instead of notification, show timer dialog again
        response=$(create_timer_dialog)
        case $response in
            "40 minutes") start_timer $((40 * 60)) ;;
            "30 minutes") start_timer $((30 * 60)) ;;
            "25 minutes") start_timer $((25 * 60)) ;;
            "5 minutes") start_timer $((5 * 60)) ;;
            "1 minute") start_timer $((1 * 60)) ;;
            *) return ;;
        esac
        return
    fi

    minutes=$((remaining / 60))
    seconds=$((remaining % 60))
    
    # Format the time string
    if [[ $seconds -lt 10 ]]; then
        seconds="0$seconds"
    fi

    sketchybar --set pomodoro icon.drawing=off label.drawing=on label="${minutes}:${seconds}"
}

case "$SENDER" in
    "mouse.clicked")
        handle_click
        ;;
    "pomodoro_start")
        handle_click
        ;;
    *)
        update_timer
        ;;
esac
