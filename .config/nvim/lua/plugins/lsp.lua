return {
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
    dependencies = { "mfussenegger/nvim-dap" },
  },
  {
    "b0o/schemastore.nvim",
    lazy = true,
  },
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup({
        ui = {
          border = "rounded",
          icons = {
            package_installed = "",
            package_pending = "",
            package_uninstalled = "",
          },
        },
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls", "rust_analyzer", "pyright", "bashls", "jsonls",
          "yamlls", "cssls", "html", "ts_ls", "emmet_ls", "clangd", "jdtls", "taplo",
        },
      })
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    lazy = false,
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-nvim-dap").setup({
        ensure_installed = { "codelldb", "javadbg", "javatest", "debugpy" },
        automatic_installation = true,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "b0o/schemastore.nvim",
      { "j-hui/fidget.nvim", opts = { notification = { window = { winblend = 0 } } } },
    },
    config = function()
      -- Global LSP keymaps (applied to all LSP clients)
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
          end

          map("gd", vim.lsp.buf.definition, "Go to definition")
          map("gD", vim.lsp.buf.declaration, "Go to declaration")
          map("gr", vim.lsp.buf.references, "References")
          map("gi", vim.lsp.buf.implementation, "Implementation")
          map("K", vim.lsp.buf.hover, "Hover")
          map("<leader>la", vim.lsp.buf.code_action, "Code action")
          map("<leader>lr", vim.lsp.buf.rename, "Rename")
          map("<leader>lf", function() vim.lsp.buf.format({ async = true }) end, "Format")
          map("<leader>ls", vim.lsp.buf.signature_help, "Signature help")
        end,
      })

      -- Global diagnostic config
      vim.diagnostic.config({
        virtual_text = { prefix = "", spacing = 2 },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = { border = "rounded", source = true },
      })

      local signs = { Error = "", Warn = "", Hint = "", Info = "" }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end

      -- Language-specific LSP configs are in lang/*.lua files
    end,
  },
}
