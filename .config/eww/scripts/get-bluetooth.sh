#!/bin/bash

# Check if Bluetooth is powered on
BLUETOOTH_STATUS=$(bluetoothctl show | grep "Powered" | awk '{print $2}')

if [[ "$BLUETOOTH_STATUS" == "yes" ]]; then
    # Get the name of the connected Bluetooth device
    DEVICE_NAME=$(bluetoothctl devices | grep "Device" | awk '{print substr($0, index($0,$3))}')
    
    if [[ -n "$DEVICE_NAME" ]]; then
        echo "$DEVICE_NAME"
    else
        echo "None"
    fi
else
    echo ""
fi

