# Kitty Terminal Configuration

GPU-accelerated terminal emulator with Gruvbox color scheme and powerline tabs.

## Configuration File

`~/.config/kitty/kitty.conf`

## Font

| Setting | Value |
|---------|-------|
| Font | JetBrainsMono Nerd Font |
| Size | 14 |
| Fallback | Noto Sans Mono CJK SC |

Nerd Font symbols and CJK characters are mapped to appropriate fallback fonts.

## Colors (Gruvbox Dark)

| Element | Color |
|---------|-------|
| Background | `#1a1a1a` |
| Foreground | `#d9d9d9` |
| Cursor | `#d9d9d9` |
| Cursor text | `#1a1a1a` |
| Selection BG | `#4d4d4d` |
| Selection FG | `#d9d9d9` |
| URL | `#83a598` (curly underline) |

### Color Palette

| Color | Normal | Bright |
|-------|--------|--------|
| Black | `#1a1a1a` | `#808080` |
| Red | `#cc241d` | `#fb4934` |
| Green | `#98971a` | `#b8bb26` |
| Yellow | `#d79921` | `#fabd2f` |
| Blue | `#458588` | `#83a598` |
| Magenta | `#b16286` | `#d3869b` |
| Cyan | `#689d6a` | `#8ec07c` |
| White | `#d9d9d9` | `#d9d9d9` |

## Window

| Setting | Value |
|---------|-------|
| Padding | 16px all sides |
| Dynamic opacity | Enabled |

## Tab Bar

| Setting | Value |
|---------|-------|
| Position | Top |
| Style | Powerline (slanted) |
| Active tab FG | `#1a1a1a` |
| Active tab BG | `#b8bb26` (green) |
| Inactive tab FG | `#d9d9d9` |
| Inactive tab BG | `#4d4d4d` |
| Tab bar BG | `#1a1a1a` |

## Behavior

| Setting | Value |
|---------|-------|
| Scrollback | 10,000 lines |
| Copy on select | To clipboard |
| Strip trailing spaces | Smart |
| Cursor blink | 0.5s interval |

## Keybindings

| Key | Action |
|-----|--------|
| `Ctrl+Shift+C` | Copy |
| `Ctrl+Shift+V` | Paste |
| `Ctrl+Shift+T` | New tab |
| `Ctrl+Shift+Q` | Close tab |
| `Ctrl+Shift+Right` | Next tab |
| `Ctrl+Shift+Left` | Previous tab |
| `Ctrl+Shift+Enter` | New window |
| `Ctrl+Shift+]` | Next window |
| `Ctrl+Shift+[` | Previous window |
| `Ctrl+Shift+F5` | Reload config |
| `Ctrl+Shift+F11` | Toggle fullscreen |
| `Ctrl+Shift+U` | Unicode input |
| `Ctrl+Shift+E` | Open URL hint |

## Dependencies

- `kitty`
- `ttf-jetbrains-mono-nerd`
- `noto-fonts-cjk`

## Reload Command

Restart terminal or press `Ctrl+Shift+F5`
