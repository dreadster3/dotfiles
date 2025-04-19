return {
	{
		"lspconfig",
		opts = {
			servers = {
				gopls = {
					mason = false,
					settings = {
						gopls = {
							gofumpt = true,
							codelenses = {
								gc_details = false,
								generate = true,
								regenerate_cgo = true,
								run_govulncheck = true,
								test = true,
								tidy = true,
								upgrade_dependency = true,
								vendor = true,
							},
							hints = {
								assignVariableTypes = true,
								compositeLiteralFields = true,
								compositeLiteralTypes = true,
								constantValues = true,
								functionTypeParameters = true,
								parameterNames = true,
								rangeVariableTypes = true,
							},
							analyses = {
								nilness = true,
								unusedparams = true,
								unusedwrite = true,
								useany = true,
							},
							usePlaceholders = true,
							completeUnimported = true,
							staticcheck = true,
							directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
							semanticTokens = true,
						},
					},
				},
			},
		},
	},
	{
		"nvim-lint",
		opts = {
			go = { "trivy" },
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
		ft = { "go", "gomod" },
		opts = {},
		event = { "CmdlineEnter" },
		specs = {
			{
				"dap",

        -- stylua: ignore
				keys = {
					{ "<leader>dc", ":GoDebug<CR>", ft = { "go" }, desc = "[Go] Debug" },
					{ "<F5>", ":GoDebug<CR>", ft = { "go" }, desc = "[Go] Debug" },
					{ "<leader>db", ":GoDebug --breakpoint<CR>", ft = { "go" }, desc = "[Go] Toggle Breakpoint" },
				},
			},
		},
	},
	{
		"dap",
		optional = true,
		dependencies = {
			{
				"leoluz/nvim-dap-go",
				opts = {},
			},
		},
	},
	{
		"neotest",
		optional = true,
		dependencies = {
			"fredrikaverpil/neotest-golang",
		},
		opts = {
			adapters = {
				["neotest-golang"] = {
					-- go_test_args = { "-v", "-race", "-count=1", "-timeout=60s" },
					dap_go_enabled = true,
				},
			},
		},
	},
}
