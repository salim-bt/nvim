return {
  -- Git signs
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("custom.configs.gitsigns").setup()
    end,
  },
  -- Git integration
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G" },
  },
  -- Git conflict resolution
  {
    "akinsho/git-conflict.nvim",
    event = "VeryLazy",
    config = true,
  },
} 