#!/bin/bash
# Run speedtest-cli with 5-minute caching to avoid API abuse

CACHE_FILE="/tmp/speedtest_cache.txt"
CACHE_TIME="/tmp/speedtest_time.txt"
CACHE_DURATION=300  # 5 minutes in seconds

# Check if cache exists and is still valid
if [[ -f "$CACHE_FILE" && -f "$CACHE_TIME" ]]; then
    last_run=$(cat "$CACHE_TIME")
    current_time=$(date +%s)
    elapsed=$((current_time - last_run))

    if [[ $elapsed -lt $CACHE_DURATION ]]; then
        cat "$CACHE_FILE"
        exit 0
    fi
fi

# Run speedtest
if command -v speedtest-cli &>/dev/null; then
    result=$(speedtest-cli --simple 2>/dev/null)

    if [[ -n "$result" ]]; then
        # Parse results
        ping=$(echo "$result" | grep "Ping:" | awk '{print $2 " " $3}')
        download=$(echo "$result" | grep "Download:" | awk '{print $2 " " $3}')
        upload=$(echo "$result" | grep "Upload:" | awk '{print $2 " " $3}')

        output="↓ $download | ↑ $upload | $ping"
        echo "$output" > "$CACHE_FILE"
        date +%s > "$CACHE_TIME"
        echo "$output"
    else
        echo "Test failed"
    fi
else
    echo "speedtest-cli not installed"
fi
