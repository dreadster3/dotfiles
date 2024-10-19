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
		"j-hui/fidget.nvim",
		cond = false,
		name = "fidget",
		event = "LspAttach",
		tag = "legacy",
		opts = { text = { spinner = "arc" } },
	},
	{
		"akinsho/bufferline.nvim",
		name = "bufferline",
		dependencies = { "devicons" },
		event = "BufReadPost",
		keys = {
			{
				"˙",
				":BufferLineCyclePrev<CR>",
				desc = "Cycle to previous buffer in buffer line",
			},
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
				"<A-h>",
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
		dependencies = { "devicons" },
		opts = {},
	},
	{ "levouh/tint.nvim", name = "tint", opts = {} },
	{
		"folke/noice.nvim",
		name = "noice",
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
		"folke/zen-mode.nvim",
		name = "zenmode",
		cmd = "ZenMode",
		keys = { { "<leader>zz", ":ZenMode<CR>", desc = "Toggle zen mode" } },
		opts = { plugins = { twilight = { enabled = false } } },
	},
	{
		"pocco81/truezen.nvim",
		name = "truezen",
		cond = false,
		init = function()
			vim.wo.foldmethod = "manual"
		end,
		keys = {
			{ "<leader>zz", ":TZAtaraxis<CR>", desc = "Toggle zen mode ataraxis" },
			{
				"<leader>zm",
				":TZMinimalist<CR>",
				desc = "Toggle zen mode minimalist",
			},
			{ "<leader>zf", ":TZFocus<CR>", desc = "Toggle zen mode focus" },
			{ "<leader>zn", ":TZNarrow<CR>", desc = "Toggle zen mode narrow" },
			{
				"<leader>zn",
				":'<,'>TZNarrow<CR>",
				desc = "Toggle zen mode narrow",
				mode = "v",
			},
		},
		opts = { modes = { ataraxis = { padding = { left = 20, right = 20 } } } },
	},
	{
		"folke/twilight.nvim",
		-- enabled = false,
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
		lazy = true,
		opts = {
			file = {
				[".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
				["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
			},
			filetype = {
				dotenv = { glyph = "", hl = "MiniIconsYellow" },
			},
		},
		init = function()
			package.preload["nvim-web-devicons"] = function()
				require("mini.icons").mock_nvim_web_devicons()
				return package.loaded["nvim-web-devicons"]
			end
		end,
	},
	-- {
	-- 	"nvim-tree/nvim-web-devicons",
	-- 	name = "devicons",
	-- 	lazy = true,
	-- 	config = function(_, opts)
	-- 		require("nvim-web-devicons").setup(opts)
	-- 	end,
	-- 	opts = {
	-- 		color_icons = true,
	-- 		default = true,
	-- 		override = {
	-- 			js = { icon = "󰌞", color = "#F7DF1E", name = "Javascript" },
	-- 			cjs = { icon = "󰌞", color = "#F7DF1E", name = "Javascript" },
	-- 			ts = { icon = "󰛦", color = "#007ACC", name = "Typescript" },
	-- 			astro = { icon = "", color = "#FA7A0A", name = "Astro" },
	-- 		},
	-- 		override_by_filename = {
	-- 			["tailwind.config.cjs"] = {
	-- 				icon = "󱏿",
	-- 				color = "#06B6D4",
	-- 				name = "Tailwind",
	-- 			},
	-- 			[".prettierrc"] = {
	-- 				icon = "󰬗",
	-- 				color = "#7242ED",
	-- 				name = "Prettier",
	-- 			},
	-- 		},
	-- 	},
	-- },
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
