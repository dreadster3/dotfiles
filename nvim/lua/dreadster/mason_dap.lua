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
	automatic_setup = true,
	handlers = {
		function(config)
          -- all sources with no handler get passed here

          -- Keep original functionality
          require('mason-nvim-dap').default_setup(config)
        end,
	}
})

