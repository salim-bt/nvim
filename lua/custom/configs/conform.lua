local M = {}

function M.setup()
  require("conform").setup({
    formatters_by_ft = {
      lua = { "stylua" },
      -- Web development
      javascript = { { "prettierd", "prettier" } },
      typescript = { { "prettierd", "prettier" } },
      javascriptreact = { { "prettierd", "prettier" } },
      typescriptreact = { { "prettierd", "prettier" } },
      css = { { "prettierd", "prettier" } },
      html = { { "prettierd", "prettier" } },
      json = { { "prettierd", "prettier" } },
      yaml = { { "prettierd", "prettier" } },
      markdown = { { "prettierd", "prettier" } },
      graphql = { { "prettierd", "prettier" } },
      -- Rust
      rust = { "rustfmt" },
      -- Python
      python = { "black" },
      -- Shell
      sh = { "shfmt" },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
    formatters = {
      shfmt = {
        prepend_args = { "-i", "2", "-ci" },
      },
      prettier = {
        prepend_args = { "--print-width", "100" },
      },
    },
  })

  -- Format keymap
  vim.keymap.set({ "n", "v" }, "<leader>mp", function()
    require("conform").format({
      lsp_fallback = true,
      async = false,
      timeout_ms = 500,
    })
  end, { desc = "Format file or range (in visual mode)" })
end

return M 