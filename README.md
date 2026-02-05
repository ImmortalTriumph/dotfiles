# ImmortalTriumph/dotfiles

Arch Linux + Hyprland rice configuration with Gruvbox dark theme. Security-focused setup with BlackArch integration for CTF preparation and penetration testing.

![Screenshot](docs/assets/screenshot.png)
*Screenshot coming soon*

## Components

| Component | Version | Config Location | Purpose |
|-----------|---------|-----------------|---------|
| Hyprland | 0.53.1 | `.config/hypr/` | Wayland compositor |
| Waybar | 0.14.0 | `.config/waybar/` | Status bar |
| EWW | 0.6.0 | `.config/eww/` | Dashboard widgets |
| Kitty | 0.45.0 | `.config/kitty/` | Terminal emulator |
| Neovim | 0.11.5 | `.config/nvim/` | Editor |
| Rofi | 2.0.0 | `.config/rofi/` | Application launcher |
| Cava | 0.10.6 | `.config/cava/` | Audio visualizer |
| Zsh | 5.9 | `.zshrc` | Shell |

## Quick Start

```bash
# Clone repository
git clone https://github.com/ImmortalTriumph/dotfiles ~/dotfiles
cd ~/dotfiles

# Install dependencies (Arch Linux)
paru -S hyprland waybar eww kitty neovim rofi cava zsh

# Deploy with GNU Stow
paru -S stow
stow -t ~ .

# Reload Hyprland
hyprctl reload
```

## Directory Structure

```
dotfiles/
├── .config/
│   ├── hypr/                  # Hyprland window manager
│   │   ├── hyprland.conf      # Main config (sources modules)
│   │   ├── hyprlock.conf      # Lock screen
│   │   ├── hypridle.conf      # Idle manager
│   │   └── config/            # Modular configs (12 files)
│   │       ├── binds.conf     # Keybindings
│   │       ├── variables.conf # Variables & autostart
│   │       ├── decoration.conf
│   │       ├── animation.conf
│   │       ├── input.conf
│   │       ├── layout.conf
│   │       ├── monitor.conf
│   │       ├── workspace.conf
│   │       ├── windowrule.conf
│   │       ├── gesture.conf
│   │       ├── general.conf
│   │       └── misc.conf
│   ├── waybar/                # Status bar
│   │   ├── config.jsonc
│   │   └── style.css
│   ├── eww/                   # Dashboard widgets
│   │   ├── eww.yuck           # Widget definitions
│   │   ├── eww.scss           # Styling
│   │   ├── widgets/           # Widget modules
│   │   └── scripts/           # Backend scripts
│   ├── kitty/                 # Terminal
│   │   └── kitty.conf
│   ├── nvim/                  # Neovim
│   │   ├── init.lua
│   │   └── lua/
│   ├── rofi/                  # Application launcher
│   │   ├── config.rasi
│   │   └── theme.rasi
│   └── cava/                  # Audio visualizer
│       └── config
├── .zshrc                     # Zsh configuration
├── .bashrc                    # Bash configuration
├── docs/                      # Documentation
│   ├── installation.md
│   ├── hyprland.md
│   ├── eww.md
│   └── keybindings.md
└── README.md
```

## Keybindings

**Modifier**: `Super` (Win key)

### Essential

| Binding | Action |
|---------|--------|
| `Super + T` | Open terminal (Kitty) |
| `Super + R` | Open launcher (Rofi) |
| `Super + Q` | Close window |
| `Super + V` | Toggle floating |
| `Super + L` | Lock screen |
| `Super + F` | Open dashboard (EWW) |
| `Super + E` | File manager (Thunar) |

### Workspaces

| Binding | Action |
|---------|--------|
| `Super + 1-5` | Switch to workspace |
| `Super + Shift + 1-5` | Move window to workspace |
| `Super + Scroll` | Cycle workspaces |

### Screenshots

| Binding | Action |
|---------|--------|
| `Super + S` | Full screen to clipboard |
| `Super + Shift + S` | Selection to clipboard |
| `Super + Ctrl + S` | Full screen to file |
| `Super + Alt + S` | Selection to file |

### Media

| Binding | Action |
|---------|--------|
| `XF86AudioRaiseVolume` | Volume up |
| `XF86AudioLowerVolume` | Volume down |
| `XF86AudioMute` | Toggle mute |
| `XF86AudioPlay` | Play/pause |
| `XF86AudioPrev/Next` | Previous/next track |

See [docs/keybindings.md](docs/keybindings.md) for complete reference.

## Features

- **Gruvbox Dark** color scheme across all components
- **Modular Hyprland** configuration (12 separate config files)
- **EWW Dashboard** with system stats, media controls, network info
- **Cava Integration** audio visualizer in EWW widgets
- **Spotify Support** media integration via playerctl
- **BlackArch Tools** security/forensics toolkit support

## Documentation

- [Installation Guide](docs/installation.md) - Full setup instructions
- [Hyprland Config](docs/hyprland.md) - Window manager details
- [EWW Widgets](docs/eww.md) - Dashboard customization
- [Keybindings](docs/keybindings.md) - Complete keybinding reference

## Customization

### Colors

The Gruvbox palette is defined in:
- `.config/eww/eww.scss` - `$gruvbox-*` variables
- `.config/waybar/style.css` - CSS variables
- `.config/kitty/kitty.conf` - Terminal colors

### Adding Keybindings

Edit `.config/hypr/config/binds.conf`:
```
bind = $mainMod, KEY, exec, command
```

Then reload: `hyprctl reload`

### Fonts

Primary font: **JetBrains Mono Nerd Font**

```bash
paru -S ttf-jetbrains-mono-nerd
fc-cache -fv
```

## Troubleshooting

**Config not applying:**
```bash
hyprctl reload
killall waybar && waybar &
eww reload
```

**Check syntax:**
```bash
hyprland --config ~/.config/hypr/hyprland.conf
zsh -n ~/.zshrc
```

**View logs:**
```bash
journalctl --user -u hyprland.service -f
```

## Credits

- [Hyprland](https://hyprland.org/)
- [Gruvbox](https://github.com/morhetz/gruvbox)
- [r/unixporn](https://reddit.com/r/unixporn)
- Layout reference: [dionysus](https://github.com/pewdiepie-archdaemon/dionysus)

## License

MIT
