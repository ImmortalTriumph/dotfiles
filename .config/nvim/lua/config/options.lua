local opt = vim.opt

vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

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

opt.background = "dark"

opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4
opt.smartindent = true
opt.wrap = false
opt.linebreak = true
opt.breakindent = true

opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.undodir = vim.fn.stdpath("data") .. "/undo"

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

opt.lazyredraw = false
opt.synmaxcol = 240
opt.redrawtime = 1500
