local utils = require("dreadster.utils")
local module_name = "nvim-treesitter"
local status_ok, _ = pcall(require, module_name)

if not status_ok then
	utils.log_module_failed_load(module_name)
	return
end

require('nvim-treesitter.configs').setup {
	ensure_installed = {'c', 'lua', 'typescript', 'tsx', 'html', 'java', 'cpp', 'c_sharp', 'css'},
	sync_install = false,
	auto_install = true,
	autotag = {
		enable = true,
		filetypes = {
			'html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'svelte', 'vue', 'tsx', 'jsx', 'rescript',
			'xml',
			'php',
			'markdown',
			'glimmer','handlebars','hbs'
		}
	},
	highlight = {
		enable = true,
		disable = {}
	},
	indent = {
		enable = true
	},
	rainbow = {
		enable = true
	}
}
