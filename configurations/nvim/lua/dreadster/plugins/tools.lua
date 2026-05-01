return {
	{
		"kdheepak/lazygit.nvim",
		name = "lazygit",
		dependencies = { "nvim-lua/plenary.nvim" },
		cmd = "LazyGit",
		keys = { { "<leader>gg", "<CMD>LazyGit<CR>", desc = "Lazygit" } },
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
				'<CMD>execute v:count . "ToggleTerm direction=tab"<CR>',
				mode = { "n", "t", "x" },
				desc = "Toggle terminal horizontal",
			},
			{
				"<M-\\>",
				'<CMD>execute v:count . "ToggleTerm direction=float"<CR>',
				mode = { "n", "t", "x" },
				desc = "Toggle terminal float",
			},
			{
				"«",
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
		"laytan/cloak.nvim",
		event = {
			{ event = "BufReadPre", pattern = "*.env*" },
			{ event = "BufNewFile", pattern = "*.env*" },
		},
		opts = {
			cloak_on_leave = true,
			patterns = {
				{
					file_pattern = "*.env*",
					cloak_pattern = "=.+",
					replace = nil,
				},
			},
		},
	},
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
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		-- stylua: ignore
		keys = {
            -- { "<leader>gg",  function() Snacks.lazygit() end, desc = "Lazygit" },
            { "<leader>z",  function() Snacks.zen.zoom() end, desc = "Toggle Zoom" },
			{ "<leader>Z",  function() Snacks.zen() end, desc = "Toggle Zen Mode" },
            { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse", mode = { "n", "v" } },
            { "<leader>gi", function() Snacks.picker.gh_issue() end, desc = "GitHub Issues (open)" },
            { "<leader>gI", function() Snacks.picker.gh_issue({ state = "all" }) end, desc = "GitHub Issues (all)" },
            { "<leader>gp", function() Snacks.picker.gh_pr() end, desc = "GitHub Pull Requests (open)" },
            { "<leader>gP", function() Snacks.picker.gh_pr({ state = "all" }) end, desc = "GitHub Pull Requests (all)" },
		},
		---@type snacks.Config
		opts = {
			buffer = { enabled = true },
			indent = { enabled = true },
			input = { enabled = true },
			gh = { enabled = true },
			gitbrowse = { enabled = true },
			lazygit = { enabled = false },
			rename = { enabled = true },
			scope = { enabled = true },
			scroll = { enable = true },
			words = { enable = true },
			zen = { enable = true },
		},
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {},
        -- stylua: ignore
        keys = {
          { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
          { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
          { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
          { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
          { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
          -- Simulate nvim-treesitter incremental selection
          { "<c-space>", mode = { "n", "o", "x" },
            function()
              require("flash").treesitter({
                actions = {
                  ["<c-space>"] = "next",
                  ["<BS>"] = "prev"
                }
              }) 
            end, desc = "Treesitter Incremental Selection" },
        },
	},
}
