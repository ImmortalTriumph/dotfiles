#!/bin/bash
# Get Bluetooth power state and connected device name

# Check if bluetooth is powered on
powered=$(bluetoothctl show 2>/dev/null | grep "Powered:" | awk '{print $2}')

if [[ "$powered" != "yes" ]]; then
    echo "Off"
    exit 0
fi

# Check for connected devices
connected=$(bluetoothctl devices Connected 2>/dev/null | head -n1)

if [[ -n "$connected" ]]; then
    # Extract device name (format: "Device XX:XX:XX:XX:XX:XX DeviceName")
    device_name=$(echo "$connected" | cut -d' ' -f3-)
    echo "$device_name"
else
    echo "On (no device)"
fi
