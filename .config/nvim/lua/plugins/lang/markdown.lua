local M = {}

local function setup()
  local bufnr = vim.api.nvim_get_current_buf()
  if vim.b[bufnr].markdown_config_loaded then
    return
  end
  vim.b[bufnr].markdown_config_loaded = true

  require("conform").formatters_by_ft.markdown = { "prettierd", "prettier", stop_after_first = true }

  vim.opt_local.wrap = true
  vim.opt_local.linebreak = true
  vim.opt_local.spell = true
  vim.opt_local.conceallevel = 2

  local map = function(mode, keys, func, desc)
    vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
  end

  map("n", "<leader>mp", function()
    local file = vim.fn.expand("%:p")
    vim.fn.jobstart({ "xdg-open", file }, { detach = true })
  end, "Preview in browser")

  map("n", "<leader>mt", function()
    local line = vim.api.nvim_get_current_line()
    if line:match("^%s*%- %[ %]") then
      line = line:gsub("%- %[ %]", "- [x]", 1)
    elseif line:match("^%s*%- %[x%]") then
      line = line:gsub("%- %[x%]", "- [ ]", 1)
    end
    vim.api.nvim_set_current_line(line)
  end, "Toggle checkbox")

  map("n", "<leader>ml", function()
    local url = vim.fn.input("URL: ")
    if url ~= "" then
      local text = vim.fn.input("Text: ")
      local link = text ~= "" and string.format("[%s](%s)", text, url) or string.format("<%s>", url)
      vim.api.nvim_put({ link }, "c", true, true)
    end
  end, "Insert link")

  map("n", "<leader>mc", function()
    local lang = vim.fn.input("Language: ")
    local fence = string.format("```%s\n\n```", lang)
    vim.api.nvim_put(vim.split(fence, "\n"), "l", true, true)
    vim.cmd("normal! k")
  end, "Insert code block")

  map("n", "<leader>mh", function()
    local level = vim.fn.input("Heading level (1-6): ")
    local num = tonumber(level)
    if num and num >= 1 and num <= 6 then
      local prefix = string.rep("#", num) .. " "
      local line = vim.api.nvim_get_current_line()
      line = line:gsub("^#+ ", "")
      vim.api.nvim_set_current_line(prefix .. line)
    end
  end, "Set heading level")
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = setup,
  once = false,
})

if vim.bo.filetype == "markdown" then
  setup()
end

return M
