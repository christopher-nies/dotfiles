-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Escape mapping to exit insert mode
vim.api.nvim_set_keymap("i", "jk", "<Esc>", { noremap = true, silent = true })

-- Scrolling
vim.api.nvim_set_keymap("n", "J", "5gj", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "K", "5gk", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "J", "5gj", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "K", "5gk", { noremap = true, silent = true })

-- Navigation
vim.api.nvim_set_keymap("n", "j", "gj", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "k", "gk", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "L", "$", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "H", "^", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>j", "J", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>k", "K", { noremap = true, silent = true })

-- Clipboard mappings
vim.api.nvim_set_keymap("v", "<Leader>y", '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<Leader>p", '"+p', { noremap = true, silent = true })

-- Quit and write
vim.api.nvim_set_keymap("n", "<leader>q", ":q<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>w", ":w<CR>", { noremap = true, silent = true })
