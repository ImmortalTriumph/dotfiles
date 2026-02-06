return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      { "<leader>lf", function() require("conform").format({ async = true, lsp_fallback = true }) end, mode = "", desc = "Format buffer" },
    },
    config = function()
      require("conform").setup({
        -- Language-specific formatters are registered in lang/*.lua files
        formatters_by_ft = {
          ["_"] = { "trim_whitespace" },
        },
        format_on_save = function(bufnr)
          local ignore_filetypes = { "sql", "java" }
          if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
            return
          end
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end
          return { timeout_ms = 500, lsp_fallback = true }
        end,
        formatters = {
          shfmt = { prepend_args = { "-i", "2" } },
          ["clang-format"] = { prepend_args = { "--style=file", "--fallback-style=Google" } },
        },
      })

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
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")

      -- Language-specific linters are registered in lang/*.lua files
      lint.linters_by_ft = {}

      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function() lint.try_lint() end,
      })

      vim.keymap.set("n", "<leader>ll", function() lint.try_lint() end, { desc = "Trigger linting" })
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          "prettier", "prettierd", "stylua", "shfmt", "clang-format",
          "google-java-format", "black", "ruff", "eslint_d", "mypy", "cpplint", "taplo",
        },
        auto_update = false,
        run_on_start = true,
      })
    end,
  },
  {
    'elkowar/yuck.vim',
    ft = 'yuck',
  }

}
