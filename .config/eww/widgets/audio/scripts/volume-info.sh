#!/bin/bash
# Get current volume percentage via wpctl

volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null | awk '{print int($2 * 100)}')

if [[ -n "$volume" ]]; then
    echo "$volume"
else
    echo "0"
fi
