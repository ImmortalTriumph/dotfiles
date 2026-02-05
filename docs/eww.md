# EWW Widget System

Dashboard widget system using EWW 0.6.0 with Gruvbox color scheme.

## Architecture

```
eww/
├── eww.yuck              # Main layout & window definition
├── eww.scss              # Global styles & color variables
└── widgets/
    ├── variables.yuck    # All polling variables
    ├── audio/
    │   ├── audio-section.yuck
    │   ├── _audio-section.scss
    │   └── scripts/      # cava-viz.py, spotify-*, volume-info, brightness-info
    ├── net/
    │   ├── network-info.yuck
    │   ├── _network-info.scss
    │   └── scripts/      # network-info, wifi-ssid, vpn-status, bluetooth-status, net-speed, net-ping
    ├── sys/
    │   ├── system-stats.yuck
    │   ├── _system-stats.scss
    │   └── scripts/      # cpu-stats, mem-stats, swap-stats, disk-stats
    └── power/
        ├── power-button.yuck
        └── _power-button.scss
```

## Widgets

### Audio Section
- **Cava Visualizer**: Real-time audio spectrum (180 bars)
- **Spotify Info**: Track title and artist (Spotify only)
- **Album Art**: 96x96 cached artwork
- **Volume Slider**: wpctl control
- **Brightness Slider**: brightnessctl control

### Network Info
- Interface name
- WiFi SSID
- Bluetooth status
- VPN status (OpenVPN, WireGuard, Tor)
- Download/Upload speed
- Ping latency

### System Stats
- CPU usage with ASCII progress bar
- RAM usage with used/total
- Swap usage with used/total
- Disk usage (root + home partitions)

### Power Controls
- Close dashboard
- Lock (hyprlock)
- Logout
- Reboot
- Shutdown

## Polling Intervals

| Variable | Interval | Output |
|----------|----------|--------|
| network_info | 5s | text |
| wifi_ssid | 5s | text |
| vpn_status | 5s | text |
| bluetooth_status | 5s | text |
| net_upload/download | 1s | text |
| net_ping | 2s | text |
| cpu_stats | 1s | JSON |
| mem_stats | 2s | JSON |
| swap_stats | 5s | JSON |
| disk_stats | 30s | JSON |
| spotify_info | 2s | JSON |
| spotify_art | 2s | path |
| volume_percent | 1s | number |
| brightness_percent | 1s | number |
| visualizer_content | 50ms | pango markup |

## Usage

```bash
# Open dashboard
eww open dashboard

# Close dashboard
eww close dashboard

# Reload configuration
eww reload
```

## Customization

### Colors
Edit `eww.scss` color variables:
```scss
$fg-bright: #d9d9d9;
$green-bright: #b8bb26;
$cyan-bright: #8ec07c;
// etc.
```

### Widget Layout
Edit `eww.yuck` layout widget to rearrange panels.

### Polling Scripts
Scripts in `widgets/*/scripts/` return data for widgets. Modify output format as needed.
