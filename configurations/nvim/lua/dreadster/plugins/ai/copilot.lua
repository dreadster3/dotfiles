return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		name = "copilot-chat",
		cmd = { "CopilotChat", "CopilotChatAgents", "CopilotChatModels", "CopilotChatExplain" },
		version = "*",
		enabled = function()
			-- TODO: remove if plan to keep copilot
			-- local utils = require("dreadster.utils")
			-- return utils.is_mac()
			return true
		end,
		dependencies = {
			{ "copilot" }, -- or github/copilot.vim
			{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
		},
		build = "make tiktoken", -- Only on MacOS or Linux
        -- stylua: ignore
		keys = {
			{ "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
			{ "<leader>aa", function() return require("CopilotChat").toggle() end, desc = "Toggle (CopilotChat)", mode = { "n", "v" } },
			{ "<leader>ax", function() return require("CopilotChat").reset() end, desc = "Clear (CopilotChat)", mode = { "n", "v" }, },
			{ "<leader>aq", function() local input = vim.fn.input("Quick Chat: ") if input ~= "" then require("CopilotChat").ask(input) end end, desc = "Quick Chat (CopilotChat)", mode = { "n", "v" }, },
			-- Show prompts actions with telescope
			{ "<leader>ap", function() require("CopilotChat").select_prompt() end, desc = "Prompt Actions (CopilotChat)", mode = { "n", "v" } },
		},
		config = function(_, opts)
			local chat = require("CopilotChat")

			vim.api.nvim_create_autocmd("BufEnter", {
				pattern = "copilot-chat",
				callback = function()
					vim.opt_local.relativenumber = false
					vim.opt_local.number = false
				end,
			})

			chat.setup(opts)
		end,
		opts = function()
			local user = vim.env.USER or "User"
			return {
				question_header = "  " .. user .. " ",
				model = "claude-sonnet-4",
				answer_header = "  Copilot ",
				auto_insert_mode = true,
				mappings = {
					reset = {
						normal = "<leader>ax",
						insert = "<C-l>",
					},
				},
				window = {
					width = 0.2,
				},
			}
		end,
	},
	{
		"zbirenbaum/copilot.lua",
		name = "copilot",
		version = "*",
		build = ":Copilot auth",
		enabled = function()
			-- local utils = require("dreadster.utils")
			-- return utils.is_mac()
			return true
		end,
		cmd = { "Copilot" },
		event = { "BufReadPost" },
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
		lazy = true,
		opts = {},
	},
	{
		"hrsh7th/nvim-cmp",
		optional = true,
		dependencies = { "zbirenbaum/copilot-cmp" },
		opts = function(_, opts)
			table.insert(opts.sources, 1, {
				name = "copilot",
				priority = 1100,
				group_index = 1,
			})
		end,
	},
}
