-- Null-LS Config for Formatting and Linting
return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        -- Prettier for formatting
        null_ls.builtins.formatting.prettier.with({
          filetypes = { "css", "scss", "javascript", "typescript", "javascriptreact", "typescriptreact" }
        }),
      },
    })

    -- Keymap to format the buffer
    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {}) -- Binding for formatting
  end,
}
