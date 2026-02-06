#!/bin/bash
# Unified swap stats - outputs JSON with percent, htop-style block bar, used, and total
# Output: {"percent": 10, "bar": "[████░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░]", "used": "1.2Gi", "total": "8.0Gi"}

BAR_WIDTH=40

# Get swap info in one call
swap_line=$(free -h 2>/dev/null | grep Swap)
swap_raw=$(free 2>/dev/null | grep Swap)

if [[ -z "$swap_line" || -z "$swap_raw" ]]; then
    printf '{"percent": 0, "bar": "[%s]", "used": "0B", "total": "0B"}\n' "$(printf '░%.0s' $(seq 1 $BAR_WIDTH))"
    exit 0
fi

# Extract values
total_raw=$(echo "$swap_raw" | awk '{print $2}')
used_raw=$(echo "$swap_raw" | awk '{print $3}')
total_human=$(echo "$swap_line" | awk '{print $2}')
used_human=$(echo "$swap_line" | awk '{print $3}')

# Calculate percentage (handle zero total)
if [[ -n "$total_raw" && $total_raw -gt 0 ]]; then
    percent=$((used_raw * 100 / total_raw))
else
    percent=0
fi

# Clamp between 0 and 100
if [[ $percent -lt 0 ]]; then
    percent=0
elif [[ $percent -gt 100 ]]; then
    percent=100
fi

# Generate htop-style block bar: █ for filled, ░ for empty
filled=$(( (percent * BAR_WIDTH) / 100 ))
empty=$(( BAR_WIDTH - filled ))

bar="["
for ((i=0; i<filled; i++)); do
    bar+="█"
done
for ((i=0; i<empty; i++)); do
    bar+="░"
done
bar+="]"

# Output JSON
printf '{"percent": %d, "bar": "%s", "used": "%s", "total": "%s"}\n' "$percent" "$bar" "$used_human" "$total_human"
