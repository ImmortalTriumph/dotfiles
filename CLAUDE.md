# ImmortalTriumph/dotfiles - Claude Code Configuration

**Repository**: https://github.com/ImmortalTriumph/dotfiles
**Stack**: Arch Linux | Hyprland 0.53.1 | Wayland | BlackArch

Security-focused Arch Linux Hyprland configuration with CTF/pentesting toolkit integration.

---

## Directory Structure

```
dotfiles/
├── .config/
│   ├── hypr/           # Hyprland (modular: 12 files in config/)
│   ├── waybar/         # Status bar
│   ├── eww/            # Dashboard widgets
│   ├── kitty/          # Terminal
│   ├── nvim/           # Neovim
│   ├── rofi/           # Launcher
│   └── cava/           # Audio visualizer
├── .zshrc              # Shell config
├── .bashrc             # Bash fallback
└── docs/               # Documentation
```

---

## Key Configuration Files

| Component | Config | Reload Command |
|-----------|--------|----------------|
| Hyprland | `.config/hypr/hyprland.conf` | `hyprctl reload` |
| Waybar | `.config/waybar/config.jsonc` | `killall waybar && waybar &` |
| EWW | `.config/eww/eww.yuck` | `eww reload` |
| Kitty | `.config/kitty/kitty.conf` | Restart terminal |
| Zsh | `.zshrc` | `source ~/.zshrc` |

### Hyprland Modular Config

Main config sources 12 modules from `.config/hypr/config/`:
- `binds.conf` - Keybindings
- `variables.conf` - Variables, autostart, environment
- `decoration.conf`, `animation.conf` - Visual effects
- `input.conf`, `gesture.conf` - Input handling
- `monitor.conf`, `layout.conf`, `workspace.conf` - Display
- `windowrule.conf` - Window rules
- `general.conf`, `misc.conf` - General settings

---

## Modification Guidelines

### Safe to Modify
- All files in `.config/` (user configs)
- Color values in theme files
- Keybindings in `binds.conf`
- Shell aliases in `.zshrc`

### Handle with Care
- Symlinked files (maintain source and link)
- Font cache (regenerate: `fc-cache -fv`)

### Never Modify
- Package manager caches
- API keys or credentials
- Wordlists/security databases

---

## Validation Commands

```bash
# Hyprland syntax
hyprland --config ~/.config/hypr/hyprland.conf

# Zsh syntax
zsh -n ~/.zshrc

# Reload all
hyprctl reload && killall waybar && waybar & && eww reload
```

---

## Sensitive Information Policy

**Never commit:**
- CTF flags or solutions
- API keys/tokens
- Credentials
- SSH private keys

**Safe approach:**
1. Store secrets in `~/.local/share/secrets/` (gitignored)
2. Source via: `source ~/.local/share/secrets/tokens.sh`
3. Reference only via environment variables

---

## Color Scheme

**Gruvbox Dark** - defined in:
- `.config/eww/eww.scss` - `$gruvbox-*` SCSS variables
- `.config/waybar/style.css` - CSS variables
- `.config/kitty/kitty.conf` - Terminal palette

---

## Common Tasks

### Add Keybinding
Edit `.config/hypr/config/binds.conf`:
```
bind = $mainMod, KEY, exec, command
```
Then: `hyprctl reload`

### Change Colors
1. Edit color variables in respective config files
2. Reload affected components

### Add Autostart Application
Edit `.config/hypr/config/variables.conf`:
```
exec-once = application
```

---

## Security Tools Integration

BlackArch tools available:
- Steganography: steghide, stegsolve, stegdetect, stegseek
- Forensics: Autopsy, emldump, xorsearch
- APK analysis: android-apktool
- Wordlists: seclists

---

## Resources

- [Hyprland Wiki](https://wiki.hyprland.org)
- [Arch Wiki](https://wiki.archlinux.org)
- [BlackArch](https://blackarch.org)
