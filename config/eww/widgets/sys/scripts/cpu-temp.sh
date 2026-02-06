#!/bin/bash
# CPU temperature for EWW dashboard

# Try thermal zones first
for zone in /sys/class/thermal/thermal_zone*/; do
    type=$(cat "${zone}type" 2>/dev/null)
    case "$type" in
        x86_pkg_temp|TCPU|coretemp)
            temp=$(cat "${zone}temp" 2>/dev/null)
            if [[ -n "$temp" ]]; then
                echo "$((temp / 1000))°C"
                exit 0
            fi
            ;;
    esac
done

# Fallback: try sensors command
if command -v sensors &>/dev/null; then
    temp=$(sensors 2>/dev/null | grep -oP 'Package id 0:\s+\+\K[0-9]+' | head -1)
    if [[ -n "$temp" ]]; then
        echo "${temp}°C"
        exit 0
    fi
    temp=$(sensors 2>/dev/null | grep -oP 'Tctl:\s+\+\K[0-9]+' | head -1)
    if [[ -n "$temp" ]]; then
        echo "${temp}°C"
        exit 0
    fi
fi

echo "--°C"
