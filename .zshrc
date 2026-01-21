# =============================================================================
# ZSH Configuration - Gruvbox Dark Theme
# =============================================================================

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
# Zsh Options
# -----------------------------------------------------------------------------

setopt AUTO_CD                  # cd by typing directory name
setopt AUTO_PUSHD               # Push directory to stack on cd
setopt PUSHD_IGNORE_DUPS        # Don't push duplicates
setopt PUSHD_SILENT             # Don't print dir stack after pushd/popd

setopt EXTENDED_HISTORY         # Write timestamp to history
setopt HIST_EXPIRE_DUPS_FIRST   # Expire duplicate entries first
setopt HIST_IGNORE_DUPS         # Don't record duplicates
setopt HIST_IGNORE_ALL_DUPS     # Remove old duplicate
setopt HIST_IGNORE_SPACE        # Don't record entries starting with space
setopt HIST_FIND_NO_DUPS        # No duplicates in search
setopt HIST_SAVE_NO_DUPS        # Don't write duplicates
setopt HIST_REDUCE_BLANKS       # Remove superfluous blanks
setopt SHARE_HISTORY            # Share history between sessions
setopt INC_APPEND_HISTORY       # Add commands immediately

setopt CORRECT                  # Spell correction for commands
setopt INTERACTIVE_COMMENTS     # Allow comments in interactive shell
setopt NO_BEEP                  # No beep on error
setopt PROMPT_SUBST             # Enable prompt substitution

# -----------------------------------------------------------------------------
# Completion System
# -----------------------------------------------------------------------------

autoload -Uz compinit
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"

# Completion styling
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # Case insensitive
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion:*:warnings' format '%F{red}-- no matches found --%f'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"

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
# Colors - Gruvbox Dark Palette
# -----------------------------------------------------------------------------

# Define colors for prompt
typeset -A COLORS
COLORS=(
    bg      "#1a1a1a"
    fg      "#d9d9d9"
    gray    "#808080"
    red     "#cc241d"
    red_b   "#fb4934"
    green   "#98971a"
    green_b "#b8bb26"
    yellow  "#d79921"
    yellow_b "#fabd2f"
    orange  "#d65d0e"
    orange_b "#fe8019"
    blue    "#458588"
    blue_b  "#83a598"
    purple  "#b16286"
    purple_b "#d3869b"
    cyan    "#689d6a"
    cyan_b  "#8ec07c"
)

# -----------------------------------------------------------------------------
# Prompt Configuration
# -----------------------------------------------------------------------------

# Git integration
autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr '%F{green}+%f'
zstyle ':vcs_info:*' unstagedstr '%F{red}*%f'
zstyle ':vcs_info:git:*' formats '%F{cyan}(%b%c%u%F{cyan})%f '
zstyle ':vcs_info:git:*' actionformats '%F{cyan}(%b|%F{red}%a%F{cyan}%c%u)%f '

# Prompt (bash-like: user@host:path)
PROMPT='%F{blue}%n%f@%F{yellow}%m%f:%F{cyan}%~%f ${vcs_info_msg_0_}$ '

# Right prompt - show exit code if non-zero
RPROMPT='%(?.%F{gray}%T%f.%F{red}✗ %?%f)'

# -----------------------------------------------------------------------------
# Aliases - General
# -----------------------------------------------------------------------------

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'
alias -- -='cd -'

# ls replacements (using built-in or eza if available)
if command -v eza &>/dev/null; then
    alias ls='eza --color=auto --icons'
    alias ll='eza -la --icons --git'
    alias la='eza -a --icons'
    alias lt='eza -T --icons --git-ignore'
else
    alias ls='ls --color=auto'
    alias ll='ls -lAh'
    alias la='ls -A'
fi

# File operations (safe)
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'
alias mkdir='mkdir -pv'

# Grep with color
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# Editor
alias v='nvim'
alias vi='nvim'
alias vim='nvim'
alias sv='sudo nvim'

# System
alias reboot='sudo systemctl reboot'
alias poweroff='sudo systemctl poweroff'
alias suspend='systemctl suspend'

# -----------------------------------------------------------------------------
# Aliases - Arch Linux / Pacman / AUR
# -----------------------------------------------------------------------------

# Pacman
alias pac='sudo pacman'
alias pacs='sudo pacman -S'              # Install
alias pacr='sudo pacman -Rns'            # Remove with deps
alias pacu='sudo pacman -Syu'            # Update system
alias pacq='pacman -Qs'                  # Query local
alias pacss='pacman -Ss'                 # Search remote
alias pacqi='pacman -Qi'                 # Info on installed
alias pacsi='pacman -Si'                 # Info on remote
alias pacls='pacman -Qe'                 # List explicitly installed
alias pacorphan='pacman -Qdt'            # List orphans
alias pacclean='sudo pacman -Sc'         # Clean cache

# Paru (AUR helper)
alias p='paru'
alias ps='paru -S'
alias pr='paru -Rns'
alias pu='paru -Syu'
alias pss='paru -Ss'
alias pclean='paru -Sc'

# Yay (AUR helper alternative)
alias y='yay'
alias ys='yay -S'
alias yr='yay -Rns'
alias yu='yay -Syu'
alias yss='yay -Ss'

# -----------------------------------------------------------------------------
# Aliases - Development
# -----------------------------------------------------------------------------

# Git
alias g='git'
alias gs='git status'
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit -m'
alias gca='git commit --amend'
alias gp='git push'
alias gpl='git pull'
alias gf='git fetch'
alias gd='git diff'
alias gds='git diff --staged'
alias gl='git log --oneline --graph --decorate -10'
alias gla='git log --oneline --graph --decorate --all'
alias gb='git branch'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gst='git stash'
alias gstp='git stash pop'

# Python
alias py='python'
alias py3='python3'
alias pip='pip3'
alias venv='python -m venv'
alias activate='source ./venv/bin/activate'

# Rust
alias cr='cargo run'
alias cb='cargo build'
alias ct='cargo test'
alias cc='cargo check'
alias cf='cargo fmt'
alias ccl='cargo clippy'

# Docker
alias d='docker'
alias dc='docker-compose'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias di='docker images'

# -----------------------------------------------------------------------------
# Aliases - Hyprland / Rice
# -----------------------------------------------------------------------------

# Hyprland
alias hc='hyprctl'
alias hcr='hyprctl reload'
alias hcs='hyprctl systemstats'
alias hcc='hyprctl clients'

# Config shortcuts
alias zshrc='$EDITOR ~/.config/zsh/.zshrc'
alias hyprconf='$EDITOR ~/.config/hypr/hyprland.conf'
alias kittyconf='$EDITOR ~/.config/kitty/kitty.conf'
alias waybarconf='$EDITOR ~/.config/waybar/config'

# Eww
alias eww-open='eww open dashboard'
alias eww-close='eww close dashboard'
alias eww-toggle='eww open --toggle dashboard'
alias eww-reload='eww kill && eww daemon && eww open dashboard'

# Screenshot (grim + slurp)
alias ss='grim -g "$(slurp)" - | wl-copy'
alias ssf='grim ~/Pictures/Screenshots/$(date +%Y%m%d_%H%M%S).png'

# -----------------------------------------------------------------------------
# Aliases - Security / CTF Tools
# -----------------------------------------------------------------------------

# Steganography
alias stegdetect='stegdetect -s 1'
alias stegextract='steghide extract -sf'

# Network
alias myip='curl -s ifconfig.me'
alias localip='ip -4 addr show | grep inet | grep -v 127.0.0.1'
alias ports='ss -tulanp'

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

# Quick find
ff() {
    find . -type f -iname "*$1*"
}

# Quick grep in files
gg() {
    grep -rn "$1" .
}

# Weather
weather() {
    curl -s "wttr.in/${1:-}"
}

# Cheatsheet
cheat() {
    curl -s "cheat.sh/$1"
}

# -----------------------------------------------------------------------------
# Plugin Loading
# -----------------------------------------------------------------------------

# Syntax highlighting (install: paru -S zsh-syntax-highlighting)
if [[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# Autosuggestions (install: paru -S zsh-autosuggestions)
if [[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#808080'
    ZSH_AUTOSUGGEST_STRATEGY=(history completion)
fi

# fzf integration (install: paru -S fzf)
if command -v fzf &>/dev/null; then
    source /usr/share/fzf/key-bindings.zsh 2>/dev/null
    source /usr/share/fzf/completion.zsh 2>/dev/null
    export FZF_DEFAULT_OPTS="--color=bg+:#1a1a1a,bg:#1a1a1a,spinner:#d65d0e,hl:#83a598 --color=fg:#d9d9d9,header:#83a598,info:#d79921,pointer:#d65d0e --color=marker:#b8bb26,fg+:#d9d9d9,prompt:#d79921,hl+:#83a598"
fi

# zoxide (better cd) - install: paru -S zoxide
if command -v zoxide &>/dev/null; then
    eval "$(zoxide init zsh)"
    alias cd='z'
fi

# -----------------------------------------------------------------------------
# Startup
# -----------------------------------------------------------------------------

# Auto-start Hyprland on tty1
if [[ -z "$DISPLAY" ]] && [[ "$(tty)" = "/dev/tty1" ]]; then
    exec Hyprland
fi

# Ensure history directory exists
mkdir -p "$(dirname "$HISTFILE")"
