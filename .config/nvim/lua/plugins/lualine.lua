return {
  "nvim-lualine/lualine.nvim",
  lazy = false,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local function get_colors()
      local json_path = vim.fn.expand("~/.config/nvim/colors/lush-colors.json")
      local file = io.open(json_path, "r")
      local fallback = {
        background = "#1a1b26",
        foreground = "#c0caf5",
        color1 = "#f7768e",
        color4 = "#7aa2f7",
        color8 =
        "#414868"
      }

      if not file then return fallback end
      local content = file:read("*a")
      file:close()
      local ok, data = pcall(vim.fn.json_decode, content)
      return ok and data or fallback
    end

    local c = get_colors()

    local wallust_lualine = {
      normal = {
        a = { bg = c.color4, fg = c.background, gui = "bold" },
        b = { bg = c.color0, fg = c.foreground },
        c = { bg = c.background, fg = c.color8 },
      },
      insert = {
        a = { bg = c.color2, fg = c.background, gui = "bold" },
        b = { bg = c.color0, fg = c.foreground },
      },
      visual = {
        a = { bg = c.color1, fg = c.background, gui = "bold" },
        b = { bg = c.color0, fg = c.foreground },
      },
      replace = {
        a = { bg = c.color3, fg = c.background, gui = "bold" },
        b = { bg = c.color0, fg = c.foreground },
      },
      inactive = {
        a = { bg = c.background, fg = c.color8 },
        b = { bg = c.background, fg = c.color8 },
        c = { bg = c.background, fg = c.color8 },
      },
    }

    require("lualine").setup({
      options = {
        theme = wallust_lualine,
        component_separators = "",
        section_separators = "",
        globalstatus = true,
        disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
      },
      sections = {
        lualine_a = { { "mode", fmt = function(str) return str:sub(1, 1) end } },
        lualine_b = { "branch", "diagnostics" },
        lualine_c = { { "filename", file_status = true, path = 1 } },
        lualine_x = { "encoding", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    })
  end,
}
