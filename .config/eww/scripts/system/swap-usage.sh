#!/bin/bash
# Calculate swap usage percentage from free command

swap_info=$(free | awk '/Swap:/ {print $2, $3}')
total=$(echo "$swap_info" | awk '{print $1}')
used=$(echo "$swap_info" | awk '{print $2}')

if [[ "$total" -eq 0 ]]; then
    echo "0"
else
    percent=$((used * 100 / total))
    echo "$percent"
fi
