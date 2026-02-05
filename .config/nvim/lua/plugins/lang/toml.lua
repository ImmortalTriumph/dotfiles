local M = {}

local function setup()
  local bufnr = vim.api.nvim_get_current_buf()
  if vim.b[bufnr].toml_config_loaded then
    return
  end
  vim.b[bufnr].toml_config_loaded = true

  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  vim.lsp.config("taplo", {
    capabilities = capabilities,
    filetypes = { "toml" },
    settings = {
      taplo = {
        configFile = { enabled = true },
        schema = {
          enabled = true,
          catalogs = { "https://www.schemastore.org/api/json/catalog.json" },
        },
      },
    },
  })

  vim.lsp.enable("taplo")

  require("conform").formatters_by_ft.toml = { "taplo" }

  local map = function(mode, keys, func, desc)
    vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
  end

  map("n", "<leader>tv", function()
    vim.cmd("split | terminal taplo check " .. vim.fn.expand("%"))
  end, "Validate TOML")

  map("n", "<leader>tf", function()
    vim.cmd("split | terminal taplo format " .. vim.fn.expand("%"))
    vim.cmd("edit")
  end, "Format with taplo")
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "toml",
  callback = setup,
  once = false,
})

if vim.bo.filetype == "toml" then
  setup()
end

return M
