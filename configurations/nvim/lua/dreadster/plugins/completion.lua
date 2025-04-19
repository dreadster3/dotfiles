return {
	{
		"hrsh7th/nvim-cmp",
		name = "cmp",
		event = { "InsertEnter" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-emoji",
			"petertriho/cmp-git",
			"onsails/lspkind-nvim",
		},
		config = function(_, opts)
			local cmp = require("cmp")
			cmp.setup(opts)

			for _, filetype in ipairs(opts.disabled_filetypes) do
				cmp.setup.filetype(filetype, {
					enabled = false,
				})
			end
		end,
		opts = function()
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
				Copilot = " ",
				Codeium = "󰘦 ",
			}

			local cmp = require("cmp")
			local lspkind = require("lspkind")
			local defaults = require("cmp.config.default")()
			return {
				completion = { completeopt = "menuone,noselect,noinsert" },
				preselect = cmp.PreselectMode.Item,
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
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
							fallback()
						end
					end, { "i", "s" }),

					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol_text", -- show only symbol annotations
						maxwidth = {
							abbr = function()
								local max_width = math.ceil((1 / 3) * vim.fn.winwidth(0))
								local kind = math.ceil((1 / 3) * 0.25 * vim.fn.winwidth(0))
								local menu = math.min(math.ceil((1 / 3) * 0.2 * vim.fn.winwidth(0)), 6)
								return max_width - kind - menu
							end,
							kind = function()
								return math.ceil((1 / 3) * 0.25 * vim.fn.winwidth(0))
							end,
							menu = function()
								return math.min(math.ceil((1 / 3) * 0.2 * vim.fn.winwidth(0)), 6)
							end,
						},
						ellipsis_char = "...",
						show_labelDetails = true,

						symbol_map = kind_icons,

						-- The function below will be called before any actual modifications from lspkind
						-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
						before = function(entry, item)
							local menu_icon = {
								nvim_lsp = "[LSP]",
								git = "[Git]",
								luasnip = "[SNIP]",
								buffer = "[BUF]",
								path = "[PATH]",
								nvim_lsp_signature_help = "[SIG]",
								lazydev = "[LDEV]",
								copilot = "[AI]",
								codeium = "[AI]",
								-- nvim_lua = "[Lua]"
							}

							item.menu = menu_icon[entry.source.name]

							return item
						end,
					}),
				},
				sources = cmp.config.sources({
					{ name = "lazydev" },
					{ name = "nvim_lsp" },
					{ name = "path" },
					{ name = "emoji", trigger_characters = { ":" } },
					{ name = "git" },
					{ name = "buffer", max_item_count = 5 },
				}),
				experimental = {
					ghost_text = {
						hl_group = "CmpGhostText",
					},
				},
				disabled_filetypes = {
					"sagarename",
				},
				sorting = defaults.sorting,
			}
		end,
	},
}
