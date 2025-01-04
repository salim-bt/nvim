return {
  -- Color scheme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("custom.configs.catppuccin").setup()
    end,
  },
  -- Notifications
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    priority = 999,
    config = function()
      vim.notify = require("notify")
    end,
  },
  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      require("custom.configs.lualine")
    end,
  },
  -- Indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
  },
  -- Better UI elements
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("custom.configs.noice")
    end,
  },
} 