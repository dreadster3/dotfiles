return {
	{
		"lewis6991/gitsigns.nvim",
		name = "gitsigns",
		version = "*",
		event = "VeryLazy",
		cmd = { "Gitsigns" },
		opts = { current_line_blame = true },
	},
	{
		"akinsho/bufferline.nvim",
		enabled = false,
		version = "*",
		name = "bufferline",
		dependencies = { "icons" },
		event = "BufReadPost",
		keys = {
			{ "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
			{ "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
			{ "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
			{ "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
			{ "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
			{ "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
			{ "[B", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
			{ "]B", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
		},
		opts = {
			options = {
				close_command = function(n)
					Snacks.bufdelete(n)
				end,
				right_mouse_command = function(n)
					Snacks.bufdelete(n)
				end,
				diagnostics = "nvim_lsp",
				offsets = {
					{
						filetype = "neo-tree",
						text = "Neo-tree",
						highlight = "Directory",
						text_align = "left",
					},
					{
						filetype = "snacks_layout_box",
					},
				},
			},
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		name = "lualine",
		event = "BufReadPost",
		dependencies = { "icons" },
		config = function(_, opts)
			local theme = require("lualine.themes.catppuccin-mocha")
			local accent_color = require("dreadster.utils.ui").get_accent_color()

			theme.normal.a.bg = accent_color
			theme.normal.b.fg = accent_color
			theme.normal.c.fg = accent_color

			local final = vim.tbl_deep_extend("force", opts, {
				options = {
					theme = theme,
				},
			})

			require("lualine").setup(final)
		end,
		opts = {
			options = {
				theme = "catppuccin",
			},
		},
	},
	{
		"tadaa/vimade",
		version = "*",
		event = "VeryLazy",
		opts = {
			recipe = { "default", { animate = true } },
			fadelevel = 0.75,
		},
	},
	{
		"folke/noice.nvim",
		version = "*",
		event = "VeryLazy",
		dependencies = { "folke/snacks.nvim", "MunifTanjim/nui.nvim" },
		config = function(_, opts)
			-- HACK: noice shows messages from before it was enabled,
			-- but this is not ideal when Lazy is installing plugins,
			-- so clear the messages in this case.
			if vim.o.filetype == "lazy" then
				vim.cmd([[messages clear]])
			end
			require("noice").setup(opts)
		end,
		---@type NoiceConfig
		opts = {
			lsp = {
				-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
				hover = {
					enabled = true,
				},
				signature = {
					enabled = false,
				},
			},
			-- you can enable a preset for easier configuration
			presets = {
				bottom_search = true, -- use a classic bottom cmdline for search
				command_palette = true, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				lsp_doc_border = true,
			},
		},
	},
	{
		"ray-x/lsp_signature.nvim",
		event = "InsertEnter",
		opts = {
			bind = true,
			floating_window_above_cur_line = false,
			floating_window_off_x = 0,
			floating_window_off_y = -2,
			handler_opts = {
				border = "rounded",
			},
		},
	},
	{
		"sindrets/diffview.nvim",
		commit = "4516612fe98ff56ae0415a259ff6361a89419b0a",
		name = "diffview",
		cmd = {
			"DiffviewOpen",
			"DiffviewFileHistory",
			"DiffviewClose",
			"DiffviewToggleFiles",
			"DiffviewFocusFiles",
			"DiffviewRefresh",
		},
		opts = {},
	},
	{
		"NvChad/ui",
		name = "nvchad-ui",
		lazy = false,
		init = function()
			vim.g.nvmark_hovered = true
			require("nvchad.colorify").run()
		end,
	},
	{
		"sphamba/smear-cursor.nvim",
		version = "*",
		event = "VeryLazy",
		opts = {},
	},
}
