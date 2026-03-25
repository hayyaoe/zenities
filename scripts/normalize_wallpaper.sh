#!/bin/bash

DIRECTORY="$HOME/wallpapers"

if [ ! -d "$DIRECTORY" ]; then
  echo "Directory does not exist: $DIRECTORY"
  exit 1
fi

shopt -s nullglob

for file in "$DIRECTORY"/*.{png,jpeg,jpg,webp,PNG,JPG,JPEG,WEBP}; do
  if [ -f "$file" ]; then
    
    filename=$(basename "$file")
    base_name="${filename%.*}"

    if [[ "$base_name" == preview-* ]]; then
      continue
    fi

    target_jpg="${DIRECTORY}/${base_name}.jpg"
    preview_file="${DIRECTORY}/preview-${base_name}.jpg"

    if [[ "$file" != *.jpg && "$file" != *.JPG ]]; then
       if [ ! -f "$target_jpg" ]; then
          magick "$file" "$target_jpg" && echo "Converted: $filename -> ${base_name}.jpg"
       fi
       source_for_preview="$target_jpg"
    else
       source_for_preview="$file"
    fi

    if [ ! -f "$preview_file" ]; then
      magick "$source_for_preview" -resize 800x600 -quality 50 "$preview_file" \
      && echo "Created preview: $preview_file"
    fi

  fi
done

echo "Processing completed."
