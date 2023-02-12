local utils = require("dreadster.utils")
local module_name = "notify"
local status_ok, _ = pcall(require, module_name)

if not status_ok then
	utils.log_module_failed_load(module_name)
	return
end

vim.notify = require("notify")

require("notify").setup({
	background_colour = "#000000",
	render = "compact",
	max_width = 50,
	top_down = false,
	max_height = 3
})
