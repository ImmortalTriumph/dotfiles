# Colors - monochromic graphite base with gruvbox highlights

# Colors - gruvbox palette
local aqua='%F{108}'       # #83a598 - gruvbox aqua for hostname
local green='%F{142}'      # #b8bb26 - gruvbox green for username
local orange='%F{208}'     # #fe8019 - gruvbox orange for git branch
local gray='%F{245}'       # #8a8a8a - muted gray for user@host
local yellow='%F{214}'     # #fabd2f - gruvbox yellow for arrow
local dim='%F{240}'        # #585858 - dim gray for separators
local reset='%f'

local pathname="%K{#A0640A}%F{white} "
local pathreset=' %k'

# Git prompt configuration - highlighted with orange
ZSH_THEME_GIT_PROMPT_PREFIX="${orange}"
ZSH_THEME_GIT_PROMPT_SUFFIX="${reset} "
ZSH_THEME_GIT_PROMPT_DIRTY=" %F{167}●${reset}"
ZSH_THEME_GIT_PROMPT_CLEAN=" %F{142}●${reset}"

PROMPT='
[${aqua}%n${dim}@${green}%m${reset}] ${pathname}%1~${pathreset} $(git_prompt_info)${yellow}
->${reset} '

RPROMPT='%(?.%F{gray}%T%f.%F{red}✗ %?%f)'
