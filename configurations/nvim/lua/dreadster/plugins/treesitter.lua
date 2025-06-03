return {
	{
		"nvim-treesitter/nvim-treesitter",
		name = "treesitter",
		main = "nvim-treesitter.configs",
		dependencies = { "nvim-treesitter/playground" },
		build = ":TSUpdate",
		version = "*",
		event = { "BufReadPre", "BufNewFile", "VeryLazy" },
		---@type TSConfig
		---@diagnostic disable-next-line: missing-fields
		opts = {
			ensure_installed = {
				"bash",
				"diff",
				"json",
				"lua",
				"markdown",
				"markdown_inline",
				"printf",
				"python",
				"query",
				"regex",
				"vim",
				"vimdoc",
				"yaml",
			},
			auto_install = true,
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
			context_commentstring = { enable = true },
			playground = {
				enable = true,
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		name = "treesitter-context",
		dependencies = { "treesitter" },
		cmd = { "TSContextEnable", "TSContextDisable", "TSContextToggle" },
		event = { "BufReadPost", "BufWritePost", "BufNewFile" },
		opts = {
			mode = "cursor",
			max_lines = 3,
		},
	},
	{
		"echasnovski/mini.ai",
		name = "miniai",
		dependencies = { "treesitter" },
		main = "mini.ai",
		event = "VeryLazy",
		opts = function()
			local ai = require("mini.ai")
			return {
				n_lines = 500,
				custom_textobjects = {
					o = ai.gen_spec.treesitter({ -- code block
						a = { "@block.outer", "@conditional.outer", "@loop.outer" },
						i = { "@block.inner", "@conditional.inner", "@loop.inner" },
					}),
					f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
					c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }), -- class
					t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- tags
					d = { "%f[%d]%d+" }, -- digits
					e = { -- Word with case
						{
							"%u[%l%d]+%f[^%l%d]",
							"%f[%S][%l%d]+%f[^%l%d]",
							"%f[%P][%l%d]+%f[^%l%d]",
							"^[%l%d]+%f[^%l%d]",
						},
						"^().*()$",
					},
					u = ai.gen_spec.function_call(), -- u for "Usage"
					U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
				},
			}
		end,
	},
}
