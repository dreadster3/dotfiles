return {
	{
		"nvim-tree/nvim-tree.lua",
		name = "nvimtree",
		lazy = false,
		dependencies = { "devicons" },
		keys = { { "<leader>e", ":NvimTreeFocus<CR>", desc = "Focus nvim tree" } },
		opts = {
			disable_netrw = true,
			hijack_netrw = true,
			sync_root_with_cwd = true,
			actions = {
				change_dir = { enable = true, global = true },
				open_file = { quit_on_open = true },
			},
			live_filter = { always_show_folders = false },
		},
	},
	{
		"echasnovski/mini.files",
		version = "*",
		dependencies = { "devicons" },
		keys = {
			{
				"<C-e>",
				function()
					require("mini.files").open()
				end,
				desc = "Open mini files",
			},
		},
		opts = {
			options = {
				permanent_delete = false,
				use_as_default_explorer = false,
			},
		},
	},
}
