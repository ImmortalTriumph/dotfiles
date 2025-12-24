
export QT_QPA_PLATFORMTHEME=qt5ct

[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
    exec Hyprland
fi

RESET="\[\e[0m\]"
FG_CRIMSON="\[\e[91m\]"   
FG_NAVY="\[\e[34m\]"     
FG_GREEN="\[\e[32m\]"    


PS1="${FG_NAVY}\u${RESET}@${FG_CRIMSON}\h${RESET}:${FG_NAVY}\w${RESET}\$ "


if command -v __git_ps1 >/dev/null; then
    GIT_PS1_SHOWDIRTYSTATE=1
    GIT_PS1_SHOWSTASHSTATE=1
    GIT_PS1_SHOWUNTRACKEDFILES=1
    PS1="${FG_NAVY}\u${RESET}@${FG_CRIMSON}\h${RESET}:${FG_NAVY}\w${RESET} ${FG_GREEN}\$(__git_ps1 '(%s)')${RESET}\$ "
fi
