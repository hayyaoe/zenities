return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "html", "jsonls", "jdtls", "psalm", "sqls" }
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local lspconfig = require("lspconfig")

      lspconfig.lua_ls.setup({
        capabilities = capabilities
      })
      lspconfig.html.setup({
        capabilities = capabilities
      })
      lspconfig.jsonls.setup({
        capabilities = capabilities
      })
      lspconfig.jdtls.setup({
        capabilities = capabilities
      })
      lspconfig.psalm.setup({
        capabilities = capabilities
      })
      lspconfig.sqls.setup({
        capabilities = capabilities
      })

      vim.keymap.set('n','K', vim.lsp.buf.hover, {})
      vim.keymap.set('n','gD', vim.lsp.buf.definition, {})
      vim.keymap.set({ 'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action, {})
    end
  }
}
