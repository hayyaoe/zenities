#!/bin/bash

# Define the directory to read as ~/wallpaper
DIRECTORY=~/wallpaper

# Expand the tilde to the actual home directory path
DIRECTORY=$(eval echo $DIRECTORY)

# Initialize an array to hold the file names
file_array=()

# Check if the directory exists
if [ -d "$DIRECTORY" ]; then
    # Iterate over all files in the directory
    for file in "$DIRECTORY"/*; do
        # Check if it's a file, not a directory
        if [ -f "$file" ]; then
            # Add the file name to the array
            file_array+=("$(basename "$file")")
        fi
    done
else
    echo "The directory $DIRECTORY does not exist."
    exit 1
fi

# Print the file names as an array
echo "Files found in the ~/wallpaper directory:"
printf '%s\n' "${file_array[@]}"

