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
		name = "neotree",
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
					require("neo-tree.command").execute({ action = "focus", toggle = false, dir = vim.fn.getcwd() })
				end,
				desc = "Focus neotree",
			},
		},
		init = function()
			-- FIX: use `autocmd` for lazy-loading neo-tree instead of directly requiring it,
			-- because `cwd` is not set up properly.
			vim.api.nvim_create_autocmd("BufEnter", {
				group = vim.api.nvim_create_augroup("Neotree_start_directory", { clear = true }),
				desc = "Start Neo-tree with directory",
				once = true,
				callback = function()
					if package.loaded["neo-tree"] then
						return
					else
						local stats = vim.uv.fs_stat(vim.fn.argv(0))
						if stats and stats.type == "directory" then
							require("neo-tree")
						end
					end
				end,
			})
		end,
		opts = {
			close_if_last_window = true,
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
				position = "left",
				width = 30,
				mappings = {
					["<C-f>"] = "noop",
				},
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
		name = "minifiles",
		main = "mini.files",
		lazy = false,
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
