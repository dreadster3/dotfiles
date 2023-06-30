local utils = require("dreadster.utils")
if not utils.check_module_installed("dapui") then
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
