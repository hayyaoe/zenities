#!/bin/bash

# Check for available audio input devices

# Using PulseAudio
if command -v pactl &>/dev/null; then
    mic_count=$(pactl list sources short | grep -c input)
    [[ "$mic_count" -gt 0 ]] && echo "true" || echo "false"

# Using ALSA
elif command -v arecord &>/dev/null; then
    mic_count=$(arecord -l | grep -c 'card')
    [[ "$mic_count" -gt 0 ]] && echo "true" || echo "false"

else
    echo "false"
fi

