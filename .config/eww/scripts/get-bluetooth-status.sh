#!/bin/bash

# Get Bluetooth status
BLUETOOTH_STATUS=$(bluetoothctl show | grep "Powered" | awk '{print $2}')

# Check if Bluetooth is powered on and if any device is connected
if [[ "$BLUETOOTH_STATUS" == "yes" ]]; then
    DEVICE_STATUS=$(bluetoothctl devices | grep "Device" | wc -l)
    
    if (( DEVICE_STATUS > 0 )); then
        echo "󰂯"  # Icon for connected Bluetooth device
    else
        echo "󰂯"  # Icon for Bluetooth powered on, but no device connected
    fi
else
    echo "󰂲"  # Icon for Bluetooth turned off
fi

