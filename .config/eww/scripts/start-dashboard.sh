#!/bin/bash
# Start eww dashboard with cava visualizer
# Hides waybar while dashboard is open

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CAVA_CONFIG="$HOME/.config/cava/config"
VIZ_SCRIPT="$SCRIPT_DIR/audio/cava-viz.py"

# Kill existing processes
pkill -f "cava-viz.py" 2>/dev/null
pkill -x cava 2>/dev/null
eww close dashboard 2>/dev/null

# Clean up old files
rm -f /tmp/cava.raw /tmp/visualizer.txt 2>/dev/null

sleep 0.2

# Ensure eww daemon is running
eww daemon 2>/dev/null

# Hide waybar
pkill -SIGUSR1 waybar 2>/dev/null || killall -SIGUSR1 waybar 2>/dev/null
sleep 0.2

# Start cava in background with explicit config (outputs to /tmp/cava.raw)
cava -p "$CAVA_CONFIG" &
CAVA_PID=$!

sleep 0.3

# Start cava-viz (reads /tmp/cava.raw, writes /tmp/visualizer.txt)
"$VIZ_SCRIPT" &
VIZ_PID=$!

sleep 0.2

# Open dashboard
eww open dashboard

# Trap to cleanup on exit
cleanup() {
    kill $CAVA_PID 2>/dev/null
    kill $VIZ_PID 2>/dev/null
    pkill -f "cava-viz.py" 2>/dev/null
    eww close dashboard 2>/dev/null
    rm -f /tmp/cava.raw /tmp/visualizer.txt 2>/dev/null
    # Show waybar again
    pkill -SIGUSR1 waybar 2>/dev/null || killall -SIGUSR1 waybar 2>/dev/null
}

trap cleanup EXIT INT TERM

# Wait for dashboard to close (check active windows, not available windows)
while eww active-windows 2>/dev/null | grep -q "dashboard"; do
    sleep 0.5
done

cleanup
