return {
	{
		"nvim-telescope/telescope.nvim",
		version = "*",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-media-files.nvim",
			"nvim-telescope/telescope-symbols.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
			"nvim-telescope/telescope-media-files.nvim",
		},
		cmd = { "Telescope" },
		event = { "VeryLazy" },
		keys = {
			{ "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files" },
			{
				"<leader>fb",
				"<cmd>Telescope buffers sort_mru=true sort_lastused=true ignore_current_buffer=true<cr>",
				desc = "Buffers",
			},
			{ "<leader>fg", ":Telescope live_grep<CR>", desc = "Live grep" },
			{ "<leader>fd", "<cmd>Telescope diagnostics<CR>", desc = "Diagnostics" },
			{ "<leader>fs", "<cmd>Telescope <CR>", desc = "Status" },
			{
				"<leader>fm",
				":Telescope media_files<CR>",
				mode = "n",
				desc = "Find media files",
			},

			-- Git
			{ "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "Commits" },
			{ "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "Status" },
		},
		config = function(_, opts)
			require("telescope").setup(opts)
			require("telescope").load_extension("ui-select")
			require("telescope").load_extension("media_files")
		end,
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
				extensions = {
					media_files = { find_cmd = "rg" },
				},
			}

			return opts
		end,
	},
}
