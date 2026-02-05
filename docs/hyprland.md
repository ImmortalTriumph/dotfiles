# Hyprland Configuration

Modular Hyprland 0.53.1 configuration with security-focused workflow.

## Directory Structure

```
hypr/
├── hyprland.conf      # Main config (includes modules)
├── hyprlock.conf      # Lock screen config
├── hyprpaper.conf     # Wallpaper config
├── config/
│   ├── general.conf       # General settings
│   ├── variables.conf     # Startup programs
│   ├── monitor.conf       # Display configuration
│   ├── input.conf         # Input device settings
│   ├── layout.conf        # Tiling layout
│   ├── decoration.conf    # Visual decorations
│   ├── animation.conf     # Animation settings
│   ├── binds.conf         # Keybindings
│   ├── windowrule.conf    # Window rules
│   ├── workspace.conf     # Workspace config
│   ├── gesture.conf       # Touchpad gestures
│   └── misc.conf          # Miscellaneous
└── wallpaper/
    ├── wallpaper.jpg      # Desktop wallpaper
    └── lock.png           # Lock screen wallpaper
```

## Key Bindings

### Application Launchers
| Binding | Action |
|---------|--------|
| `Super + Return` | Kitty terminal |
| `Super + D` | Rofi launcher |
| `Super + E` | Thunar file manager |
| `Super + B` | Firefox |

### Window Management
| Binding | Action |
|---------|--------|
| `Super + Q` | Close window |
| `Super + F` | Toggle fullscreen |
| `Super + V` | Toggle floating |
| `Super + P` | Toggle pseudo-tile |
| `Super + J` | Toggle split |

### Workspace Navigation
| Binding | Action |
|---------|--------|
| `Super + 1-9` | Switch to workspace |
| `Super + Shift + 1-9` | Move window to workspace |
| `Super + Mouse Scroll` | Cycle workspaces |

### System
| Binding | Action |
|---------|--------|
| `Super + L` | Lock screen |
| `Super + Shift + S` | Screenshot region |
| `Print` | Screenshot full |

### Media Keys
| Binding | Action |
|---------|--------|
| `XF86AudioRaiseVolume` | Volume up 5% |
| `XF86AudioLowerVolume` | Volume down 5% |
| `XF86AudioMute` | Toggle mute |
| `XF86AudioPlay` | Play/pause |
| `XF86AudioNext/Prev` | Next/previous track |

## Window Rules

### Layer Rules
- `eww-dashboard`: Blur, overlay, highest priority
- `rofi`: Blur enabled
- `waybar`: Blur enabled
- `hyprpaper`: No blur (background)

### Float Rules
Automatically float: file dialogs, image viewers, video players, system utilities, PiP windows.

### Security Tools
Tiled by default: Burp Suite, Wireshark, Ghidra, Autopsy.

## Startup Programs

Configured in `variables.conf`:
- waybar
- hyprpaper
- cava + cava-viz.py
- EWW daemon

## Reload

```bash
hyprctl reload
```
