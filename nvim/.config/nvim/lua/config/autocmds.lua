-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Markdown: LazyVim already sets conceallevel=2 (global) and spell=true for markdown.
-- Only override what it doesn't handle: colorcolumn, textwidth, and German spellcheck.
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("markdown_overrides", { clear = true }),
  pattern = "markdown",
  callback = function()
    vim.opt_local.colorcolumn = ""
    vim.opt_local.textwidth = 0
    vim.opt_local.spelllang = "en,de"
  end,
})

-- Markdown: centre real markdown files at a readable width (no-neck-pain), and go back
-- to full width when a normal file of another type takes the window.
-- Only real file buffers in normal windows count: LSP hover floats are filetype
-- markdown too, and pickers, explorers and the margin buffers are all buftype=nofile.
local function markdown_width(buf)
  if vim.bo[buf].buftype ~= "" then
    return
  end
  vim.schedule(function()
    local win = vim.api.nvim_get_current_win()
    if vim.api.nvim_win_get_buf(win) ~= buf or vim.api.nvim_win_get_config(win).relative ~= "" then
      return
    end
    local active = require("no-neck-pain.state"):is_active_tab_registered()
    local markdown = vim.bo[buf].filetype == "markdown"
    if markdown and not active then
      require("no-neck-pain").enable()
      -- The border on the text window's right edge is drawn by this window.
      -- Append to the global value so its other entries (e.g. eob) stay.
      vim.wo[win].fillchars = vim.go.fillchars .. ",vert: "
    elseif not markdown and active then
      require("no-neck-pain").disable()
      vim.wo[win].fillchars = "" -- back to the global value
    end
  end)
end
vim.api.nvim_create_autocmd("BufWinEnter", {
  group = vim.api.nvim_create_augroup("markdown_width", { clear = true }),
  callback = function(ev)
    markdown_width(ev.buf)
  end,
})
-- This file loads on VeryLazy, after `nvim note.md` already entered its window.
markdown_width(vim.api.nvim_get_current_buf())
