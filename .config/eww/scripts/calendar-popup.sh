calendar(){
LOCK_FILE="$HOME/.cache/eww-calendar.lock"
EWW_BIN="$HOME/eww/target/release/eww"

run() {
    ${EWW_BIN} -c $HOME/.config/eww/ open calendar
}

# Run eww daemon if not running
if [[ ! `pidof eww` ]]; then
    ${EWW_BIN} daemon
    sleep 1
fi

# Open widgets
if [[ ! -f "$LOCK_FILE" ]]; then
    touch "$LOCK_FILE"
    run
else
    ${EWW_BIN} -c $HOME/.config/eww/ close calendar
    rm "$LOCK_FILE"
fi
}


calendar
