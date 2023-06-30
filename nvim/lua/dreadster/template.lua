local utils = require("dreadster.utils")
if not utils.check_module_installed("template") then return end

local template = require('template')

template.author = "dreadster3"
template.email = "afonso.antunes@live.com.pt"
template.temp_dir = "/home/dreadster/.config/nvim/template"
