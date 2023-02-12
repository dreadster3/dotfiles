local utils = require("dreadster.utils")
local module_name = "cmp"
local status_ok, _ = pcall(require, module_name)

if not status_ok then
	utils.log_module_failed_load(module_name)
	return
end

local cmp = require("cmp")
local lspkind = require('lspkind')

cmp.setup({
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
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete({}),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({select = false}),
		['<Up>'] = cmp.mapping.select_prev_item(),
		['<Down>'] = cmp.mapping.select_next_item(),
		["<Tab>"] = cmp.mapping(function(fallback)
		  if cmp.visible() then
			cmp.select_next_item()
		  else
			fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
		  end
		end, {"i", "s"}),

		["<S-Tab>"] = cmp.mapping(function()
			  if cmp.visible() then
				cmp.select_prev_item()
			  end
			end, {"i", "s"})
	}),
	formatting = {
		format = lspkind.cmp_format({
			mode = 'symbol', -- show only symbol annotations
			maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
			ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

		  -- The function below will be called before any actual modifications from lspkind
		  -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
			before = function (entry, item)
				local menu_icon = {
					nvim_lsp = 'λ',
					luasnip = '',
					buffer = '﬘',
					path = '',
					nvim_lsp_signature_help = ''
				}

				item.menu = menu_icon[entry.source.name]

				return item
			end
		})
	},
	sources = {
		-- tabnine completion? yayaya


		{ name = "nvim_lsp" },

		-- For vsnip user.
		-- { name = 'vsnip' },

		-- For luasnip user.
		{ name = "luasnip" },


		-- For ultisnips user.
		-- { name = 'ultisnips' },

		{ name = "buffer" },

		{ name = "path" },

		{ name = "nvim_lsp_signature_help" }
	},
})
