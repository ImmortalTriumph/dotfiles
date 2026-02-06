#!/bin/bash
# Get all network interfaces with their IP addresses

output=""

# Parse ip addr output - interface is at end of line, IP after "inet"
while IFS= read -r line; do
    ip=$(echo "$line" | awk '{print $2}' | cut -d'/' -f1)
    iface=$(echo "$line" | awk '{print $NF}')
    if [[ -n "$ip" && -n "$iface" && "$ip" != "127.0.0.1" ]]; then
        output+="$iface: $ip\n"
    fi
done < <(ip -4 addr show | grep "inet ")

# Clean up output
if [[ -z "$output" ]]; then
    echo "No network"
else
    echo -e "${output%\\n}"
fi
