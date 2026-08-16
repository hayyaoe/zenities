#!/bin/bash

DIRECTORY="$HOME/wallpapers"

for file in "$DIRECTORY"/preview-*; do
    [ -e "$file" ] || continue
    line=$(basename "$file")
    echo "$line"
done
