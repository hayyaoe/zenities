#!/bin/bash

battery_info=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0)

time_to_empty=$(echo "$battery_info" | awk '/time to empty/ {print $4, $5}')
time_to_full=$(echo "$battery_info" | awk '/time to full/ {print $4, $5}')

convert_time() {
    local time_value=$1
    local unit=$2
    local hours=0
    local minutes=0

    if [[ "$time_value" == *"hours"* ]]; then
        # Convert hours to integer and minutes
        numeric_value=$(echo "$time_value" | awk '{print $1}')
        hours=${numeric_value%.*}
        minutes=$(echo "scale=0; (${numeric_value#*.} * 60)/1" | bc)
    elif [[ "$time_value" == *"minutes"* ]]; then
        # If time is in minutes only
        numeric_value=$(echo "$time_value" | awk '{print $1}')
        minutes=${numeric_value%.*}
    fi

    # Ensure values are numbers
    [[ -z "$hours" ]] && hours=0
    [[ -z "$minutes" ]] && minutes=0

    echo "$hours h $minutes min to $unit"
}

if [[ -n "$time_to_empty" ]]; then
    convert_time "$time_to_empty" "empty"
elif [[ -n "$time_to_full" ]]; then
    convert_time "$time_to_full" "full"
else
    echo "Battery status: Time information not available."
fi

