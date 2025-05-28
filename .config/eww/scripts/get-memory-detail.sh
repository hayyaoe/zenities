#!/bin/bash

# Get the free memory value from the 'free' command, in human-readable format (MB or GB)
free_memory=$(free -h | awk '/Mem:/ {print $7}')

# Print the free memory
echo "$free_memory"

