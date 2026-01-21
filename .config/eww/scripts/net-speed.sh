#!/bin/bash
# Network speed monitor
# Usage: net-speed.sh [up|down]

direction="$1"

# Get default interface
iface=$(ip route | grep default | awk '{print $5}' | head -1)

if [[ -z "$iface" ]]; then
    echo "N/A"
    exit 0
fi

# Read bytes
rx_file="/sys/class/net/$iface/statistics/rx_bytes"
tx_file="/sys/class/net/$iface/statistics/tx_bytes"

if [[ ! -f "$rx_file" || ! -f "$tx_file" ]]; then
    echo "N/A"
    exit 0
fi

# Cache file for previous values
cache_dir="/tmp/eww_net_speed"
mkdir -p "$cache_dir"

rx1=$(cat "$rx_file")
tx1=$(cat "$tx_file")

# Get previous values
rx0=$(cat "$cache_dir/rx" 2>/dev/null || echo "$rx1")
tx0=$(cat "$cache_dir/tx" 2>/dev/null || echo "$tx1")
time0=$(cat "$cache_dir/time" 2>/dev/null || date +%s%N)
time1=$(date +%s%N)

# Save current values
echo "$rx1" > "$cache_dir/rx"
echo "$tx1" > "$cache_dir/tx"
echo "$time1" > "$cache_dir/time"

# Calculate time difference in seconds
time_diff=$(echo "scale=3; ($time1 - $time0) / 1000000000" | bc)

if [[ $(echo "$time_diff < 0.1" | bc) -eq 1 ]]; then
    time_diff="1"
fi

# Calculate speed in bytes per second
rx_speed=$(echo "scale=0; ($rx1 - $rx0) / $time_diff" | bc)
tx_speed=$(echo "scale=0; ($tx1 - $tx0) / $time_diff" | bc)

# Ensure non-negative
rx_speed=${rx_speed#-}
tx_speed=${tx_speed#-}

# Format function
format_speed() {
    local bytes=$1
    if [[ -z "$bytes" || "$bytes" -lt 0 ]]; then
        bytes=0
    fi

    if [[ $bytes -ge 1073741824 ]]; then
        echo "$(echo "scale=2; $bytes / 1073741824" | bc) GB/s"
    elif [[ $bytes -ge 1048576 ]]; then
        echo "$(echo "scale=2; $bytes / 1048576" | bc) MB/s"
    elif [[ $bytes -ge 1024 ]]; then
        echo "$(echo "scale=2; $bytes / 1024" | bc) KB/s"
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
