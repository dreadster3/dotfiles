local utils = require("dreadster.utils")
local module_name = "telescope"
local status_ok, _ = pcall(require, module_name)

if not status_ok then
	utils.log_module_failed_load(module_name)
	return
end


require('telescope').setup({
	defaults = {
		file_ignore_patterns = {
			"obj",
			"bin",
			"node_modules"
		}
	},
	extensions = {
		media_files = {
		  -- filetypes whitelist
		  -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
		}
	},
})

require('telescope').load_extension('media_files')

