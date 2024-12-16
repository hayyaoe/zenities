# Get the current position of the song in seconds
POSITION=$(playerctl --player=ncspot position)
LENGTH_MICROSECONDS=$(playerctl --player=ncspot metadata --format "{{mpris:length}}")

POSITION=$(playerctl --player=ncspot position)
LENGTH_MICROSECONDS=$(playerctl --player=ncspot metadata --format "{{mpris:length}}")

# Calculate the percentage using Python
PERCENTAGE=$(python3 -c "
import sys
position = float(sys.argv[1])
length_seconds = float(sys.argv[2]) / 1000000
percentage = (position / length_seconds) * 100
print(f'{percentage:.2f}')
" "$POSITION" "$LENGTH_MICROSECONDS")

# Output the percentage
echo "$PERCENTAGE"
