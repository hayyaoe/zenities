return {
  "nvim-lualine/lualine.nvim",
  config = function()
    local theme = require("lualine.themes.auto")
    local normal_bg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg
    local modes = { "normal", "insert", "visual", "replace", "command", "inactive", "terminal" }

    for _, m in ipairs(modes) do
      if theme[m] then
        if theme[m].c then theme[m].c.bg = normal_bg end
        if theme[m].x then theme[m].x.bg = normal_bg end
      end
    end

    require("lualine").setup({
      options = {
        theme = theme,
        component_separators = "",
        section_separators = "",
        globalstatus = true,
      },
      sections = {
        lualine_a = { { "mode", fmt = function(str) return str:sub(1, 1) end } },
        lualine_b = {},
        lualine_c = { { "filename", file_status = true, path = 1 } },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
    })
  end,
}
