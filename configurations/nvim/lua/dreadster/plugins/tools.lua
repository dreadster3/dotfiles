return {
	{
		"kdheepak/lazygit.nvim",
		name = "lazygit",
		dependencies = { "nvim-lua/plenary.nvim" },
		cmd = "LazyGit",
		keys = { { "<leader>g", "<CMD>LazyGit<CR>", desc = "Lanch lazygit" } },
	},
	{
		"akinsho/toggleterm.nvim",
		dependencies = {
			"lualine",
			"christoomey/vim-tmux-navigator", -- Sets the keybinds to navigate between windows
		},
		name = "toggleterm",
		version = "*",
		cmd = "ToggleTerm",
		keys = {
			{
				"<C-\\>",
				'<CMD>execute v:count . "ToggleTerm direction=horizontal"<CR>',
				mode = { "n", "t", "x" },
				desc = "Toggle terminal horizontal",
			},
			{
				"<M-\\>",
				'<CMD>execute v:count . "ToggleTerm direction=float"<CR>',
				mode = { "n", "t", "x" },
				desc = "Toggle terminal float",
			},
		},
		opts = {
			open_mapping = "<Nop>",
			start_in_insert = true,
			persist_size = false,
			persist_mode = false,
		},
	},
	{
		"nvimdev/template.nvim",
		version = false,
		name = "template",
		cmd = { "Template" },
		config = function(_, opts)
			require("template").setup(opts)
			require("template").register("{{_dir_}}", function()
				vim.fn.expand("%:p:h")
			end)
			require("dreadster.utils.lazy").lazy_load_telescope_extension("find_template")
		end,
		opts = {
			author = "dreadster3",
			email = "afonso.antunes@live.com.pt",
			temp_dir = vim.fn.expand("$HOME/.config/nvim/template"),
		},
	},
	{
		"ahmedkhalf/project.nvim",
		name = "project",
		cmd = { "ProjectRoot", "Telescope" },
		event = { "VeryLazy" },
		keys = {
			{
				"<leader>fp",
				":Telescope projects<CR>",
				desc = "Find projects",
			},
		},
		config = function(_, opts)
			require("project_nvim").setup(opts)

			require("dreadster.utils.lazy").lazy_load_telescope_extension("projects")
		end,
		opts = {
			on_config_done = nil,
			manual_mode = true,
			detection_methods = { "pattern" },
			patterns = {
				".git",
				"_darcs",
				".hg",
				".bzr",
				".svn",
				"Makefile",
				"package.json",
			},
			show_hidden = false,
			silent_chdir = false,
			ignore_lsp = {},
			datapath = vim.fn.stdpath("data"),
		},
	},
	{
		"stevearc/overseer.nvim",
		name = "overseer",
		cmd = {
			"OverseerOpen",
			"OverseerClose",
			"OverseerToggle",
			"OverseerSaveBundle",
			"OverseerLoadBundle",
			"OverseerDeleteBundle",
			"OverseerRunCmd",
			"OverseerRun",
			"OverseerInfo",
			"OverseerBuild",
			"OverseerQuickAction",
			"OverseerTaskAction",
			"OverseerClearCache",
		},
		keys = {
			{ "<leader>ow", "<cmd>OverseerToggle<cr>", desc = "Task list" },
			{ "<leader>oo", "<cmd>OverseerRun<cr>", desc = "Run task" },
			{ "<leader>oq", "<cmd>OverseerQuickAction<cr>", desc = "Action recent task" },
			{ "<leader>oi", "<cmd>OverseerInfo<cr>", desc = "Overseer Info" },
			{ "<leader>ob", "<cmd>OverseerBuild<cr>", desc = "Task builder" },
			{ "<leader>ot", "<cmd>OverseerTaskAction<cr>", desc = "Task action" },
			{ "<leader>oc", "<cmd>OverseerClearCache<cr>", desc = "Clear cache" },
		},
		opts = {},
	},
	{
		"danymat/neogen",
		name = "neogen",
		cmd = "Neogen",
		opts = {
			enabled = true,
			languages = {
				cs = { template = { annotation_convention = "xmldoc" } },
				python = { template = { annotation_convention = "google_docstrings" } },
			},
		},
	},
	{
		"nvim-pack/nvim-spectre",
		cmd = "Spectre",
		opts = { open_cmd = "noswapfile vnew" },
		-- stylua: ignore
		keys = {
			{
				"<leader>sr",
				function() require("spectre").toggle() end,
				desc = "Replace in files (Spectre)"
			}
		}
,
	},
	{
		"cshuaimin/ssr.nvim",
		name = "ssr",
		keys = {
			{
				"<leader>sR",
				"<CMD>lua require('ssr').open()<CR>",
				desc = "Search and Replace",
			},
		},
		opts = {
			border = "rounded",
			min_width = 50,
			min_height = 5,
			max_width = 120,
			max_height = 25,
			keymaps = {
				close = "q",
				next_match = "n",
				prev_match = "N",
				replace_confirm = "<cr>",
				replace_all = "<leader><cr>",
			},
		},
	},
	{
		"pwntester/octo.nvim",
		name = "octo",
		cmd = "Octo",
		event = { { event = "BufReadCmd", pattern = "octo://*" } },
		dependencies = { "telescope", "nvim-lua/plenary.nvim", "icons" },
		opts = {
			enable_builtin = true,
			default_to_projects_v2 = true,
			default_merge_method = "squash",
			picker = "telescope",
		},
	},
	{ "lervag/vimtex", name = "vimtex", init = function() end },
	{ "laytan/cloak.nvim", opts = {} },
	{
		"christoomey/vim-tmux-navigator",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			"TmuxNavigatePrevious",
			"TmuxNavigatorProcessList",
		},
		keys = {
			{ "<c-h>", "<cmd>TmuxNavigateLeft<cr>", mode = { "n", "t" } },
			{ "<c-j>", "<cmd>TmuxNavigateDown<cr>", mode = { "n", "t" } },
			{ "<c-k>", "<cmd>TmuxNavigateUp<cr>", mode = { "n", "t" } },
			{ "<c-l>", "<cmd>TmuxNavigateRight<cr>", mode = { "n", "t" } },
		},
		init = function()
			vim.g.tmux_navigator_no_mappings = 1
		end,
	},
	{
		"numToStr/Comment.nvim",
		name = "nvim_comment",
		keys = {
			{ "<C-/>", "<Plug>(comment_toggle_linewise_current)", desc = "Toggle comment for line", mode = "n" },
			{ "<C-/>", "<Plug>(comment_toggle_linewise_visual)", desc = "Toggle comment for line visual", mode = "v" },
			{ "<C-_>", "<Plug>(comment_toggle_linewise_current)", desc = "Toggle comment for line", mode = "n" },
			{ "<C-_>", "<Plug>(comment_toggle_linewise_visual)", desc = "Toggle comment for line visual", mode = "v" },
		},
	},
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			rename = { enabled = true },
			buffer = { enabled = true },
			words = { enable = true },
		},
	},
}
