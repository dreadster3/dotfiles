local utils = require("dreadster.utils")
local module_name = "mason-nvim-dap"
local status_ok, _ = pcall(require, module_name)

if not status_ok then
	utils.log_module_failed_load(module_name)
	return
end

local dap = require("dap")
local mason_dap = require("mason-nvim-dap")

mason_dap.setup({
	ensure_installed = {
		"python"
	},
	automatic_setup = true
})

mason_dap.setup_handlers({
	function (source_name)
		require("mason-nvim-dap.automatic_setup")(source_name)
	end,
})
