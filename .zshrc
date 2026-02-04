# === ENVIRONMENT ===

export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="kitty"
export BROWSER="firefox"
export PAGER="less"

# XDG Base Directory
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

# Less colors (Gruvbox)
export LESS_TERMCAP_mb=$'\e[1;31m'
export LESS_TERMCAP_md=$'\e[1;33m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[1;44;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;32m'

# === OH MY ZSH ===

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="gruvbox-mono"

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

source $ZSH/oh-my-zsh.sh

# === ZSH OPTIONS ===

setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT
setopt HIST_IGNORE_SPACE
setopt NO_BEEP

# === KEY BINDINGS ===

bindkey -e

bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[[3~' delete-char
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word
bindkey '^H' backward-kill-word
bindkey '^[[3;5~' kill-word

# === SYNTAX HIGHLIGHTING (Gruvbox) ===

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
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#808080'

# === ALIASES ===

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'
alias -- -='cd -'

alias ls='ls --color=auto'
alias ll='ls -lAh'
alias la='ls -A'
alias mkdir='mkdir -p'

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

alias reboot='sudo systemctl reboot'
alias poweroff='sudo systemctl poweroff'
alias suspend='systemctl suspend'

alias py='python'
alias py3='python3'
alias pip='pip3'
alias venv='python -m venv'
alias activate='source ./venv/bin/activate'

alias neofetch='fastfetch'
alias dash='eww open dashboard'

# === FUNCTIONS ===

mkcd() {
    mkdir -p "$1" && cd "$1"
}

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

# === STARTUP ===

if [[ -z "$DISPLAY" ]] && [[ "$(tty)" = "/dev/tty1" ]]; then
    exec Hyprland
fi
