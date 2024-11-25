return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		version = "*",
		init = function()
			local accent_color = require("dreadster.utils.ui").get_accent_color()
			vim.api.nvim_set_hl(0, "NeoTreeDirectoryIcon", { fg = accent_color })
			vim.api.nvim_set_hl(0, "NeoTreeDirectoryName", { fg = accent_color })
			vim.api.nvim_set_hl(0, "NeoTreeRootName", { fg = accent_color, bold = true })

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
				neotree = false,
				illuminate = true,
				lsp_trouble = true,
			},
		},
	},
}
