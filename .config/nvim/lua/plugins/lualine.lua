return {
  'nvim-lualine/lualine.nvim',
  config = function()
    require('lualine').setup({
      options = {
        theme = 'pywal-nvim'
      }
    })
  end
}
