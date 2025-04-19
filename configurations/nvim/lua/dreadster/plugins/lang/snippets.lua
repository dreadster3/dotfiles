return {
	{
		"L3MON4D3/LuaSnip",
		name = "luasnip",
		dependencies = {
			{
				"rafamadriz/friendly-snippets",
				config = function()
					require("luasnip.loaders.from_vscode").lazy_load()
					require("luasnip.loaders.from_vscode").lazy_load({
						paths = { vim.fn.stdpath("config") .. "/snippets" },
					})
				end,
			},
		},
		lazy = true,
		version = "*",
		build = "make install_jsregexp",
		opts = {
			history = true,
			delete_check_events = "TextChanged",
		},
	},
	{
		"cmp",
		optional = true,
		dependencies = { "saadparwaiz1/cmp_luasnip" },
		opts = function(_, opts)
			opts.snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			}
			table.insert(opts.sources, { name = "luasnip", group_index = 1 })

			local cmp = require("cmp")
			local luasnip = require("luasnip")
			opts.mapping["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.jumpable(1) then
					luasnip.jump(1)
				else
					fallback()
				end
			end, { "i", "s" })

			opts.mapping["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, { "i", "s" })
		end,
		-- -- stylua: ignore
		-- keys = {
		--   { "<tab>", function() require("luasnip").jump(1) end, desc = "Snippet jump forward", mode = "s" },
		--   { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
		-- },
	},
}
