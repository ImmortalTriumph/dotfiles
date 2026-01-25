#!/bin/bash
# Network speed monitor using /proc/net/dev (no bc dependency)
# Usage: net-speed.sh [up|down]

direction="$1"

# Get default interface
iface=$(ip route | grep default | awk '{print $5}' | head -1)

if [[ -z "$iface" ]]; then
    echo "N/A"
    exit 0
fi

# Cache file for previous values
cache_dir="/tmp/eww_net_speed"
mkdir -p "$cache_dir"

# Read current bytes from /proc/net/dev
# Format: iface: rx_bytes rx_packets ... tx_bytes tx_packets ...
read_bytes() {
    awk -v iface="$iface" '$1 ~ iface {gsub(":", "", $1); print $2, $10}' /proc/net/dev
}

current=$(read_bytes)
rx1=$(echo "$current" | awk '{print $1}')
tx1=$(echo "$current" | awk '{print $2}')

# Get previous values
rx0=$(cat "$cache_dir/rx" 2>/dev/null || echo "$rx1")
tx0=$(cat "$cache_dir/tx" 2>/dev/null || echo "$tx1")

# Save current values
echo "$rx1" > "$cache_dir/rx"
echo "$tx1" > "$cache_dir/tx"

# Calculate speed (bytes per second, assuming 1s poll interval)
rx_speed=$((rx1 - rx0))
tx_speed=$((tx1 - tx0))

# Ensure non-negative
[[ $rx_speed -lt 0 ]] && rx_speed=0
[[ $tx_speed -lt 0 ]] && tx_speed=0

# Format function using awk for floating point
format_speed() {
    local bytes=$1
    [[ -z "$bytes" || "$bytes" -lt 0 ]] && bytes=0

    if [[ $bytes -ge 1073741824 ]]; then
        awk "BEGIN {printf \"%.2f GB/s\", $bytes / 1073741824}"
    elif [[ $bytes -ge 1048576 ]]; then
        awk "BEGIN {printf \"%.2f MB/s\", $bytes / 1048576}"
    elif [[ $bytes -ge 1024 ]]; then
        awk "BEGIN {printf \"%.1f KB/s\", $bytes / 1024}"
    else
        echo "$bytes B/s"
    fi
}

if [[ "$direction" == "up" ]]; then
    format_speed "$tx_speed"
elif [[ "$direction" == "down" ]]; then
    format_speed "$rx_speed"
else
    echo "Usage: $0 [up|down]"
fi
