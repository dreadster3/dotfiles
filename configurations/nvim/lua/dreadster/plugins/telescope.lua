return {
	{
		"nvim-telescope/telescope.nvim",
		name = "telescope",
		main = "telescope",
		version = false,
		lazy = true,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-media-files.nvim",
			"nvim-telescope/telescope-symbols.nvim",
		},
		cmd = { "Telescope" },
		keys = {
			{ "<leader>ff", ":Telescope find_files<CR>", desc = "Find files" },
			{ "<C-f>", ":Telescope live_grep<CR>", desc = "Live grep" },
		},
		opts = function()
			local opts = {
				defaults = {
					file_ignore_patterns = {
						"obj",
						"bin",
						"node_modules",
						"build",
						"target",
					},
					layout_strategy = "vertical",
					layout_config = {
						horizontal = {
							prompt_position = "top",
							preview_width = 0.5,
							results_width = 0.5,
						},
						vertical = {
							prompt_position = "top",
							preview_height = 0.6,
							width = 0.6,
						},
					},
					borderchars = {
						"─",
						"│",
						"─",
						"│",
						"╭",
						"╮",
						"╯",
						"╰",
					},
					mappings = {
						n = { ["q"] = require("telescope.actions").close },
					},
				},
				extensions = { media_files = { find_cmd = "rg" } },
			}

			return opts
		end,
	},
	{
		"nvim-telescope/telescope-media-files.nvim",
		name = "telescope-media-files",
		lazy = true,
		keys = {
			{
				"<leader>fm",
				":Telescope media_files<CR>",
				mode = "n",
				desc = "Find media files",
			},
		},
		config = function()
			require("dreadster.utils.lazy").on_load("telescope", function()
				require("telescope").load_extension("media_files")
			end)
		end,
	},
}
