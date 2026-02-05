return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    config = function()
      require("nvim-treesitter").setup({})

      local parsers = {
        "bash", "c", "cpp", "css", "dockerfile", "go", "html", "java", "javascript",
        "json", "lua", "markdown", "markdown_inline", "python", "regex", "rust",
        "toml", "tsx", "typescript", "vim", "vimdoc", "yaml",
      }

      vim.schedule(function()
        require("nvim-treesitter").install(parsers)
      end)

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "*",
        callback = function() pcall(vim.treesitter.start) end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "*",
        callback = function() vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" end,
      })

      vim.keymap.set("n", "<C-space>", function()
        local ok, inc_sel = pcall(require, "nvim-treesitter.incremental_selection")
        if ok and inc_sel.init_selection then inc_sel.init_selection() end
      end, { desc = "Init treesitter selection" })

      vim.keymap.set("x", "<C-space>", function()
        local ok, inc_sel = pcall(require, "nvim-treesitter.incremental_selection")
        if ok and inc_sel.node_incremental then inc_sel.node_incremental() end
      end, { desc = "Increment treesitter selection" })

      vim.keymap.set("x", "<bs>", function()
        local ok, inc_sel = pcall(require, "nvim-treesitter.incremental_selection")
        if ok and inc_sel.node_decremental then inc_sel.node_decremental() end
      end, { desc = "Decrement treesitter selection" })
    end,
  },
}
