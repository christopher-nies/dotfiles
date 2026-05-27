return {
  -- Obsidian-optimized render-markdown overrides (LazyVim disables checkboxes and icons by default)
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      heading = {
        sign = false,
        icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
      },
      code = {
        sign = false,
        width = "block",
        right_pad = 1,
        border = "thin",
      },
      checkbox = {
        enabled = true,
        unchecked = { icon = "󰄱 " },
        checked = { icon = "󰱒 " },
      },
      callout = {
        note = { raw = "[!NOTE]", rendered = "󰋽 Note", highlight = "RenderMarkdownInfo" },
        tip = { raw = "[!TIP]", rendered = "󰌶 Tip", highlight = "RenderMarkdownSuccess" },
        important = { raw = "[!IMPORTANT]", rendered = "󰅾 Important", highlight = "RenderMarkdownHint" },
        warning = { raw = "[!WARNING]", rendered = "󰀪 Warning", highlight = "RenderMarkdownWarn" },
        caution = { raw = "[!CAUTION]", rendered = "󰳦 Caution", highlight = "RenderMarkdownError" },
      },
    },
  },

  -- Override markdown-preview build to use bun instead of npm
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && bun install",
  },

  -- Glow: charmbracelet/glow CLI wrapped for nvim floating preview
  -- Install: sudo pacman -S glow
  {
    "ellisonleao/glow.nvim",
    cmd = "Glow",
    ft = { "markdown" },
    opts = {
      border = "rounded",
      style = "dark",
      width = 120,
      height = 80,
      pager = false,
    },
    keys = {
      { "<leader>mg", "<cmd>Glow<cr>", ft = "markdown", desc = "Glow Preview" },
    },
  },

  -- Obsidian vault integration: wikilinks, search, new notes, daily notes, backlinks
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      workspaces = {
        { name = "vault", path = "~/Documents/obsidian/vault" },
      },
      -- render-markdown.nvim handles all visual rendering
      ui = { enable = false },
      completion = {
        nvim_cmp = false,
        min_chars = 2,
      },
      follow_url_func = function(url)
        vim.fn.jobstart({ "xdg-open", url })
      end,
    },
    keys = {
      { "<leader>mn", "<cmd>ObsidianNew<cr>", desc = "New Obsidian note" },
      { "<leader>mf", "<cmd>ObsidianSearch<cr>", desc = "Search vault" },
      { "<leader>mo", "<cmd>ObsidianOpen<cr>", desc = "Open in Obsidian" },
      { "<leader>mb", "<cmd>ObsidianBacklinks<cr>", desc = "Backlinks" },
      { "<leader>ml", "<cmd>ObsidianLinks<cr>", desc = "Links in note" },
      { "<leader>mt", "<cmd>ObsidianTags<cr>", desc = "Tags" },
      { "<leader>md", "<cmd>ObsidianDailies<cr>", desc = "Daily notes" },
    },
  },

  -- Pass explicit config to markdownlint-cli2 (stdin mode skips filesystem discovery)
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters = {
        ["markdownlint-cli2"] = {
          args = { "--config", vim.fn.expand("~/.markdownlint.json"), "-" },
        },
      },
    },
  },

  -- blink.compat bridges nvim-cmp-style sources (obsidian's cmp_obsidian*.lua) into blink.cmp
  {
    "saghen/blink.compat",
    version = "*",
    lazy = true,
    opts = {},
  },

  -- Wire obsidian completion into blink.cmp via blink.compat (markdown only)
  {
    "saghen/blink.cmp",
    opts = {
      sources = {
        per_filetype = {
          markdown = { "lsp", "path", "snippets", "buffer", "obsidian", "obsidian_new", "obsidian_tags" },
        },
        providers = {
          obsidian = { name = "obsidian", module = "blink.compat.source" },
          obsidian_new = { name = "obsidian_new", module = "blink.compat.source" },
          obsidian_tags = { name = "obsidian_tags", module = "blink.compat.source" },
        },
      },
    },
  },
}
