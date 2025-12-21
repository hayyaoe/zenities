return {
  {
    "RedsXDD/neopywal.nvim",
    name = "neopywal",
    lazy = false,
    priority = 1000,
    config = function()
      require('neopywal').setup({
        transparent_background = true,
        terminal_colors = true,
        default_fileformats = false,
        default_plugins = false,
        alpha = true,
        lazy = true,
        treesitter = true,
        neotree = true,
        telescope = {
          enabled = true,
        },
        custom_highlights = function(C)
          return {
            Normal = { bg = C.none },
          }
        end
      })
      vim.cmd.colorscheme("neopywal")
    end
  }
}
