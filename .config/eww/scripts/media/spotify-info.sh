#!/bin/bash
# Get current Spotify/media track info via playerctl

status=$(playerctl status 2>/dev/null)

if [[ "$status" == "Playing" || "$status" == "Paused" ]]; then
    artist=$(playerctl metadata artist 2>/dev/null)
    title=$(playerctl metadata title 2>/dev/null)

    if [[ -n "$title" ]]; then
        if [[ -n "$artist" ]]; then
            echo "$artist - $title"
        else
            echo "$title"
        fi
    else
        echo "No track"
    fi
else
    echo "Not playing"
fi
