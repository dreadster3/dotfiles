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
			{
				"<leader>gl",
				":Trouble diagnostics<CR>",
				desc = "Trouble diagnostics",
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
			{
				"¬",
				":BufferLineCycleNext<CR>",
				desc = "Cycle to next buffer in buffer line",
			},
			{
				"<A-l>",
				":BufferLineCycleNext<CR>",
				desc = "Cycle to next buffer in buffer line",
			},
			{
				"]b",
				":BufferLineCycleNext<CR>",
				desc = "Cycle to next buffer in buffer line",
			},
			{
				"<A-h>",
				":BufferLineCyclePrev<CR>",
				desc = "Cycle to previous buffer in buffer line",
			},
			{
				"˙",
				":BufferLineCyclePrev<CR>",
				desc = "Cycle to previous buffer in buffer line",
			},
			{
				"[b",
				":BufferLineCyclePrev<CR>",
				desc = "Cycle to previous buffer in buffer line",
			},
		},
		opts = {
			options = {
				offsets = {
					{
						filetype = "NvimTree",
						text = "File Explorer",
						text_align = "center",
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
				inc_rename = false, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = false, -- add a border to hover docs and signature help
			},
			messages = { enabled = false },
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
		"folke/zen-mode.nvim",
		name = "zenmode",
		cmd = "ZenMode",
		keys = { { "<leader>zz", ":ZenMode<CR>", desc = "Toggle zen mode" } },
		opts = { plugins = { twilight = { enabled = false } } },
	},
	{
		"folke/twilight.nvim",
		name = "twilight",
		cmd = "Twilight",
		opts = { treesitter = true, context = 10 },
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			indent = {
				char = "│",
				tab_char = "│",
			},
			scope = { show_start = false, show_end = false },
			exclude = {
				filetypes = {
					"help",
					"alpha",
					"dashboard",
					"neo-tree",
					"Trouble",
					"trouble",
					"lazy",
					"mason",
					"notify",
					"toggleterm",
					"lazyterm",
				},
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
		"karb94/neoscroll.nvim",
		name = "neoscroll",
		opts = {
			mappings = {
				"<C-u>",
				"<C-d>",
				"<C-b>",
				"<C-y>",
				"<C-e>",
				"zt",
				"zz",
				"zb",
			},
		},
	},
}
