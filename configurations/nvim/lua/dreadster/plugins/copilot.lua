local function pick(kind)
	return function()
		local actions = require("CopilotChat.actions")
		local items = actions[kind .. "_actions"]()
		if not items then
			return
		end

		require("CopilotChat.integrations.telescope").pick(items)
	end
end

return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		name = "copilot-chat",
		cmd = { "CopilotChat", "CopilotChatAgents", "CopilotChatModels", "CopilotChatExplain" },
		branch = "canary",
		enabled = function()
			local utils = require("dreadster.utils")
			return utils.is_mac()
		end,
		dependencies = {
			{ "copilot" },      -- or github/copilot.vim
			{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
		},
		build = "make tiktoken", -- Only on MacOS or Linux
		keys = {
			{ "<leader>a",  "",             desc = "+ai",                           mode = { "n", "v" } },
			{
				"<leader>aa",
				function()
					return require("CopilotChat").toggle()
				end,
				desc = "Toggle (CopilotChat)",
				mode = { "n", "v" },
			},
			{
				"<leader>ax",
				function()
					return require("CopilotChat").reset()
				end,
				desc = "Clear (CopilotChat)",
				mode = { "n", "v" },
			},
			{
				"<leader>aq",
				function()
					local input = vim.fn.input("Quick Chat: ")
					if input ~= "" then
						require("CopilotChat").ask(input)
					end
				end,
				desc = "Quick Chat (CopilotChat)",
				mode = { "n", "v" },
			},
			-- Show help actions with telescope
			{ "<leader>ad", pick("help"),   desc = "Diagnostic Help (CopilotChat)", mode = { "n", "v" } },
			-- Show prompts actions with telescope
			{ "<leader>ap", pick("prompt"), desc = "Prompt Actions (CopilotChat)",  mode = { "n", "v" } },
		},
		config = function(_, opts)
			local chat = require("CopilotChat")

			require("CopilotChat.integrations.cmp").setup()
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
				answer_header = "  Copilot ",
				window = {
					width = 0.2,
				},
				mappings = {
					reset = {
						normal = "<C-a>",
						insert = "<C-a>",
					},
				},
			}
		end,
	},
	{
		"zbirenbaum/copilot.lua",
		name = "copilot",
		enabled = function()
			utils = require("dreadster.utils")
			return utils.is_mac()
		end,
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
		enabled = function()
			utils = require("dreadster.utils")
			return utils.is_mac()
		end,
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
