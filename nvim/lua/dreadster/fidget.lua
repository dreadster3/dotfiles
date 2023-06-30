local utils = require("dreadster.utils")
if not utils.check_module_installed("fidget") then return end

require("fidget").setup({})
