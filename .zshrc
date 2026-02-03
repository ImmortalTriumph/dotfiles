# -----------------------------------------------------------------------------
# Environment Variables
# -----------------------------------------------------------------------------

export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="kitty"
export BROWSER="firefox"
export PAGER="less"

# XDG Base Directory Specification
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

# Wayland / Hyprland
export XDG_SESSION_TYPE=wayland
export XDG_CURRENT_DESKTOP=Hyprland
export QT_QPA_PLATFORM=wayland
export QT_QPA_PLATFORMTHEME=qt6ct
export MOZ_ENABLE_WAYLAND=1
export ELECTRON_OZONE_PLATFORM_HINT=wayland

# History
export HISTFILE="$XDG_STATE_HOME/zsh/history"
export HISTSIZE=50000
export SAVEHIST=50000

# Path
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"

# Less colors for man pages (Gruvbox)
export LESS_TERMCAP_mb=$'\e[1;31m'      # begin bold
export LESS_TERMCAP_md=$'\e[1;33m'      # begin blink
export LESS_TERMCAP_me=$'\e[0m'         # reset bold/blink
export LESS_TERMCAP_se=$'\e[0m'         # reset standout
export LESS_TERMCAP_so=$'\e[1;44;33m'   # begin standout
export LESS_TERMCAP_ue=$'\e[0m'         # reset underline
export LESS_TERMCAP_us=$'\e[1;32m'      # begin underline

# -----------------------------------------------------------------------------
# Oh My Zsh Configuration
# -----------------------------------------------------------------------------

export ZSH="$HOME/.oh-my-zsh"

# Gruvbox monochrome theme (custom, matches bash prompt)
ZSH_THEME="gruvbox-mono"

# Plugins
plugins=(
    git
    kitty
    zsh-autosuggestions
    zsh-syntax-highlighting
    colored-man-pages
    command-not-found
    sudo
    copypath
    copybuffer
    dirhistory
    history-substring-search
)

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

# -----------------------------------------------------------------------------
# Zsh Options (additional to oh-my-zsh defaults)
# -----------------------------------------------------------------------------

setopt AUTO_CD                  # cd by typing directory name
setopt AUTO_PUSHD               # Push directory to stack on cd
setopt PUSHD_IGNORE_DUPS        # Don't push duplicates
setopt PUSHD_SILENT             # Don't print dir stack after pushd/popd
setopt HIST_IGNORE_SPACE        # Don't record entries starting with space
setopt NO_BEEP                  # No beep on error

# -----------------------------------------------------------------------------
# Key Bindings (Emacs mode)
# -----------------------------------------------------------------------------

bindkey -e

bindkey '^[[A' history-search-backward      # Up arrow
bindkey '^[[B' history-search-forward       # Down arrow
bindkey '^[[H' beginning-of-line            # Home
bindkey '^[[F' end-of-line                  # End
bindkey '^[[3~' delete-char                 # Delete
bindkey '^[[1;5C' forward-word              # Ctrl+Right
bindkey '^[[1;5D' backward-word             # Ctrl+Left
bindkey '^H' backward-kill-word             # Ctrl+Backspace
bindkey '^[[3;5~' kill-word                 # Ctrl+Delete

# -----------------------------------------------------------------------------
# Gruvbox Dark Palette for zsh-syntax-highlighting
# -----------------------------------------------------------------------------

typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[command]='fg=#b8bb26'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#b8bb26'
ZSH_HIGHLIGHT_STYLES[alias]='fg=#8ec07c'
ZSH_HIGHLIGHT_STYLES[function]='fg=#8ec07c'
ZSH_HIGHLIGHT_STYLES[path]='fg=#83a598,underline'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=#fabd2f'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#b8bb26'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#b8bb26'
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=#b8bb26'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#fb4934'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=#d3869b'
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=#fe8019'
ZSH_HIGHLIGHT_STYLES[redirection]='fg=#fe8019'
ZSH_HIGHLIGHT_STYLES[comment]='fg=#808080'

# Autosuggestion color (gruvbox gray)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#808080'

# -----------------------------------------------------------------------------
# Aliases - General
# -----------------------------------------------------------------------------

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'
alias -- -='cd -'

alias ls='ls --color=auto'
alias ll='ls -lAh'
alias la='ls -A'

alias mkdir='mkdir -p'

# Grep with color
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# System
alias reboot='sudo systemctl reboot'
alias poweroff='sudo systemctl poweroff'
alias suspend='systemctl suspend'

# -----------------------------------------------------------------------------
# Aliases - Development
# -----------------------------------------------------------------------------

# Python
alias py='python'
alias py3='python3'
alias pip='pip3'
alias venv='python -m venv'
alias activate='source ./venv/bin/activate'

# -----------------------------------------------------------------------------
# ;)
# -----------------------------------------------------------------------------

alias neofetch='fastfetch'
alias dash='eww open dashboard'

# -----------------------------------------------------------------------------
# Functions
# -----------------------------------------------------------------------------

# Create directory and cd into it
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Extract archives
extract() {
    if [[ -f "$1" ]]; then
        case "$1" in
            *.tar.bz2) tar xjf "$1" ;;
            *.tar.gz)  tar xzf "$1" ;;
            *.tar.xz)  tar xJf "$1" ;;
            *.bz2)     bunzip2 "$1" ;;
            *.rar)     unrar x "$1" ;;
            *.gz)      gunzip "$1" ;;
            *.tar)     tar xf "$1" ;;
            *.tbz2)    tar xjf "$1" ;;
            *.tgz)     tar xzf "$1" ;;
            *.zip)     unzip "$1" ;;
            *.Z)       uncompress "$1" ;;
            *.7z)      7z x "$1" ;;
            *)         echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# -----------------------------------------------------------------------------
# Startup
# -----------------------------------------------------------------------------

# Auto-start Hyprland on tty1
if [[ -z "$DISPLAY" ]] && [[ "$(tty)" = "/dev/tty1" ]]; then
    exec Hyprland
fi
