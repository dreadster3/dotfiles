return {
	{
		"mfussenegger/nvim-dap",
		name = "dap",
		dependencies = {
			"mason-dap",
			"dapui",
			{
				"theHamsta/nvim-dap-virtual-text",
				opts = {},
			},
		},
        -- stylua: ignore
		keys = {
			{ "<F5>", function() require("dap").continue() end, desc = "DAP Continue" },
			{ "<F10>", function() require("dap").step_over() end, desc = "DAP Step Over" },
			{ "<F11>", function() require("dap").step_into() end, desc = "DAP Step Into" },
			{ "<F12>", function() require("dap").step_out() end, desc = "DAP Step Out" },
			{ "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "Breakpoint Condition" },
			{ "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
			{ "<leader>dc", function() require("dap").continue() end, desc = "Run/Continue" },
			{ "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
			{ "<leader>dg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
			{ "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
			{ "<leader>dj", function() require("dap").down() end, desc = "Down" },
			{ "<leader>dk", function() require("dap").up() end, desc = "Up" },
			{ "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
			{ "<leader>dO", function() require("dap").step_out() end, desc = "Step Out" },
			{ "<leader>do", function() require("dap").step_over() end, desc = "Step Over" },
			{ "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
			{ "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
			{ "<leader>ds", function() require("dap").session() end, desc = "Session" },
			{ "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
			{ "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
		},
		config = function()
			vim.fn.sign_define("DapBreakpoint", {
				text = "",
				texthl = "DapBreakpoint",
				linehl = "",
				numhl = "",
			})
			vim.fn.sign_define("DapBreakpointCondition", {
				text = "",
				texthl = "DapBreakpointCondition",
				linehl = "",
				numhl = "",
			})
			vim.fn.sign_define("DapLogPoint", {
				text = "",
				texthl = "DapLogPoint",
				linehl = "",
				numhl = "",
			})
		end,
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		name = "mason-dap",
		lazy = true,
		dependencies = { "mason" },
		cmd = { "DapInstall", "DapUninstall" },
		opts = {
			automatic_installation = true,
			ensure_installed = {},
			handlers = {},
		},
	},
	{
		"rcarriga/nvim-dap-ui",
		name = "dapui",
		dependencies = { "nvim-neotest/nvim-nio" },
    -- stylua: ignore
		keys = {
			{ "<leader>du", function() require("dapui").toggle({}) end, desc = "Dap UI" },
			{ "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = { "n", "v" } },
		},
		opts = {},
		config = function(_, opts)
			local dap = require("dap")
			local dapui = require("dapui")
			dapui.setup(opts)
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open({})
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close({})
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close({})
			end
		end,
	},
	{
		"nvim-neotest/neotest",
		name = "neotest",
		cmd = { "Neotest" },
		version = "*",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"treesitter",
		},
    -- stylua: ignore
		keys = {
			{ "<leader>t", "", desc = "+test" },
			{ "<leader>tt", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File (Neotest)" },
			{ "<leader>tT", function() require("neotest").run.run(vim.uv.cwd()) end, desc = "Run All Test Files (Neotest)" },
			{ "<leader>tr", function() require("neotest").run.run() end, desc = "Run Nearest (Neotest)" },
			{ "<leader>tl", function() require("neotest").run.run_last() end, desc = "Run Last (Neotest)" },
			{ "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle Summary (Neotest)" },
			{ "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show Output (Neotest)" },
			{ "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Toggle Output Panel (Neotest)" },
			{ "<leader>tS", function() require("neotest").run.stop() end, desc = "Stop (Neotest)" },
			{ "<leader>tw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end, desc = "Toggle Watch (Neotest)" },
            { "<leader>tW", function() require("neotest").watch.toggle(vim.uv.cwd()) end, desc = "Toggle Watch (Neotest)" },
		},
		opts = { status = { virtual_text = true }, output = { open_on_run = true } },
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

			if opts.adapters then
				local adapters = {}
				for name, config in pairs(opts.adapters or {}) do
					if type(name) == "number" then
						if type(config) == "string" then
							config = require(config)
						end
						adapters[#adapters + 1] = config
					elseif config ~= false then
						local adapter = require(name)
						if type(config) == "table" and not vim.tbl_isempty(config) then
							local meta = getmetatable(adapter)
							if adapter.setup then
								adapter.setup(config)
							elseif adapter.adapter then
								adapter.adapter(config)
								adapter = adapter.adapter
							elseif meta and meta.__call then
								adapter = adapter(config)
							else
								error("Adapter " .. name .. " does not support setup")
							end
						end
						adapters[#adapters + 1] = adapter
					end
				end
				opts.adapters = adapters
			end

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
}
