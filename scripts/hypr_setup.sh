#!/bin/bash

# Path Setup
USER_DIR="$HOME/.config/hypr/user"
SERVICE_DIR="$SERVICE/.config/hypr/service"
TEMPLATE_DIR="$HOME/.config/hypr/template"
MONITORS_CONF="$USER_DIR/monitors.conf"

mkdir -p "$USER_DIR"


echo "# Auto-generated Config" > "$MONITORS_CONF"

MONITOR_DATA=$(hyprctl monitors | awk '/^Monitor/{n=$2} $2=="at"{print n, $1, $3}')

echo "$MONITOR_DATA" | while read -r NAME RES POS; do
    if [ -z "$NAME" ]; then continue; fi
    echo "monitor = $NAME, $RES, $POS, 1" >> "$MONITORS_CONF"
done

echo -e "\n# Workspace Mapping" >> "$MONITORS_CONF"
COUNT=0
echo "$MONITOR_DATA" | while read -r NAME RES POS; do
    if [ -z "$NAME" ]; then continue; fi
    if [ $COUNT -eq 0 ]; then
        for i in {1..5}; do echo "workspace = $i, monitor:$NAME" >> "$MONITORS_CONF"; done
    else
        for i in {6..10}; do echo "workspace = $i, monitor:$NAME" >> "$MONITORS_CONF"; done
    fi
    ((COUNT++))
done

echo "monitors.conf generated."

echo "checking other config files..."

FILES=("apps.conf" "colors.conf" "env.conf" "execs.conf" "inputs.conf")

for FILE in "${FILES[@]}"; do
    TARGET_FILE="$USER_DIR/$FILE"
    SOURCE_TEMPLATE="$TEMPLATE_DIR/$FILE.example"

    if [ ! -f "$TARGET_FILE" ]; then
        if [ -f "$SOURCE_TEMPLATE" ]; then
            cp "$SOURCE_TEMPLATE" "$TARGET_FILE"
            echo "   $FILE copied from template."
        else
            echo "   Template $FILE.example cannot be found $TEMPLATE_DIR"
        fi
    else
        echo "     $FILE already exist, skipping."
    fi
done

FILES=("hyprpaper.conf", "hyprlock.conf")

for FILE in "${FILES[@]}"; do
    TARGET_FILE="$SERVICE_DIR/$FILE"
    SOURCE_TEMPLATE="$TEMPLATE_DIR/$FILE.example"

    if [ ! -f "$TARGET_FILE" ]; then
        if [ -f "$SOURCE_TEMPLATE" ]; then
            cp "$SOURCE_TEMPLATE" "$TARGET_FILE"
            echo "   $FILE copied from template."
        else
            echo "   Template $FILE.example cannot be found $TEMPLATE_DIR"
        fi
    else
        echo "     $FILE already exist, skipping."
    fi
done

echo -e "\nSetup complete"
