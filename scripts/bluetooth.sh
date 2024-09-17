#!/bin/bash

notify-send "Getting list of available Bluetooth devices..."

# Make sure Bluetooth is powered on
bluetoothctl power on

# Get a list of available Bluetooth devices
bt_list=$(bluetoothctl devices | sed 's/Device //')

# Prepare a list of device names (without MAC addresses)
device_names=$(echo "$bt_list" | awk '{$1=""; print substr($0,2)}')

# Add option to toggle Bluetooth on/off
powered=$(bluetoothctl show | grep "Powered: yes")
if [ -n "$powered" ]; then
    toggle="󰂯  Disable Bluetooth"
else
    toggle="󰂯  Enable Bluetooth"
fi

# Use rofi to select Bluetooth device
chosen_device_name=$(echo -e "$toggle\n$device_names" | rofi -dmenu -i -selected-row 1 -p "󰂯")

# Exit if no device is selected
if [ -z "$chosen_device_name" ]; then
    exit
fi

if [ "$chosen_device_name" = "󰂯  Enable Bluetooth" ]; then
    bluetoothctl power on
elif [ "$chosen_device_name" = "󰂯  Disable Bluetooth" ]; then
    bluetoothctl power off
else
    # Get the corresponding MAC address for the selected device name
    chosen_mac=$(echo "$bt_list" | grep "$chosen_device_name" | awk '{print $1}')

    # Initiate pairing
    pairing_output=$(bluetoothctl pair "$chosen_mac")

    # Check if a PIN is requested
    if echo "$pairing_output" | grep -q "Request.*PIN code"; then
        # Ask user for the PIN via rofi
        pin_code=$(rofi -dmenu -p "Enter PIN for $chosen_device_name: " -lines 0)

        # Send the PIN to bluetoothctl
        echo "$pin_code" | bluetoothctl pair "$chosen_mac"
    elif echo "$pairing_output" | grep -q "Request.*confirmation"; then
        # Ask user for confirmation via rofi (usually Y/n)
        confirmation=$(echo -e "yes\nno" | rofi -dmenu -p "Confirm pairing with $chosen_device_name? " -selected-row 0)
        if [ "$confirmation" = "yes" ]; then
            echo "yes" | bluetoothctl pair "$chosen_mac"
        else
            echo "no" | bluetoothctl pair "$chosen_mac"
            exit
        fi
    fi

    # Trust the device
    bluetoothctl trust "$chosen_mac"
    # Connect to the device
    bluetoothctl connect "$chosen_mac"

    # Notify the user of the connection status
    if bluetoothctl info "$chosen_mac" | grep -q "Connected: yes"; then
        notify-send "Bluetooth Device Connected" "Successfully connected to \"$chosen_device_name\"."
    else
        notify-send "Bluetooth Device Connection Failed" "Failed to connect to \"$chosen_device_name\"."
    fi
fi

