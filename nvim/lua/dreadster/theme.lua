local utils = require("dreadster.utils")
local module_name = "catppuccin"
local status_ok, _ = pcall(require, module_name)

if not status_ok then
	utils.log_module_failed_load(module_name)
	return
end

require('catppuccin').setup({
	transparent_background = "true"
})

vim.opt.background = 'dark'

vim.cmd.colorscheme("catppuccin")
