return{
  "nvim-treesitter/nvim-treesitter",
  config = function()
    local config = require("nvim-treesitter.configs")
    config.setup({
      auto_install = true,
      heighlight = { enable = true },
      trueindent = { enable = true },
    })
  end
}

