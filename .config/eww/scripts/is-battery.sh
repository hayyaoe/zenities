if ls /sys/class/power_supply/ | grep -q 'BAT'; then
    echo "true"
else
    echo "false"
fi
