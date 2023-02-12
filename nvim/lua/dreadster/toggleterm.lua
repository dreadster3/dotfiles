local utils = require("dreadster.utils")
local module_name = "toggleterm"
local status_ok, _ = pcall(require, module_name)

if not status_ok then
	utils.log_module_failed_load(module_name)
	return
end

require('toggleterm').setup({
	open_mapping = [[<c-\>]],
})
