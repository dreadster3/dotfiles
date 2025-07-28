return {
	{
		"mrcjkb/rustaceanvim",
		version = "^6",
		ft = { "rust" },
		config = function(_, opts)
			vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts or {})
		end,
		opts = {
			server = {
				on_attach = function(_, bufnr)
					vim.keymap.set("n", "<leader>cR", function()
						vim.cmd.RustLsp("codeAction")
					end, { desc = "Code Action", buffer = bufnr })
					vim.keymap.set("n", "<leader>dr", function()
						vim.cmd.RustLsp("debuggables")
					end, { desc = "Rust Debuggables", buffer = bufnr })
				end,
				default_settings = {
					-- rust-analyzer language server configuration
					["rust-analyzer"] = {
						cargo = {
							allFeatures = true,
							loadOutDirsFromCheck = true,
							buildScripts = {
								enable = true,
							},
						},
						checkOnSave = true,
						diagnostics = {
							enable = true,
						},
						procMacro = {
							enable = true,
							ignored = {
								["async-trait"] = { "async_trait" },
								["napi-derive"] = { "napi" },
								["async-recursion"] = { "async_recursion" },
							},
						},
						files = {
							excludeDirs = {
								".direnv",
								".git",
								".github",
								".gitlab",
								"bin",
								"node_modules",
								"target",
								"venv",
								".venv",
							},
						},
					},
				},
			},
		},
	},
	{
		"lspconfig",
		optional = true,
		opts = {
			rust_analyzer = { enabled = false },
		},
	},
	{
		"nvim-lint",
		opts = {
			linters_by_ft = {
				rust = { "clippy" },
			},
		},
	},
	{
		"conform",
		opts = {
			formatters_by_ft = {
				rust = { "rustfmt" },
			},
		},
	},
	{
		"neotest",
		optional = true,
		opts = {
			adapters = {
				["rustaceanvim.neotest"] = {},
			},
		},
	},
	{
		"Saecki/crates.nvim",
		event = { "BufRead Cargo.toml" },
		opts = {
			completion = {
				crates = {
					enabled = true,
				},
			},
			lsp = {
				enabled = true,
				actions = true,
				completion = true,
				hover = true,
			},
		},
	},
	{
		"hrsh7th/nvim-cmp",
		optional = true,
		dependencies = { "codeium" },
		opts = function(_, opts)
			table.insert(opts.sources, 1, {
				name = "crates",
				group_index = 1,
				priority = 100,
			})
		end,
	},
}
