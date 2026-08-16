#!/usr/bin/env bash

BAT_PATH=(/sys/class/power_supply/BAT*)
if [ -e "${BAT_PATH[0]}" ]; then
    BAT=$(basename "${BAT_PATH[0]}")
    cat "/sys/class/power_supply/${BAT}/capacity"
fi
