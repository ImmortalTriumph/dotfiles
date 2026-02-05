local M = {}

local function setup()
  local bufnr = vim.api.nvim_get_current_buf()
  if vim.b[bufnr].cpp_config_loaded then
    return
  end
  vim.b[bufnr].cpp_config_loaded = true

  -- Use shared C/C++ setup from c.lua
  local c_module = require("plugins.lang.c")
  local dap = c_module.setup_clangd_and_codelldb()
  dap.configurations.cpp = c_module.get_codelldb_configurations()

  require("conform").formatters_by_ft.cpp = { "clang-format" }
  require("lint").linters_by_ft.cpp = { "cpplint" }

  local map = function(mode, keys, func, desc)
    vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
  end

  map("n", "<leader>ch", "<cmd>ClangdSwitchSourceHeader<cr>", "Switch header/source")

  map("n", "<leader>cr", function()
    local file = vim.fn.expand("%")
    local output = vim.fn.expand("%:r")
    vim.cmd("split | terminal g++ -g -Wall -Wextra -std=c++17 " .. file .. " -o " .. output .. " && ./" .. output)
  end, "Compile and run")

  map("n", "<leader>cc", function()
    local file = vim.fn.expand("%")
    local output = vim.fn.expand("%:r")
    vim.cmd("split | terminal g++ -g -Wall -Wextra -std=c++17 " .. file .. " -o " .. output)
  end, "Compile only")

  map("n", "<leader>ci", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
  end, "Toggle inlay hints")

  map("n", "<leader>ca", "<cmd>ClangdAST<cr>", "Show AST")
  map("n", "<leader>ct", "<cmd>ClangdTypeHierarchy<cr>", "Show type hierarchy")
  map("n", "<leader>cm", "<cmd>ClangdMemoryUsage<cr>", "Show memory usage")
  map("n", "<leader>cs", "<cmd>ClangdSymbolInfo<cr>", "Show symbol info")

  map("n", "<leader>cg", function()
    local class_name = vim.fn.input("Class name: ")
    if class_name == "" then
      return
    end
    local lines = {
      "class " .. class_name .. " {",
      "public:",
      "    " .. class_name .. "();",
      "    ~" .. class_name .. "();",
      "",
      "    " .. class_name .. "(const " .. class_name .. "& other);",
      "    " .. class_name .. "& operator=(const " .. class_name .. "& other);",
      "",
      "    " .. class_name .. "(" .. class_name .. "&& other) noexcept;",
      "    " .. class_name .. "& operator=(" .. class_name .. "&& other) noexcept;",
      "",
      "private:",
      "};",
    }
    vim.api.nvim_put(lines, "l", true, true)
  end, "Generate class skeleton")
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "cpp",
  callback = setup,
  once = false,
})

if vim.bo.filetype == "cpp" then
  setup()
end

return M
