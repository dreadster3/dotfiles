local utils = require("dreadster.utils")
if not utils.check_module_installed("mason-nvim-dap") then
	return
end

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

