return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {},
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("render-markdown").setup()
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.cmd([[Lazy load markdown-preview.nvim]])
      vim.fn["mkdp#util#install"]()
    end,
  },
  {
    "AntonVanAssche/md-headers.nvim",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require("md-headers").setup({})
      -- Shorten function name.
      local keymap = vim.keymap.set
      -- Silent keymap option.
      local opts = { silent = true }

      -- Set keymap.
      keymap("n", "<leader>mdh", "<cmd>MarkdownHeaders<CR>", opts)
      keymap("n", "<leader>mdhc", "<cmd>MarkdownHeadersClosest<CR>", opts)
    end,
  },
}
