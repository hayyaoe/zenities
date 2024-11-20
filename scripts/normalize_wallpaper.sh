#!/bin/bash

# Define the target directory
DIRECTORY=~/zenities/wallpapers/  # Change this to your target directory

# Ensure the directory exists
DIRECTORY=$(eval echo "$DIRECTORY")
if [ ! -d "$DIRECTORY" ]; then
  echo "Directory does not exist: $DIRECTORY"
  exit 1
fi

# Convert and remove non-JPG versions
for file in "$DIRECTORY"/*.{png,jpeg}; do
  if [ -f "$file" ]; then
    output="${file%.*}.jpg"  # Change the extension to .jpg
    magick "$file" "$output" && echo "Converted: $file -> $output"
    rm "$file" && echo "Removed original: $file"
  fi
done

