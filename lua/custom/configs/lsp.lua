local M = {}

function M.setup()
  -- Add LSP logging
  vim.lsp.set_log_level("debug")
  
  -- Add diagnostic command
  vim.api.nvim_create_user_command("LspInfo", function()
    local clients = vim.lsp.get_active_clients()
    if #clients == 0 then
      print("No LSP clients running")
      return
    end
    
    local buf_ft = vim.bo.filetype
    print(string.format("Current filetype: %s", buf_ft))
    print("Active LSP clients:")
    
    for _, client in pairs(clients) do
      print(string.format(
        "- %s (id: %d, root: %s)",
        client.name,
        client.id,
        client.config.root_dir or "no root"
      ))
    end
  end, {})

  -- Debug function to check if a file exists
  local function file_exists(name)
    local f = io.open(name, "r")
    if f ~= nil then
      io.close(f)
      return true
    else
      return false
    end
  end
  
  require("mason").setup({
    ui = {
      border = "rounded",
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗"
      }
    }
  })
  
  require("mason-lspconfig").setup({
    ensure_installed = {
      "lua_ls",
      "ts_ls",
      "eslint",
      "prismals",
      "cssls",
      "tailwindcss",
      "graphql",
    },
    automatic_installation = true,
  })

  local lspconfig = require("lspconfig")
  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  -- Add on_attach function for diagnostics
  local on_attach = function(client, bufnr)
    
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings
    local opts = { buffer = bufnr, noremap = true, silent = true }
    
    -- Goto mappings
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)
    
    -- Workspace management
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    
    -- Documentation and help
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    
    -- Code actions and modifications
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
    
    -- Diagnostics
    vim.keymap.set('n', 'gl', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)
    
    -- Add format on save for eslint
    if client.name == "eslint" then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        command = "EslintFixAll",
      })
    end
  end

  -- Custom root dir function for TypeScript
  local function get_typescript_root_dir(fname)
    local root_patterns = { "package.json", "tsconfig.json", "jsconfig.json", ".git" }
    local root = lspconfig.util.root_pattern(unpack(root_patterns))(fname)
    return root
  end

  -- Lua
  lspconfig.lua_ls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = {
            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            [vim.fn.stdpath("config") .. "/lua"] = true,
          },
        },
      },
    },
  })

  -- TypeScript/JavaScript
  lspconfig.ts_ls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascript", "javascriptreact", "javascript.jsx" },
    root_dir = get_typescript_root_dir,
    single_file_support = false,
    init_options = {
      hostInfo = "neovim",
      preferences = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
    -- Debug settings
    flags = {
      debounce_text_changes = 150,
      allow_incremental_sync = true,
    },
  })

  -- ESLint
  lspconfig.eslint.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
    root_dir = lspconfig.util.root_pattern(".eslintrc", ".eslintrc.js", ".eslintrc.json", "package.json"),
    settings = {
      workingDirectory = { mode = "auto" },
    },
  })

  -- GraphQL
  lspconfig.graphql.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "graphql", "typescriptreact", "javascriptreact" },
  })

  -- Prisma
  lspconfig.prismals.setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })

  -- CSS
  lspconfig.cssls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })

  -- Tailwind CSS
  lspconfig.tailwindcss.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    root_dir = lspconfig.util.root_pattern("tailwind.config.js", "tailwind.config.ts"),
  })
end

return M 