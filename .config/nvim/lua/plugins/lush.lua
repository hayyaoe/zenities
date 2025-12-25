return {
  "rktjmp/lush.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    local lush = require("lush")

    local function get_wallust_theme()
      local path = vim.fn.expand("~/.config/nvim/colors/lush-colors.json")
      local file = io.open(path, "r")

      if not file then return {} end

      local content = file:read("*a")
      file:close()
      return vim.fn.json_decode(content) or {}
    end

    local c = get_wallust_theme()

    local theme = lush(function(injected_functions)
      local sym = injected_functions.sym
      return {
        -- UI Elements
        Normal       { bg = c.background, fg = c.foreground },
        Visual       { bg = c.color1, fg = c.background },
        LineNr       { fg = c.color8 },
        CursorLineNr { fg = c.color6, gui = "bold" },
        StatusLine   { bg = c.background, fg = c.foreground },

        -- Basic Syntax
        Comment      { fg = c.color8, gui = "italic" },
        Keyword      { fg = c.color5, gui = "bold" },
        Function     { fg = c.color4 },
        String       { fg = c.color2 },
        Constant     { fg = c.color3 },
        Type         { fg = c.color9 },

        -- Tree-sitter Support
        sym("@variable")          { fg = c.foreground },
        sym("@variable.builtin")  { fg = c.color1 },
        sym("@function")          { fg = c.color4 },
        sym("@function.builtin")  { fg = c.color6 },
        sym("@keyword")           { fg = c.color5, gui = "bold" },
        sym("@operator")          { fg = c.color5 },
        sym("@property")          { fg = c.color4 },
        sym("@field")             { fg = c.color4 },
        sym("@type")              { fg = c.color3 },
        sym("@string")            { fg = c.color2 },
        sym("@number")            { fg = c.color11 },
        sym("@boolean")           { fg = c.color11 },
        sym("@parameter")         { fg = c.color1 },
        sym("@comment")           { fg = c.color8, gui = "italic" },
        sym("@punctuation")       { fg = c.color6 },
      }
    end)

    lush.apply(theme)
  end
}
