local utils = require("dreadster.utils")
if not utils.check_module_installed("catppuccin") then return end

require('catppuccin').setup({transparent_background = "true"})

vim.opt.background = 'dark'

vim.cmd.colorscheme("catppuccin")
