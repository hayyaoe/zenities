return {
	{
		"hrsh7th/cmp-nvim-lsp",
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",  -- Include friendly snippets
		},
		config = function()
			local luasnip = require("luasnip")

			-- Load all friendly-snippets
			require("luasnip.loaders.from_vscode").lazy_load()

			-- Optionally: Load only specific snippets
			-- luasnip.loaders.from_vscode.lazy_load({ paths = { "./path/to/your/snippets" } })

			-- Key mappings for snippet navigation
			vim.api.nvim_set_keymap("i", "<C-j>", "<cmd>lua require'luasnip'.jump(1)<CR>", { silent = true })
			vim.api.nvim_set_keymap("s", "<C-j>", "<cmd>lua require'luasnip'.jump(1)<CR>", { silent = true })
			vim.api.nvim_set_keymap("i", "<C-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>", { silent = true })
			vim.api.nvim_set_keymap("s", "<C-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>", { silent = true })
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			cmp.setup({
				snippet = {
					-- REQUIRED - you must specify a snippet engine
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
				}, {
					{ name = "buffer" },
				}),
			})
		end,
	},
}

