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
		dependencies = { "lualine" },
		name = "toggleterm",
		version = "*",
		init = function()
			-- Terminal Toggle
			function _G.set_terminal_keymaps()
				local opts = { noremap = true, buffer = 0 }

				if vim.bo.filetype ~= "toggleterm" then
					return
				end

				vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
				vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
				vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
				vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
				vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
				vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
			end

			vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
		end,
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
		"iamcco/markdown-preview.nvim",
		name = "markdown-preview",
		version = "*",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview" },
		build = "cd app && npx --yes yarn install",
		ft = { "markdown" },
		keys = {
			{
				"<leader>md",
				"<CMD>MarkdownPreviewToggle<CR>",
				desc = "Toggle markdown preview",
			},
		},
	},
	{
		"hiphish/rainbow-delimiters.nvim",
		version = "*",
		name = "rainbow",
		main = "rainbow-delimiters.setup",
		opts = {
			blacklist = { "markdown" },
		},
	},
	{
		"nvimdev/template.nvim",
		version = false,
		name = "template",
		cmd = { "Template" },
		init = function()
			local mappings = {
				typescript = { "function.ts" },
				cmake = { "VCMakeLists.txt" },
				text = { "conanfile.txt" },
				yaml = { "clangformat" },
			}

			local temp_table = {}

			for filetype, filenames in pairs(mappings) do
				for _, filename in ipairs(filenames) do
					temp_table[filename] = filetype
				end
			end

			-- Add any template that filetype cannot be detected
			vim.filetype.add({ filename = temp_table })
		end,
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
		end,
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		name = "render-markdown",
		dependencies = { "treesitter", "echasnovski/mini.icons" }, -- if you use standalone mini plugins
		ft = { "markdown" },
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {
			file_types = { "markdown" },
		},
	},
	{ "laytan/cloak.nvim", opts = {} },
}
