#!/bin/bash
# Get VPN status (Surfshark / OpenVPN / WireGuard)

# Check for Surfshark (usually uses OpenVPN or WireGuard)
surfshark_status=$(systemctl is-active surfshark 2>/dev/null)

# Check for OpenVPN
openvpn_status=$(pgrep -x openvpn 2>/dev/null)

# Check for WireGuard interfaces
wg_status=$(ip link show type wireguard 2>/dev/null | grep -oP '^\d+: \K[^:]+')

# Check NetworkManager VPN connections
nm_vpn=$(nmcli -t -f TYPE,STATE,NAME con show --active 2>/dev/null | grep "vpn:activated" | cut -d: -f3)

if [[ -n "$nm_vpn" ]]; then
    # Get VPN server location from connection name
    echo "$nm_vpn"
elif [[ -n "$wg_status" ]]; then
    echo "WireGuard ($wg_status)"
elif [[ -n "$openvpn_status" ]]; then
    # Try to get server from openvpn config
    server=$(ps aux | grep openvpn | grep -oP '(?<=--remote )[^ ]+' | head -1)
    if [[ -n "$server" ]]; then
        echo "OpenVPN ($server)"
    else
        echo "OpenVPN (Active)"
    fi
elif [[ "$surfshark_status" == "active" ]]; then
    echo "Surfshark (Active)"
else
    echo "Disconnected"
fi
