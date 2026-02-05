local M = {
  {
    "windwp/nvim-ts-autotag",
    ft = { "html", "javascript", "javascriptreact", "typescript", "typescriptreact", "xml", "vue", "svelte", "astro" },
    opts = {
      opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = false,
      },
    },
  },
  {
    "NvChad/nvim-colorizer.lua",
    ft = { "css", "scss", "html", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte" },
    opts = {
      filetypes = { "css", "scss", "html", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte" },
      user_default_options = {
        RGB = true,
        RRGGBB = true,
        names = false,
        RRGGBBAA = true,
        AARRGGBB = true,
        rgb_fn = true,
        hsl_fn = true,
        css = true,
        css_fn = true,
        mode = "background",
        tailwind = true,
        sass = { enable = true, parsers = { "css" } },
        virtualtext = "■",
      },
    },
  },
}

local function setup()
  local bufnr = vim.api.nvim_get_current_buf()
  if vim.b[bufnr].web_config_loaded then
    return
  end
  vim.b[bufnr].web_config_loaded = true

  local ft = vim.bo[bufnr].filetype
  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  if ft == "javascript" or ft == "javascriptreact" or ft == "typescript" or ft == "typescriptreact" then
    vim.lsp.config("ts_ls", {
      capabilities = capabilities,
      settings = {
        typescript = {
          inlayHints = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayVariableTypeHintsWhenTypeMatchesName = false,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
        },
        javascript = {
          inlayHints = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayVariableTypeHintsWhenTypeMatchesName = false,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
        },
      },
      filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
      root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
    })
    vim.lsp.enable("ts_ls")
  end

  if ft == "html" then
    vim.lsp.config("html", {
      capabilities = capabilities,
      filetypes = { "html", "templ" },
      root_markers = { "package.json", ".git" },
    })
    vim.lsp.enable("html")
  end

  if ft == "css" or ft == "scss" then
    vim.lsp.config("cssls", {
      capabilities = capabilities,
      settings = {
        css = { validate = true, lint = { unknownAtRules = "ignore" } },
        scss = { validate = true, lint = { unknownAtRules = "ignore" } },
      },
      filetypes = { "css", "scss", "less" },
      root_markers = { "package.json", ".git" },
    })
    vim.lsp.enable("cssls")
  end

  vim.lsp.config("emmet_ls", {
    capabilities = capabilities,
    filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte" },
    init_options = {
      html = { options = { ["bem.enabled"] = true } },
    },
  })
  vim.lsp.enable("emmet_ls")

  local prettier_fts = { "javascript", "javascriptreact", "typescript", "typescriptreact", "html", "css", "scss", "json" }
  for _, filetype in ipairs(prettier_fts) do
    require("conform").formatters_by_ft[filetype] = { "prettierd", "prettier", stop_after_first = true }
  end

  local eslint_fts = { "javascript", "javascriptreact", "typescript", "typescriptreact" }
  for _, filetype in ipairs(eslint_fts) do
    require("lint").linters_by_ft[filetype] = { "eslint_d" }
  end

  local map = function(mode, keys, func, desc)
    vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
  end

  map("n", "<leader>wo", function()
    local file = vim.fn.expand("%:p")
    vim.fn.jobstart({ "xdg-open", file }, { detach = true })
  end, "Open in browser")

  map("n", "<leader>wl", function()
    vim.cmd("split | terminal npx live-server .")
  end, "Start live server")

  map("n", "<leader>ws", function()
    vim.fn.jobstart({ "pkill", "-f", "live-server" })
    vim.notify("Live server stopped", vim.log.levels.INFO)
  end, "Stop live server")

  if ft == "javascript" or ft == "typescript" then
    map("n", "<leader>wr", function()
      local cmd = ft == "typescript" and "npx ts-node" or "node"
      vim.cmd("split | terminal " .. cmd .. " " .. vim.fn.expand("%"))
    end, "Run with node")
  end

  map("n", "<leader>wn", function()
    vim.cmd("split | terminal npm run dev")
  end, "npm run dev")

  map("n", "<leader>wb", function()
    vim.cmd("split | terminal npm run build")
  end, "npm run build")

  map("n", "<leader>wi", function()
    vim.cmd("split | terminal npm install")
  end, "npm install")

  map("n", "<leader>wc", function()
    vim.cmd("ColorizerToggle")
  end, "Toggle colorizer")

  map("n", "<leader>wh", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
  end, "Toggle inlay hints")

  map("n", "<leader>wf", function()
    vim.cmd("!npx eslint --fix %")
    vim.cmd("edit")
  end, "ESLint fix")

  if ft == "typescript" or ft == "typescriptreact" then
    map("n", "<leader>wt", function()
      vim.cmd("split | terminal npx tsc --noEmit")
    end, "TypeScript check")
  end
end

local web_filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact" }

vim.api.nvim_create_autocmd("FileType", {
  pattern = web_filetypes,
  callback = setup,
  once = false,
})

if vim.tbl_contains(web_filetypes, vim.bo.filetype) then
  setup()
end

return M
