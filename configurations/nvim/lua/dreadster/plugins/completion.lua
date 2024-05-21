return {
	{
		'hrsh7th/nvim-cmp',
		event = { "InsertEnter" },
		name = "cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline", "saadparwaiz1/cmp_luasnip",
			"onsails/lspkind-nvim", "L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip", "cmpgit"
		},
		opts = function(_, opts)
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
				Misc = " "
			}

			local cmp = require("cmp")
			local lspkind = require("lspkind")
			local local_opts = vim.tbl_deep_extend("force", opts or {}, {
				completion = { completeopt = 'menuone,noselect,noinsert' },
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered()
				},
				snippet = {
					expand = function(args)
						-- For `vsnip` user.
						-- vim.fn["vsnip#anonymous"](args.body)

						-- For `luasnip` user.
						require("luasnip").lsp_expand(args.body)

						-- For `ultisnips` user.
						-- vim.fn["UltiSnips#Anon"](args.body)
					end
				},
				mapping = cmp.mapping.preset.insert({
					['<C-d>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
					['<C-Space>'] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.abort()
						else
							cmp.complete()
						end
					end, { "i", "s" }),
					['<C-e>'] = cmp.mapping.abort(),
					['<CR>'] = cmp.mapping.confirm({ select = false }),
					['<Up>'] = cmp.mapping.select_prev_item(),
					['<Down>'] = cmp.mapping.select_next_item(),
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
					end, { "i", "s" })
				}),
				formatting = {
					format = lspkind.cmp_format({
						mode = 'symbol',       -- show only symbol annotations
						maxwidth = 50,         -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
						ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

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
								nvim_lsp_signature_help = "[LSP]"
								-- nvim_lua = "[Lua]"
							}

							item.menu = menu_icon[entry.source.name]

							return item
						end
					})
				},
				sources = {
					{ name = "nvim_lsp" }, { name = "git" }, { name = "luasnip" },
					{ name = "buffer" }, { name = "path" }
				}
			});

			return local_opts
		end
	}, {
	"petertriho/cmp-git",
	dependencies = { "nvim-lua/plenary.nvim" },
	name = "cmpgit",
	lazy = true,
	opts = {}
}, {
	"github/copilot.vim",
	enable = false,
	cond = false,
	name = "copilot",
	cmd = { "Copilot" },
	event = { "InsertEnter" },
	init = function()
		local utils = require("dreadster.utils")
		if utils.is_mac() then
			vim.g.copilot_proxy = os.getenv("http_proxy")
		end

		vim.g.copilot_assume_mapped = true
	end
}, {
	"zbirenbaum/copilot.lua",
	name = "copilot.lua",
	cmd = { "Copilot" },
	event = { "InsertEnter" },
	opts = {
		panel = { keymap = { enable = false } },
		suggestion = {
			auto_trigger = true,
			keymap = {
				accept = "<M-CR>",
				accept_word = "<M-Right>",
				accept_line = "<M-Up>"
			}
		}
	}
}
}
