-- Core Neovim options
-- Matching the minimalist dark aesthetic

local opt = vim.opt

-- UI
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.termguicolors = true
opt.showmode = false
opt.cmdheight = 1
opt.pumheight = 10
opt.pumblend = 10
opt.winblend = 10
opt.laststatus = 3
opt.fillchars = { eob = " ", vert = "│", horiz = "─" }
opt.list = true
opt.listchars = { tab = "  ", trail = "·", nbsp = "␣" }

-- Colors
opt.background = "dark"

-- Editing
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.smartindent = true
opt.wrap = false
opt.linebreak = true
opt.breakindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Files
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.undodir = vim.fn.stdpath("data") .. "/undo"

-- Behavior
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.splitbelow = true
opt.splitright = true
opt.timeoutlen = 300
opt.updatetime = 200
opt.completeopt = { "menu", "menuone", "noselect" }
opt.conceallevel = 0
opt.confirm = true
opt.shortmess:append("sI")

-- Performance
opt.lazyredraw = false
opt.synmaxcol = 240
opt.redrawtime = 1500
