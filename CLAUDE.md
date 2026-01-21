# ImmortalTriumph/dotfiles - Claude Code Configuration

**Description**: arch-hyprland rice config for edgelord wannabes  
**Repository**: https://github.com/ImmortalTriumph/dotfiles  
**Session Type**: Wayland (Hyprland)  
**Total Packages**: 79

---

## Project Overview

Security-focused Arch Linux Hyprland ricing configuration with comprehensive toolkit for CTF competition preparation, penetration testing, and system customization. Integrates BlackArch tools, steganography utilities, forensic analysis tools, and professional development environment alongside aesthetic desktop customization.

**Core Stack**: Hyprland 0.53.1 | Wayland | Arch Linux Rolling Release | BlackArch Mirror

---

## Directory Structure

```
dotfiles/
├── .config/
│   ├── hypr/              # Hyprland window manager (0.53.1)
│   │   ├── hyprland.conf
│   │   ├── hyprlock.conf
│   │   └── hypridle.conf
│   ├── waybar/            # Status bar (0.14.0)
│   │   ├── config.jsonc
│   │   └── style.css
│   ├── rofi/              # Application launcher (2.0.0)
│   │   ├── config.rasi
│   │   └── themes/
│   ├── kitty/             # Terminal emulator (0.45.0)
│   │   └── kitty.conf
│   ├── nvim/              # Neovim editor (0.11.5)
│   │   ├── init.lua
│   │   └── lua/
│   ├── zsh/               # Shell configuration (5.9)
│   │   ├── .zshrc
│   │   └── plugins/
│   ├── eww/               # Widget system (0.6.0)
│   │   ├── eww.yuck
│   │   └── eww.scss
│   └── other/             # Additional configs
├── .bashrc                # Bash configuration
├── .local/share/
│   └── fonts/             # JetBrains Mono Nerd Font
├── scripts/               # Automation & setup
│   ├── install.sh         # Dependency installer
│   ├── deploy.sh          # Dotfiles deployment
│   └── steg_tools.sh      # Steganography helpers
├── wallpapers/            # Hyprland backgrounds
├── themes/                # Color schemes & GTK/Qt
└── README.md              # Main documentation
```

---

## Installed Dependencies (79 packages)

### Window Manager & Compositors
- `hyprland` 0.53.1 - Wayland compositor (primary)
- `hyprland-workspaces` 2.0.4 - Workspace management
- `eww` 0.6.0 - Elkowar's Wacky Widgets system

### Lock & Display Management
- `hyprlock` 0.9.2 - Wayland lock screen
- `hyprpaper` 0.8.1 - Background/wallpaper manager
- `sddm` 0.21.0 - Display manager

### Bars & System Monitoring
- `waybar` 0.14.0 - Wayland status bar (primary)
- `cava` 0.10.6 - Audio spectrum visualization
- `pavucontrol` 6.2 - PulseAudio volume control
- `wireplumber` 0.5.13 - PipeWire session manager
- `efibootmgr` 18 - EFI boot manager

### Application Launcher & Terminal
- `rofi` 2.0.0 - Application launcher & switcher
- `kitty` 0.45.0 - GPU-accelerated terminal
- `zsh` 5.9 - Z Shell (primary shell)

### Editors
- `vim` 9.1.1975 - Vi improved
- `neovim` 0.11.5 - Vim-fork (primary editor)

### Fonts & Icon Themes
- `ttf-jetbrains-mono` 2.304 - JetBrains Mono regular
- `ttf-jetbrains-mono-nerd` 3.4.0 - JetBrains Mono Nerd Font
- `noto-fonts-cjk` 20240730 - CJK font support
- `noto-fonts-emoji` 2.051 - Emoji font support
- `papirus-icon-theme` 20250501 - Papirus icon set
- `arc-gtk-theme` 20221218 - Arc GTK theme
- `nordic-darker-theme` 2.2.0 - Nordic dark theme
- `adwaita-dark` 1.0 - Adwaita dark GTK
- `kvantum` 1.1.5 - Qt5/Qt6 theme engine

### Screenshot & Image Tools
- `grim` 1.5.0 - Wayland screenshot tool
- `slurp` 1.5.0 - Region selector for grim
- `imagemagick` 7.1.2 - Image manipulation
- `jp2a` 1.3.3 - JPEG to ASCII art
- `neofetch` 7.1.0 - System information display

### Wayland & XDG Portals
- `xdg-desktop-portal-gtk` 1.15.3 - GTK portal backend
- `xdg-desktop-portal-hyprland` 1.3.11 - Hyprland-specific portals

### Theme & Appearance Tools
- `nwg-look` 1.0.6 - GTK3 theme selector
- `qt5ct` 1.9 - Qt5 configuration tool
- `qt6ct` 0.11 - Qt6 configuration tool
- `granite` 6.2.0 - Elementary OS design library
- `thunar` 4.20.6 - File manager

### Audio & Bluetooth
- `blueman` 2.4.6 - Bluetooth manager
- `bluez-utils` 5.85 - BlueZ utilities
- `pipewire-audio` 1.4.9 - PipeWire audio server
- `pipewire-pulse` 1.4.9 - PipeWire PulseAudio compatibility

### Network & VPN
- `networkmanager` 1.54.3 - Network management
- `openssh` 10.2p1 - SSH client/server
- `openvpn` 2.6.17 - OpenVPN client
- `tor` 0.4.8.21 - Tor anonymity network
- `tor-browser` 15.0.3 - Tor Browser (15.0.3)

### Development & Build Tools
- `base-devel` 1 - Base development packages
- `git` 2.52.0 - Version control
- `rustup` 1.28.2 - Rust toolchain manager
- `python-pip` 25.3 - Python package manager
- `qemu-desktop` 10.1.2 - QEMU virtualization

### Security & Forensics ⚠️ ADVANCED TOOLS
- `autopsy` 4.22.1 - Forensic analysis framework
- `android-apktool` 2.7.0 - APK reverse engineering
- `openstego` 0.8.6 - Steganography tool
- `steghide` 0.5.1 - Steganography (JPEG/WAV/BMP)
- `stegdetect` 20.28a4f07 - Steganography detection
- `stegseek` 0.6 - Steghide brute-force cracker
- `stegsolve` 1.3 - Image steganography analyzer
- `emldump` 0.0.11 - Email dump analysis
- `xorsearch` 1.11.4 - XOR pattern search utility
- `seclists` 2025.3 - Security wordlists
- `wordlists` 0.5 - Comprehensive wordlists

### BlackArch Tools & Repos
- `blackarch-mirrorlist` 20251205 - BlackArch mirror list
- `blackarch-officials` 20251027 - Official BlackArch packages

### Package Managers & System
- `paru` 2.0.4 - AUR helper (concurrent)
- `yay` 12.5.7 - AUR helper
- `yay-debug` 12.5.7 - Debug symbols for yay
- `base` 3 - Base package group
- `sudo` 1.9.17 - Sudo privilege escalation
- `linux` 6.18.3.arch1 - Linux kernel
- `linux-firmware` 20251125 - Linux firmware
- `grub` 2.14rc1 - Boot loader
- `grub2-theme-preview` 2.9.1 - GRUB theme preview
- `man-db` 2.13.1 - Manual page database

### Applications
- `firefox` 146.0.1 - Web browser
- `discord` 0.0.119 - Discord client
- `spotify-launcher` 0.6.4 - Spotify launcher
- `opera` 125.0.5729 - Opera web browser
- `flatpak` 1.16.2 - Flatpak runtime

---

## Installation & Deployment

### Quick Start

```bash
# Clone repository
git clone https://github.com/ImmortalTriumph/dotfiles ~/dotfiles
cd ~/dotfiles

# Run installation script (installs all 79 packages)
./scripts/install.sh

# Deploy dotfiles with stow
paru -S stow  # or yay -S stow
stow -d ~ -t ~ config local share

# Reload Hyprland
hyprctl reload
```

### Prerequisites

```bash
sudo pacman -Syyu
sudo pacman -S base-devel git

# Add BlackArch mirror (for forensics/security tools)
# Edit /etc/pacman.conf to include BlackArch mirror
sudo pacman -Syyu
```

### Layout References

Check out these github repo for reference for layout.
https://github.com/pewdiepie-archdaemon/dionysus


---

## Key Files & Configuration

### Hyprland (0.53.1)
- **Main config**: `~/.config/hypr/hyprland.conf`
- **Lock screen**: `~/.config/hypr/hyprlock.conf`
- **Idle manager**: `~/.config/hypr/hypridle.conf`
- **Reload**: `hyprctl reload`

### Status Bar (Waybar 0.14.0)
- **Config**: `~/.config/waybar/config.jsonc`
- **Styling**: `~/.config/waybar/style.css`
- **Reload**: `killall waybar && waybar &`

### Terminal & Shell
- **Terminal**: Kitty 0.45.0 (`~/.config/kitty/kitty.conf`)
- **Shell**: Zsh 5.9 (`~/.zshrc`)
- **Editor**: Neovim 0.11.5 (`~/.config/nvim/init.lua`)

### Application Launcher
- **Rofi 2.0.0**: `~/.config/rofi/config.rasi`

### Color Scheme Management
- **Master theme file**: `~/.config/theme.conf`
- **Format**: `#RRGGBB` hex values with variables
- **Variables**: `$bg`, `$fg`, `$accent`, `$border`, `$inactive`

---

## Keybindings

**Primary Modifier**: `Super` (Win key)  
**Secondary Modifier**: `Alt`  
**Tertiary Modifier**: `Ctrl`

### Critical Bindings
```
Super + Return        → Launch Kitty terminal
Super + D             → Open Rofi launcher
Super + Q             → Close focused window
Super + F             → Toggle fullscreen
Super + V             → Toggle floating mode
Super + [1-9]         → Switch workspace
Super + Shift + [1-9] → Move window to workspace
Super + Shift + S     → Screenshot (grim + slurp)
```

---

## Common Customization Tasks

### Change Color Scheme

1. Edit `~/.config/theme.conf`:
```bash
$bg = "#1e1e2e"
$fg = "#cdd6f4"
$accent = "#89b4fa"
$border = "#585b70"
```

2. Reload affected components:
```bash
hyprctl reload                    # Hyprland
killall waybar && waybar &        # Waybar
killall rofi 2>/dev/null          # Rofi
```

### Add/Modify Hyprland Keybinding

Edit `~/.config/hypr/hyprland.conf`:
```
bind = SUPER, P, exec, grim -g "$(slurp)" - | wl-copy
bind = SUPER SHIFT, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy
```

Then: `hyprctl reload`

### Install/Update Fonts

```bash
# Copy fonts to user directory
cp fonts/*.ttf ~/.local/share/fonts/
cp fonts/*.otf ~/.local/share/fonts/

# Rebuild font cache
fc-cache -fv

# Verify installation
fc-list | grep "JetBrains Mono"
```

### Configure GTK Theme

```bash
nwg-look  # GUI theme selector
# OR manually edit ~/.config/gtk-3.0/settings.ini
```

---

## Security & Forensics Workflow

### Steganography Analysis
```bash
# Detect steganography
stegdetect -s 1 image.jpg

# Solve with stegseek
stegseek image.jpg wordlist.txt -f output.txt

# Analyze with stegsolve
stegsolve  # GUI tool

# Extract with steghide
steghide extract -sf image.jpg -p password -f output.txt
```

### APK Analysis
```bash
# Decompile APK
apktool d vulnerable.apk

# Recompile
apktool b vulnerable -o modified.apk
```

### Email & Data Analysis
```bash
# Dump email data
emldump email.eml

# XOR pattern search
xorsearch file.bin pattern
```

### Forensic Analysis
```bash
# Launch Autopsy web interface
autopsy

# Access at http://localhost:8888
```

---

## File Modification Rules

### ✅ Safe to Modify
- Any file in `~/.config/` (user-level)
- Color values in theme files
- Keybindings in Hyprland config
- Shell aliases and functions (`.zshrc`)
- Status bar modules (waybar)

### ⚠️ Handle with Care
- Symlinked files (maintain both source and link)
- Font cache files (regenerate: `fc-cache -fv`)
- System configs in `/etc/` (requires `sudo`)
- Sensitive forensics output

### ❌ Never Modify
- Original package configs (use rc files)
- Build artifacts/compiled binaries
- Package manager caches
- API keys or credentials
- Wordlists or security databases

---

## Sensitive Information Policy

**CRITICAL - BlackArch Security Context**:

Do NOT commit to repository:
- CTF challenge flags or solutions
- API keys or authentication tokens
- Credentials for services
- Private SSH keys
- OAuth tokens or API tokens
- Database connection strings
- Personal identifiers or IPs

**Safe approach**:
1. Store secrets in `~/.local/share/secrets/` (gitignored)
2. Source in `.zshrc`: `source ~/.local/share/secrets/tokens.sh`
3. Reference via environment variables only
4. Audit wordlists/seclists before committing

---

## Performance Optimization

### Monitoring Tools
```bash
htop              # Interactive process viewer
btop              # Better top with GPU monitoring
systemd-analyze   # Boot time analysis
hyprctl systemstats   # Hyprland performance stats
```

### Hyprland Optimization
```
# In hyprland.conf:
disable_hyprcursor = true
decoration:blur:enabled = false  # If performance critical
```

### Audio Optimization
```bash
# Check PipeWire status
pw-dump
wireplumber status

# Adjust latency
pw-record --list-targets
```

---

## Git Workflow & Security Checks

### Pre-Push Validation
```bash
# Scan for hardcoded secrets
git diff --cached --name-only | xargs grep -l "api_key\|token\|password\|flag{" 2>/dev/null && echo "⚠️ SECRETS DETECTED!" || echo "✓ Safe"

# Review staged changes
git diff --cached

# Sign commits
git config --global commit.gpgsign true
```

### Commit Message Format
```
sec: add steganography wordlist integration

- Integrate stegseek brute-force automation
- Update steganography analysis scripts
- Tested on CTF challenge set
- No sensitive data included
```

---

## Testing & Validation

### Pre-Commit Checks
```bash
# Shell script validation
shellcheck scripts/*.sh

# Hyprland syntax check
hyprland -c check

# Test symlinks
ls -la ~/.config/hypr/ | grep "^l"

# Security check
grep -r "flag{\|password\|api" .config/ scripts/ 2>/dev/null || echo "✓ No secrets"
```

### Incremental Testing
1. Test changes in isolated Hyprland session
2. Apply one config at a time
3. Reload affected component
4. Commit with detailed messages

---

## Troubleshooting

### Display/Rendering Issues
```bash
# Check GPU driver
glxinfo | grep "OpenGL"
glxinfo | grep "NVIDIA\|AMD\|Intel"

# Verify Wayland session
echo $XDG_SESSION_TYPE  # Should output 'wayland'

# Check Hyprland logs
journalctl --user -u hyprland.service -f
```

### Configuration Not Applying
```bash
# Verify file permissions
ls -la ~/.config/hypr/hyprland.conf

# Check syntax
hyprland -c check

# Full reload
hyprctl reload

# Waybar issues
killall waybar && waybar &
```

### Performance Issues
```bash
# Profile system
perf record -g sleep 10
perf report

# Monitor resource usage
watch -n 1 'free -h && ps aux --sort=-%cpu | head -n 5'

# Check startup time
systemd-analyze time
systemd-analyze blame
```

### Forensics Tools Issues
```bash
# Autopsy service start
systemctl start autopsy

# Check BlackArch mirror
sudo pacman -Sy

# Verify tool availability
which steghide stegsolve stegseek autopsy
```

---

## Arch Linux Specific Notes

### Pacman Configuration
```bash
# Update system
sudo pacman -Syyu

# Install from AUR (using paru)
paru -S package-name

# Install from AUR (using yay)
yay -S package-name

# Check for BlackArch packages
pacman -Sl blackarch | grep tool-name
```

### Wayland Session Setup
```bash
# Set Hyprland as default
export XDG_SESSION_TYPE=wayland
export QT_QPA_PLATFORM=wayland

# In ~/.zshrc or ~/.bashrc:
export XDG_SESSION_TYPE=wayland
export QT_QPA_PLATFORM=wayland
export QT_QPA_PLATFORM_PLUGIN_PATH=/usr/lib/qt6/plugins
```

### Font Configuration
- **Primary**: JetBrains Mono Nerd Font 3.4.0
- **Fallback**: Noto Sans Mono (CJK support)
- **Emoji**: Noto Color Emoji 2.051
- **Location**: `~/.local/share/fonts/`

---

## Security Best Practices

### File Permissions
```bash
# Restrict dotfiles
chmod 700 ~/.config/
chmod 600 ~/.config/hypr/hyprland.conf
chmod 600 ~/.zshrc

# Scripts executable
chmod +x ~/dotfiles/scripts/*.sh
```

### SSH Key Management
```bash
# Never commit SSH keys
echo "/.ssh/" >> .gitignore
echo "*.pem" >> .gitignore
echo ".private" >> .gitignore

# Use SSH agent
ssh-add ~/.ssh/id_ed25519
```

### Credential Handling
- Use `pass` or `1password-cli` for secrets
- Never hardcode credentials
- Use environment variables
- Use `.gitignore` for sensitive files

---

## CLI Commands Reference

### Hyprland Control
```bash
hyprctl reload              # Reload configuration
hyprctl dispatch exec CMD   # Execute command
hyprctl systemstats         # Performance stats
hyprctl clients             # List open clients
hyprctl activewindow        # Get active window
hyprctl workspaces          # List workspaces
hyprctl --help              # Full command list
```

### Screenshot & Selection
```bash
grim -g "$(slurp)" - | wl-copy     # Copy selected region
grim ~/screenshot.png              # Full screenshot
slurp                               # Interactive region selector
```

### Font Management
```bash
fc-cache -fv                # Rebuild font cache
fc-list | grep "JetBrains"  # List JetBrains fonts
fc-match monospace          # Check monospace fallback
```

### Forensics Tools
```bash
stegdetect -s 1 image.jpg           # Detect steg
stegseek image.jpg wordlist.txt     # Brute-force steghide
stegsolve &                         # GUI analysis tool
autopsy &                           # Forensic framework
apktool d app.apk                   # Decompile APK
```

### System Information
```bash
neofetch                    # System info display
lsblk                       # Block devices
pacman -Qe                  # List explicitly installed
paru -Ps                    # Search AUR
```

---

## External Resources

- **Hyprland Wiki**: https://wiki.hyprland.org
- **Arch Wiki Ricing**: https://wiki.archlinux.org/title/Ricing
- **r/unixporn**: https://reddit.com/r/unixporn
- **BlackArch Linux**: https://blackarch.org
- **Nerd Fonts**: https://www.nerdfonts.com/
- **Dotfiles**: https://dotfiles.github.io
- **Forensics Resources**: https://digital-forensics.sans.org/

---

## Maintenance Schedule

- **Weekly**: `sudo pacman -Syyu` (system updates)
- **Monthly**: Review logs (`journalctl -xe`), audit BlackArch packages
- **Quarterly**: Backup dotfiles, update wordlists/seclists
- **Annually**: Audit all 79 packages, remove unused tools

---

## Claude Code Specific Instructions

### When Modifying Configs

1. **Validate syntax before committing**:
   - Hyprland: `hyprland -c check`
   - Zsh: `zsh -n ~/.zshrc`
   - JSONC: Verify bracket matching in waybar config

2. **Test incrementally**:
   - `hyprctl reload` for WM changes
   - `killall waybar && waybar &` for bar changes
   - `source ~/.zshrc` for shell changes

3. **Preserve color scheme variables**: Keep `$bg`, `$fg`, `$accent` format

4. **Use environment variables**: Never hardcode paths or secrets

5. **Check gitignore** before suggesting new files:
   - Secrets → `~/.local/share/secrets/`
   - Build artifacts → `.gitignore`

### Common Tasks for This Repository

- Update Hyprland keybindings with validation
- Modify color scheme with auto-reload
- Integrate new CTF/forensics tools
- Optimize performance for older hardware
- Configure theme propagation
- Fix Wayland-specific issues
- Troubleshoot BlackArch package conflicts
- Generate steganography automation scripts

### Security-First Approach

- Scan all config changes for leaked flags/credentials
- Validate forensics tool integration
- Document security-sensitive configurations
- Never suggest wordlist modifications that break functionality
- Keep audit trail of sensitive tool updates

---

## Key Integrations

### BlackArch Security Suite
Comprehensive security and forensics toolchain integrated for CTF preparation:
- Steganography: steghide, stegsolve, stegdetect, stegseek
- Analysis: Autopsy, emldump, xorsearch
- Wordlists: seclists, wordlists
- APK Tools: android-apktool

### Development Environment
- **Editor**: Neovim 0.11.5 with Lua configuration
- **Shell**: Zsh 5.9 with plugin ecosystem
- **Build**: Rust (rustup), Python (pip), C/C++ (base-devel)
- **VCS**: Git 2.52.0

### Multimedia & Aesthetics
- **Screenshot**: Grim + Slurp (Wayland-native)
- **Terminal**: Kitty 0.45.0 (GPU acceleration)
- **Icons**: Papirus + Nerd Fonts
- **Themes**: Nordic Dark, Arc GTK, Kvantum

---

**Last Updated**: January 19, 2026  
**Arch Version**: Rolling Release (Linux 6.18.3)  
**Session Type**: Wayland (Hyprland 0.53.1)  
**Total Installed Packages**: 79  
**BlackArch Integration**: Active
