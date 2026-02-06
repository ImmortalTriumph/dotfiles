" vim-plug: https://github.com/junegunn/vim-plug
" Gruvbox Dark Theme: https://github.com/sainnhe/gruvbox-material

call plug#begin()

Plug 'sainnhe/gruvbox-material'

call plug#end()

set termguicolors
set background=dark
set number
set relativenumber
set signcolumn=yes
set cursorline
set noshowmode
set cmdheight=1
set pumheight=10
set laststatus=2
set conceallevel=0

syntax on
colorscheme gruvbox-material

" Highlight overrides (match Neovim colorscheme.lua)
highlight Normal           guibg=#1a1a1a guifg=#d9d9d9
highlight NormalFloat      guibg=#1a1a1a
highlight FloatBorder      guifg=#4d4d4d guibg=#1a1a1a
highlight SignColumn       guibg=#1a1a1a
highlight CursorLine       guibg=#252525
highlight CursorLineNr     guifg=#b3b3b3 guibg=#252525
highlight LineNr           guifg=#808080
highlight VertSplit        guifg=#4d4d4d
highlight StatusLine       guibg=#1a1a1a guifg=#d9d9d9
highlight StatusLineNC     guibg=#1a1a1a guifg=#808080
highlight Pmenu            guibg=#252525 guifg=#d9d9d9
highlight PmenuSel         guibg=#4d4d4d guifg=#d9d9d9
highlight PmenuSbar        guibg=#252525
highlight PmenuThumb       guibg=#4d4d4d
highlight TabLine          guibg=#1a1a1a guifg=#808080
highlight TabLineFill      guibg=#1a1a1a
highlight TabLineSel       guibg=#252525 guifg=#d9d9d9
highlight DiagnosticError  guifg=#fb4934
highlight DiagnosticWarn   guifg=#fabd2f
highlight DiagnosticInfo   guifg=#83a598
highlight DiagnosticHint   guifg=#8ec07c

set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4
set smartindent
set nowrap
set linebreak
set breakindent

set ignorecase
set smartcase
set hlsearch
set incsearch

set noswapfile
set nobackup
set undofile
set undodir=~/.vim/undo

" Create undo directory if it doesn't exist
if !isdirectory(expand('~/.vim/undo'))
    call mkdir(expand('~/.vim/undo'), 'p')
endif

set mouse=a
set clipboard=unnamedplus
set scrolloff=8
set sidescrolloff=8
set splitbelow
set splitright
set timeoutlen=300
set updatetime=200
set completeopt=menu,menuone,noselect
set confirm
set shortmess+=sI
set nolazyredraw
set synmaxcol=240
set redrawtime=1500
