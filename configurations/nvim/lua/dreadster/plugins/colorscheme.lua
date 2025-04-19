return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		version = "*",
		init = function()
			vim.cmd.colorscheme("catppuccin-mocha")
		end,
		opts = {
			transparent_background = true,
			integrations = {
				treesitter = true,
				cmp = true,
				gitsigns = true,
				lsp_saga = true,
				mason = true,
				notify = true,
				telescope = { enabled = true },
				dap = true,
				alpha = true,
				markdown = true,
				which_key = true,
				nvimtree = true,
				neotree = true,
				illuminate = true,
				lsp_trouble = true,
			},
			custom_highlights = function(colors)
				local accent_name = require("dreadster.utils.ui").get_accent_name()
				return {
					FloatBorder = { fg = colors[accent_name] },
					FloatTitle = { fg = colors.text },

					-- Neotree
					NeoTreeDirectoryName = { fg = colors[accent_name] },
					NeoTreeDirectoryIcon = { fg = colors[accent_name] },
					NeoTreeRootName = { fg = colors[accent_name], bold = true },
					NeoTreeTitleBar = { fg = colors.mantle, bg = colors[accent_name] },

					-- Noice
					NoiceCmdlinePopupBorder = { fg = colors[accent_name] },
					NoiceCmdlineIcon = { fg = colors[accent_name] },

					-- Cmp
					CmpItemKindCopilot = { fg = colors.green },
					CmpItemKindCodeium = { fg = colors.green },
					CmpGhostText = { link = "Comment", default = true },
				}
			end,
		},
	},
}
