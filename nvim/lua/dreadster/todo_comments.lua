local utils = require("dreadster.utils")
if not utils.check_module_installed("todo-comments") then return end

require("todo-comments").setup({})
