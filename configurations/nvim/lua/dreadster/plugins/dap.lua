return {
	{
		"mfussenegger/nvim-dap",
		name = "dap",
		dependencies = {
			"dapui",
			{
				"jay-babu/mason-nvim-dap.nvim",
				name = "mason-dap",
				dependencies = { "mason" },
				cmd = { "DapInstall", "DapUninstall" },
				opts = function()
					return {
						ensure_installed = {},
						automatic_installation = true,
						handlers = {},
					}
				end,
			},
		},
		init = function()
			vim.fn.sign_define("DapBreakpoint", {
				text = "",
				texthl = "Error",
				linehl = "",
				numhl = "",
			})
		end,
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
	},
	{
		"rcarriga/nvim-dap-ui",
		name = "dapui",
		lazy = true,
		dependencies = { "nvim-neotest/nvim-nio" },
		config = function(_, opts)
			-- local nvim_tree = require("nvim-tree.api")
			-- local dap = require("dap")
			-- local dapui = require("dapui")
			-- dapui.setup(opts)
			-- dap.listeners.after.event_initialized["dapui_config"] = function()
			-- 	nvim_tree.tree.close()
			-- 	dapui.open({})
			-- end
			-- dap.listeners.before.event_terminated["dapui_config"] = function()
			-- 	nvim_tree.tree.open()
			-- 	dapui.close({})
			-- end
			-- dap.listeners.before.event_exited["dapui_config"] = function()
			-- 	nvim_tree.tree.open()
			-- 	dapui.close({})
			-- end
		end,
	},
}
