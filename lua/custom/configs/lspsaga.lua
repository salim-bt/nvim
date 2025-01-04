local M = {}

function M.setup()
  require("lspsaga").setup({
    -- UI configs
    ui = {
      border = "rounded",
      title = true,
      winblend = 0,
      expand = "",
      collapse = "",
      code_action = "💡",
      diagnostic = "🔎",
      incoming = " ",
      outgoing = " ",
      hover = ' ',
      kind = {},
    },
    
    -- Hover configuration
    hover = {
      max_width = 0.6,
      max_height = 0.6,
      open_link = 'gx',
      open_browser = '!chrome',
    },

    -- Diagnostic configurations
    diagnostic = {
      show_code_action = true,
      show_source = true,
      jump_num_shortcut = true,
      max_width = 0.7,
      max_height = 0.6,
      text_hl_follow = true,
      border_follow = true,
      extend_relatedInformation = false,
      diagnostic_only_current = false,
      keys = {
        exec_action = 'o',
        quit = 'q',
        toggle_or_jump = '<CR>',
        quit_in_show = { 'q', '<ESC>' },
      },
    },

    -- Code action configurations
    code_action = {
      num_shortcut = true,
      show_server_name = true,
      extend_gitsigns = true,
      keys = {
        quit = 'q',
        exec = '<CR>',
      },
    },

    -- Lightbulb configurations
    lightbulb = {
      enable = true,
      enable_in_insert = true,
      sign = true,
      sign_priority = 40,
      virtual_text = true,
    },

    -- Rename configurations
    rename = {
      in_select = true,
      auto_save = false,
      project_max_width = 0.5,
      project_max_height = 0.5,
      keys = {
        quit = '<C-k>',
        exec = '<CR>',
        select = 'x',
      },
    },

    -- Symbol in winbar configurations
    symbol_in_winbar = {
      enable = true,
      separator = " › ",
      hide_keyword = true,
      show_file = true,
      folder_level = 2,
      color_mode = true,
      delay = 300,
    },

    -- Outline configurations
    outline = {
      win_position = "right",
      win_width = 30,
      auto_preview = true,
      detail = true,
      auto_close = true,
      close_after_jump = false,
      layout = "normal",
      max_height = 0.5,
      left_width = 0.3,
      keys = {
        toggle_or_jump = 'o',
        quit = 'q',
        jump = 'e',
      },
    },

    -- Callhierarchy configurations
    callhierarchy = {
      layout = "float",
      keys = {
        edit = "e",
        vsplit = "s",
        split = "i",
        tabe = "t",
        quit = "q",
        shuttle = "[w",
        toggle_or_req = "u",
      },
    },

    -- Implement configurations
    implement = {
      enable = true,
      sign = true,
      virtual_text = true,
      priority = 100,
    },

    -- Definition configurations
    definition = {
      width = 0.6,
      height = 0.5,
      keys = {
        edit = '<C-c>o',
        vsplit = '<C-c>v',
        split = '<C-c>i',
        tabe = '<C-c>t',
        quit = 'q',
        close = '<Esc>',
      },
    },
  })

  -- Keymaps
  local keymap = vim.keymap.set
  local opts = { noremap = true, silent = true }

  -- LSP finder
  keymap("n", "gh", "<cmd>Lspsaga finder<CR>", opts)
  -- Code action
  keymap({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
  -- Rename
  keymap("n", "gr", "<cmd>Lspsaga rename<CR>", opts)
  -- Peek Definition
  keymap("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts)
  -- Show line diagnostics
  keymap("n", "<leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
  -- Show cursor diagnostics
  keymap("n", "<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)
  -- Show buffer diagnostics
  keymap("n", "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>", opts)
  -- Diagnostic jump
  keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
  keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
  -- Hover Doc
  keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
  -- Float terminal
  keymap({ "n", "t" }, "<A-d>", "<cmd>Lspsaga term_toggle<CR>", opts)
  -- Outline
  keymap("n", "<leader>o", "<cmd>Lspsaga outline<CR>", opts)
end

return M 