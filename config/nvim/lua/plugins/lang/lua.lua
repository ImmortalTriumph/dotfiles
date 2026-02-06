local M = {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "wezterm-types", mods = { "wezterm" } },
      },
    },
  },
  {
    "Bilal2453/luvit-meta",
    lazy = true,
  },
}

local function setup()
  local bufnr = vim.api.nvim_get_current_buf()
  if vim.b[bufnr].lua_config_loaded then
    return
  end
  vim.b[bufnr].lua_config_loaded = true

  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  vim.lsp.config("lua_ls", {
    capabilities = capabilities,
    settings = {
      Lua = {
        runtime = { version = "LuaJIT" },
        diagnostics = { globals = {} },
        workspace = {
          checkThirdParty = false,
          library = { vim.env.VIMRUNTIME },
        },
        completion = { callSnippet = "Replace" },
        hint = {
          enable = true,
          setType = true,
          paramType = true,
          paramName = "Disable",
          semicolon = "Disable",
          arrayIndex = "Disable",
        },
        telemetry = { enable = false },
      },
    },
    root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", "selene.yml", ".git" },
  })

  vim.lsp.enable("lua_ls")

  require("conform").formatters_by_ft.lua = { "stylua" }

  local map = function(mode, keys, func, desc)
    vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
  end

  map("n", "<leader>Lr", function()
    vim.cmd("split | terminal lua " .. vim.fn.expand("%"))
  end, "Run current file")

  map("v", "<leader>Lx", function()
    local lines = vim.fn.getregion(vim.fn.getpos("v"), vim.fn.getpos("."), { type = vim.fn.mode() })
    local code = table.concat(lines, "\n")
    local ok, result = pcall(loadstring(code))
    if ok then
      vim.notify("Executed successfully" .. (result and (": " .. vim.inspect(result)) or ""), vim.log.levels.INFO)
    else
      vim.notify("Error: " .. tostring(result), vim.log.levels.ERROR)
    end
  end, "Execute selection")

  map("n", "<leader>Ls", function()
    vim.cmd("source %")
    vim.notify("Sourced: " .. vim.fn.expand("%"), vim.log.levels.INFO)
  end, "Source file")

  map("n", "<leader>Lh", function()
    local word = vim.fn.expand("<cword>")
    vim.cmd("help " .. word)
  end, "Help for word")

  map("n", "<leader>Li", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
  end, "Toggle inlay hints")

  map("n", "<leader>LR", function()
    local file = vim.fn.expand("%:p")
    local module = file:match("lua/(.+)%.lua$")
    if module then
      module = module:gsub("/", ".")
      package.loaded[module] = nil
      require(module)
      vim.notify("Reloaded: " .. module, vim.log.levels.INFO)
    else
      vim.notify("Could not determine module name", vim.log.levels.WARN)
    end
  end, "Reload module")

  map("n", "<leader>La", function()
    vim.cmd("help api")
  end, "Neovim API docs")

  map("n", "<leader>Lc", function()
    local file = vim.fn.expand("%")
    vim.cmd("split | terminal luac -p " .. file)
  end, "Check syntax")
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = setup,
  once = false,
})

if vim.bo.filetype == "lua" then
  setup()
end

return M
