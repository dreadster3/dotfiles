local utils = require("dreadster.utils")
if not utils.check_module_installed("gitsigns") then return end

require("gitsigns").setup({current_line_blame = true})
