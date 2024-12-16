#!/bin/bash

# Check if hypridle is running
if pgrep -x "hypridle" > /dev/null; then
    # HyprIdle is running
    echo "false"
else
    # HyprIdle is not running
    echo "true"
fi

