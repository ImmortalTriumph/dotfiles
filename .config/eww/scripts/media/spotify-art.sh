#!/bin/bash
# Get Spotify album art URL for display in EWW
# Returns the art URL or empty string if not available

art_url=$(playerctl -p spotify metadata mpris:artUrl 2>/dev/null)

if [[ -n "$art_url" ]]; then
    # Handle file:// URLs (local files)
    if [[ "$art_url" == file://* ]]; then
        echo "${art_url#file://}"
    else
        # Return URL as-is for http/https
        echo "$art_url"
    fi
else
    echo ""
fi
