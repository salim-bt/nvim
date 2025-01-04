-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
local plugins = {
  -- Load plugin configurations from separate files
  require("custom.plugins.editor"),    -- Editor enhancements
  require("custom.plugins.ui"),        -- UI related plugins
  require("custom.plugins.lsp"),       -- LSP configurations
  require("custom.plugins.completion"), -- Completion related plugins
  require("custom.plugins.git"),       -- Git related plugins
  require("custom.plugins.treesitter"), -- Treesitter configurations
}

-- Flatten the plugins table
local final_plugins = {}
for _, plugin in ipairs(plugins) do
  for _, p in ipairs(plugin) do
    table.insert(final_plugins, p)
  end
end

return final_plugins
