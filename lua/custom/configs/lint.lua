local M = {}

function M.setup()
  local lint = require("lint")

  lint.linters_by_ft = {
    javascript = { "eslint" },
    typescript = { "eslint" },
    javascriptreact = { "eslint" },
    typescriptreact = { "eslint" },
  }

  -- Configure eslint to use local project configuration
  lint.linters.eslint.args = {
    "--format",
    "json",
    "--stdin",
    "--stdin-filename",
    function()
      return vim.api.nvim_buf_get_name(0)
    end,
  }

  -- Create an autocmd to trigger linting
  vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
    callback = function()
      require("lint").try_lint()
    end,
  })

  -- Add a command to manually trigger linting
  vim.api.nvim_create_user_command("Lint", function()
    require("lint").try_lint()
  end, {})
end

return M 