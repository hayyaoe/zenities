#!/bin/bash

# Define the target directory
DIRECTORY=~/zenities/wallpapers/  # Change this to your target directory

# Ensure the directory exists
DIRECTORY=$(eval echo "$DIRECTORY")
if [ ! -d "$DIRECTORY" ]; then
  echo "Directory does not exist: $DIRECTORY"
  exit 1
fi

# Convert and skip existing previews
shopt -s nullglob  # Prevent errors if no matching files
for file in "$DIRECTORY"/*.{png,jpeg,jpg}; do
  if [ -f "$file" ]; then
    # Get the base name of the file without extension
    base_name=$(basename "${file%.*}")

    # Skip files that already start with 'preview-'
    if [[ "$base_name" == preview-* ]]; then
      continue
    fi

    # Define the preview file name
    preview="${DIRECTORY}/preview-${base_name}.jpg"

    # Skip if the preview already exists
    if [ -f "$preview" ]; then
      continue
    fi

    # Define the output file name for the converted .jpg
    output="${file%.*}.jpg"

    # Convert the file to JPG format if needed
    if [[ "$file" != *.jpg ]]; then
      magick "$file" "$output" && echo "Converted: $file -> $output"
      rm "$file" && echo "Removed original: $file"
    fi

    # Create a lower-quality, lower-resolution preview image
    magick "$output" -resize 800x600 -quality 50 "$preview" && echo "Created preview: $preview"
  fi
done

echo "Processing completed."

