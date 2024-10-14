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
			panel = { keymap = { enable = false } },
			suggestion = {
				auto_trigger = true,
				keymap = {
					accept = "<M-CR>",
					accept_word = "<M-Right>",
					accept_line = "<M-Up>",
				},
			},
			filetypes = { yaml = true, markdown = true },
		},
	},
}
