local utils = require("dreadster.utils")
local module_name = "template"
local status_ok, _ = pcall(require, module_name)

if not status_ok then
	utils.log_module_failed_load(module_name)
	return
end

local template = require('template')

template.author = "dreadster3"
template.email = "afonso.antunes@live.com.pt"
template.temp_dir = "/home/dreadster/.config/nvim/template"
