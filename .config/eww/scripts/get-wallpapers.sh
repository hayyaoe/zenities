#!/bin/bash

DIRECTORY="$HOME/wallpapers"

if [ -d "$DIRECTORY" ]; then
    \ls -1 "$DIRECTORY" | grep "^preview-" | while read -r line; do
        echo "$line" | sed -E 's/^preview-//; s/\.[^.]+$//'
    done | sort -V | jq -R . | jq -s .
else
    echo "[]"
    exit 1
fi
