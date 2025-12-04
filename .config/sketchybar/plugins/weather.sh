#!/usr/bin/env sh

# Optimized weather plugin with location caching
LOCATION_CACHE="/tmp/sketchybar_location_cache"

# Cache location for 24 hours to avoid unnecessary API calls
if [[ ! -f "$LOCATION_CACHE" || $(($(date +%s) - $(stat -f %m "$LOCATION_CACHE" 2>/dev/null || echo 0))) -gt 86400 ]]; then
    LOCATION=$(curl -s --max-time 5 "https://ipinfo.io/city" 2>/dev/null || echo "Berlin")
    echo "$LOCATION" > "$LOCATION_CACHE"
else
    LOCATION=$(cat "$LOCATION_CACHE")
fi

# Get weather data with timeout for better responsiveness
WEATHER_JSON=$(curl -s --max-time 10 "wttr.in/${LOCATION}?format=j1" 2>/dev/null)

if [[ $? -eq 0 && -n "$WEATHER_JSON" ]]; then
    # Parse weather data
    TEMP=$(echo "$WEATHER_JSON" | jq -r '.current_condition[0].temp_C' 2>/dev/null)
    CONDITION=$(echo "$WEATHER_JSON" | jq -r '.current_condition[0].weatherDesc[0].value' 2>/dev/null)
    
    # Weather icon mapping using more distinct SF Symbols
    case "$CONDITION" in
        *"Clear"*|*"Sunny"*) ICON="􀇁" ;;  # sun.max
        *"Partly cloudy"*|*"Partly Cloudy"*) ICON="􀇃" ;;  # cloud.sun
        *"Cloudy"*|*"Overcast"*) ICON="􀇔" ;;  # cloud.fill (more distinct)
        *"Rain"*|*"Light rain"*|*"Heavy rain"*) ICON="􀇇" ;;  # cloud.drizzle (clearer rain)
        *"Snow"*|*"Light snow"*|*"Heavy snow"*) ICON="􀇏" ;;  # cloud.snow
        *"Thunderstorm"*|*"Thunder"*) ICON="􀇒" ;;  # cloud.bolt.rain
        *"Fog"*|*"Mist"*) ICON="􀇊" ;;  # cloud.fog
        *) ICON="􀇂" ;;  # sun.dust
    esac
    
    if [[ -n "$TEMP" && "$TEMP" != "null" ]]; then
        LABEL="${TEMP}°C"
        # Save location for click script
        echo "$LOCATION" > /tmp/sketchybar_weather_location
        sketchybar --set weather icon="$ICON" label="$LABEL" icon.drawing=on label.drawing=on
    else
        sketchybar --set weather icon="􀇆" label="--°C" icon.drawing=on label.drawing=on
    fi
else
    # Fallback when no internet or API fails
    sketchybar --set weather icon="􀇆" label="--°C" icon.drawing=on label.drawing=on
fi
