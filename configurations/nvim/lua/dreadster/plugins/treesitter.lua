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
	{
		"nvim-treesitter/nvim-treesitter-context",
		name = "treesitter-context",
		event = { "BufReadPost", "BufNewFile" },
		keys = {
			{
				"gc",
				function()
					require("treesitter-context").go_to_context(vim.v.count1)
				end,
				desc = "Go to treesitter context",
			},
		},
		opts = {},
	},
	{
		"echasnovski/mini.ai",
		name = "miniai",
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
