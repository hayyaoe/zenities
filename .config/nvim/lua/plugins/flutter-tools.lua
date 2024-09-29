return {
  {
    "akinsho/flutter-tools.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",  -- Required dependency
      "stevearc/dressing.nvim", -- Optional for improved UI (optional)
    },
    config = function()
      require("flutter-tools").setup {
        ui = {
          border = "rounded", -- Adds rounded borders to the Flutter tools windows
        },
        decorations = {
          statusline = {
            app_version = true,
            device = true,
          }
        },
        widget_guides = {
          enabled = true, -- Enables widget guides for Flutter widgets
        },
        closing_tags = {
          highlight = "ErrorMsg", -- Highlight closing tags of widgets
          prefix = ">",           -- Add prefix > to closing tags
          enabled = true
        },
        dev_log = {
          enabled = true,
          open_cmd = "tabedit", -- Command to use for opening the dev logs
        },
        lsp = {
          color = {
            enabled = true, -- Enable colors for LSP diagnostics
            background = true, -- Use background color for Flutter's diagnostics
          },
          on_attach = function(_, bufnr)
            -- Keybindings for LSP actions
            local opts = { noremap = true, silent = true }
            vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
            vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
          end,
        },
      }
    end,
  },
}

