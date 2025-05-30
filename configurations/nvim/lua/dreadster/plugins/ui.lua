return {
	{
		"rcarriga/nvim-notify",
		name = "notify",
		lazy = false,
		init = function()
			vim.notify = require("notify")
		end,
		opts = {
			background_colour = "#000000",
			render = "compact",
			max_width = 50,
			top_down = false,
			max_height = 3,
		},
		config = function(_, opts)
			require("notify").setup(opts)
			require("dreadster.utils.lazy").lazy_load_telescope_extension("notify")
		end,
	},
	{
		"petertriho/nvim-scrollbar",
		name = "scrollbar",
		config = function(_, opts)
			require("scrollbar").setup(opts)
			require("scrollbar.handlers.gitsigns").setup()
		end,
		opts = { handlers = { cursor = false } },
	},
	{
		"lewis6991/gitsigns.nvim",
		name = "gitsigns",
		opts = { current_line_blame = true },
	},
	{
		"folke/trouble.nvim",
		cmd = "Trouble",
		keys = {
			{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
			{ "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
			{ "<leader>xs", "<cmd>Trouble symbols toggle<cr>", desc = "Symbols (Trouble)" },
			{ "<leader>xS", "<cmd>Trouble lsp toggle<cr>", desc = "LSP references/definitions/... (Trouble)" },
			{ "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
			{ "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
			{
				"[q",
				function()
					if require("trouble").is_open() then
						require("trouble").prev({ skip_groups = true, jump = true })
					else
						local ok, err = pcall(vim.cmd.cprev)
						if not ok then
							vim.notify(err, vim.log.levels.ERROR)
						end
					end
				end,
				desc = "Previous Trouble/Quickfix Item",
			},
			{
				"]q",
				function()
					if require("trouble").is_open() then
						require("trouble").next({ skip_groups = true, jump = true })
					else
						local ok, err = pcall(vim.cmd.cnext)
						if not ok then
							vim.notify(err, vim.log.levels.ERROR)
						end
					end
				end,
				desc = "Next Trouble/Quickfix Item",
			},
		},
		opts = {},
	},
	{
		"akinsho/bufferline.nvim",
		name = "bufferline",
		dependencies = { "icons" },
		event = "BufReadPost",
		keys = {
			{ "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
			{ "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
			{ "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
			{ "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
			{ "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
			{ "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
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
	{ "levouh/tint.nvim", name = "tint", opts = {} },
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		version = "*",
		dependencies = { "notify", "MunifTanjim/nui.nvim" },
		config = function(_, opts)
			-- HACK: noice shows messages from before it was enabled,
			-- but this is not ideal when Lazy is installing plugins,
			-- so clear the messages in this case.
			if vim.o.filetype == "lazy" then
				vim.cmd([[messages clear]])
			end
			require("noice").setup(opts)
		end,
		opts = {
			lsp = {
				-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
				signature = {
					auto_open = { enabled = false },
				},
			},
			-- you can enable a preset for easier configuration
			presets = {
				bottom_search = true, -- use a classic bottom cmdline for search
				command_palette = true, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
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
		"echasnovski/mini.icons",
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
	{
		"sindrets/diffview.nvim",
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
		"kevinhwang91/nvim-ufo",
		name = "ufo",
		dependencies = { "kevinhwang91/promise-async" },
		opts = {},
	},
	{
		"nvzone/minty",
		dependencies = { "nvzone/volt", "nvzone/menu" },
		cmd = { "Huefy", "Shades" },
		opts = {
			huefy = {
				border = false,
			},
			shades = {
				border = false,
			},
		},
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
}
