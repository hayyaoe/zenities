return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "muniftanjim/nui.nvim",
    "3rd/image.nvim",
  },
  config = function()
    -- Neotree Keymap
    vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal right<CR>")
    require("neo-tree").setup({
      window = {
        position = "right",
        width = 25,
        mappings = {},
      },
      filesystem = {
        filtered_items = {
          visible = true,
          show_hidden_count = true,
          hide_dotfiles = false,
          hide_gitignored = true,
          hide_by_name = {
          },
          never_show = {
            '.git',
          },
        }
      }
    })
    vim.cmd("highlight WinSeparator guifg=NONE guibg=NONE")
    vim.opt.fillchars:append({
      vert = " ",
      horiz = " ",
    })
  end,
}
