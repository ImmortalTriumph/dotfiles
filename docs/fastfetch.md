# Fastfetch System Info Configuration

System information display with custom ASCII art logo and Gruvbox colors.

## Configuration Files

| File | Purpose |
|------|---------|
| `~/.config/fastfetch/config.jsonc` | Main configuration |
| `~/.config/fastfetch/image.txt` | Custom ASCII art logo |

## Launch

```bash
fastfetch
# or
neofetch  # aliased to fastfetch
```

## Displayed Information

### System Section
| Key | Module |
|-----|--------|
| `os` | Operating system |
| `host` | Hardware model |
| `ker` | Kernel version |
| `up` | Uptime |
| `bat` | Battery status |
| `pkg` | Package count |
| `loc` | Locale |

### Desktop Section
| Key | Module |
|-----|--------|
| `disp` | Display resolution |
| `de` | Desktop Environment |
| `wm` | Window Manager (Hyprland) |
| `lm` | Login Manager |
| `wmth` | WM Theme |
| `theme` | GTK Theme |
| `icons` | Icon theme |

### Terminal Section
| Key | Module |
|-----|--------|
| `sh` | Shell (zsh) |
| `term` | Terminal (kitty) |
| `font` | Terminal font |

### Media Section
| Key | Module |
|-----|--------|
| `vol` | Volume level |
| `play` | Now playing (Spotify) |

## Layout

Output is organized with section headers:
```
── system ──────────────────────────
── desktop ─────────────────────────
── terminal ────────────────────────
── media ───────────────────────────
```

Ends with terminal color palette display.

## Colors

| Element | Color |
|---------|-------|
| Keys | Yellow |
| Values | White |
| Username | Blue |
| Hostname | Cyan |
| Section headers | Green |

## Logo

Custom ASCII art loaded from `~/.config/fastfetch/image.txt` with padding:
- Top: 2
- Left: 1
- Right: 4

## Configuration Structure

```json
{
    "logo": { "source": "...", "type": "file", "padding": {...} },
    "display": {
        "separator": "  ",
        "color": { "keys": "yellow", "output": "white" },
        "key": { "width": 10 }
    },
    "modules": [...]
}
```

## Dependencies

- `fastfetch`

## Customization

### Change Logo
Replace content in `~/.config/fastfetch/image.txt` or change the logo source:
```json
"logo": {
    "source": "arch",  // Built-in logo
    "type": "auto"
}
```

### Add/Remove Modules
Edit the `modules` array in `config.jsonc`. Available modules:
- System: `os`, `host`, `kernel`, `uptime`, `battery`, `packages`, `locale`
- Desktop: `display`, `de`, `wm`, `lm`, `wmtheme`, `theme`, `icons`, `cursor`
- Hardware: `cpu`, `gpu`, `memory`, `disk`, `swap`
- Terminal: `shell`, `terminal`, `terminalfont`
- Media: `sound`, `media`, `player`
- Formatting: `title`, `separator`, `break`, `custom`, `colors`

### Change Colors
Modify the `display.color` section:
```json
"color": {
    "keys": "blue",
    "output": "cyan"
}
```
