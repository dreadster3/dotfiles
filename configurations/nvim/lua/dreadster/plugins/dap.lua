return {
	{
		"mfussenegger/nvim-dap",
		name = "dap",
		dependencies = {
			"dapui",
			"mason-dap",
		},
		keys = {
			{
				"<F5>",
				function()
					require("dap").continue()
				end,
				desc = "DAP Continue",
			},
			{
				"<F10>",
				function()
					require("dap").step_over()
				end,
				desc = "DAP Step Over",
			},
			{
				"<F11>",
				function()
					require("dap").step_into()
				end,
				desc = "DAP Step Into",
			},
			{
				"<F12>",
				function()
					require("dap").step_out()
				end,
				desc = "DAP Step Out",
			},
			{
				"<leader>b",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "DAP Toggle Breakpoint",
			},
		},
		config = function(_, opts)
			local dap = require("dap")
			local dapui = require("dapui")

			vim.fn.sign_define("DapBreakpoint", {
				text = "",
				texthl = "Error",
				linehl = "",
				numhl = "",
			})

			dap.listeners.after.event_initialized["dapui_config"] = dapui.open
			dap.listeners.before.event_terminated["dapui_config"] = dapui.close
			dap.listeners.before.event_exited["dapui_config"] = dapui.close
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		name = "dapui",
		main = "dapui",
		dependencies = { "nvim-neotest/nvim-nio" },
		opts = {},
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		name = "mason-dap",
		lazy = true,
		dependencies = { "mason" },
		cmd = { "DapInstall", "DapUninstall" },
		opts = function()
			return {
				automatic_installation = true,
				ensure_installed = {},
				handlers = {},
			}
		end,
	},
}
