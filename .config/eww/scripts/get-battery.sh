BAT=$(ls /sys/class/power_supply 2>/dev/null | grep BAT | head -n 1)

if [ -z "$BAT" ] || [ ! -f "/sys/class/power_supply/${BAT}/capacity" ]; then
    echo 0.0
else
    cat /sys/class/power_supply/${BAT}/capacity
fi

