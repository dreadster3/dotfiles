return {
	{
		"folke/ts-comments.nvim",
		enabled = vim.fn.has("nvim-0.10.0") == 1,
		event = "VeryLazy",
		opts = {},
	},
	{
		"conform",
		opts = {
			formatters_by_ft = {
				typescript = { "prettier" },
				typescriptreact = { "prettier" },
			},
		},
	},
}
