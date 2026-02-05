# Keybindings Reference

Complete keybinding reference for the Hyprland configuration.

**Primary Modifier**: `Super` (Win key)

Config file: `.config/hypr/config/binds.conf`

---

## Window Management

| Binding | Action |
|---------|--------|
| `Super + Q` | Close active window |
| `Super + V` | Toggle floating mode |
| `Super + P` | Toggle pseudo-tiling |
| `Super + J` | Toggle split direction |
| `Super + Delete` | Exit Hyprland |

---

## Applications

| Binding | Action | Application |
|---------|--------|-------------|
| `Super + T` | Open terminal | Kitty |
| `Super + R` | Open launcher | Rofi |
| `Super + E` | Open file manager | Thunar |
| `Super + F` | Open dashboard | EWW |
| `Super + L` | Lock screen | Hyprlock |

---

## Workspaces

### Switch Workspace

| Binding | Action |
|---------|--------|
| `Super + 1` | Switch to workspace 1 |
| `Super + 2` | Switch to workspace 2 |
| `Super + 3` | Switch to workspace 3 |
| `Super + 4` | Switch to workspace 4 |
| `Super + 5` | Switch to workspace 5 |

### Move Window to Workspace

| Binding | Action |
|---------|--------|
| `Super + Shift + 1` | Move window to workspace 1 |
| `Super + Shift + 2` | Move window to workspace 2 |
| `Super + Shift + 3` | Move window to workspace 3 |
| `Super + Shift + 4` | Move window to workspace 4 |
| `Super + Shift + 5` | Move window to workspace 5 |

### Mouse Navigation

| Binding | Action |
|---------|--------|
| `Super + Scroll Down` | Next workspace |
| `Super + Scroll Up` | Previous workspace |

---

## Screenshots

All screenshots use `grim` (Wayland screenshot tool) and `slurp` (region selector).

| Binding | Action | Output |
|---------|--------|--------|
| `Super + S` | Capture full screen | Clipboard |
| `Super + Shift + S` | Capture selected region | Clipboard |
| `Super + Ctrl + S` | Capture full screen | `~/Pictures/Screenshots/` |
| `Super + Alt + S` | Capture selected region | `~/Pictures/Screenshots/` + notification |

Screenshots saved to file use timestamp naming: `YYYY-MM-DD-HHMMSS.png`

---

## Brightness Control

| Binding | Action |
|---------|--------|
| `Super + =` (Equal) | Increase brightness 10% |
| `Super + -` (Minus) | Decrease brightness 10% |

---

## Media Keys

Hardware media keys (no modifier required):

### Volume

| Key | Action |
|-----|--------|
| `XF86AudioRaiseVolume` | Volume up 5% |
| `XF86AudioLowerVolume` | Volume down 5% |
| `XF86AudioMute` | Toggle mute |

### Playback

| Key | Action |
|-----|--------|
| `XF86AudioPlay` | Play/pause media |
| `XF86AudioPrev` | Previous track |
| `XF86AudioNext` | Next track |

---

## Adding Custom Keybindings

Edit `.config/hypr/config/binds.conf`:

```
# Standard bind
bind = $mainMod, KEY, action, argument

# Examples
bind = $mainMod, B, exec, firefox
bind = $mainMod SHIFT, R, exec, hyprctl reload
```

### Bind Types

| Type | Description |
|------|-------------|
| `bind` | Standard keybinding |
| `bindel` | Bind that executes while held (for volume, etc.) |
| `bindl` | Locked bind (works even when locked) |

### Reload After Changes

```bash
hyprctl reload
```

---

## Quick Reference Card

```
╔═══════════════════════════════════════════════════════╗
║                  ESSENTIAL BINDINGS                    ║
╠═══════════════════════════════════════════════════════╣
║  Super + T     Terminal      Super + Q     Close      ║
║  Super + R     Launcher      Super + V     Float      ║
║  Super + E     Files         Super + L     Lock       ║
║  Super + F     Dashboard     Super + 1-5   Workspace  ║
╠═══════════════════════════════════════════════════════╣
║                    SCREENSHOTS                         ║
╠═══════════════════════════════════════════════════════╣
║  Super + S           Full screen → clipboard          ║
║  Super + Shift + S   Selection → clipboard            ║
║  Super + Ctrl + S    Full screen → file               ║
║  Super + Alt + S     Selection → file                 ║
╚═══════════════════════════════════════════════════════╝
```
