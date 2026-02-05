local M = {
  {
    "p00f/clangd_extensions.nvim",
    ft = { "c", "cpp", "objc", "objcpp" },
    opts = {
      inlay_hints = {
        inline = true,
        only_current_line = false,
        only_current_line_autocmd = { "CursorHold" },
        show_parameter_hints = true,
        parameter_hints_prefix = "<- ",
        other_hints_prefix = "=> ",
        max_len_align = false,
        max_len_align_padding = 1,
        right_align = false,
        right_align_padding = 7,
        highlight = "Comment",
        priority = 100,
      },
      ast = {
        role_icons = {
          type = "",
          declaration = "",
          expression = "",
          specifier = "",
          statement = "",
          ["template argument"] = "",
        },
        kind_icons = {
          Compound = "",
          Recovery = "",
          TranslationUnit = "",
          PackExpansion = "",
          TemplateTypeParm = "",
          TemplateTemplateParm = "",
          TemplateParamObject = "",
        },
        highlights = { detail = "Comment" },
      },
      memory_usage = { border = "rounded" },
      symbol_info = { border = "rounded" },
    },
  },
}

-- Shared setup for C/C++ (clangd LSP and codelldb DAP)
M.setup_clangd_and_codelldb = function()
  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  vim.lsp.config("clangd", {
    capabilities = capabilities,
    cmd = {
      "clangd",
      "--background-index",
      "--clang-tidy",
      "--header-insertion=iwyu",
      "--completion-style=detailed",
      "--function-arg-placeholders",
      "--fallback-style=Google",
    },
    filetypes = { "c", "cpp", "objc", "objcpp" },
    root_markers = { ".clangd", ".clang-tidy", ".clang-format", "compile_commands.json", "compile_flags.txt", ".git" },
  })

  vim.lsp.enable("clangd")

  local dap = require("dap")
  local mason_path = vim.fn.stdpath("data") .. "/mason"
  local codelldb_path = mason_path .. "/packages/codelldb/extension/adapter/codelldb"

  if not dap.adapters.codelldb then
    dap.adapters.codelldb = {
      type = "server",
      port = "${port}",
      executable = {
        command = codelldb_path,
        args = { "--port", "${port}" },
      },
    }
  end

  return dap
end

-- Shared DAP configurations for C/C++
M.get_codelldb_configurations = function()
  return {
    {
      name = "Launch file",
      type = "codelldb",
      request = "launch",
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
      args = function()
        local args_string = vim.fn.input("Arguments: ")
        return vim.split(args_string, " ", { trimempty = true })
      end,
    },
    {
      name = "Launch file (no args)",
      type = "codelldb",
      request = "launch",
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
    },
    {
      name = "Attach to process",
      type = "codelldb",
      request = "attach",
      pid = require("dap.utils").pick_process,
      cwd = "${workspaceFolder}",
    },
  }
end

local function setup()
  local bufnr = vim.api.nvim_get_current_buf()
  if vim.b[bufnr].c_config_loaded then
    return
  end
  vim.b[bufnr].c_config_loaded = true

  local dap = M.setup_clangd_and_codelldb()
  dap.configurations.c = M.get_codelldb_configurations()

  require("conform").formatters_by_ft.c = { "clang-format" }
  require("lint").linters_by_ft.c = { "cpplint" }

  local map = function(mode, keys, func, desc)
    vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
  end

  map("n", "<leader>ch", "<cmd>ClangdSwitchSourceHeader<cr>", "Switch header/source")

  map("n", "<leader>cr", function()
    local file = vim.fn.expand("%")
    local output = vim.fn.expand("%:r")
    vim.cmd("split | terminal gcc -g -Wall -Wextra " .. file .. " -o " .. output .. " && ./" .. output)
  end, "Compile and run")

  map("n", "<leader>cc", function()
    local file = vim.fn.expand("%")
    local output = vim.fn.expand("%:r")
    vim.cmd("split | terminal gcc -g -Wall -Wextra " .. file .. " -o " .. output)
  end, "Compile only")

  map("n", "<leader>ci", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
  end, "Toggle inlay hints")

  map("n", "<leader>ca", "<cmd>ClangdAST<cr>", "Show AST")
  map("n", "<leader>ct", "<cmd>ClangdTypeHierarchy<cr>", "Show type hierarchy")
  map("n", "<leader>cm", "<cmd>ClangdMemoryUsage<cr>", "Show memory usage")
  map("n", "<leader>cs", "<cmd>ClangdSymbolInfo<cr>", "Show symbol info")
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "c",
  callback = setup,
  once = false,
})

if vim.bo.filetype == "c" then
  setup()
end

return M
