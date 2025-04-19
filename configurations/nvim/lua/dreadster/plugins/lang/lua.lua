return {
	{
		"lspconfig",
		optional = true,
		opts = {
			servers = {
				lua_ls = {
					mason = false,
					settings = {
						Lua = {
							diagnostics = { globals = { "vim", "Snacks" } },
							workspace = { checkThirdParty = false },
						},
					},
				},
			},
		},
	},
	{
		"folke/lazydev.nvim",
		ft = "lua",
		cmd = "LazyDev",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				{ path = "LazyVim", words = { "LazyVim" } },
				{ path = "snacks.nvim", words = { "Snacks" } },
				{ path = "lazy.nvim", words = { "LazyVim" } },
			},
		},
	},
	{
		"conform",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
			},
		},
	},
	{
		"nvim-lint",
		opts = {
			linters_by_ft = {
				lua = { "luacheck" },
			},
			linters = {
				luacheck = {
					args_prepend = { "--globals", "vim" },
				},
			},
		},
	},
}
