-- Formatting and linting with conform.nvim and nvim-lint

return {
  -- Formatter
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>lf",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = "",
        desc = "Format buffer",
      },
    },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          -- JavaScript/TypeScript/JSX/TSX
          javascript = { "prettierd", "prettier", stop_after_first = true },
          javascriptreact = { "prettierd", "prettier", stop_after_first = true },
          typescript = { "prettierd", "prettier", stop_after_first = true },
          typescriptreact = { "prettierd", "prettier", stop_after_first = true },
          jsx = { "prettierd", "prettier", stop_after_first = true },
          tsx = { "prettierd", "prettier", stop_after_first = true },

          -- Web
          html = { "prettierd", "prettier", stop_after_first = true },
          css = { "prettierd", "prettier", stop_after_first = true },
          scss = { "prettierd", "prettier", stop_after_first = true },
          json = { "prettierd", "prettier", stop_after_first = true },
          yaml = { "prettierd", "prettier", stop_after_first = true },
          markdown = { "prettierd", "prettier", stop_after_first = true },

          -- C/C++
          c = { "clang-format" },
          cpp = { "clang-format" },

          -- Java
          java = { "google-java-format" },

          -- Python
          python = { "ruff_format", "black", stop_after_first = true },

          -- Rust
          rust = { "rustfmt" },

          -- Lua
          lua = { "stylua" },

          -- Shell
          sh = { "shfmt" },
          bash = { "shfmt" },

          -- Fallback
          ["_"] = { "trim_whitespace" },
        },

        format_on_save = function(bufnr)
          -- Disable autoformat for certain filetypes
          local ignore_filetypes = { "sql", "java" }
          if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
            return
          end

          -- Disable with a global variable
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end

          return {
            timeout_ms = 500,
            lsp_fallback = true,
          }
        end,

        formatters = {
          shfmt = {
            prepend_args = { "-i", "2" },
          },
          ["clang-format"] = {
            prepend_args = { "--style=file", "--fallback-style=Google" },
          },
        },
      })

      -- Commands to toggle format on save
      vim.api.nvim_create_user_command("FormatDisable", function(args)
        if args.bang then
          vim.b.disable_autoformat = true
        else
          vim.g.disable_autoformat = true
        end
      end, { desc = "Disable autoformat-on-save", bang = true })

      vim.api.nvim_create_user_command("FormatEnable", function()
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
      end, { desc = "Enable autoformat-on-save" })
    end,
  },

  -- Linter
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        javascript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescript = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        python = { "ruff", "mypy" },
        c = { "cpplint" },
        cpp = { "cpplint" },
      }

      -- Create autocommand to trigger linting
      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })

      -- Keymap to manually trigger linting
      vim.keymap.set("n", "<leader>ll", function()
        lint.try_lint()
      end, { desc = "Trigger linting" })
    end,
  },

  -- Mason tool installer for formatters/linters
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          -- Formatters
          "prettier",
          "prettierd",
          "stylua",
          "shfmt",
          "clang-format",
          "google-java-format",
          "black",
          "ruff",

          -- Linters
          "eslint_d",
          "mypy",
          "cpplint",
        },
        auto_update = false,
        run_on_start = true,
      })
    end,
  },
}
