-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.winbar = "%=%m %f"

vim.opt.exrc = true
vim.opt.guicursor = ""
vim.opt.relativenumber = true
vim.opt.hlsearch = false
vim.opt.hidden = true
vim.opt.errorbells = false
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.number = true
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.smartcase = true
vim.opt.backup = false
vim.opt.undodir = vim.fn.expand("~/.vim/undodir")
vim.opt.undofile = true
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.showmode = false
vim.opt.completeopt = { "menuone", "noinsert", "noselect" }
vim.opt.colorcolumn = "90"
vim.opt.signcolumn = "yes"
vim.opt.cmdheight = 2
vim.opt.updatetime = 50
vim.opt.shortmess:append("c")
vim.opt.textwidth = 100
vim.opt.splitbelow = true
vim.opt.splitright = true
