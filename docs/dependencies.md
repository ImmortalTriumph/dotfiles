# Dependencies

Complete list of packages required for this dotfiles configuration.

## Quick Install

### Pacman (Core)

```bash
sudo pacman -S --needed \
    hyprland hyprpaper hyprlock \
    waybar \
    kitty \
    rofi \
    zsh \
    fastfetch \
    neovim \
    thunar \
    pipewire pipewire-pulse pipewire-alsa wireplumber \
    playerctl \
    pavucontrol \
    cava \
    grim slurp wl-clipboard \
    brightnessctl \
    networkmanager nm-connection-editor \
    bluez bluez-utils blueman \
    ttf-jetbrains-mono-nerd noto-fonts-cjk noto-fonts-emoji \
    unzip unrar p7zip \
    python python-pip \
    jq \
    less
```

### AUR Packages

```bash
paru -S --needed eww-git
# or
yay -S eww-git
```

## Package Categories

### Core Desktop

| Package | Description |
|---------|-------------|
| `hyprland` | Wayland compositor |
| `hyprpaper` | Wallpaper manager |
| `hyprlock` | Lock screen |
| `waybar` | Status bar |
| `eww-git` | Widget system (AUR) |
| `kitty` | Terminal emulator |
| `rofi` | Application launcher |
| `thunar` | File manager |

### Shell

| Package | Description |
|---------|-------------|
| `zsh` | Z shell |
| `fastfetch` | System info |
| `neovim` | Text editor |
| `jq` | JSON processor |
| `less` | Pager |

### Audio

| Package | Description |
|---------|-------------|
| `pipewire` | Audio server |
| `pipewire-pulse` | PulseAudio replacement |
| `pipewire-alsa` | ALSA integration |
| `wireplumber` | Session manager |
| `playerctl` | Media player control |
| `pavucontrol` | Volume control GUI |
| `cava` | Audio visualizer |

### Utilities

| Package | Description |
|---------|-------------|
| `grim` | Screenshot tool |
| `slurp` | Region selector |
| `wl-clipboard` | Clipboard utilities |
| `brightnessctl` | Brightness control |

### Network

| Package | Description |
|---------|-------------|
| `networkmanager` | Network management |
| `nm-connection-editor` | Network GUI |
| `bluez` | Bluetooth stack |
| `bluez-utils` | Bluetooth utilities |
| `blueman` | Bluetooth manager GUI |

### Fonts

| Package | Description |
|---------|-------------|
| `ttf-jetbrains-mono-nerd` | Primary font (with icons) |
| `noto-fonts-cjk` | CJK character support |
| `noto-fonts-emoji` | Emoji support |

### Archive Tools

| Package | Description |
|---------|-------------|
| `unzip` | ZIP extraction |
| `unrar` | RAR extraction |
| `p7zip` | 7z extraction |

### Python

| Package | Description |
|---------|-------------|
| `python` | Python interpreter |
| `python-pip` | Package installer |

Required for `cava-viz.py` EWW widget script.

## Oh My Zsh

### Install Oh My Zsh

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### Required Plugins

Clone to `~/.oh-my-zsh/custom/plugins/`:

```bash
# zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

### Custom Theme

Copy `gruvbox-mono.zsh-theme` to `~/.oh-my-zsh/custom/themes/`

## Optional Services

### Enable at Boot

```bash
# NetworkManager
sudo systemctl enable --now NetworkManager

# Bluetooth
sudo systemctl enable --now bluetooth

# PipeWire (user service)
systemctl --user enable --now pipewire pipewire-pulse wireplumber
```

## Verification

Check all packages are installed:

```bash
# Core apps
which hyprland waybar eww kitty rofi zsh fastfetch nvim

# Audio
pactl info
playerctl --list-all

# Network
nmcli general status
bluetoothctl show

# Font
fc-list | grep -i jetbrains
```
