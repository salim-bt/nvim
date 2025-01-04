local M = {}

function M.setup()
  require("neo-tree").setup({
    close_if_last_window = true,
    popup_border_style = "rounded",
    enable_git_status = true,
    enable_diagnostics = true,
    enable_normal_mode_for_inputs = true,
    open_files_do_not_replace_types = { "terminal", "trouble", "qf" },
    sort_case_insensitive = false,
    sort_function = nil,
    close_on_file_open = true,
    
    -- Better window sizes
    window = {
      position = "left",
      width = 35,
      mappings = {
        ["<space>"] = "none", -- disable space mapping to not conflict with leader key
        ["l"] = "open",
        ["h"] = "close_node",
        ["/"] = "fuzzy_finder",
        ["f"] = "filter_on_submit",
        ["<esc>"] = "clear_filter",
        ["H"] = "toggle_hidden",
      },
    },
    
    -- Better filtering
    filesystem = {
      filtered_items = {
        visible = false,
        hide_dotfiles = true,
        hide_gitignored = true,
        hide_by_name = {
          ".git",
          "node_modules",
          ".cache",
        },
        never_show = {
          ".DS_Store",
          "thumbs.db",
        },
      },
      follow_current_file = {
        enabled = true,          -- This will find and focus the file in the active buffer every time
        leave_dirs_open = true,  -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
      },
      group_empty_dirs = true,   -- when true, empty folders will be grouped together
      hijack_netrw_behavior = "open_default",
      use_libuv_file_watcher = true,  -- This will use the OS level file watchers
    },
    
    -- Git support
    git_status = {
      symbols = {
        -- Change type
        added     = "✚",
        deleted   = "✖",
        modified  = "",
        renamed   = "󰁕",
        -- Status type
        untracked = "",
        ignored   = "",
        unstaged  = "󰄱",
        staged    = "",
        conflict  = "",
      },
    },
    
    -- Better icons
    default_component_configs = {
      indent = {
        with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
        expander_collapsed = "",
        expander_expanded = "",
        expander_highlight = "NeoTreeExpander",
      },
      icon = {
        folder_closed = "",
        folder_open = "",
        folder_empty = "󰜌",
        default = "*",
      },
      modified = {
        symbol = "[+]",
        highlight = "NeoTreeModified",
      },
      name = {
        trailing_slash = false,
        use_git_status_colors = true,
        highlight = "NeoTreeFileName",
      },
    },
  })

  -- Set keymaps
  vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>', { desc = 'Toggle Neotree' })
  vim.keymap.set('n', '<leader>o', ':Neotree focus<CR>', { desc = 'Focus Neotree' })
end

return M 