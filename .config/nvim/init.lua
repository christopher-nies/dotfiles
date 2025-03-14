-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Settings
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

-- Leader keys
vim.g.mapleader = " "  -- Set <leader> to <space>
vim.g.maplocalleader = "\\"  -- Set <localleader> to "\"

-- Key mappings
-- Escape mapping to exit insert mode
vim.api.nvim_set_keymap('i', 'jk', '<Esc>', { noremap = true, silent = true })

-- Scrolling
vim.api.nvim_set_keymap('n', 'J', '5gj', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'K', '5gk', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', 'J', '5gj', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', 'K', '5gk', { noremap = true, silent = true })

-- Navigation
vim.api.nvim_set_keymap('n', 'j', 'gj', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'k', 'gk', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'L', '$', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'H', '^', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>j', 'J', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>k', 'K', { noremap = true, silent = true })

-- Clipboard mappings
vim.api.nvim_set_keymap('v', '<Leader>y', '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<Leader>p', '"+p', { noremap = true, silent = true })

-- Quit and write
vim.api.nvim_set_keymap('n', '<leader>q', ':q<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>w', ':w<CR>', { noremap = true, silent = true })

local plugins = {
  { 
    "ellisonleao/gruvbox.nvim", priority = 1000 , 
    config = true,
  },
  { 
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim", 
    }
  },
  { 
    "nvim-treesitter/nvim-treesitter", 
    build = ":TSUpdate",
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
  },
}

local opts = {}

-- Setup lazy.nvim
require("lazy").setup(plugins, opts)

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })

-- Tree-sitter
local config = require("nvim-treesitter.configs")
config.setup({ 
    ensure_installed = {"lua", "javascript", "python"},
    highlight = { enable = true }, 
    indent = { enable = true }, 
})

-- neo-tree
vim.keymap.set('n', '<C-n>', ':Neotree filesystem toggle left<CR>')

-- Colorscheme with default options
require("gruvbox").setup({
    italic = {
        strings = false,
    },
})

vim.cmd("colorscheme gruvbox")
