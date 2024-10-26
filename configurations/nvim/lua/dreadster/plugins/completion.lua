return {
	{
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter" },
		name = "cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-emoji",
			"saadparwaiz1/cmp_luasnip",
			"onsails/lspkind-nvim",
			"luasnip",
			"saadparwaiz1/cmp_luasnip",
			"cmpgit",
			"copilotcmp",
		},
		opts = function(_, opts)
			vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
			local kind_icons = {
				Text = "󰉿",
				Method = "󰆧",
				Function = "󰊕",
				Constructor = "",
				Field = "",
				Variable = "󰀫",
				Class = "",
				Interface = "",
				Module = "",
				Property = "",
				Unit = "",
				Value = "󰎠",
				Enum = "",
				Keyword = "󰌋",
				Snippet = "",
				Color = "󰏘",
				File = "󰈙",
				Reference = "",
				Folder = "󰉋",
				EnumMember = "",
				Constant = "󰏿",
				Struct = "",
				Event = "",
				Operator = "",
				TypeParameter = " ",
				Misc = " ",
				Copilot = "",
			}

			vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

			local cmp = require("cmp")
			local lspkind = require("lspkind")
			local local_opts = vim.tbl_deep_extend("force", opts or {}, {
				completion = { completeopt = "menuone,noselect,noinsert" },
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				snippet = {
					expand = function(args)
						-- For `vsnip` user.
						-- vim.fn["vsnip#anonymous"](args.body)

						-- For `luasnip` user.
						require("luasnip").lsp_expand(args.body)

						-- For `ultisnips` user.
						-- vim.fn["UltiSnips#Anon"](args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping(function(_)
						if cmp.visible() then
							cmp.abort()
						else
							cmp.complete()
						end
					end, { "i", "s" }),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = false }),
					["<Up>"] = cmp.mapping.select_prev_item(),
					["<Down>"] = cmp.mapping.select_next_item(),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						else
							fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
						end
					end, { "i", "s" }),

					["<S-Tab>"] = cmp.mapping(function()
						if cmp.visible() then
							cmp.select_prev_item()
						end
					end, { "i", "s" }),
				}),
				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol", -- show only symbol annotations
						maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
						ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

						symbol_map = kind_icons,

						-- The function below will be called before any actual modifications from lspkind
						-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
						before = function(entry, item)
							local menu_icon = {
								nvim_lsp = "[LSP]",
								git = "[Git]",
								luasnip = "[Snippet]",
								buffer = "[Buffer]",
								path = "[Path]",
								nvim_lsp_signature_help = "[LSP]",
								lazydev = "[LazyDev]",
								copilot = "[AI]",
								-- nvim_lua = "[Lua]"
							}

							item.menu = menu_icon[entry.source.name]

							return item
						end,
					}),
				},
				sources = {
					{ name = "lazydev", group_index = 0 },
					{ name = "path", group_index = 1 },
					{ name = "luasnip", group_index = 2 },
					{ name = "copilot", group_index = 2 },
					{ name = "nvim_lsp", group_index = 2 },
					{ name = "git", group_index = 3 },
					{ name = "buffer", group_index = 3 },
					{ name = "emoji", group_index = 4 },
				},
				experimental = {
					ghost_text = {
						hl_group = "CmpGhostText",
					},
				},
			})

			return local_opts
		end,
	},
	{
		"petertriho/cmp-git",
		dependencies = { "nvim-lua/plenary.nvim" },
		name = "cmpgit",
		lazy = true,
		opts = {},
	},
	{
		"L3MON4D3/LuaSnip",
		name = "luasnip",
		dependencies = { "rafamadriz/friendly-snippets" },
		lazy = true,
		version = "*",
		build = "make install_jsregexp",
		config = function(_, opts)
			require("luasnip").setup(opts)
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},
	{
		"folke/lazydev.nvim",
		ft = "lua",
		cmd = "LazyDev",
		opts = {
			library = {
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
				{ path = "LazyVim", words = { "LazyVim" } },
				{ path = "lazy.nvim", words = { "LazyVim" } },
			},
		},
	},
}
