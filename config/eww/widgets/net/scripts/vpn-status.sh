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

# Function to get country from IP
get_country() {
    country=$(curl -s --max-time 2 ifconfig.co/country 2>/dev/null)
    if [[ -n "$country" && "$country" != *"error"* ]]; then
        echo "$country"
    else
        echo ""
    fi
}

if [[ -n "$nm_vpn" ]]; then
    country=$(get_country)
    if [[ -n "$country" ]]; then
        echo "Connected ($country)"
    else
        echo "$nm_vpn"
    fi
elif [[ -n "$wg_status" ]]; then
    country=$(get_country)
    if [[ -n "$country" ]]; then
        echo "WireGuard ($country)"
    else
        echo "WireGuard ($wg_status)"
    fi
elif [[ -n "$openvpn_status" ]]; then
    country=$(get_country)
    if [[ -n "$country" ]]; then
        echo "OpenVPN ($country)"
    else
        echo "OpenVPN (Active)"
    fi
elif [[ "$surfshark_status" == "active" ]]; then
    country=$(get_country)
    if [[ -n "$country" ]]; then
        echo "Surfshark ($country)"
    else
        echo "Surfshark (Active)"
    fi
else
    echo "Disconnected"
fi
