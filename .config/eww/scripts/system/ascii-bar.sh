#!/bin/bash
# Generate htop-style ASCII progress bar
# Usage: ascii-bar.sh <percentage> [width]
# Example: ascii-bar.sh 45 20 -> [|||||||||           ]

percent=${1:-0}
width=${2:-20}

# Clamp percentage to 0-100
if [ "$percent" -lt 0 ]; then
    percent=0
elif [ "$percent" -gt 100 ]; then
    percent=100
fi

# Calculate filled portion
filled=$(( (percent * width) / 100 ))
empty=$(( width - filled ))

# Build the bar using htop-style characters
bar="["
for ((i=0; i<filled; i++)); do
    bar+="|"
done
for ((i=0; i<empty; i++)); do
    bar+=" "
done
bar+="]"

echo "$bar"
