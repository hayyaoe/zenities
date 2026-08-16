#!/usr/bin/env bash

if compgen -G "/sys/class/power_supply/BAT*" > /dev/null; then
    echo "true"
fi
