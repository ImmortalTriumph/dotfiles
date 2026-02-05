# Zsh Configuration

Zsh shell configuration with Oh My Zsh, Gruvbox syntax highlighting, and custom functions.

## Configuration File

`~/.zshrc`

## Environment Variables

| Variable | Value | Description |
|----------|-------|-------------|
| `EDITOR` | `nvim` | Default editor |
| `VISUAL` | `nvim` | Visual editor |
| `TERMINAL` | `kitty` | Default terminal |
| `BROWSER` | `firefox` | Default browser |
| `PAGER` | `less` | Default pager |
| `HISTSIZE` | `50000` | History entries in memory |
| `SAVEHIST` | `50000` | History entries saved to file |

## XDG Directories

| Variable | Path |
|----------|------|
| `XDG_CONFIG_HOME` | `~/.config` |
| `XDG_DATA_HOME` | `~/.local/share` |
| `XDG_CACHE_HOME` | `~/.cache` |
| `XDG_STATE_HOME` | `~/.local/state` |

## Oh My Zsh

**Theme:** `gruvbox-mono` (custom)

**Plugins:**

| Plugin | Description |
|--------|-------------|
| `git` | Git aliases and functions |
| `kitty` | Kitty terminal integration |
| `zsh-autosuggestions` | Fish-like autosuggestions |
| `zsh-syntax-highlighting` | Syntax highlighting |
| `colored-man-pages` | Colorized man pages |
| `command-not-found` | Package suggestions |
| `sudo` | Press `Esc` twice to prepend sudo |
| `copypath` | Copy current path to clipboard |
| `copybuffer` | Copy current command to clipboard |
| `dirhistory` | Navigate directory history |
| `history-substring-search` | Search history by substring |

## Keybindings

| Key | Action |
|-----|--------|
| `Up` | Search history backward (prefix match) |
| `Down` | Search history forward (prefix match) |
| `Home` | Beginning of line |
| `End` | End of line |
| `Delete` | Delete character |
| `Ctrl+Right` | Forward word |
| `Ctrl+Left` | Backward word |
| `Ctrl+Backspace` | Delete word backward |
| `Ctrl+Delete` | Delete word forward |
| `Esc Esc` | Prepend sudo (from plugin) |

## Zsh Options

| Option | Description |
|--------|-------------|
| `AUTO_CD` | cd by typing directory name |
| `AUTO_PUSHD` | Push directory to stack on cd |
| `PUSHD_IGNORE_DUPS` | No duplicate dirs in stack |
| `PUSHD_SILENT` | Silent pushd operations |
| `HIST_IGNORE_SPACE` | Don't record commands starting with space |
| `NO_BEEP` | Disable error beep |

## Aliases

### Navigation

| Alias | Command |
|-------|---------|
| `..` | `cd ..` |
| `...` | `cd ../..` |
| `....` | `cd ../../..` |
| `~` | `cd ~` |
| `-` | `cd -` (previous directory) |

### Listing

| Alias | Command | Description |
|-------|---------|-------------|
| `ls` | `ls --color=auto` | Colorized listing |
| `ll` | `ls -lAh` | Long listing with hidden |
| `la` | `ls -A` | List all (except . ..) |

### Utilities

| Alias | Command |
|-------|---------|
| `mkdir` | `mkdir -p` |
| `grep` | `grep --color=auto` |
| `egrep` | `egrep --color=auto` |
| `fgrep` | `fgrep --color=auto` |

### System

| Alias | Command |
|-------|---------|
| `reboot` | `sudo systemctl reboot` |
| `poweroff` | `sudo systemctl poweroff` |
| `suspend` | `systemctl suspend` |

### Python

| Alias | Command |
|-------|---------|
| `py` | `python` |
| `py3` | `python3` |
| `pip` | `pip3` |
| `venv` | `python -m venv` |
| `activate` | `source ./venv/bin/activate` |

### Custom

| Alias | Command | Description |
|-------|---------|-------------|
| `neofetch` | `fastfetch` | System info |
| `dash` | `eww open dashboard` | Open EWW dashboard |

## Functions

### `mkcd`
Create directory and cd into it:
```bash
mkcd myproject
```

### `extract`
Universal archive extractor:
```bash
extract archive.tar.gz
extract file.zip
extract package.7z
```
Supports: `.tar.bz2`, `.tar.gz`, `.tar.xz`, `.bz2`, `.rar`, `.gz`, `.tar`, `.tbz2`, `.tgz`, `.zip`, `.Z`, `.7z`

## Syntax Highlighting Colors (Gruvbox)

| Element | Color |
|---------|-------|
| Command | Green (`#b8bb26`) |
| Builtin | Green (`#b8bb26`) |
| Alias/Function | Cyan (`#8ec07c`) |
| Path | Blue underline (`#83a598`) |
| Globbing | Yellow (`#fabd2f`) |
| String | Green (`#b8bb26`) |
| Error | Red (`#fb4934`) |
| Reserved word | Purple (`#d3869b`) |
| Separator/Redirection | Orange (`#fe8019`) |
| Comment | Gray (`#808080`) |
| Autosuggestion | Gray (`#808080`) |

## Auto-start

Hyprland automatically starts on tty1 login:
```bash
if [[ -z "$DISPLAY" ]] && [[ "$(tty)" = "/dev/tty1" ]]; then
    exec Hyprland
fi
```

## Dependencies

- `zsh`
- `oh-my-zsh`
- `zsh-autosuggestions` (AUR or oh-my-zsh plugin)
- `zsh-syntax-highlighting` (AUR or oh-my-zsh plugin)

## Reload Command

```bash
source ~/.zshrc
```
