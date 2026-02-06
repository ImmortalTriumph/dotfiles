#!/bin/bash
# Unified memory stats - outputs JSON with percent, htop-style block bar, used, and total
# Output: {"percent": 65, "bar": "[██████████████████████████░░░░░░░░░░░░░░]", "used": "12.5Gi", "total": "31.2Gi"}

BAR_WIDTH=40

# Get memory info in one call
mem_line=$(free -h 2>/dev/null | grep Mem)
mem_raw=$(free 2>/dev/null | grep Mem)

if [[ -z "$mem_line" || -z "$mem_raw" ]]; then
    printf '{"percent": 0, "bar": "[%s]", "used": "0B", "total": "0B"}\n' "$(printf '░%.0s' $(seq 1 $BAR_WIDTH))"
    exit 0
fi

# Extract values
total_raw=$(echo "$mem_raw" | awk '{print $2}')
used_raw=$(echo "$mem_raw" | awk '{print $3}')
total_human=$(echo "$mem_line" | awk '{print $2}')
used_human=$(echo "$mem_line" | awk '{print $3}')

# Calculate percentage
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
