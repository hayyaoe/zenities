#!/bin/bash

# Check if HyprIdle is running
if pgrep -x "hypridle" > /dev/null; then
    # If HyprIdle is running, kill it
    pkill -x "hypridle"
else
    # If HyprIdle is not running, start it
    hypridle &
fi
