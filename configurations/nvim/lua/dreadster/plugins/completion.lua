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
			local kind_icons = require("dreadster.utils.ui").lsp_icons
			local cmp = require("cmp")
			local lspkind = require("lspkind")
			local defaults = require("cmp.config.default")()
			-- local cmp_menu_max_screen_ratio = 1 / 2
			return {
				completion = { completeopt = "menuone,noselect,noinsert" },
				preselect = cmp.PreselectMode.Item,
				window = {
					completion = cmp.config.window.bordered({
						winhighlight = "Normal:Normal,CursorLine:CmpSel,Search:None,FloatBorder:FloatBorder",
					}),
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
						-- maxwidth = {
						-- 	abbr = function()
						-- 		local max_width = math.ceil(cmp_menu_max_screen_ratio * vim.fn.winwidth(0))
						-- 		local kind = math.ceil(cmp_menu_max_screen_ratio * 0.25 * vim.fn.winwidth(0))
						-- 		local menu =
						-- 			math.min(math.ceil(cmp_menu_max_screen_ratio * 0.2 * vim.fn.winwidth(0)), 6)
						-- 		return max_width - kind - menu
						-- 	end,
						-- 	kind = function()
						-- 		return math.ceil(cmp_menu_max_screen_ratio * 0.25 * vim.fn.winwidth(0))
						-- 	end,
						-- 	menu = function()
						-- 		return math.min(math.ceil(cmp_menu_max_screen_ratio * 0.2 * vim.fn.winwidth(0)), 6)
						-- 	end,
						-- },
						ellipsis_char = "...",
						show_labelDetails = true,

						symbol_map = kind_icons,

						-- The function below will be called before any actual modifications from lspkind
						-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
						before = function(entry, item)
							local icon = kind_icons[item.kind] or ""
							local kind = item.kind or ""

							item.menu = kind
							item.menu_hl_group = "LineNr"
							item.kind = icon .. " "

							if kind == "Color" then
								require("dreadster.utils.colors").lsp(entry, item, "")
							end

							return item
						end,
					}),
					fields = { "kind", "abbr", "menu" },
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
