return {
  -- Installs LSP servers, formatters, linters
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    config = function()
      require("mason").setup()
    end,
  },

  -- Bridges mason <-> lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          -- Web / JS
          "ts_ls",        -- TypeScript / JavaScript (tsserver)
          "eslint",

          -- Lua (Neovim config)
          "lua_ls",

          -- Markup / styles
          "html",
          "cssls",
          "jsonls",
          "yamlls",
          "bashls",
          "marksman",     -- Markdown

          -- C# (pick one; see note below)
          "csharp_ls",

          -- SQL
          "sqlls",
        },
        automatic_installation = true,
      })
    end,
  },

  -- Actual LSP client configuration
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
config = function()
  -- -----------------------------------------------------
  -- Diagnostics UI
  -- -----------------------------------------------------
  vim.diagnostic.config({
    virtual_text = true,
    severity_sort = true,
    float = { border = "rounded" },
    signs = true,
    underline = true,
    update_in_insert = false,
  })

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  local ok_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
  if ok_cmp then
    capabilities = cmp_lsp.default_capabilities(capabilities)
  end


  -- -----------------------------------------------------
  -- LSP keymaps (per-buffer)
  -- -----------------------------------------------------
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
      local opts = { buffer = ev.buf, silent = true }
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
      vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
      vim.keymap.set("n", "<leader>ds", vim.diagnostic.open_float, opts)
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
    end,
  })

  -- -----------------------------------------------------
  -- Server configurations (NEW API)
  -- -----------------------------------------------------

  vim.lsp.config("lua_ls", {capabilities = capabilities,
    settings = {
      Lua = {
        diagnostics = { globals = { "vim" } },
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
      },
    },
  })

  vim.lsp.config("ts_ls", {capabilities = capabilities})
  vim.lsp.config("eslint", {capabilities = capabilities})
  vim.lsp.config("html", {capabilities = capabilities})
  vim.lsp.config("cssls", {capabilities = capabilities})
  vim.lsp.config("jsonls", {capabilities = capabilities})
  vim.lsp.config("yamlls", {capabilities = capabilities})
  vim.lsp.config("bashls", {capabilities = capabilities})
  vim.lsp.config("marksman", {capabilities = capabilities})
  vim.lsp.config("sqlls", {capabilities = capabilities})
  vim.lsp.config("csharp_ls", {capabilities = capabilities})
end,
  },
}

