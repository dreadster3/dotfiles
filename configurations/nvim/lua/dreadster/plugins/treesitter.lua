return {
	{
		"nvim-treesitter/nvim-treesitter",
		name = "treesitter",
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
		build = ":TSUpdate",
		version = "*",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			ensure_installed = {
				"c",
				"lua",
				"typescript",
				"tsx",
				"html",
				"java",
				"cpp",
				"c_sharp",
				"css",
				"go",
				"markdown",
				"markdown_inline",
				"python",
				"regex",
			},
			sync_install = false,
			auto_install = true,
			highlight = { enable = true, disable = {} },
			indent = { enable = true },
			context_commentstring = { enable = true },
		},
	},
}
