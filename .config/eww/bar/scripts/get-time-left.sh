
battery_info=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0)

time_to_empty=$(echo "$battery_info" | grep -E "time to empty" | awk '{print $4, $5}')
time_to_full=$(echo "$battery_info" | grep -E "time to full" | awk '{print $4, $5}')

if [[ ! -z "$time_to_empty" ]]; then
    echo "$time_to_empty to empty"
elif [[ ! -z "$time_to_full" ]]; then
    echo "$time_to_full to full"
else
    echo "Battery status: Time information not available."
fi

