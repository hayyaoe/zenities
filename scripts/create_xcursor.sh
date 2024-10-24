#!/bin/bash

# Set the theme name
theme_name="MokouX"
cursor_dir="./$theme_name/cursors"

# List of mandatory X cursor names
mandatory_cursors=(
    "left_ptr" "right_ptr" "hand1" "hand2" "watch" "xterm" "cross" "crosshair" 
    "text" "question_arrow" "arrow" "center_ptr" "move" "plus" "fleur" 
    "resize_left" "resize_right" "resize_top" "resize_bottom" 
    "resize_topleft" "resize_topright" "resize_bottomleft" "resize_bottomright"
)

# Create directory structure
mkdir -p "$cursor_dir"

# Function to create a simple xcursorgen config file
create_config_file() {
    local image_path=$1
    local cursor_name=$2
    local hotspot_x=$3
    local hotspot_y=$4
    
    # Create xcursorgen config file
    config_file="${cursor_dir}/${cursor_name}.config"
    echo "$image_path" > "$config_file"
    echo "$hotspot_x $hotspot_y 2" >> "$config_file"
}

# Function to generate the .Xcursor file using xcursorgen
generate_xcursor() {
    local cursor_name=$1
    local config_file="${cursor_dir}/${cursor_name}.config"
    local output_cursor="${cursor_dir}/${cursor_name}"
    
    # Run xcursorgen to create the compiled cursor file
    xcursorgen "$config_file" "$output_cursor"
    
    if [[ $? -eq 0 ]]; then
        echo "Cursor generated: $cursor_name"
    else
        echo "Failed to generate cursor: $cursor_name"
    fi
}

# Iterate over the mandatory cursor list and generate them
for cursor_name in "${mandatory_cursors[@]}"; do
    # Path to the .png image (you need to replace this with your actual images)
    # If you're using placeholders, you can adjust this path accordingly
    image_path="$cursor_dir/$cursor_name.png"
    
    # Example: Create placeholder PNG file (48x48, transparent background)
    if [[ ! -f "$image_path" ]]; then
        echo "Creating placeholder image for $cursor_name"
        convert -size 48x48 xc:none -gravity center \
            -pointsize 10 -fill black -draw "text 0,0 '$cursor_name'" \
            "$image_path"
    fi
    
    # Define the hotspot (adjust manually as needed)
    hotspot_x=24
    hotspot_y=24

    # Create the config file
    create_config_file "$image_path" "$cursor_name" "$hotspot_x" "$hotspot_y"
    
    # Generate the X cursor file
    generate_xcursor "$cursor_name"
done

echo "All cursors generated for $theme_name theme in '$cursor_dir'"

