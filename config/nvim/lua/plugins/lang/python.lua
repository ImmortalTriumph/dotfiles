local M = {
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-telescope/telescope.nvim",
      "mfussenegger/nvim-dap-python",
    },
    branch = "regexp",
    ft = "python",
    keys = {
      { "<leader>pv", "<cmd>VenvSelect<cr>", desc = "Select venv", ft = "python" },
    },
    opts = {
      name = { "venv", ".venv", "env", ".env" },
      auto_refresh = true,
    },
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      local path = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(path)
    end,
  },
}

local function setup()
  local bufnr = vim.api.nvim_get_current_buf()
  if vim.b[bufnr].python_config_loaded then
    return
  end
  vim.b[bufnr].python_config_loaded = true

  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  vim.lsp.config("pyright", {
    capabilities = capabilities,
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          diagnosticMode = "openFilesOnly",
          useLibraryCodeForTypes = true,
          typeCheckingMode = "basic",
        },
      },
    },
    root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", ".git" },
  })

  vim.lsp.enable("pyright")

  require("conform").formatters_by_ft.python = { "ruff_format", "black", stop_after_first = true }
  require("lint").linters_by_ft.python = { "ruff", "mypy" }

  local map = function(mode, keys, func, desc)
    vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
  end

  map("n", "<leader>pr", function()
    vim.cmd("split | terminal python3 " .. vim.fn.expand("%"))
  end, "Run current file")

  map("n", "<leader>pt", function()
    vim.cmd("split | terminal pytest")
  end, "Run pytest")

  map("n", "<leader>ptf", function()
    vim.cmd("split | terminal pytest " .. vim.fn.expand("%"))
  end, "Run pytest (file)")

  map("n", "<leader>ptn", function()
    local func_name = vim.fn.expand("<cword>")
    vim.cmd("split | terminal pytest -k " .. func_name)
  end, "Run pytest (function)")

  map("n", "<leader>pi", function()
    local req_file = vim.fn.findfile("requirements.txt", ".;")
    if req_file ~= "" then
      vim.cmd("split | terminal pip install -r " .. req_file)
    else
      vim.notify("requirements.txt not found", vim.log.levels.WARN)
    end
  end, "pip install requirements")

  map("n", "<leader>pd", function()
    require("dap-python").test_method()
  end, "Debug test method")

  map("n", "<leader>pD", function()
    require("dap-python").test_class()
  end, "Debug test class")

  map("n", "<leader>ph", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
  end, "Toggle inlay hints")

  map("n", "<leader>pp", function()
    vim.cmd("split | terminal python3")
  end, "Open Python REPL")

  map("v", "<leader>ps", function()
    local lines = vim.fn.getregion(vim.fn.getpos("v"), vim.fn.getpos("."), { type = vim.fn.mode() })
    local code = table.concat(lines, "\n")
    vim.fn.setreg("+", code)
    vim.notify("Code copied to clipboard", vim.log.levels.INFO)
  end, "Copy selection for REPL")
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = setup,
  once = false,
})

if vim.bo.filetype == "python" then
  setup()
end

return M
