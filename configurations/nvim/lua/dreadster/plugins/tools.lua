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
		lazy = false,
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
	{ "stevearc/overseer.nvim", name = "overseer", opts = {} },
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
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"treesitter",
			"nvim-neotest/neotest-go",
			"nvim-neotest/neotest-python",
		},
		keys = {
			{ "<leader>t", "", desc = "+test" },
			{
				"<leader>tt",
				function()
					require("neotest").run.run(vim.fn.expand("%"))
				end,
				desc = "Run File (Neotest)",
			},
			{
				"<leader>tT",
				function()
					require("neotest").run.run(vim.uv.cwd())
				end,
				desc = "Run All Test Files (Neotest)",
			},
			{
				"<leader>tr",
				function()
					require("neotest").run.run()
				end,
				desc = "Run Nearest (Neotest)",
			},
			{
				"<leader>tl",
				function()
					require("neotest").run.run_last()
				end,
				desc = "Run Last (Neotest)",
			},
			{
				"<leader>ts",
				function()
					require("neotest").summary.toggle()
				end,
				desc = "Toggle Summary (Neotest)",
			},
			{
				"<leader>to",
				function()
					require("neotest").output.open({ enter = true, auto_close = true })
				end,
				desc = "Show Output (Neotest)",
			},
			{
				"<leader>tO",
				function()
					require("neotest").output_panel.toggle()
				end,
				desc = "Toggle Output Panel (Neotest)",
			},
			{
				"<leader>tS",
				function()
					require("neotest").run.stop()
				end,
				desc = "Stop (Neotest)",
			},
			{
				"<leader>tw",
				function()
					require("neotest").watch.toggle(vim.fn.expand("%"))
				end,
				desc = "Toggle Watch (Neotest)",
			},
			{
				"<leader>tW",
				function()
					require("neotest").watch.toggle(vim.uv.cwd())
				end,
				desc = "Toggle Watch (Neotest)",
			},
		},
		opts = function()
			local opts = {
				adapters = {
					require("neotest-go")({ recursive_run = true }),
					require("neotest-python"),
				},
			}

			return opts
		end,
		config = function(_, opts)
			-- get neotest namespace (api call creates or returns namespace)
			local neotest_ns = vim.api.nvim_create_namespace("neotest")
			vim.diagnostic.config({
				virtual_text = {
					format = function(diagnostic)
						local message =
							diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
						return message
					end,
				},
			}, neotest_ns)

			require("neotest").setup(opts)

			vim.api.nvim_create_user_command("NeotestWatch", function(args)
				local first = tostring(args.fargs[1])
				if first == "" then
					first = vim.uv.cwd() or vim.fn.expand("%s")
				end

				require("neotest").watch.toggle(first)
			end, {
				desc = "Neotest watch current working directory",
				nargs = "?",
			})
		end,
	},
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
}
