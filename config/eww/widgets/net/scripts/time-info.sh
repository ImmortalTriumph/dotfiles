#!/bin/bash
# Time, timezone, and NTP status for EWW dashboard

datetime=$(date '+%Y-%m-%d %H:%M:%S')

# Timezone: UTC offset + zone name
utc_offset=$(date '+%:z')
if command -v timedatectl &>/dev/null; then
    zone_name=$(timedatectl show --property=Timezone --value 2>/dev/null)
    timezone="UTC${utc_offset} ${zone_name}"
else
    timezone="UTC${utc_offset}"
fi

# NTP sync status
if command -v timedatectl &>/dev/null; then
    ntp_val=$(timedatectl show --property=NTPSynchronized --value 2>/dev/null)
    if [[ "$ntp_val" == "yes" ]]; then
        ntp="sync"
    else
        ntp="not sync"
    fi
else
    ntp="unknown"
fi

echo "{\"datetime\": \"${datetime}\", \"timezone\": \"${timezone}\", \"ntp\": \"${ntp}\"}"
