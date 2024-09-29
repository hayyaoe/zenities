return { --[[
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "frappe",
			background = {
				light = "frappe",
				dark = "frappe",
			},
			transparent_background = true,
			term_colors = true,
			dim_inactive = {
				enabled = false,
				shade = "dark",
				percentage = 0.15,
			},
		})
		vim.cmd.colorscheme("catppuccin")
	end,
  ]]}
