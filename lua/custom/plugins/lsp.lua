return {
  -- LSP Support
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "folke/neodev.nvim",
    },
    config = function()
      -- Load our custom LSP configuration
      require("custom.configs.lsp").setup()
    end,
    event = { "BufReadPre", "BufNewFile" },
  },
  -- LSP UI improvements
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    config = function()
      require("custom.configs.lspsaga")
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },
  -- Formatting
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    config = function()
      require("custom.configs.conform")
    end,
  },
  -- Linting
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("custom.configs.lint")
    end,
  },
} 