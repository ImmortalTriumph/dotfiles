local M = {}

local function setup()
  local bufnr = vim.api.nvim_get_current_buf()
  if vim.b[bufnr].bash_config_loaded then
    return
  end
  vim.b[bufnr].bash_config_loaded = true

  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  vim.lsp.config("bashls", {
    capabilities = capabilities,
    filetypes = { "sh", "bash", "zsh" },
    settings = {
      bashIde = {
        globPattern = "*@(.sh|.inc|.bash|.command)",
      },
    },
  })

  vim.lsp.enable("bashls")

  require("conform").formatters_by_ft.sh = { "shfmt" }
  require("conform").formatters_by_ft.bash = { "shfmt" }
  require("conform").formatters_by_ft.zsh = { "shfmt" }

  local map = function(mode, keys, func, desc)
    vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
  end

  map("n", "<leader>br", function()
    vim.cmd("split | terminal bash " .. vim.fn.expand("%"))
  end, "Run script")

  map("n", "<leader>bc", function()
    vim.cmd("split | terminal bash -n " .. vim.fn.expand("%"))
  end, "Check syntax")

  map("n", "<leader>bx", function()
    local file = vim.fn.expand("%")
    vim.fn.system("chmod +x " .. file)
    vim.notify("Made executable: " .. file, vim.log.levels.INFO)
  end, "Make executable")
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "sh", "bash", "zsh" },
  callback = setup,
  once = false,
})

if vim.tbl_contains({ "sh", "bash", "zsh" }, vim.bo.filetype) then
  setup()
end

return M
