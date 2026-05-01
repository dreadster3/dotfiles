return {
	{
		"conform",
		optional = true,
		opts = {
			formatters_by_ft = {
				typescript = { "prettier" },
				typescriptreact = { "prettier" },
			},
		},
	},
	{
		"lspconfig",
		optional = true,
		opts = {
			servers = {
				ts_ls = {},
				eslint = { mason = false, settings = { format = false } },
			},
		},
	},
	{
		"autopairs",
		optional = true,
		dependencies = {
			{
				"windwp/nvim-ts-autotag",
				name = "autopairs-ts",
				opts = {
					opts = {
						enable = true,
						enable_rename = true,
						enable_close = true,
						enable_close_on_slash = true,
					},
				},
			},
		},
		opts = { check_ts = true },
	},
	{
		"nvim-mini/mini.comment",
		optional = true,
		dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
		opts = {
			custom_commentstring = function()
				return require("ts_context_commentstring").calculate_commentstring() or vim.bo.commentstring
			end,
		},
	},
}
