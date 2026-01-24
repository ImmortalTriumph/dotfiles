[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
    exec Hyprland
fi

# Gruvbox Dark Theme Colors (matching zsh/nvim/neofetch)
RESET="\[\e[0m\]"
FG_GRAY="\[\e[38;2;128;128;128m\]"
FG_RED="\[\e[38;2;251;73;52m\]"
FG_GREEN="\[\e[38;2;184;187;38m\]"
FG_YELLOW="\[\e[38;2;250;189;47m\]"
FG_BLUE="\[\e[38;2;131;165;152m\]"
FG_PURPLE="\[\e[38;2;211;134;155m\]"
FG_CYAN="\[\e[38;2;142;192;124m\]"
FG_ORANGE="\[\e[38;2;254;128;25m\]"
FG_FG="\[\e[38;2;217;217;217m\]"

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
