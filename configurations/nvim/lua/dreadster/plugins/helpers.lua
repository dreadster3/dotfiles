return {
	{
		"terrortylor/nvim-comment",
		name = "nvim_comment",
		dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
		keys = {
			{ "<C-/>", ":CommentToggle<CR>", desc = "Toggle comment for line" },
			{
				"<C-/>",
				":'<,'>CommentToggle<CR>",
				mode = "v",
				desc = "Toggle comment for line",
			},
			{ "<C-_>", ":CommentToggle<CR>", desc = "Toggle comment for line" },
			{
				"<C-_>",
				":'<,'>CommentToggle<CR>",
				mode = "v",
				desc = "Toggle comment for line",
			},
		},
		cmd = { "CommentToggle" },
		opts = {
			hook = function()
				require("ts_context_commentstring.internal").update_commentstring({})
			end,
		},
	},
	{
		"windwp/nvim-autopairs",
		name = "autopairs",
		dependencies = {
			{ "windwp/nvim-ts-autotag", name = "autopairs-ts", opts = {} },
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
		opts = {
			delay = function(ctx)
				return 500
			end,
		},
	},
	{ "folke/todo-comments.nvim", event = "BufReadPre", opts = {} },
	{ "RRethy/vim-illuminate", event = { "BufReadPost" } },
	{
		"gbprod/yanky.nvim",
		lazy = false,
		keys = {
			{ "y", "<Plug>(YankyYank)", mode = { "n", "x" } },
			{ "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" } },
			{ "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" } },
			{ "<c-n>", "<Plug>(YankyCycleForward)", mode = { "n", "x" } },
			{ "<c-p>", "<Plug>(YankyCycleBackward)", mode = { "n", "x" } },
		},
		opts = {},
	},
	{ "rhysd/git-messenger.vim", cmd = { "GitMessenger" }, opts = {} },
	{
		"rmagatti/auto-session",
		name = "autosession",
		main = "auto-session",
		opts = {},
	},
	{
		"chrisgrieser/nvim-early-retirement",
		name = "earlyretirement",
		event = "VeryLazy",
		opts = {
			retirementAgeMins = 15,
		},
	},
}
