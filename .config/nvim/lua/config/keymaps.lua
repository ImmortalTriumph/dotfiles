local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

map("n", "<C-Up>", ":resize +2<CR>", opts)
map("n", "<C-Down>", ":resize -2<CR>", opts)
map("n", "<C-Left>", ":vertical resize -2<CR>", opts)
map("n", "<C-Right>", ":vertical resize +2<CR>", opts)

map("n", "<S-h>", ":bprevious<CR>", opts)
map("n", "<S-l>", ":bnext<CR>", opts)
map("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete buffer" })

map("n", "<Esc>", ":nohlsearch<CR>", opts)

map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

map("n", "<A-j>", ":m .+1<CR>==", opts)
map("n", "<A-k>", ":m .-2<CR>==", opts)
map("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
map("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)

map("n", "<C-d>", "<C-d>zz", opts)
map("n", "<C-u>", "<C-u>zz", opts)
map("n", "n", "nzzzv", opts)
map("n", "N", "Nzzzv", opts)

map("n", "<leader>w", ":w<CR>", { desc = "Save file" })
map("n", "<leader>q", ":q<CR>", { desc = "Quit" })
map("n", "<leader>x", ":x<CR>", { desc = "Save and quit" })

map("n", "Y", "y$", opts)
map("v", "p", '"_dP', opts)

map("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "File explorer" })
map("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Find files" })
map("n", "<leader>fg", ":Telescope live_grep<CR>", { desc = "Live grep" })
map("n", "<leader>fb", ":Telescope buffers<CR>", { desc = "Buffers" })
map("n", "<leader>fh", ":Telescope help_tags<CR>", { desc = "Help" })
map("n", "<leader>fr", ":Telescope oldfiles<CR>", { desc = "Recent files" })

map("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Line diagnostics" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })

map("n", "<leader>tt", ":ToggleTerm<CR>", { desc = "Toggle terminal" })
map("t", "<Esc>", "<C-\\><C-n>", opts)

map("n", "<leader>gg", ":LazyGit<CR>", { desc = "LazyGit" })
map("n", "<leader>gd", ":Gitsigns diffthis<CR>", { desc = "Diff" })
map("n", "<leader>gb", ":Gitsigns blame_line<CR>", { desc = "Blame line" })
