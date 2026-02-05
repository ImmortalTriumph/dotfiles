local M = {
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    lazy = false,
    ft = "rust",
    init = function()
      local mason_path = vim.fn.stdpath("data") .. "/mason"
      local codelldb_path = mason_path .. "/packages/codelldb/extension/adapter/codelldb"
      local liblldb_path = mason_path .. "/packages/codelldb/extension/lldb/lib/liblldb.so"

      vim.g.rustaceanvim = {
        tools = {
          hover_actions = { replace_builtin_hover = false },
          float_win_config = { border = "rounded" },
        },
        server = {
          on_attach = function(client, bufnr)
            local map = function(mode, keys, func, desc)
              vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
            end

            map("n", "<leader>rr", function() vim.cmd.RustLsp("runnables") end, "Cargo run / Runnables")
            map("n", "<leader>rb", function() vim.cmd("split | terminal cargo build") end, "Cargo build")
            map("n", "<leader>rc", function() vim.cmd("split | terminal cargo check") end, "Cargo check")
            map("n", "<leader>rt", function() vim.cmd.RustLsp("testables") end, "Cargo test")
            map("n", "<leader>rd", function() vim.cmd.RustLsp("openDocs") end, "Open docs.rs")
            map("n", "<leader>re", function() vim.cmd.RustLsp("expandMacro") end, "Expand macro")
            map("n", "<leader>rp", function() vim.cmd.RustLsp("parentModule") end, "Parent module")
            map("n", "<leader>rj", function() vim.cmd.RustLsp("joinLines") end, "Join lines")
            map("n", "<leader>ra", function() vim.cmd.RustLsp("codeAction") end, "Code action group")
            map("n", "<leader>rD", function() vim.cmd.RustLsp("debuggables") end, "Debug nearest")
            map("n", "<leader>rh", function() vim.cmd.RustLsp({ "hover", "actions" }) end, "Hover actions")
            map("n", "<leader>ri", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
            end, "Toggle inlay hints")
            map("n", "<leader>rm", function() vim.cmd.RustLsp("rebuildProcMacros") end, "Rebuild proc macros")
            map("n", "<leader>rv", function() vim.cmd.RustLsp({ "view", "mir" }) end, "View MIR")
            map("n", "<leader>rx", function() vim.cmd.RustLsp("explainError") end, "Explain error")
            map("n", "<leader>rl", function() vim.cmd.RustLsp("renderDiagnostic") end, "Render diagnostic")
          end,
          default_settings = {
            ["rust-analyzer"] = {
              checkOnSave = { command = "clippy" },
              cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
                runBuildScripts = true,
              },
              procMacro = {
                enable = true,
                ignored = {
                  ["async-trait"] = { "async_trait" },
                  ["napi-derive"] = { "napi" },
                  ["async-recursion"] = { "async_recursion" },
                },
              },
              inlayHints = {
                lifetimeElisionHints = {
                  enable = true,
                  useParameterNames = true,
                },
              },
            },
          },
        },
        dap = {
          adapter = {
            type = "server",
            port = "${port}",
            host = "127.0.0.1",
            executable = {
              command = codelldb_path,
              args = { "--liblldb", liblldb_path, "--port", "${port}" },
            },
          },
        },
      }
    end,
  },
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      popup = {
        border = "rounded",
        show_version_date = true,
        max_height = 30,
        min_width = 20,
      },
      completion = { cmp = { enabled = true } },
    },
    config = function(_, opts)
      local crates = require("crates")
      crates.setup(opts)

      vim.api.nvim_create_autocmd("BufRead", {
        pattern = "Cargo.toml",
        callback = function(args)
          local bufnr = args.buf
          local map = function(mode, keys, func, desc)
            vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
          end

          map("n", "<leader>cu", crates.update_crate, "Update crate")
          map("v", "<leader>cu", crates.update_crates, "Update crates")
          map("n", "<leader>cU", crates.upgrade_crate, "Upgrade crate")
          map("v", "<leader>cU", crates.upgrade_crates, "Upgrade crates")
          map("n", "<leader>cA", crates.upgrade_all_crates, "Upgrade all crates")
          map("n", "<leader>cd", crates.show_dependencies_popup, "Show dependencies")
          map("n", "<leader>cf", crates.show_features_popup, "Show features")
          map("n", "<leader>cv", crates.show_versions_popup, "Show versions")
          map("n", "<leader>cH", crates.open_homepage, "Open homepage")
          map("n", "<leader>cR", crates.open_repository, "Open repository")
          map("n", "<leader>cD", crates.open_documentation, "Open documentation")
          map("n", "<leader>cC", crates.open_crates_io, "Open crates.io")
        end,
      })
    end,
  },
}

local function setup()
  local bufnr = vim.api.nvim_get_current_buf()
  if vim.b[bufnr].rust_config_loaded then
    return
  end
  vim.b[bufnr].rust_config_loaded = true

  require("conform").formatters_by_ft.rust = { "rustfmt" }
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "rust",
  callback = setup,
  once = false,
})

if vim.bo.filetype == "rust" then
  setup()
end

return M
