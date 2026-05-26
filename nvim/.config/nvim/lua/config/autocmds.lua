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
