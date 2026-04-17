return {
	{
		"nvim-mini/mini.ai",
		version = "*",
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
	{
		"nvim-mini/mini.move",
		event = { "BufReadPost", "BufWritePost", "BufNewFile" },
		version = "*",
		opts = {},
	},
	{
		"nvim-mini/mini.icons",
		name = "icons",
		main = "mini.icons",
		lazy = true,
		opts = function()
			return {
				file = {
					[".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
					["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
				},
				filetype = {
					dotenv = { glyph = "", hl = "MiniIconsYellow" },
				},
				lsp_icons = {
					folder = { glyph = "", hl = "MiniIconsAccent" },
				},
				default = {
					directory = { glyph = "󰉋", hl = "MiniIconsAccent" },
				},
			}
		end,
		init = function()
			package.preload["nvim-web-devicons"] = function()
				require("mini.icons").mock_nvim_web_devicons()
				return package.loaded["nvim-web-devicons"]
			end
		end,
	},
}
