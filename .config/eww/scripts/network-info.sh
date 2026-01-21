#!/bin/bash
# Get all network interfaces with their IP addresses

output=""

# Get all non-loopback interfaces with IPs
while IFS= read -r line; do
    iface=$(echo "$line" | awk '{print $1}' | tr -d ':')
    ip=$(echo "$line" | grep -oP 'inet \K[\d.]+')
    if [[ -n "$ip" && "$iface" != "lo" ]]; then
        output+="$iface: $ip\n"
    fi
done < <(ip -4 addr show | grep -E "^[0-9]+:|inet ")

# Clean up output
if [[ -z "$output" ]]; then
    echo "No network"
else
    echo -e "${output%\\n}"
fi
