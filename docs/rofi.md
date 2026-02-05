# Rofi Launcher Configuration

Application launcher with two-column layout and Gruvbox theme.

## Configuration Files

| File | Purpose |
|------|---------|
| `~/.config/rofi/config.rasi` | Main configuration |
| `~/.config/rofi/theme.rasi` | Theme and styling |
| `~/.config/rofi/image.jpg` | Banner image |

## Launch

Default keybinding in Hyprland: `Super + D`

```bash
rofi -show drun
```

## Modes

| Mode | Icon | Description |
|------|------|-------------|
| `drun` |  | Desktop applications |
| `run` |  | Executables in PATH |

## Keybindings (inside Rofi)

| Key | Action |
|-----|--------|
| `Enter` | Select item |
| `Escape` | Close |
| `Tab` | Switch mode |
| `Up/Down` | Navigate list |
| `Ctrl+J/K` | Navigate list (vim-style) |
| Type | Filter results |

## Layout

- **Width:** 1000px
- **Lines:** 8 visible
- **Layout:** Two-column (image banner on left, list on right)
- **Border radius:** 6px
- **Scrollbar:** Enabled
- **Padding:** 15px

## Theme (Gruvbox Dark)

| Element | Color |
|---------|-------|
| Background | `#1a1a1a` (98% opacity) |
| Background Soft | `#252525` |
| Foreground | `#d9d9d9` |
| Border | `#4d4d4d` |
| Accent | `#b3b3b3` |
| Selected | Orange (`#fe8019`) |
| Active | Blue (`#83a598`) / Green (`#b8bb26`) |
| Urgent | Red (`#fb4934`) |

### Element States

| State | Background | Text |
|-------|------------|------|
| Normal | Transparent | `#d9d9d9` |
| Selected | `#fe8019` | `#1a1a1a` |
| Active | Transparent | `#83a598` |
| Selected Active | `#b8bb26` | `#1a1a1a` |
| Urgent | Transparent | `#fb4934` |
| Selected Urgent | `#fb4934` | `#1a1a1a` |

## Font

JetBrainsMono Nerd Font, 14px (list) / 12px (config)

## Configuration Options

| Option | Value |
|--------|-------|
| `show-icons` | true |
| `scroll-method` | 0 |
| `disable-history` | false |
| `sidebar-mode` | false |
| `drun-display-format` | `{name}` |

## Dependencies

- `rofi`
- `ttf-jetbrains-mono-nerd`

## Customization

### Change Banner Image
Replace `~/.config/rofi/image.jpg` with your preferred image.

### Modify Colors
Edit color variables in `~/.config/rofi/theme.rasi`:
```css
bg:      #1a1a1a;
fg:      #d9d9d9;
orange:  #fe8019;
```
