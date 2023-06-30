local utils = require("dreadster.utils")
if not utils.check_module_installed("nvim_comment") then return end

require("nvim_comment").setup({})
