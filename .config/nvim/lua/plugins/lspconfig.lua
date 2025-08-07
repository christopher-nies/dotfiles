return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- Disable default 'K' mapping
      keys[#keys + 1] = { "K", false }
      -- Add new 'gH' mapping for hover
      keys[#keys + 1] = {
        "gH",
        vim.lsp.buf.hover,
        desc = "LSP Hover",
        mode = "n",
      }
      opts.keys = keys
    end,
  },
}
