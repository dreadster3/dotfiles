return {
	{
		"windwp/nvim-autopairs",
		name = "autopairs",
		dependencies = {
			{
				"windwp/nvim-ts-autotag",
				name = "autopairs-ts",
				opts = {
					opts = {
						enable = true,
						enable_rename = true,
						enable_close = true,
						enable_close_on_slash = true,
					},
				},
			},
		},
		event = { "InsertEnter" },
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = { check_ts = true },
	},
	{
		"folke/which-key.nvim",
		version = "*",
		event = "VeryLazy",
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Keymaps (which-key)",
			},
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
				},
			},
		},
	},
	{ "folke/todo-comments.nvim", event = "BufReadPre", opts = {} },
	{
		"RRethy/vim-illuminate",
		name = "illuminate",
		main = "illuminate",
		event = { "BufReadPre", "BufNewFile" },
		-- keys = {
		-- 	{
		-- 		"[[",
		-- 		function()
		-- 			require("illuminate").goto_prev_reference(false)
		-- 		end,
		-- 		mode = "n",
		-- 		desc = "Goto next Reference",
		-- 	},
		-- 	{
		-- 		"]]",
		-- 		function()
		-- 			require("illuminate").goto_next_reference(false)
		-- 		end,
		-- 		mode = "n",
		-- 		desc = "Goto previous Reference",
		-- 	},
		-- },
		opts = {
			delay = 200,
			large_file_cutoff = 5000,
			large_file_overrides = {
				providers = {
					"lsp",
				},
			},
		},
		config = function(_, opts)
			require("illuminate").configure(opts)
		end,
	},
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
		"chrisgrieser/nvim-early-retirement",
		name = "earlyretirement",
		main = "early-retirement",
		event = "VeryLazy",
		opts = {
			retirementAgeMins = 15,
		},
	},
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
		version = "*",
		name = "rainbow",
		main = "rainbow-delimiters.setup",
		opts = {},
	},
	{
		"johnfrankmorgan/whitespace.nvim",
		name = "whitespace",
		event = { "BufReadPre", "BufNewFile" },
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
}
