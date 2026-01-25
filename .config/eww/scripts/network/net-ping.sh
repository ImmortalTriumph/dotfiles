#!/bin/bash
# Get ping latency to 1.1.1.1 (Cloudflare DNS)

ping -c 1 -W 2 1.1.1.1 2>/dev/null | grep 'time=' | awk -F'time=' '{print int($2)" ms"}' || echo "-- ms"
