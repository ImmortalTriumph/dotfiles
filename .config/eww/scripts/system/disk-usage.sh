#!/bin/bash
# Get disk usage for root and home partitions
# Usage: disk-usage.sh [root|home|root-percent|home-percent]

case "$1" in
    root)
        df -h / | awk 'NR==2 {print $3 " / " $2}'
        ;;
    home)
        df -h /home | awk 'NR==2 {print $3 " / " $2}'
        ;;
    root-percent)
        df / | awk 'NR==2 {gsub(/%/,""); print $5}'
        ;;
    home-percent)
        df /home | awk 'NR==2 {gsub(/%/,""); print $5}'
        ;;
    *)
        echo "Usage: $0 [root|home|root-percent|home-percent]"
        exit 1
        ;;
esac
