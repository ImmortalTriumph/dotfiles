#!/bin/bash
# Unified CPU stats - outputs JSON with percent and htop-style block bar
# Output: {"percent": 45, "bar": "[████████████████░░░░░░░░░░░░░░░░░░░░░░░░]"}

BAR_WIDTH=40

# Read /proc/stat for accurate measurement
read -r cpu user nice system idle iowait irq softirq steal guest guest_nice < /proc/stat 2>/dev/null || {
    printf '{"percent": 0, "bar": "[%s]"}\n' "$(printf '░%.0s' $(seq 1 $BAR_WIDTH))"
    exit 0
}

# Get previous values from cache
cache_file="/tmp/eww_cpu_cache"

if [[ -f "$cache_file" ]]; then
    read -r prev_total prev_idle < "$cache_file"
else
    prev_total=0
    prev_idle=0
fi

# Calculate totals
total=$((user + nice + system + idle + iowait + irq + softirq + steal))
idle_all=$((idle + iowait))

# Save current values
echo "$total $idle_all" > "$cache_file"

# Calculate differences
total_diff=$((total - prev_total))
idle_diff=$((idle_all - prev_idle))

# Calculate CPU usage percentage
if [[ $total_diff -gt 0 ]]; then
    percent=$(( (1000 * (total_diff - idle_diff) / total_diff + 5) / 10 ))
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
printf '{"percent": %d, "bar": "%s"}\n' "$percent" "$bar"
