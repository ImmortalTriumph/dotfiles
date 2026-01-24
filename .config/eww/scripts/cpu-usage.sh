#!/bin/bash
# CPU usage percentage

# Using /proc/stat for accurate measurement
read -r cpu user nice system idle iowait irq softirq steal guest guest_nice < /proc/stat 2>/dev/null || { echo "0"; exit 0; }

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
    cpu_usage=$(( (1000 * (total_diff - idle_diff) / total_diff + 5) / 10 ))
else
    cpu_usage=0
fi

# Clamp between 0 and 100
if [[ $cpu_usage -lt 0 ]]; then
    cpu_usage=0
elif [[ $cpu_usage -gt 100 ]]; then
    cpu_usage=100
fi

echo "${cpu_usage:-0}"
