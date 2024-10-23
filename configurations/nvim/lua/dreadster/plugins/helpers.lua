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
			spec = {
				{
					mode = { "n", "v" },
					{ "[", group = "Previous" },
					{ "]", group = "Next" },
				},
			},
			delay = function(ctx)
				return 500
			end,
		},
	},
	{ "folke/todo-comments.nvim", event = "BufReadPre", opts = {} },
	{
		"RRethy/vim-illuminate",
		name = "illuminate",
		main = "illuminate",
		event = { "BufReadPre", "BufNewFile" },
		keys = {
			{
				"[[",
				function()
					require("illuminate").goto_prev_reference(false)
				end,
				mode = "n",
				desc = "Goto next Reference",
			},
			{
				"]]",
				function()
					require("illuminate").goto_next_reference(false)
				end,
				mode = "n",
				desc = "Goto previous Reference",
			},
		},
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
		lazy = false,
		keys = {
			{ "y", "<Plug>(YankyYank)", mode = { "n", "x" } },
			{ "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" } },
			{ "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" } },
			{ "<c-n>", "<Plug>(YankyCycleForward)", mode = { "n", "x" } },
			{ "<c-p>", "<Plug>(YankyCycleBackward)", mode = { "n", "x" } },
		},
		opts = {
			picker = {
				telescope = {
					use_default_mappings = true,
				},
			},
		},
		config = function(_, opts)
			require("yanky").setup(opts)

			require("dreadster.utils.lazy").on_load("telescope", function()
				require("telescope").load_extension("yank_history")
			end)
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
}
