return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		name = "neotree",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"icons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		},
    -- stylua: ignore
		keys = {
			{ "<leader>e", function() require("neo-tree.command").execute({ action = "focus", toggle = false, dir = vim.fn.getcwd() }) end, desc = "Focus neotree" },
            { "<leader>be", function() require("neo-tree.command").execute({ source = "buffers", toggle = true }) end, desc = "Buffer Explorer", },
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
		opts = function()
			local function on_move(data)
				Snacks.rename.on_rename_file(data.source, data.destination)
			end

			local events = require("neo-tree.events")
			return {
				close_if_last_window = true,
				open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
				auto_clean_after_session_restore = true,
				filesystem = {
					filtered_items = {
						visible = true,
					},
					bind_to_cwd = true,
					follow_current_file = { enabled = true },
					use_libuv_file_watcher = true,
					window = {
						mappings = {
							["/"] = { "fuzzy_finder", config = { keep_filter_on_submit = true } },
							["D"] = { "fuzzy_finder_directory", config = { keep_filter_on_submit = true } },
						},
					},
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
					width = "15%",
					auto_expand = false,
					mappings = {
						["Y"] = {
							function(state)
								local node = state.tree:get_node()
								local path = node:get_id()
								vim.fn.setreg("+", path, "c")
							end,
							desc = "Copy Path to Clipboard",
						},
						["O"] = {
							function(state)
								require("lazy.util").open(state.tree:get_node().path, { system = true })
							end,
							desc = "Open with System Application",
						},
					},
				},
				event_handlers = {
					{
						event = events.FILE_OPEN_REQUESTED,
						handler = function()
							require("neo-tree.command").execute({ action = "close" })
						end,
					},
					{ event = events.FILE_MOVED, handler = on_move },
					{ event = events.FILE_RENAMED, handler = on_move },
				},
			}
		end,
	},
	{
		"mikavilpas/yazi.nvim",
		event = "VeryLazy",
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
