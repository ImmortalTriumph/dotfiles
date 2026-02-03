#!/bin/bash
# Unified disk stats - outputs JSON for root and home partitions with htop-style block bars
# Output: {"root": {"percent": 45, "bar": "[██████████████████░░░░░░░░░░░░░░░░░░░░░░]", "info": "120G / 256G"},
#          "home": {"percent": 60, "bar": "[████████████████████████░░░░░░░░░░░░░░░░]", "info": "300G / 500G"}}

BAR_WIDTH=40

generate_bar() {
    local percent=$1
    local filled=$(( (percent * BAR_WIDTH) / 100 ))
    local empty=$(( BAR_WIDTH - filled ))

    local bar="["
    for ((i=0; i<filled; i++)); do
        bar+="█"
    done
    for ((i=0; i<empty; i++)); do
        bar+="░"
    done
    bar+="]"

    echo "$bar"
}

# Get disk info for root
root_line=$(df -h / 2>/dev/null | awk 'NR==2')
root_raw=$(df / 2>/dev/null | awk 'NR==2')

if [[ -n "$root_line" && -n "$root_raw" ]]; then
    root_percent=$(echo "$root_raw" | awk '{gsub(/%/,""); print $5}')
    root_used=$(echo "$root_line" | awk '{print $3}')
    root_total=$(echo "$root_line" | awk '{print $2}')
    root_info="${root_used} / ${root_total}"

    # Clamp percentage
    if [[ $root_percent -lt 0 ]]; then root_percent=0; fi
    if [[ $root_percent -gt 100 ]]; then root_percent=100; fi

    root_bar=$(generate_bar "$root_percent")
else
    root_percent=0
    root_bar=$(generate_bar 0)
    root_info="0B / 0B"
fi

# Get disk info for home
home_line=$(df -h /home 2>/dev/null | awk 'NR==2')
home_raw=$(df /home 2>/dev/null | awk 'NR==2')

if [[ -n "$home_line" && -n "$home_raw" ]]; then
    home_percent=$(echo "$home_raw" | awk '{gsub(/%/,""); print $5}')
    home_used=$(echo "$home_line" | awk '{print $3}')
    home_total=$(echo "$home_line" | awk '{print $2}')
    home_info="${home_used} / ${home_total}"

    # Clamp percentage
    if [[ $home_percent -lt 0 ]]; then home_percent=0; fi
    if [[ $home_percent -gt 100 ]]; then home_percent=100; fi

    home_bar=$(generate_bar "$home_percent")
else
    home_percent=0
    home_bar=$(generate_bar 0)
    home_info="0B / 0B"
fi

# Output JSON
printf '{"root": {"percent": %d, "bar": "%s", "info": "%s"}, "home": {"percent": %d, "bar": "%s", "info": "%s"}}\n' \
    "$root_percent" "$root_bar" "$root_info" \
    "$home_percent" "$home_bar" "$home_info"
