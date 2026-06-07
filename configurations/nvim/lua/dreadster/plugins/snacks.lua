return {
	{
		"folke/snacks.nvim",
		version = "*",
		priority = 1000,
		lazy = false,
		-- stylua: ignore
		keys = {
            -- Top
            { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
            { "<leader>,", function() Snacks.picker.buffers({ focus = "list" }) end, desc = "Buffers" },
            { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
            { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
            { "<leader>n", function() Snacks.picker.notifications({focus = "list"}) end, desc = "Notification History" },
            { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File", mode ={"n"} },

            -- find
            { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
            { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
            { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
            { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
            { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
            { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
            { "<leader>fd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
            { "<leader>fD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },

            -- Lazygit
            { "<leader>gg",  function() Snacks.lazygit() end, desc = "Lazygit" },

            -- Git
            { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
            { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse", mode = { "n", "v" } },
            { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
            { "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
            { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
            { "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
            { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
            { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },

            -- Github
            { "<leader>gi", function() Snacks.picker.gh_issue({ focus = "list" }) end, desc = "GitHub Issues (open)" },
            { "<leader>gI", function() Snacks.picker.gh_issue({ focus = "list", state = "all" }) end, desc = "GitHub Issues (all)" },
            { "<leader>gp", function() Snacks.picker.gh_pr({ focus = "list" }) end, desc = "GitHub Pull Requests (open)" },
            { "<leader>gP", function() Snacks.picker.gh_pr({ focus = "list", state = "all" }) end, desc = "GitHub Pull Requests (all)" },

            -- Zen
            { "<leader>z",  function() Snacks.zen.zoom() end, desc = "Toggle Zoom" },
            { "<leader>Z",  function() Snacks.zen() end, desc = "Toggle Zen Mode" },
		},
		---@type snacks.Config
		opts = {
			buffer = { enabled = true },
			indent = { enabled = true },
			input = { enabled = true },
			gh = { enabled = true },
			gitbrowse = { enabled = true },
			lazygit = { enabled = true },
			notifier = { enabled = true },
			image = { enabled = true },
			---@type snacks.picker.Config
			picker = {
				enabled = true,
				matcher = {
					frecency = true,
				},
				win = {
					input = {
						keys = {
							["<a-f>"] = { "preview_scroll_left", mode = { "i", "n" } },
							["<a-b>"] = { "preview_scroll_right", mode = { "i", "n" } },
							["<c-x>"] = { "edit_split", mode = { "i", "n" } },
						},
					},
				},
				layout = {
					layout = {
						box = "vertical",
						backdrop = false,
						row = -1,
						width = 0,
						height = 0.4,
						border = "top",
						title = " {title} {live} {flags}",
						title_pos = "left",
						{ win = "input", height = 1, border = "bottom" },
						{
							box = "horizontal",
							{ win = "list", border = "none" },
							{ win = "preview", title = "{preview}", width = 0.6, border = "left" },
						},
					},
				},
				sources = {
					buffers = {
						win = {
							input = {
								keys = {
									["dd"] = { "bufdelete", mode = { "n" } },
								},
							},
						},
					},
				},
				debug = {
					scores = true,
				},
			},
			rename = { enabled = true },
			scope = { enabled = true },
			scroll = { enable = true },
			statuscolumn = { enable = true },
			words = { enable = true },
			util = { enable = true },
			zen = { enable = true },
		},
	},
}
