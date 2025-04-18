return {
	{
		"lspconfig",
		opts = {
			servers = {
				gopls = { mason = false },
			},
		},
	},
	{
		"nvim-lint",
		opts = {
			go = { "staticcheck", "trivy", "nilaway" },
		},
	},
	{
		"conform",
		opts = {
			formatters_by_ft = {
				go = { "goimports", "gofumpt" },
			},
		},
	},
	{
		"ray-x/go.nvim",
		dependencies = {
			"ray-x/guihua.lua",
			"lspconfig",
			"treesitter",
		},
		version = "v0.9.0",
		main = "go",
		event = { "CmdlineEnter" },
		ft = { "go", "gomod" },
		opts = {},
	},
}
