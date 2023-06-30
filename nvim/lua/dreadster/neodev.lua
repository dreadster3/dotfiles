local utils = require("dreadster.utils")
if not utils.check_module_installed("neodev") then return end

require("neodev").setup({})
