" Gruvbox Dark Theme (matching nvim/zsh/neofetch)
set termguicolors
set background=dark

" Define Gruvbox colors
let s:bg = "#1a1a1a"
let s:bg_soft = "#252525"
let s:fg = "#d9d9d9"
let s:gray = "#808080"
let s:red = "#cc241d"
let s:red_b = "#fb4934"
let s:green = "#98971a"
let s:green_b = "#b8bb26"
let s:yellow = "#d79921"
let s:yellow_b = "#fabd2f"
let s:blue = "#458588"
let s:blue_b = "#83a598"
let s:purple = "#b16286"
let s:purple_b = "#d3869b"
let s:cyan = "#689d6a"
let s:cyan_b = "#8ec07c"
let s:orange = "#d65d0e"
let s:orange_b = "#fe8019"

" Apply highlights
hi clear
if exists("syntax_on")
    syntax reset
endif

exe "hi Normal guifg=".s:fg." guibg=".s:bg
exe "hi CursorLine guibg=".s:bg_soft
exe "hi CursorLineNr guifg=".s:fg." guibg=".s:bg_soft
exe "hi LineNr guifg=".s:gray
exe "hi StatusLine guifg=".s:fg." guibg=".s:bg_soft
exe "hi StatusLineNC guifg=".s:gray." guibg=".s:bg
exe "hi VertSplit guifg=".s:gray
exe "hi Pmenu guifg=".s:fg." guibg=".s:bg_soft
exe "hi PmenuSel guifg=".s:fg." guibg=".s:gray
exe "hi Visual guibg=".s:gray
exe "hi Search guifg=".s:bg." guibg=".s:yellow
exe "hi IncSearch guifg=".s:bg." guibg=".s:orange

" Syntax highlighting
exe "hi Comment guifg=".s:gray
exe "hi Constant guifg=".s:purple_b
exe "hi String guifg=".s:green_b
exe "hi Character guifg=".s:green_b
exe "hi Number guifg=".s:purple_b
exe "hi Boolean guifg=".s:purple_b
exe "hi Float guifg=".s:purple_b
exe "hi Identifier guifg=".s:blue_b
exe "hi Function guifg=".s:green_b
exe "hi Statement guifg=".s:red_b
exe "hi Conditional guifg=".s:red_b
exe "hi Repeat guifg=".s:red_b
exe "hi Label guifg=".s:red_b
exe "hi Operator guifg=".s:fg
exe "hi Keyword guifg=".s:red_b
exe "hi Exception guifg=".s:red_b
exe "hi PreProc guifg=".s:cyan_b
exe "hi Include guifg=".s:cyan_b
exe "hi Define guifg=".s:cyan_b
exe "hi Macro guifg=".s:cyan_b
exe "hi Type guifg=".s:yellow_b
exe "hi StorageClass guifg=".s:orange_b
exe "hi Structure guifg=".s:cyan_b
exe "hi Typedef guifg=".s:yellow_b
exe "hi Special guifg=".s:orange_b
exe "hi SpecialChar guifg=".s:orange_b
exe "hi Tag guifg=".s:cyan_b
exe "hi Delimiter guifg=".s:fg
exe "hi SpecialComment guifg=".s:gray
exe "hi Debug guifg=".s:red_b
exe "hi Underlined guifg=".s:blue_b
exe "hi Error guifg=".s:red_b." guibg=".s:bg
exe "hi Todo guifg=".s:yellow_b." guibg=".s:bg." gui=bold"

" Diff
exe "hi DiffAdd guifg=".s:green_b." guibg=".s:bg
exe "hi DiffChange guifg=".s:blue_b." guibg=".s:bg
exe "hi DiffDelete guifg=".s:red_b." guibg=".s:bg
exe "hi DiffText guifg=".s:yellow_b." guibg=".s:bg

" Basic settings
set number
set cursorline
set laststatus=2
syntax on
