#!/bin/bash
# Get current Spotify track info via playerctl (Spotify only)
# Outputs JSON: {"title": "...", "artist": "..."}

status=$(playerctl -p spotify status 2>/dev/null)

if [[ "$status" == "Playing" || "$status" == "Paused" ]]; then
    artist=$(playerctl -p spotify metadata artist 2>/dev/null | sed 's/"/\\"/g')
    title=$(playerctl -p spotify metadata title 2>/dev/null | sed 's/"/\\"/g')

    if [[ -z "$title" ]]; then
        title="No track"
    fi
    if [[ -z "$artist" ]]; then
        artist=""
    fi

    echo "{\"title\": \"$title\", \"artist\": \"$artist\"}"
else
    echo "{\"title\": \"\", \"artist\": \"\"}"
fi
