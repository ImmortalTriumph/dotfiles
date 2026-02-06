#!/bin/bash
# Battery stats - outputs JSON with percent, bar, status, and uptime
# Output: {"percent": 85, "bar": "[██████████████████████████████████░░░░░░░]", "status": "discharging", "uptime": "3h 24m"}

BAR_WIDTH=40

# Find battery
bat_path=""
for bat in /sys/class/power_supply/BAT*; do
    if [[ -f "$bat/capacity" ]]; then
        bat_path="$bat"
        break
    fi
done

if [[ -z "$bat_path" ]]; then
    bar=$(printf '[%s]' "$(printf '░%.0s' $(seq 1 $BAR_WIDTH))")
    printf '{"percent": 0, "bar": "%s", "status": "no battery", "uptime": "--"}\n' "$bar"
    exit 0
fi

# Read battery info
percent=$(cat "$bat_path/capacity" 2>/dev/null || echo 0)
status_raw=$(cat "$bat_path/status" 2>/dev/null || echo "Unknown")

case "$status_raw" in
    Charging)    status="charging" ;;
    Discharging) status="discharging" ;;
    Full)        status="full" ;;
    Not\ charging) status="not charging" ;;
    *)           status="unknown" ;;
esac

# Detail: show "plugged" if on AC, uptime if on battery
if [[ "$status" == "discharging" ]]; then
    uptime_secs=$(cat /proc/uptime 2>/dev/null | cut -d' ' -f1 | cut -d'.' -f1)
    if [[ -n "$uptime_secs" && "$uptime_secs" -gt 0 ]]; then
        hours=$((uptime_secs / 3600))
        mins=$(( (uptime_secs % 3600) / 60 ))
        detail="${status} ─ up ${hours}h ${mins}m"
    else
        detail="$status"
    fi
else
    detail="plugged"
fi

# Clamp percent
if [[ $percent -lt 0 ]]; then percent=0; fi
if [[ $percent -gt 100 ]]; then percent=100; fi

# Generate bar
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

printf '{"percent": %d, "bar": "%s", "detail": "%s"}\n' "$percent" "$bar" "$detail"
