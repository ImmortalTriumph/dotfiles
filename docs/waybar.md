# Waybar Status Bar Configuration

Floating status bar with Gruvbox styling for Hyprland.

## Configuration Files

| File | Purpose |
|------|---------|
| `~/.config/waybar/config.jsonc` | Modules and behavior |
| `~/.config/waybar/style.css` | Styling |

## Position

Top of screen with margins (floating style):
- Margin top: 6px
- Margin left/right: 10px
- Height: 40px

## Modules

### Left
- **Workspaces** - Hyprland workspace switcher
- **MPRIS** - Spotify media info

### Center
- **Clock** - Time with calendar tooltip

### Right
- **CPU** - CPU usage percentage
- **Memory** - RAM usage percentage
- **PulseAudio** - Volume control
- **Network** - WiFi/Ethernet status
- **Bluetooth** - Bluetooth status
- **Battery** - Battery level
- **Tray** - System tray

## Module Interactions

### Workspaces

| Action | Effect |
|--------|--------|
| Click | Switch to workspace |
| Scroll up | Next workspace |
| Scroll down | Previous workspace |

Shows 5 persistent workspaces, sorted by number.

### Clock

| Action | Effect |
|--------|--------|
| Click | Toggle time/date format |
| Hover | Show calendar |

**Formats:**
- Default: `  HH:MM`
- Alternate: `  Day, Mon DD`

### PulseAudio

| Action | Effect |
|--------|--------|
| Click | Toggle mute |
| Scroll up | Volume +5% |
| Scroll down | Volume -5% |

**Icons:** `` `` `` (volume levels), `` (muted), `` (headphones)

### MPRIS (Spotify)

| Action | Effect |
|--------|--------|
| Click | Play/Pause |
| Scroll up | Next track |
| Scroll down | Previous track |

**Format:** `{status_icon}  {artist} - {title}` (max 45 chars)

**Icons:** `` (playing), `` (paused)

### Network

| Action | Effect |
|--------|--------|
| Click | Open nm-connection-editor |
| Hover | Show IP, SSID, bandwidth |

**Icons:** `` (WiFi), `` (Ethernet), `` (Disconnected)

### Bluetooth

| Action | Effect |
|--------|--------|
| Click | Open Blueman |

### Battery

**Icons:** `` to `` (discharge levels), `` (charging), `` (plugged)

**States:**
| State | Threshold |
|-------|-----------|
| Warning | 30% |
| Critical | 15% |

## Styling

| Element | Style |
|---------|-------|
| Background | `rgba(18, 18, 18, 0.9)` |
| Border | `#333333` |
| Border radius | 6px |
| Font | JetBrains Mono Nerd Font, 16px |
| Text color | `#d9d9d9` |

### Module Colors

| Module | Normal | Special State |
|--------|--------|---------------|
| Clock | `#b3b3b3` | - |
| CPU/Memory | `#999999` | - |
| PulseAudio | `#999999` | Muted: `#555555` |
| Network | `#999999` | Disconnected: `#555555` |
| Battery | `#999999` | Warning: `#cccccc`, Critical: `#ff6666`, Charging: `#88cc88` |
| Workspaces | Active: `#ffffff`, Inactive: `#666666` | Urgent: `#ff6666` |
| MPRIS | Playing: `#b3b3b3`, Paused: `#666666` | - |

### Hover Effects

Network, Bluetooth, and PulseAudio modules change to blue (`#83a598`) on hover with slightly brighter background.

## Dependencies

- `waybar`
- `ttf-jetbrains-mono-nerd`
- `playerctl` (for MPRIS)
- `networkmanager` + `nm-connection-editor`
- `blueman`
- `pulseaudio` or `pipewire-pulse`

## Reload Command

```bash
killall waybar && waybar &
```
