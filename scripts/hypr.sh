#!/usr/bin/env bash 

# stops execution when an error occurs
set -e

main() {
    # Find out where the absolute path of the script is
    local SCRIPT_DIR
    SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
    local REPO_ROOT
    REPO_ROOT=$(cd "$SCRIPT_DIR/.." && pwd)

    local TEMPLATE_DIR="$REPO_ROOT/.templates/hypr"
    local TARGET_DIR="$REPO_ROOT/.config/hypr/user"

    echo "Setting up Hyprland configuration from templates..."

    # Make sure the target directory exists and clean
    mkdir -p "$TARGET_DIR"

    if [ -d "$TEMPLATE_DIR" ]; then
        mkdir -p "$TARGET_DIR"
        for file in "$TEMPLATE_DIR"/*; do
            [ -e "$file" ] || continue
            local filename
	    filename=$(basename "$file")
            if [ ! -e "$TARGET_DIR/$filename" ]; then
                cp -rp "$file" "$TARGET_DIR/"
                echo "  [+] Initialized template: $filename"
            else
                echo "  [~] Preserved user config: $filename"
            fi
        done
        echo "Hyprland templates successfully set."
    else
        echo "Error: Template directory $TEMPLATE_DIR does not exist." >&2
        return 1
    fi
}

main
