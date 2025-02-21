#!/bin/bash

# Get CPU temperature (works on most systems with 'sensors' installed)
cpu_temp=$(sensors | awk '/^Core 0/ {print $3}' | tr -d '+°C' | cut -d'.' -f1)

# Print the CPU temperature as an integer
echo "$cpu_temp"

