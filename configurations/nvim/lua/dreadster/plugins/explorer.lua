return {
	-- {
	-- 	"nvim-tree/nvim-tree.lua",
	-- 	name = "nvimtree",
	-- 	lazy = false,
	-- 	dependencies = { "devicons" },
	-- 	keys = { { "<leader>e", ":NvimTreeFocus<CR>", desc = "Focus nvim tree" } },
	-- 	opts = {
	-- 		disable_netrw = true,
	-- 		hijack_netrw = true,
	-- 		sync_root_with_cwd = true,
	-- 		actions = {
	-- 			change_dir = { enable = true, global = true },
	-- 			open_file = { quit_on_open = true },
	-- 		},
	-- 		live_filter = { always_show_folders = false },
	-- 	},
	-- },
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		},
		keys = {
			{
				"<leader>e",
				function()
					require("neo-tree.command").execute({ toggle = true, dir = vim.fn.getcwd() })
				end,
				desc = "Focus neotree",
			},
		},
		lazy = false,
		opts = {
			open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
			auto_clean_after_session_restore = true,
			filesystem = {
				bind_to_cwd = true,
				follow_current_file = { enabled = true },
				use_libuv_file_watcher = true,
			},
			default_component_configs = {
				indent = {
					with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
					expander_collapsed = "",
					expander_expanded = "",
					expander_highlight = "NeoTreeExpander",
				},
				git_status = {
					symbols = {
						unstaged = "󰄱",
						staged = "󰱒",
					},
				},
			},
			window = {
				width = 0.2,
			},
			event_handlers = {

				{
					event = "file_open_requested",
					handler = function()
						require("neo-tree.command").execute({ action = "close" })
					end,
				},
			},
		},
	},
	{
		"echasnovski/mini.files",
		version = "*",
		dependencies = { "devicons" },
		keys = {
			{
				"<C-m>",
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
