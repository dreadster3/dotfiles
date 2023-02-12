local utils = require("dreadster.utils")
local module_name = "dapui"
local status_ok, _ = pcall(require, module_name)

if not status_ok then
	utils.log_module_failed_load(module_name)
	return
end

local nvim_tree = require("nvim-tree.api")
local dap, dapui = require("dap"), require("dapui")

vim.fn.sign_define('DapBreakpoint',{ text ='', texthl ='Error', linehl ='', numhl =''})

dapui.setup({
})

dap.listeners.after.event_initialized["dapui_config"]=function()
	nvim_tree.tree.close()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"]=function()
	nvim_tree.tree.open()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"]=function()
	nvim_tree.tree.open()
	dapui.close()
end
