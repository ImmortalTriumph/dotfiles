#!/bin/bash
# Get album art for any MPRIS player and download to local file
# EWW image widget requires local file paths, not URLs

CACHE_DIR="/tmp/eww-album-art"
CACHE_FILE="$CACHE_DIR/current.jpg"
mkdir -p "$CACHE_DIR"

# Get art URL from Spotify only
art_url=$(playerctl -p spotify metadata mpris:artUrl 2>/dev/null)

if [[ -z "$art_url" ]]; then
    echo ""
    exit 0
fi

# Handle file:// URLs (local files) - return path directly
if [[ "$art_url" == file://* ]]; then
    echo "${art_url#file://}"
    exit 0
fi

# For HTTP URLs, download to cache and return local path
if [[ "$art_url" == http* ]]; then
    # Check if URL changed (avoid re-downloading same image)
    url_hash=$(echo "$art_url" | md5sum | cut -d' ' -f1)
    hash_file="$CACHE_DIR/.url_hash"

    if [[ -f "$hash_file" ]] && [[ "$(cat "$hash_file")" == "$url_hash" ]] && [[ -f "$CACHE_FILE" ]]; then
        echo "$CACHE_FILE"
        exit 0
    fi

    # Download new image
    if curl -sL --max-time 5 "$art_url" -o "$CACHE_FILE" 2>/dev/null; then
        echo "$url_hash" > "$hash_file"
        echo "$CACHE_FILE"
    else
        echo ""
    fi
else
    echo ""
fi
