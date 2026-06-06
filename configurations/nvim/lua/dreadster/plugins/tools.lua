return {
	{
		"akinsho/toggleterm.nvim",
		dependencies = {
			"lualine",
			"christoomey/vim-tmux-navigator", -- Sets the keybinds to navigate between windows
		},
		version = "*",
		name = "toggleterm",
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
		"laytan/cloak.nvim",
		commit = "648aca6d33ec011dc3166e7af3b38820d01a71e4",
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
		commit = "e41c431a0c7b7388ae7ba341f01a0d217eb3a432",
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
		"folke/flash.nvim",
		version = "*",
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
