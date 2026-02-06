local M = {}

local function setup()
  local bufnr = vim.api.nvim_get_current_buf()
  if vim.b[bufnr].yaml_config_loaded then
    return
  end
  vim.b[bufnr].yaml_config_loaded = true

  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  vim.lsp.config("yamlls", {
    capabilities = capabilities,
    filetypes = { "yaml", "yaml.docker-compose" },
    settings = {
      yaml = {
        schemas = {
          ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
          ["https://json.schemastore.org/github-action.json"] = "/.github/actions/**/action.yml",
          ["https://json.schemastore.org/docker-compose.json"] = "*docker-compose*.yml",
        },
        validate = true,
        completion = true,
        hover = true,
      },
    },
  })

  vim.lsp.enable("yamlls")

  require("conform").formatters_by_ft.yaml = { "prettierd", "prettier", stop_after_first = true }

  local map = function(mode, keys, func, desc)
    vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
  end

  map("n", "<leader>yv", function()
    vim.cmd("split | terminal yamllint " .. vim.fn.expand("%"))
  end, "Validate YAML")
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "yaml", "yaml.docker-compose" },
  callback = setup,
  once = false,
})

if vim.bo.filetype == "yaml" or vim.bo.filetype == "yaml.docker-compose" then
  setup()
end

return M
