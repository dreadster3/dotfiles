return {
	{
		"petertriho/nvim-scrollbar",
		enabled = false,
		name = "scrollbar",
		dependencies = { "gitsigns" },
		event = "VeryLazy",
		config = function(_, opts)
			require("scrollbar").setup(opts)
			require("scrollbar.handlers.gitsigns").setup()
		end,
		opts = { handlers = { cursor = false } },
	},
	{
		"stevearc/overseer.nvim",
		name = "overseer",
		cmd = {
			"OverseerOpen",
			"OverseerClose",
			"OverseerToggle",
			"OverseerSaveBundle",
			"OverseerLoadBundle",
			"OverseerDeleteBundle",
			"OverseerRunCmd",
			"OverseerRun",
			"OverseerInfo",
			"OverseerBuild",
			"OverseerQuickAction",
			"OverseerTaskAction",
			"OverseerClearCache",
		},
		keys = {
			{ "<leader>ow", "<cmd>OverseerToggle<cr>", desc = "Task list" },
			{ "<leader>oo", "<cmd>OverseerRun<cr>", desc = "Run task" },
			{ "<leader>oq", "<cmd>OverseerQuickAction<cr>", desc = "Action recent task" },
			{ "<leader>oi", "<cmd>OverseerInfo<cr>", desc = "Overseer Info" },
			{ "<leader>ob", "<cmd>OverseerBuild<cr>", desc = "Task builder" },
			{ "<leader>ot", "<cmd>OverseerTaskAction<cr>", desc = "Task action" },
			{ "<leader>oc", "<cmd>OverseerClearCache<cr>", desc = "Clear cache" },
		},
		opts = {},
	},
	{
		"mikavilpas/yazi.nvim",
		event = "VeryLazy",
		enabled = false,
		dependencies = {
			{
				"snacks.nvim",
				opts = {
					buffer = { enabled = true },
				},
			},
		},
		keys = {
			{ "<leader>y", "", desc = "+yazi", mode = { "n", "v" } },
			{ "<leader>yf", "<cmd>Yazi<cr>", desc = "Open yazi at the current file" },
			{ "<leader>yc", "<cmd>Yazi cwd<cr>", desc = "Open yazi at the current directory" },
			{ "<leader>yt", "<cmd>Yazi toggle<cr>", desc = "Resume the last yazi session" },
		},
		opts = {
			open_for_directories = false,
			keymaps = {
				show_help = "g?",
			},
		},
	},
}
