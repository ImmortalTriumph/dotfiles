#!/bin/bash
# Check cava visualizer status for eww dashboard

VISUALIZER_FILE="/tmp/visualizer.txt"
CAVA_RAW="/tmp/cava.raw"

# Check if visualizer output exists
if [[ ! -f "$VISUALIZER_FILE" ]]; then
    echo "Inactive"
    exit 0
fi

# Check if cava is running
if ! pgrep -x cava > /dev/null; then
    echo "Inactive"
    exit 0
fi

# Check if file is being updated (compare modification times)
MTIME1=$(stat -c %Y "$VISUALIZER_FILE" 2>/dev/null || echo 0)
sleep 0.2
MTIME2=$(stat -c %Y "$VISUALIZER_FILE" 2>/dev/null || echo 0)

if [[ "$MTIME1" != "$MTIME2" ]]; then
    echo "Active"
elif [[ -f "$CAVA_RAW" ]]; then
    # Cava is running but visualizer might be idle (no audio)
    echo "Standby"
else
    echo "Inactive"
fi
