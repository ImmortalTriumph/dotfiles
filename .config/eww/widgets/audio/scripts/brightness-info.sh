#!/bin/bash
# Get current screen brightness percentage
# Uses brightnessctl for backlight control

brightness=$(brightnessctl -m 2>/dev/null | cut -d',' -f4 | tr -d '%')

if [[ -n "$brightness" ]]; then
    echo "$brightness"
else
    echo "50"
fi
