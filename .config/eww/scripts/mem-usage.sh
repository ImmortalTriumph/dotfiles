#!/bin/bash
# Memory usage percentage

mem_info=$(free 2>/dev/null | grep Mem)
total=$(echo "$mem_info" | awk '{print $2}')
used=$(echo "$mem_info" | awk '{print $3}')

if [[ -n "$total" && $total -gt 0 ]]; then
    percentage=$((used * 100 / total))
else
    percentage=0
fi

echo "${percentage:-0}"
