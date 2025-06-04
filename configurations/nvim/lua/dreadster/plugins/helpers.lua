return {
	{
		"windwp/nvim-autopairs",
		name = "autopairs",
		event = { "InsertEnter" },
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {},
	},
	{
		"folke/which-key.nvim",
		version = "*",
		event = "VeryLazy",
    -- stylua: ignore
		keys = {
			{ "<leader>?", function() require("which-key").show({ global = false }) end, desc = "Buffer Keymaps (which-key)" },
		},
		opts = {
			presets = "helix",
			spec = {
				{
					mode = { "n", "v" },
					{ "<leader>c", group = "code" },
					{ "<leader>b", group = "buffer" },
					{ "<leader>d", group = "debug" },
					{ "<leader>f", group = "file/find" },
					{ "<leader>g", group = "git" },
					{ "<leader>gh", group = "hunks" },
					{ "<leader>q", group = "quit/session" },
					{ "<leader>s", group = "search" },
					{ "<leader>u", group = "ui", icon = { icon = "󰙵 ", color = "cyan" } },
					{ "<leader>x", group = "diagnostics/quickfix", icon = { icon = "󱖫 ", color = "green" } },
					{ "[", group = "prev" },
					{ "]", group = "next" },
					{ "g", group = "goto" },
					{ "gs", group = "surround" },
					{ "z", group = "fold" },
					{
						"<leader>b",
						group = "buffer",
						expand = function()
							return require("which-key.extras").expand.buf()
						end,
					},
					{
						"<leader>w",
						group = "windows",
						proxy = "<c-w>",
						expand = function()
							return require("which-key.extras").expand.win()
						end,
					},
					-- better descriptions
					{ "gx", desc = "Open with system app" },
				},
			},
		},
	},
	{ "folke/todo-comments.nvim", event = "BufReadPre", opts = {} },
	{
		"gbprod/yanky.nvim",
		name = "yanky",
		event = { "BufReadPost", "BufWritePost", "BufNewFile" },
		keys = {
			{ "y", "<Plug>(YankyYank)", mode = { "n", "x" }, desc = "Yank Text" },
			{ "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put Text After Cursor" },
			{ "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put Text Before Cursor" },
			{ "gp", "<Plug>(YankyGPutAfter)", mode = { "n", "x" }, desc = "Put Text After Selection" },
			{ "gP", "<Plug>(YankyGPutBefore)", mode = { "n", "x" }, desc = "Put Text Before Selection" },
			{ "[y", "<Plug>(YankyCycleForward)", desc = "Cycle Forward Through Yank History" },
			{ "]y", "<Plug>(YankyCycleBackward)", desc = "Cycle Backward Through Yank History" },
			{ "]p", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put Indented After Cursor (Linewise)" },
			{ "[p", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put Indented Before Cursor (Linewise)" },
			{ "]P", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put Indented After Cursor (Linewise)" },
			{ "[P", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put Indented Before Cursor (Linewise)" },
			{ ">p", "<Plug>(YankyPutIndentAfterShiftRight)", desc = "Put and Indent Right" },
			{ "<p", "<Plug>(YankyPutIndentAfterShiftLeft)", desc = "Put and Indent Left" },
			{ ">P", "<Plug>(YankyPutIndentBeforeShiftRight)", desc = "Put Before and Indent Right" },
			{ "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)", desc = "Put Before and Indent Left" },
			{ "=p", "<Plug>(YankyPutAfterFilter)", desc = "Put After Applying a Filter" },
			{ "=P", "<Plug>(YankyPutBeforeFilter)", desc = "Put Before Applying a Filter" },
		},
		opts = {
			highlight = { timer = 150 },
			picker = {
				telescope = {
					use_default_mappings = true,
				},
			},
		},
		config = function(_, opts)
			require("yanky").setup(opts)
			require("dreadster.utils.lazy").lazy_load_telescope_extension("yank_history")
		end,
	},
	{ "rhysd/git-messenger.vim", cmd = { "GitMessenger" }, opts = {} },
	{
		"rmagatti/auto-session",
		lazy = false,
		name = "autosession",
		main = "auto-session",
		opts = {
			bypass_save_filetypes = { "neo-tree" },
			session_lens = {
				load_on_setup = false,
			},
			post_restore_cmds = {
				-- Forces treesitter to reload
				"e",
			},
		},
	},
	{
		"b0o/SchemaStore.nvim",
		name = "schemastore",
		lazy = true,
		version = false, -- last release is way too old
	},
	{
		"hiphish/rainbow-delimiters.nvim",
		name = "rainbow-delimiters",
		main = "rainbow-delimiters.setup",
		version = "*",
		event = { "BufReadPre", "BufWritePre", "BufNewFile" },
		opts = {},
	},
	{
		"johnfrankmorgan/whitespace.nvim",
		name = "whitespace",
		event = { "BufReadPre", "BufWritePre", "BufNewFile" },
		cmd = { "WhitespaceTrim" },
		init = function()
			vim.api.nvim_create_user_command("WhitespaceTrim", function()
				require("whitespace").trim()
			end, {})
		end,
		opts = {
			highlight = "DiffDelete",
			ignored_filetypes = {
				"TelescopePrompt",
				"Trouble",
				"help",
				"noice",
				"glow",
				"gitcommit",
			},
			ignore_terminal = true,
		},
	},
	{ "echasnovski/mini.move", event = { "BufReadPost", "BufWritePost", "BufNewFile" }, version = "*", opts = {} },
	{
		"m4xshen/hardtime.nvim",
		event = { "VeryLazy" },
		version = "*",
		dependencies = { "MunifTanjim/nui.nvim" },
		opts = {
			disable_mouse = false,
			restriction_mode = "hint",
			disabled_filetypes = {
				lazy = false, -- Enable Hardtime in lazy filetype
				["dapui*"] = false, -- Enable Hardtime in filetype starting with dapui
			},
		},
	},
}
