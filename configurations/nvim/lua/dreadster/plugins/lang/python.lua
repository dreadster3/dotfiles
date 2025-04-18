return {
	{
		"lspconfig",
		opts = {
			servers = {
				basedpyright = { mason = false, single_file_support = true },
				ruff = { mason = false },
			},
		},
	},
	{
		"nvim-lint",
		opts = {
			python = { "ruff", "mypy" },
		},
	},
	{
		"conform",
		opts = {
			formatters_by_ft = {
				python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
			},
		},
	},
}
