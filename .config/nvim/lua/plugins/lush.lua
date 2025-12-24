return {
  "rktjmp/lush.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    local lush = require("lush")

    local function get_wallust_theme()
      local json_path = vim.fn.stdpath("config") .. "/colors/lush-colors.json"
      local file = io.open(json_path, "r")

      local fallback = {
        background = "#1a1b26",
        foreground = "#c0caf5",
        color1 = "#f7768e",
        color2 = "#9ae6b4",
        color4 = "#7aa2f7",
        color5 = "#bb9af7",
        color6 = "#7dcfff",
        color8 = "#414868"
      }

      if not file then return fallback end

      local content = file:read("*a")
      file:close()

      local ok, data = pcall(vim.fn.json_decode, content)
      return ok and data or fallback
    end

    local c = get_wallust_theme()

    -- 2. Define the Lush Theme
    local theme = lush(function(injected_functions)
      local sym = injected_functions.sym
      return {
        -- Base UI
        Normal { bg = c.background, fg = c.foreground },
        Visual { bg = c.color1, fg = c.background },
        LineNr { fg = c.color8 },
        CursorLineNr { fg = c.color6, gui = "bold" },

        -- Syntax Highlighting
        Comment { fg = c.color8, gui = "italic" },
        Keyword { fg = c.color5, gui = "bold" },
        Function { fg = c.color4 },
        String { fg = c.color2 },
        Constant { fg = c.color3 },
        Type { fg = c.color9 },

        sym("@variable") { fg = c.foreground },
        sym("@operator") { fg = c.color5 },
      }
    end)

    lush.apply(theme)
  end
}
