#!/bin/bash

MIC_VOL=$(pactl get-source-volume @DEFAULT_SOURCE@ | awk '{print $5}' | tr -d '%')
echo "$MIC_VOL"

