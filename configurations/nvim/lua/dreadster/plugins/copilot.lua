return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		name = "copilot-chat",
		branch = "canary",
		dependencies = {
			{ "copilot" }, -- or github/copilot.vim
			{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
		},
		build = "make tiktoken", -- Only on MacOS or Linux
		opts = {
			window = {
				width = 0.2,
			},
			mappings = {
				reset = {
					normal = "<C-a>",
					insert = "<C-a>",
				},
			},
		},
	},
	{
		"zbirenbaum/copilot.lua",
		name = "copilot",
		cmd = { "Copilot" },
		event = { "InsertEnter" },
		opts = {
			panel = {
				enabled = false,
				keymap = { enable = false },
			},
			suggestion = {
				enabled = false,
			},
			filetypes = {
				yaml = true,
				markdown = true,
				help = true,
			},
		},
	},
	{
		"zbirenbaum/copilot-cmp",
		name = "copilotcmp",
		main = "copilot_cmp",
		lazy = true,
		dependencies = { "copilot" },
		opts = {},
		config = function(_, opts)
			local copilot_cmp = require("copilot_cmp")
			copilot_cmp.setup(opts)

			require("dreadster.utils.lsp").on_attach(function(_)
				copilot_cmp._on_insert_enter({})
			end, "copilot")
		end,
	},
}
