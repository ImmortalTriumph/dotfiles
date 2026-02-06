[[ $- != *i* ]] && return

export EDITOR="nvim"
export VISUAL="vim"
export PAGER="less"

export HISTFILE="$XDG_STATE_HOME/bash/history"
export HISTSIZE=50000
export SAVEHIST=50000

export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"

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
alias ext='extract'

mkcd() {
    mkdir -p "$1" && cd "$1" || echo "Failed to mkdir or cd"
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


if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
    exec Hyprland
fi

# Gruvbox Dark Theme Colors (matching zsh/nvim/neofetch)
RESET="\[\e[0m\]"
FG_GREEN="\[\e[38;2;184;187;38m\]"
FG_BLUE="\[\e[38;2;131;165;152m\]"
FG_CYAN="\[\e[38;2;142;192;124m\]"
FG_ORANGE="\[\e[38;2;254;128;25m\]"

# PS1 prompt (matching zsh style: user@host:path)
PS1="${FG_BLUE}\u${RESET}@${FG_ORANGE}\h${RESET}:${FG_CYAN}\w${RESET}\$ "

# Git branch function - only shows when in a git repo
git_branch() {
    if [ -d .git ] || git rev-parse --git-dir > /dev/null 2>&1; then
        local branch=$(git symbolic-ref --short HEAD 2>/dev/null || git describe --tags --exact-match 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
        local dirty=""
        [ -n "$(git status --porcelain 2>/dev/null)" ] && dirty="*"
        echo " (${branch}${dirty})"
    fi
}

# PS1 with git branch
PS1="${FG_BLUE}\u${RESET}@${FG_ORANGE}\h${RESET}:${FG_CYAN}\w${RESET}${FG_GREEN}\$(git_branch)${RESET}\$ "
