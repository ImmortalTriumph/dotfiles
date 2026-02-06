local M = {}

local function setup()
  local bufnr = vim.api.nvim_get_current_buf()
  if vim.b[bufnr].json_config_loaded then
    return
  end
  vim.b[bufnr].json_config_loaded = true

  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  vim.lsp.config("jsonls", {
    capabilities = capabilities,
    filetypes = { "json", "jsonc" },
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
        validate = { enable = true },
      },
    },
    on_new_config = function(new_config)
      local ok, schemastore = pcall(require, "schemastore")
      if ok then
        new_config.settings.json.schemas = schemastore.json.schemas()
      end
    end,
  })

  vim.lsp.enable("jsonls")

  require("conform").formatters_by_ft.json = { "prettierd", "prettier", stop_after_first = true }
  require("conform").formatters_by_ft.jsonc = { "prettierd", "prettier", stop_after_first = true }

  local map = function(mode, keys, func, desc)
    vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
  end

  map("n", "<leader>jf", function()
    vim.cmd("%!jq .")
  end, "Format with jq")

  map("n", "<leader>jc", function()
    vim.cmd("%!jq -c .")
  end, "Compact JSON")

  map("n", "<leader>jv", function()
    vim.cmd("split | terminal jq . " .. vim.fn.expand("%"))
  end, "Validate JSON")
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "json", "jsonc" },
  callback = setup,
  once = false,
})

if vim.bo.filetype == "json" or vim.bo.filetype == "jsonc" then
  setup()
end

return M
