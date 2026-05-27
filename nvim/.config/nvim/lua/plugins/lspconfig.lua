return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ["*"] = {
          keys = {
            { "K", false },
            { "gH", vim.lsp.buf.hover, desc = "LSP Hover" },
          },
        },
      },
    },
  },
}
