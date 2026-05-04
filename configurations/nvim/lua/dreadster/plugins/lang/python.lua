return {
	{
		"lspconfig",
		optional = true,
		opts = {
			servers = {
				ty = {},
				ruff = {},
			},
		},
	},
	{
		"nvim-lint",
		optional = true,
		opts = {
			linters_by_ft = {
				python = { "ruff" },
			},
		},
	},
	{
		"conform",
		optional = true,
		opts = {
			formatters_by_ft = {
				python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
			},
		},
	},
	{
		"neotest",
		optional = true,
		dependencies = {
			"nvim-neotest/neotest-python",
		},
		opts = {
			adapters = {
				["neotest-python"] = {},
			},
		},
	},
	{
		"dap",
		optional = true,
		dependencies = {
			"mfussenegger/nvim-dap-python",
		},
        -- stylua: ignore
        keys = {
          { "<leader>dPt", function() require('dap-python').test_method() end, desc = "Debug Method", ft = "python" },
          { "<leader>dPc", function() require('dap-python').test_class() end, desc = "Debug Class", ft = "python" },
        },
		config = function()
			local utils = require("dreadster.utils")
			local path = utils.is_nixos() and "python" or utils.get_pkg_path("debugpy", "/venv/bin/python")

			require("dap-python").setup(path)
		end,
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		optional = true,
		opts = {
			handlers = {
				python = function() end,
			},
		},
	},
}
