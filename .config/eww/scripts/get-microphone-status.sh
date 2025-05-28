#!/bin/bash

MIC_SOURCE=$(pactl list sources short | awk '$2 ~ /input/ {print $1; exit}')
MIC_STATUS=$(pactl get-source-mute "$MIC_SOURCE" | awk '{print $2}')

[[ "$MIC_STATUS" == "yes" ]] && echo "false" || echo "true"

