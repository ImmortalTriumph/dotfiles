# Installation Guide

## Prerequisites

- Arch Linux (rolling release)
- Base development tools
- Git

```bash
sudo pacman -Syyu
sudo pacman -S base-devel git
```

## Clone Repository

```bash
git clone https://github.com/ImmortalTriumph/dotfiles ~/dotfiles
cd ~/dotfiles
```

## Install Dependencies

### Core Packages
```bash
sudo pacman -S hyprland waybar eww kitty neovim rofi
sudo pacman -S hyprlock hyprpaper sddm
```

### Fonts
```bash
sudo pacman -S ttf-jetbrains-mono-nerd noto-fonts-cjk noto-fonts-emoji
```

### Audio
```bash
sudo pacman -S pipewire-audio pipewire-pulse wireplumber cava pavucontrol
```

### Utilities
```bash
sudo pacman -S grim slurp wl-clipboard brightnessctl playerctl
```

### AUR Helper
```bash
paru -S stow
```

## Deploy Dotfiles

Using GNU Stow:
```bash
cd ~/dotfiles

# Symlink all configs
stow -t ~ .config
stow -t ~ .local

# Or individually
stow -t ~/.config .config/hypr
stow -t ~/.config .config/waybar
stow -t ~/.config .config/eww
stow -t ~/.config .config/kitty
```

## Post-Install

### Reload Hyprland
```bash
hyprctl reload
```

### Start EWW
```bash
eww daemon
eww open dashboard
```

### Rebuild Font Cache
```bash
fc-cache -fv
```

## Troubleshooting

### EWW not loading
```bash
eww kill
eww daemon
eww logs
```

### Waybar not showing
```bash
killall waybar
waybar &
```

### Audio issues
```bash
systemctl --user restart wireplumber
wpctl status
```

### Check Hyprland logs
```bash
journalctl --user -u hyprland.service -f
```
