return {
  -- Readable line length for markdown: one real window, centred by empty side margins.
  {
    "shortcuts/no-neck-pain.nvim",
    version = "*",
    cmd = "NoNeckPain",
    opts = {
      width = 88, -- ~80 columns of text after line numbers and sign column
      autocmds = { skipEnteringNoNeckPainBuffer = true },
      -- Margins stay blank: no "[Scratch]" title from the global winbar
      -- (options.lua), no border line, no "~" filler rows.
      buffers = {
        -- winbar is global-local: "" would fall back to the global one, so use " ".
        wo = {
          winbar = " ",
          fillchars = "eob: ,vert: ",
          winhighlight = "WinBar:Normal,WinBarNC:Normal",
        },
      },
    },
    keys = {
      { "<leader>uz", "<cmd>NoNeckPain<cr>", desc = "Toggle centred width" },
    },
  },
}
